const express = require('express')
const mongoose = require('mongoose')
const { v4: uuidv4 } = require('uuid')
const twilio = require('twilio')
require('dotenv').config()

const app = express()
app.use(express.json())
app.use(express.urlencoded({ extended: true }));

const PORT = process.env.PORT || 3000
const MONGO_URI = process.env.MONGO_URI
const TWILIO_ACCOUNT_SID = process.env.TWILIO_ACCOUNT_SID
const TWILIO_AUTH_TOKEN = process.env.TWILIO_AUTH_TOKEN
const TWILIO_WHATSAPP_FROM = process.env.TWILIO_WHATSAPP_FROM
const ENDPOINT_STATUS_CALLBACK = process.env.ENDPOINT_STATUS_CALLBACK

mongoose.connect(MONGO_URI, {
    useNewUrlParser: true,
    useUnifiedTopology: true,
})

const MessageSchema = new mongoose.Schema({
    id: { type: String, required: true },
    twilioSid: { type: String },
    status: { type: String, enum: ['enviada', 'entregue', 'lida', 'respondida'], required: true },
    envio: {
        datahora: { type: Date, required: true },
        de: { type: String },
        para: { type: String },
        mensagem: { type: String, required: true },
    },
    resposta: {
        datahora: { type: Date },
        mensagem: { type: String },
    },
})

const Message = mongoose.model('Message', MessageSchema)

const client = twilio(TWILIO_ACCOUNT_SID, TWILIO_AUTH_TOKEN)

app.post('/send-message', async (req, res) => {
    const { phoneNumber, messageText } = req.body

    if (!phoneNumber || !messageText)
        return res.status(400).send({ error: 'Número de telefone e mensagem são obrigatórios' })

    const messageId = uuidv4()

    const messageBody = {
        to: `whatsapp:${phoneNumber}`,
        from: TWILIO_WHATSAPP_FROM,
        body: messageText,
        statusCallback: ENDPOINT_STATUS_CALLBACK
    }

    try {
        const response = await client.messages.create(messageBody);

        const message = new Message({
            id: messageId,
            twilioSid: response.sid,
            status: 'enviada',
            envio: {
                datahora: new Date(),
                de: messageBody.from,
                para: messageBody.to,
                mensagem: messageText,
            },
        })

        await message.save()

        res.status(200).send({ id: messageId })
    } catch (error) {
        console.error(error)
        res.status(500).send({ error: 'Erro ao enviar mensagem' })
    }
})

app.post('/status-callback', async (req, res) => {

    try {
        const { MessageSid, MessageStatus } = req.body

        const message = await Message.findOne({ twilioSid: MessageSid });

        let newstatus = ""
        switch (MessageStatus) {
            case "sent":
                newstatus = "enviada"
                break;
            case "delivered":
                newstatus = "entregue"
                break;
            case "read":
                newstatus = "lida"
                break;
            default:
                newstatus = message.status
                break;
        }

        if (message) {
            message.status = newstatus
            await message.save()
        }

        res.status(200).send()
    } catch (error) {
        console.error(error)
        res.status(500).send({ error: 'Erro ao processar status callback' })
    }
})

app.post('/receive-response', async (req, res) => {
    try {
        const { SmsMessageSid, Body, From, To } = req.body

        if (!From || !Body || !To)
            return res.status(400).send({ error: 'Dados insuficientes na resposta' })

        const message = await Message.findOne({ status: 'lida', 'envio.para': From, 'envio.de': To })

        if (!message)
            return res.status(404).send({ error: 'Mensagem não encontrada' })

        message.status = 'respondida'
        message.resposta = {
            datahora: new Date(),
            mensagem: Body,
        }

        await message.save()

        res.status(200).send({ success: 'Resposta registrada com sucesso' })
    } catch (error) {
        console.error(error)
        res.status(500).send({ error: 'Erro ao registrar resposta' })
    }
})

app.get('/message-status/:id', async (req, res) => {
    const { id } = req.params

    try {
        const message = await Message.findOne({ id: id })

        if (!message) {
            return res.status(404).send({ error: 'Mensagem não encontrada' })
        }

        res.status(200).send(message?.resposta || message)
    } catch (error) {
        console.error(error);
        res.status(500).send({ error: 'Erro ao consultar status da mensagem' })
    }
})

app.get('/health', async (req, res) => {
    res.status(200).send({ status: "API Online" })
})

app.listen(PORT, () => {
    console.log(`Servidor rodando na porta ${PORT}`)
})
