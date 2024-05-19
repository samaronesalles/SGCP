const { Model, DataTypes } = require('sequelize')

class Profissional extends Model {

    static init(sequelize) {
        super.init({
            di: DataTypes.STRING,
            nome: DataTypes.STRING,
            celular: DataTypes.STRING,
            email: DataTypes.STRING,
            ativo: DataTypes.BOOLEAN,
            username: DataTypes.STRING,
            password: DataTypes.STRING
        }, {
            tableName: 'profissionais',
            sequelize
        })
    }

    static associate(models) {
        this.hasMany(models.Agenda)
    }
}

module.exports = Profissional