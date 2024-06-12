const path = require('path')
const emailValidator = require('email-validator')

const uteis = require(path.resolve(__dirname, '../', '../', 'utils', 'utils.js'))
const mensagens = require(path.resolve(__dirname, '../', '../', 'services', 'messages.js'))
const PacienteRepository = require(path.resolve(__dirname, '../', '../', 'models', 'repositories', 'paciente.repository.js'))
const AgendaRepository = require(path.resolve(__dirname, '../', '../', 'models', 'repositories', 'agenda.repository.js'))

module.exports.cadJaExistente = async function (req, res, next) {
    if (uteis.strEmpty(req.body.email))
        return res.status(400).json(mensagens.resultDefault(2509))

    const registro = await PacienteRepository.retornePeloEmail(req.body.email)

    if (registro)
        return res.status(400).json(mensagens.resultDefault(2510))

    next()
}

module.exports.saveCad = function (req, res, next) {

    if (uteis.strEmpty(req.body.nome))
        return res.status(400).json(mensagens.resultDefault(2511))

    if (uteis.strEmpty(req.body.celular))
        return res.status(400).json(mensagens.resultDefault(2512))

    if (uteis.strEmpty(req.body.email))
        return res.status(400).json(mensagens.resultDefault(2513))

    if (!emailValidator.validate(req.body.email))
        return res.status(400).json(mensagens.resultDefault(2514))

    next()
}

module.exports.edicaoCad = async function (req, res, next) {
    const { id, di } = req.params

    let registro = await PacienteRepository.retornePeloID(id)

    // Checando "di"
    switch (await uteis.checagem_di(registro, di)) {
        case 1: return res.status(400).json(mensagens.resultDefault(1003))
            break
        case 2: return res.status(400).json(mensagens.resultDefault(2000))
            break
    }

    next()
}

module.exports.exclusaoCad = async function (req, res, next) {
    const { id, di } = req.params

    let registro = await PacienteRepository.retornePeloID(id)

    // Checando "di"
    switch (await uteis.checagem_di(registro, di)) {
        case 1: return res.status(400).json(mensagens.resultDefault(1003))
            break
        case 2: return res.status(400).json(mensagens.resultDefault(2000))
            break
    }

    const agendasDoPaciente = await AgendaRepository.retorneTodas(0, id, 0, 0)

    if (Array.isArray(agendasDoPaciente) || agendasDoPaciente.length > 0)
        return res.status(400).json(mensagens.resultDefault(2530))

    next()
}

module.exports.inativar = async function (req, res, next) {
    const { id, di } = req.params

    let registro = await PacienteRepository.retornePeloID(id)

    // Checando "di"
    switch (await uteis.checagem_di(registro, di)) {
        case 1: return res.status(400).json(mensagens.resultDefault(1003))
            break
        case 2: return res.status(400).json(mensagens.resultDefault(2000))
            break
    }

    if (!registro.ativo)
        return res.status(400).json(mensagens.resultDefault(2515))

    next()
}