const path = require('path')

const uteis = require(path.resolve(__dirname, '../', '../', 'utils', 'utils.js'))
const mensagens = require(path.resolve(__dirname, '../', '../', 'services', 'messages.js'))
const AtendimentoRepository = require(path.resolve(__dirname, '../', '../', 'models', 'repositories', 'atendimento.repository.js'))

module.exports.editar = async function (req, res, next) {
    const { id, di } = req.params
    const { anotacoes } = req.body

    let registro = await AtendimentoRepository.retornePeloID(id)

    // Checando "di"
    switch (await uteis.checagem_di(registro, di)) {
        case 1: return res.status(400).json(mensagens.resultDefault(1003))
            break
        case 2: return res.status(400).json(mensagens.resultDefault(2000))
            break
    }

    if (registro?.datahora_fim > 0)
        return res.status(400).json(mensagens.resultDefault(2519))

    if (!anotacoes)
        return res.status(400).json(mensagens.resultDefault(2520))

    if (!registro?.agenda?.ativo)
        return res.status(400).json(mensagens.resultDefault(2521))

    next()
}

module.exports.encerrar = async function (req, res, next) {
    const { id, di } = req.params
    const { datahora_fim } = req.body

    let registro = await AtendimentoRepository.retornePeloID(id)

    // Checando "di"
    switch (await uteis.checagem_di(registro, di)) {
        case 1: return res.status(400).json(mensagens.resultDefault(1003))
            break
        case 2: return res.status(400).json(mensagens.resultDefault(2000))
            break
    }

    if (!datahora_fim)
        return res.status(400).json(mensagens.resultDefault(2518))

    next()
}
