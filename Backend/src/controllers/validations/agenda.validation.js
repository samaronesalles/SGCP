const path = require('path')

const uteis = require(path.resolve(__dirname, '../', '../', 'utils', 'utils.js'))
const mensagens = require(path.resolve(__dirname, '../', '../', 'services', 'messages.js'))
const AgendaRepository = require(path.resolve(__dirname, '../', '../', 'models', 'repositories', 'agenda.repository.js'))

module.exports.nova = function (req, res, next) {

    //TODO Validar se campos obrigatórios estáo preenchidos;
    //TODO Validar se profissional existe e se está ativo;
    //TODO Validar se paciente existe e se está ativo;
    //TODO Validar se intervalo inicial e final são válidos;
    //TODO Validar se existe agenda deste profissional no mesmo intervalo do período.

    // if (uteis.strEmpty(req.body.nome))
    //     return res.status(400).json(mensagens.resultDefault(2511))

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

    //TODO Validar se campos obrigatórios estáo preenchidos;

    // if (uteis.strEmpty(req.body.nome))
    //     return res.status(400).json(mensagens.resultDefault(2511))

    next()
}

module.exports.cancelamento = async function (req, res, next) {

    const { id, di } = req.params

    let registro = await AgendaRepository.retornePeloID(id)

    // Checando "di"
    switch (await uteis.checagem_di(registro, di)) {
        case 1: return res.status(400).json(mensagens.resultDefault(1003))
            break;
        case 2: return res.status(400).json(mensagens.resultDefault(2000))
            break;
    }

    //TODO Validar se a agenda já está cancelada. Caso verdade, não permitir cancelamento;
    //TODO Validar se o atendimento vinculado à esta agenda já foi executado. Caso verdade, não permitir cancelamento;


    // if (uteis.strEmpty(req.body.nome))
    //     return res.status(400).json(mensagens.resultDefault(2511))

    next()
}
