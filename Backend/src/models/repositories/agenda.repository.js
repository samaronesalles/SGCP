const path = require('path')
const { Op, Sequelize } = require("sequelize");
const uteis = require(path.resolve(__dirname, '../', '../', 'utils', 'utils.js'))

const PacienteModel = require(path.resolve(__dirname, '../', 'paciente.model.js'))
const ProfissionalModel = require(path.resolve(__dirname, '../', 'profissional.model.js'))
const AgendaModel = require(path.resolve(__dirname, '../', 'agenda.model.js'))

const atributos_Agenda = ['id', 'di', 'descricao', 'observacao', 'evento_inicio', 'evento_fim', 'evento_confirmado', 'ativo']

module.exports.retornePeloID = async function (id) {
    const retorno = await AgendaModel.findOne({
        attributes: atributos_Agenda,
        include: [
            {
                model: ProfissionalModel, as: 'profissional',
                attributes: ['id', 'di', 'nome', 'celular', 'email', 'ativo']
            },
            {
                model: PacienteModel, as: 'paciente',
                attributes: ['id', 'di', 'nome', 'celular', 'email', 'ativo']
            }
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

module.exports.retorneTodas = async function (profissional_id, paciente_id, inicio_de, inicio_ate) {

    let condicao_where = {}

    if (profissional_id > 0)
        condicao_where["$profissional.id$"] = profissional_id

    if (paciente_id > 0)
        condicao_where["$paciente.id$"] = paciente_id

    if ((inicio_de && inicio_ate) && (Date.parse(inicio_de) > 0 && Date.parse(inicio_ate) > 0)) {
        const data_vencimento = { [Op.between]: [inicio_de, inicio_ate] };
        condicao_where["evento_inicio"] = data_vencimento;
    }

    return await AgendaModel.findAll({
        attributes: atributos_Agenda,
        include: [
            {
                model: ProfissionalModel, as: 'profissional',
                attributes: ['id', 'di', 'nome', 'celular', 'email', 'ativo']
            },
            {
                model: PacienteModel, as: 'paciente',
                attributes: ['id', 'di', 'nome', 'celular', 'email', 'ativo']
            }
        ],
        where: condicao_where,
        order: [
            ['profissioal_agendado_id', 'asc'],
            ['evento_inicio', 'asc']
        ],
    })

}