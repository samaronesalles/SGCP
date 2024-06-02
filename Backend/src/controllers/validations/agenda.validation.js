const path = require('path')
const { Op, Sequelize } = require("sequelize");

const uteis = require(path.resolve(__dirname, '../', '../', 'utils', 'utils.js'))
const mensagens = require(path.resolve(__dirname, '../', '../', 'services', 'messages.js'))
const AgendaRepository = require(path.resolve(__dirname, '../', '../', 'models', 'repositories', 'agenda.repository.js'))
const AtendimentoRepository = require(path.resolve(__dirname, '../', '../', 'models', 'repositories', 'atendimento.repository.js'))
const ProfissionalRepository = require(path.resolve(__dirname, '../', '../', 'models', 'repositories', 'profissional.repository.js'))
const PacienteRepository = require(path.resolve(__dirname, '../', '../', 'models', 'repositories', 'paciente.repository.js'))

const agendaValidaProfissional = async function (IDagendaADesconsiderar, profissional_id, evento_inicio, evento_fim) {

    let condicao_where = {
        id: { [Op.ne]: IDagendaADesconsiderar },
        profissional_agendado_id: profissional_id,
        [Op.or]: [
            {
                [Op.and]: [
                    { evento_inicio: { [Op.lte]: evento_inicio } },
                    { evento_fim: { [Op.gte]: evento_inicio } }
                ]
            },
            {
                [Op.and]: [
                    { evento_inicio: { [Op.lte]: evento_fim } },
                    { evento_fim: { [Op.gte]: evento_fim } }
                ]
            },
            {
                [Op.and]: [
                    { evento_inicio: { [Op.gte]: evento_inicio } },
                    { evento_fim: { [Op.lte]: evento_fim } }
                ]
            }
        ]
    }

    const agendaEncontrada = await AgendaRepository.retorneUmOpcional(condicao_where)

    if (agendaEncontrada?.id > 0)
        return false

    return true

}

const agendaValidaPaciente = async function (IDagendaADesconsiderar, paciente_id, evento_inicio, evento_fim) {
    let condicao_where = {
        id: { [Op.ne]: IDagendaADesconsiderar },
        paciente_agendado_id: paciente_id,
        [Op.or]: [
            {
                [Op.and]: [
                    { evento_inicio: { [Op.lte]: evento_inicio } },
                    { evento_fim: { [Op.gte]: evento_inicio } }
                ]
            },
            {
                [Op.and]: [
                    { evento_inicio: { [Op.lte]: evento_fim } },
                    { evento_fim: { [Op.gte]: evento_fim } }
                ]
            },
            {
                [Op.and]: [
                    { evento_inicio: { [Op.gte]: evento_inicio } },
                    { evento_fim: { [Op.lte]: evento_fim } }
                ]
            }
        ]
    }

    const agendaEncontrada = await AgendaRepository.retorneUmOpcional(condicao_where)

    if (agendaEncontrada?.id > 0)
        return false

    return true
}

module.exports.save = async function (req, res, next) {
    const { id } = req.params
    const { profissional_id, paciente_id, evento_inicio, evento_fim } = req.body

    if ((!profissional_id) || (parseInt(profissional_id) <= 0))
        return res.status(400).json(mensagens.resultDefault(2502))

    if ((!paciente_id) || (parseInt(paciente_id) <= 0))
        return res.status(400).json(mensagens.resultDefault(2511))

    const iniciovalido = uteis.StrToDateTimeUTC_Valido(evento_inicio)
    const fimvalido = uteis.StrToDateTimeUTC_Valido(evento_fim)

    if (!iniciovalido || !fimvalido)
        return res.status(400).json(mensagens.resultDefault(2522))

    const profissional = await ProfissionalRepository.retornePeloID(profissional_id)
    if (!profissional || !profissional.ativo)
        return res.status(400).json(mensagens.resultDefault(2523))

    const paciente = await PacienteRepository.retornePeloID(paciente_id)
    if (!paciente || !paciente.ativo)
        return res.status(400).json(mensagens.resultDefault(2524))

    if (! await agendaValidaProfissional(id || 0, profissional_id, evento_inicio, evento_fim))
        return res.status(400).json(mensagens.resultDefault(2525))

    if (!agendaValidaPaciente(id || 0, paciente_id, evento_inicio, evento_fim))
        return res.status(400).json(mensagens.resultDefault(2526))

    next()
}

module.exports.editar = async function (req, res, next) {

    const { id, di } = req.params

    let registro = await AgendaRepository.retornePeloID(id)

    // Checando "di"
    switch (await uteis.checagem_di(registro, di)) {
        case 1: return res.status(400).json(mensagens.resultDefault(1003))
            break;
        case 2: return res.status(400).json(mensagens.resultDefault(2000))
            break;
    }

    next()
}

module.exports.cancelamento = async function (req, res, next) {

    const { id, di } = req.params

    const registro = await AgendaRepository.retornePeloID(id)

    // Checando "di"
    switch (await uteis.checagem_di(registro, di)) {
        case 1: return res.status(400).json(mensagens.resultDefault(1003))
            break;
        case 2: return res.status(400).json(mensagens.resultDefault(2000))
            break;
    }

    if (!registro.ativo)
        return res.status(400).json(mensagens.resultDefault(2527))

    const atendimento = await AtendimentoRepository.retornePeloIdAgenda(id)

    if (atendimento.datahora_fim > 0)
        return res.status(400).json(mensagens.resultDefault(2528))

    next()
}
