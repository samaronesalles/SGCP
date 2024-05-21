const path = require('path')

const uteis = require(path.resolve(__dirname, '../', '../', 'utils', 'utils.js'))
const mensagens = require(path.resolve(__dirname, '../', '../', 'services', 'messages.js'))

module.exports.nova = function (req, res, next) {

    //TODO Validar se campos obrigatórios estáo preenchidos;

    // if (uteis.strEmpty(req.body.nome))
    //     return res.status(400).json(mensagens.resultDefault(2511))

    next()
}
