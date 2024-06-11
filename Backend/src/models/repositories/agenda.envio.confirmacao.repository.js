const path = require('path')
const { Op, Sequelize } = require("sequelize");
const uteis = require(path.resolve(__dirname, '../', '../', 'utils', 'utils.js'))

const AgendaConfirmacaoEnvio = require(path.resolve(__dirname, '../', 'agenda.envio.confirmacao.model.js'))

const atributos = ['agenda_id', 'idMsg']

module.exports.insert = async function (idAgenda, idMsg) {
    if (!idAgenda || !idMsg)
        return false

    const retorno = await AgendaConfirmacaoEnvio.create({ agenda_id: idAgenda, idMsg: idMsg })

    return retorno?.idMsg === idMsg
}

module.exports.retorneTodas = async function () {
    const retorno = await AgendaConfirmacaoEnvio.findAll({
        attributes: atributos,
    })

    return retorno
}

module.exports.delete = async function (ids) {
    if (!Array.isArray(ids) || ids.length === 0)
        return false

    const retorno = await AgendaConfirmacaoEnvio.destroy({
        where: {
            idMsg: {
                [Op.in]: ids
            }
        }
    })

    return retorno === ids.length
}