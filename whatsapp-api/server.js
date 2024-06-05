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

mongoose.connect(MONGO_URI, {
    useNewUrlParser: true,
    useUnifiedTopology: true,
})

const MessageSchema = new mongoose.Schema({
    id: { type: String, required: true },
    sid: { type: String },
    status: { type: String, enum: ['enviada', 'respondida'], required: true },
    envio: {
        datahora: { type: Date, required: true },
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

    if (!phoneNumber || !messageText) {
        return res.status(400).send({ error: 'Número de telefone e mensagem são obrigatórios' })
    }

    const messageId = uuidv4()

    let message = new Message({
        id: messageId,
        sid: "",
        status: 'enviada',
        envio: {
            datahora: new Date(),
            mensagem: messageText,
        },
    })

    await message.save()

    const messageBody = {
        to: `whatsapp:${phoneNumber}`,
        from: TWILIO_WHATSAPP_FROM,
        body: messageText,
        action: [
            {
                type: "button",
                buttons: [
                    {
                        type: "reply",
                        reply: {
                            id: "yes",
                            title: "Sim"
                        }
                    },
                    {
                        type: "reply",
                        reply: {
                            id: "no",
                            title: "Não"
                        }
                    }
                ]
            }
        ]
    }

    try {
        await client
            .messages
            .create(messageBody)
            .then(resposta => {
                // console.log(resposta)

                message.sid = resposta.sid
                message.save()
            })

        res.status(200).send({ id: messageId })
    } catch (error) {
        console.error(error)
        res.status(500).send({ error: 'Erro ao enviar mensagem' })
    }
});

app.post('/receive-response', async (req, res) => {
    console.log('entrou em "receive-response"')

    try {
        const { SmsMessageSid, Body, From } = req.body;

        console.error(SmsMessageSid)
        console.error(Body)

        if (!SmsMessageSid || !Body)
            return res.status(400).send({ error: 'Dados insuficientes na resposta' })

        const message = await Message.findOne({ sid: SmsMessageSid })

        if (!message)
            return res.status(404).send({ error: 'Mensagem não encontrada' })

        message.status = 'respondida';
        message.resposta = {
            datahora: new Date(),
            mensagem: Body
        }

        await message.save()

        res.status(200).send({ success: 'Resposta registrada com sucesso' })
    } catch (error) {
        console.error(error)
        res.status(500).send({ error: 'Erro ao registrar resposta' })
    }
});

app.get('/message-status/:id', async (req, res) => {
    const { id } = req.params

    try {
        const message = await Message.findOne({ id: id })

        if (!message) {
            return res.status(404).send({ error: 'Mensagem não encontrada' })
        }

        res.status(200).send(message)
    } catch (error) {
        console.error(error);
        res.status(500).send({ error: 'Erro ao consultar status da mensagem' })
    }
});

app.get('/health', async (req, res) => {
    res.status(200).send({ status: "API Online" })
})

app.listen(PORT, () => {
    console.log(`Servidor rodando na porta ${PORT}`)
})
