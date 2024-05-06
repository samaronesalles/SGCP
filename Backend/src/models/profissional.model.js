const { Model, DataTypes } = require('sequelize')

class Profissional extends Model {

    static init(sequelize) {
        super.init({
            nome: DataTypes.STRING,
            celular: DataTypes.STRING,
            username: DataTypes.STRING,
            password: DataTypes.STRING
        }, {
            tableName: 'profissionais',
            sequelize
        })
    }

}

module.exports = Profissional