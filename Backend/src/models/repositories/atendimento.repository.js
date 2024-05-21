const path = require('path')
const uteis = require(path.resolve(__dirname, '../', '../', 'utils', 'utils.js'))

const AgendasModel = require(path.resolve(__dirname, '../', 'agenda.model.js'))
const AtendimentoModel = require(path.resolve(__dirname, '../', 'atendimento.model.js'))

const atributos_Atendimento = ['id', 'di', 'datahora_inicio', 'datahora_fim', 'anotacoes']

module.exports.retornePeloID = async function (id) {

    const retorno = await AtendimentoModel.findOne({
        attributes: atributos_Atendimento,
        include: [
            {
                model: AgendasModel, as: 'agenda',
                attributes: ['id', 'di', 'descricao', 'observacao', 'evento_inicio', 'evento_fim', 'evento_confirmado', 'ativo']
            },
        ],
        where: {
            id: id,
        },
        order: [
            ['id', 'asc']
        ],
    })

    return retorno

}

module.exports.retorneTodos = async function (profissional_id, paciente_id) {

    let condicao_where = {}

    if (profissional_id > 0)
        condicao_where["$agenda.profissioal_agendado_id$"] = profissional_id

    if (paciente_id > 0)
        condicao_where["$agenda.paciente_agendado_id$"] = paciente_id

    return await AtendimentoModel.findAll({
        attributes: atributos_Atendimento,
        include: [
            {
                model: AgendasModel, as: 'agenda',
                attributes: ['id', 'di', 'descricao', 'observacao', 'evento_inicio', 'evento_fim', 'evento_confirmado', 'ativo']
            },
        ],
        where: condicao_where,
        order: [
            ['datahora_inicio', 'asc']
        ],
    })
}