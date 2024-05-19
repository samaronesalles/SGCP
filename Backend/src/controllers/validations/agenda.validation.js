const path = require('path')

const uteis = require(path.resolve(__dirname, '../', '../', 'utils', 'utils.js'))
const mensagens = require(path.resolve(__dirname, '../', '../', 'services', 'messages.js'))

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

