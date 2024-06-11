const path = require('path')
const { Op } = require('sequelize')
const emailValidator = require('email-validator')

const uteis = require(path.resolve(__dirname, '../', '../', 'utils', 'utils.js'))
const mensagens = require(path.resolve(__dirname, '../', '../', 'services', 'messages.js'))
const ProfissionalRepository = require(path.resolve(__dirname, '../', '../', 'models', 'repositories', 'profissional.repository.js'))
const AgendaRepository = require(path.resolve(__dirname, '../', '../', 'models', 'repositories', 'agenda.repository.js'))

const camposLoginValidos = function (login, senha) {
    const loginVazio = uteis.strEmpty(login)
    const senhaVazia = uteis.strEmpty(senha)

    if ((!loginVazio && senhaVazia) || (loginVazio && !senhaVazia))
        return false

    return true
}

const loginJaUsado = async function (login, idAIgnorar) {
    if (!login)
        return false

    const registro = await ProfissionalRepository.retorneUmOpcional({
        username: login,
        ativo: true,
        id: { [Op.ne]: idAIgnorar }
    })

    return registro !== null
}

module.exports.cadJaExistente = async function (req, res, next) {
    if (uteis.strEmpty(req.body.email))
        return res.status(400).json(mensagens.resultDefault(2504))

    const registro = await ProfissionalRepository.retornePeloEmail(req.body.email)

    if (registro)
        return res.status(400).json(mensagens.resultDefault(2505))

    next()
}

module.exports.saveCad = async function (req, res, next) {

    const { id } = req.params

    let x = id
    if ((!id) || (id === 0))
        x = 0

    if (uteis.strEmpty(req.body.nome))
        return res.status(400).json(mensagens.resultDefault(2502))

    if (uteis.strEmpty(req.body.celular))
        return res.status(400).json(mensagens.resultDefault(2503))

    if (uteis.strEmpty(req.body.email))
        return res.status(400).json(mensagens.resultDefault(2504))

    if (!emailValidator.validate(req.body.email))
        return res.status(400).json(mensagens.resultDefault(2506))

    if (!camposLoginValidos(req.body.username, req.body.password))
        return res.status(400).json(mensagens.resultDefault(2501))

    if (req.body.username.length > 0) {
        if (await loginJaUsado(req.body.username, x))
            return res.status(400).json(mensagens.resultDefault(2517))
    }

    next()
}

module.exports.edicaoCad = async function (req, res, next) {
    const { id, di } = req.params

    let registro = await ProfissionalRepository.retornePeloID(id)

    // Checando "di"
    switch (await uteis.checagem_di(registro, di)) {
        case 1: return res.status(400).json(mensagens.resultDefault(1003))
            break;
        case 2: return res.status(400).json(mensagens.resultDefault(2000))
            break;
    }

    next()
}

module.exports.exclusaoCad = async function (req, res, next) {
    const { id, di } = req.params

    let registro = await ProfissionalRepository.retornePeloID(id)

    // Checando "di"
    switch (await uteis.checagem_di(registro, di)) {
        case 1: return res.status(400).json(mensagens.resultDefault(1003))
            break;
        case 2: return res.status(400).json(mensagens.resultDefault(2000))
            break;
    }

    const agendasDoProfissional = await AgendaRepository.retorneTodas(id, 0, 0, 0)

    if (Array.isArray(agendasDoProfissional) || agendasDoProfissional.length > 0)
        return res.status(400).json(mensagens.resultDefault(2529))

    next()
}

module.exports.inativar = async function (req, res, next) {
    const { id, di } = req.params

    let registro = await ProfissionalRepository.retornePeloID(id)

    // Checando "di"
    switch (await uteis.checagem_di(registro, di)) {
        case 1: return res.status(400).json(mensagens.resultDefault(1003))
            break;
        case 2: return res.status(400).json(mensagens.resultDefault(2000))
            break;
    }

    if (!registro.ativo)
        return res.status(400).json(mensagens.resultDefault(2508))

    next()
}

module.exports.login = function (req, res, next) {

    if (!camposLoginValidos(req.body.username, req.body.password))
        return res.status(400).json(mensagens.resultDefault(2501))

    next()
}
