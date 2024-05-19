const { Model, DataTypes } = require('sequelize')

class Agenda extends Model {

    static init(sequelize) {
        super.init({
            di: DataTypes.STRING,
            descricao: DataTypes.STRING,
            observacao: DataTypes.STRING,
            evento_inicio: DataTypes.DATE,
            evento_fim: DataTypes.DATE,
            evento_confirmado: DataTypes.BOOLEAN
        }, {
            tableName: 'agendas',
            sequelize
        })
    }

    static associate(models) {
        this.belongsTo(models.Profissional, { foreignKey: 'profissioal_criador_id' })
        this.belongsTo(models.Profissional, { foreignKey: 'profissioal_agendado_id' })
        this.belongsTo(models.Paciente, { foreignKey: 'paciente_agendado_id' })
        this.hasOne(models.Atendimento)
    };

}

module.exports = Agenda