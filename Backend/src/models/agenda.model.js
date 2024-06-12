const { Model, DataTypes } = require('sequelize')

class Agenda extends Model {

    static init(sequelize) {
        super.init({
            di: DataTypes.STRING,
            descricao: DataTypes.STRING,
            observacao: DataTypes.STRING,
            evento_inicio: DataTypes.DATE,
            evento_fim: DataTypes.DATE,
            evento_confirmado: DataTypes.BOOLEAN,
            ativo: DataTypes.BOOLEAN
        }, {
            tableName: 'agendas',
            sequelize
        })
    }

    static associate(models) {
        this.belongsTo(models.Profissional, { foreignKey: 'profissional_criador_id' })
        this.belongsTo(models.Profissional, { foreignKey: 'profissional_agendado_id', as: 'profissional' })
        this.belongsTo(models.Paciente, { foreignKey: 'paciente_agendado_id', as: 'paciente' })
        this.hasOne(models.Atendimento)
    }

}

module.exports = Agenda