const { Model, DataTypes } = require('sequelize')

class AgendaEnvioConfirmacao extends Model {

    static init(sequelize) {
        super.init({
            idMsg: DataTypes.STRING,
        }, {
            tableName: 'agendaEnvioConfirmacao',
            sequelize
        })
    }

    static associate(models) {
        this.belongsTo(models.Agenda, { foreignKey: 'agenda_id', as: 'agenda' })
    }

}

module.exports = AgendaEnvioConfirmacao