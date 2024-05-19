const path = require('path')
const uteis = require(path.resolve(__dirname, '../', '../', 'utils', 'utils.js'))

const AgendaModel = require(path.resolve(__dirname, '../', 'agenda.model.js'))

const atributos_Agenda = ['id', 'di', 'descricao', 'observacao', 'evento_inicio', 'evento_fim', 'evento_confirmado']

module.exports.retornePeloID = async function (id) {
    return await AgendaModel.findByPk(id, {
        attributes: atributos_Agenda,
    })
}

module.exports.retorneTodos = async function () {
    return await AgendaModel.findAll({
        attributes: atributos_Agenda,
    })
}