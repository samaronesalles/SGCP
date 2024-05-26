const path = require('path')
const { Op, Sequelize } = require("sequelize");
const uteis = require(path.resolve(__dirname, '../', '../', 'utils', 'utils.js'))

const ProfissionalModel = require(path.resolve(__dirname, '../', 'profissional.model.js'))
const PacienteModel = require(path.resolve(__dirname, '../', 'paciente.model.js'))
const AgendasModel = require(path.resolve(__dirname, '../', 'agenda.model.js'))
const AtendimentoModel = require(path.resolve(__dirname, '../', 'atendimento.model.js'))

const atributos_Atendimento = ['id', 'di', 'datahora_inicio', 'datahora_fim', 'anotacoes']

module.exports.retornePeloID = async function (id) {

    const retorno = await AtendimentoModel.findOne({
        attributes: atributos_Atendimento,
        include: [
            {
                model: AgendasModel, as: 'agenda',
                attributes: ['id', 'di', 'descricao', 'observacao', 'evento_inicio', 'evento_fim', 'evento_confirmado', 'ativo'],
                include: [
                    {
                        model: ProfissionalModel, as: 'profissional',
                        attributes: ['id', 'di', 'nome', 'celular', 'email', 'ativo']
                    },
                    {
                        model: PacienteModel, as: 'paciente',
                        attributes: ['id', 'di', 'nome', 'celular', 'email', 'ativo']
                    }
                ]
            },
        ],
        where: {
            id: id,
        },
        order: [
            ['id', 'asc']
        ],
    })

    // TODO Implementar descryptografia das anotações (NO FRONTEND)

    return retorno

}

module.exports.retorneTodos = async function (profissional_id, paciente_id, inicio_de, inicio_ate) {

    let condicao_where = {}

    if (profissional_id > 0)
        condicao_where["$agenda.profissioal_agendado_id$"] = profissional_id

    if (paciente_id > 0)
        condicao_where["$agenda.paciente_agendado_id$"] = paciente_id

    if ((inicio_de && inicio_ate) && (Date.parse(inicio_de) > 0 && Date.parse(inicio_ate) > 0)) {
        const data_vencimento = { [Op.between]: [inicio_de, inicio_ate] };
        condicao_where["datahora_inicio"] = data_vencimento;
    }

    return await AtendimentoModel.findAll({
        attributes: atributos_Atendimento,
        include: [
            {
                model: AgendasModel, as: 'agenda',
                attributes: ['id', 'di', 'descricao', 'observacao', 'evento_inicio', 'evento_fim', 'evento_confirmado', 'ativo'],
                include: [
                    {
                        model: ProfissionalModel, as: 'profissional',
                        attributes: ['id', 'di', 'nome', 'celular', 'email', 'ativo']
                    },
                    {
                        model: PacienteModel, as: 'paciente',
                        attributes: ['id', 'di', 'nome', 'celular', 'email', 'ativo']
                    }
                ]
            },
        ],
        where: condicao_where,
        order: [
            ['datahora_inicio', 'asc']
        ],
    })

    // TODO Implementar descryptografia das anotações (NO FRONTEND)
}