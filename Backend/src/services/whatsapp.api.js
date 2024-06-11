const path = require('path')

const moment = require('moment')
const axios = require(path.resolve(__dirname, 'axios.js'))

module.exports.retorneStatusMensagens = async function (ids) {

    if (!Array.isArray(ids) || ids.length === 0)
        return []

    const retorno = await axios.makePost(process.env.WHATSAPP_API_URL, "messages-status-ids", "", "", { ids: ids })

    if (retorno.statusCode !== 200)
        return []

    if (!Array.isArray(retorno?.data))
        return []

    return retorno.data

}

module.exports.excluirMensagens = async function (ids) {

    if (!Array.isArray(ids) || ids.length === 0)
        return false

    const retorno = await axios.makePost(process.env.WHATSAPP_API_URL, "delete-messages-ids", "", "", { ids: ids })

    return retorno.statusCode === 200

}

module.exports.enviarMensagem = async function (agenda) {

    let mensagem = ""

    mensagem += `Olá, ${agenda?.paciente?.nome || "caro paciente"}! \n`
    mensagem += `\n`
    mensagem += `Este é um lembrete do seu agendamento na nossa clínica para amanhã, dia ${moment(agenda.evento_inicio).format('DD/MM/YYYY')} \n`
    mensagem += ` \n`
    mensagem += `Detalhes do agendamento:\n`
    mensagem += `Horário: ${moment(agenda.evento_inicio).format('HH:mm')} \n`
    mensagem += `Profissional: ${agenda?.profissional?.nome || "a confirmar"} \n`
    mensagem += ` \n`
    mensagem += `Por favor, confirme sua presença respondendo a esta mensagem com: \n`
    mensagem += `SIM - para confirmar sua presença \n`
    mensagem += `NÃO - se não puder comparecer \n`
    mensagem += ` \n`
    mensagem += `Sua confirmação é muito importante para nós. Em caso de dúvidas ou se precisar reagendar, entre em contato pelo telefone direto DA CLÍNICA. \n`
    mensagem += ` \n`
    mensagem += `Agradecemos a sua atenção.`

    const body = {
        phoneNumber: `+${agenda.paciente.celular}`,
        messageText: mensagem
    }

    const retorno = await axios.makePost(process.env.WHATSAPP_API_URL, "send-message", "", "", body)

    if (retorno.statusCode !== 200)
        return []

    return retorno?.data?.id || ""

}