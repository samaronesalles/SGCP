const path = require('path')

const uteis = require(path.resolve(__dirname, '../', '../', 'utils', 'utils.js'))
const mensagens = require(path.resolve(__dirname, '../', '../', 'services', 'messages.js'))
const AtendimentoRepository = require(path.resolve(__dirname, '../', '../', 'models', 'repositories', 'atendimento.repository.js'))

module.exports.nova = function (req, res, next) {

    //TODO Validar se campos obrigatórios estáo preenchidos;

    // if (uteis.strEmpty(req.body.nome))
    //     return res.status(400).json(mensagens.resultDefault(2511))

    next()
}

module.exports.editar = async function (req, res, next) {
    const { id, di } = req.params

    let registro = await AtendimentoRepository.retornePeloID(id)

    // Checando "di"
    switch (await uteis.checagem_di(registro, di)) {
        case 1: return res.status(400).json(mensagens.resultDefault(1003))
            break;
        case 2: return res.status(400).json(mensagens.resultDefault(2000))
            break;
    }

    //TODO Validar se o atendimento já está encerrado, se estiver, não permitir edição.
    //TODO Validar se o atendimento está com sua agenda cancelada, se estiver, não permitir edição.

    next()
}

module.exports.encerrar = async function (req, res, next) {
    const { id, di } = req.params
    const { datahora_fim } = req.body

    let registro = await AtendimentoRepository.retornePeloID(id)

    // Checando "di"
    switch (await uteis.checagem_di(registro, di)) {
        case 1: return res.status(400).json(mensagens.resultDefault(1003))
            break;
        case 2: return res.status(400).json(mensagens.resultDefault(2000))
            break;
    }

    if (!datahora_fim)
        return res.status(400).json(mensagens.resultDefault(2518))

    next()
}
