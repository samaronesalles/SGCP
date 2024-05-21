const { Model, DataTypes } = require('sequelize')

class Atendimento extends Model {

    static init(sequelize) {
        super.init({
            di: DataTypes.STRING,
            datahora_inicio: DataTypes.DATE,
            datahora_fim: DataTypes.DATE,
            anotacoes: DataTypes.TEXT
        }, {
            tableName: 'atendimentos',
            sequelize
        })
    }

    static associate(models) {
        this.belongsTo(models.Agenda, { foreignKey: 'agenda_origem_id', as: 'agenda' })
    };

}

module.exports = Atendimento