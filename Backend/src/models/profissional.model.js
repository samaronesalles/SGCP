const { Model, DataTypes } = require('sequelize')

class Profissional extends Model {

    static init(sequelize) {
        super.init({
            di: DataTypes.STRING,
            nome: DataTypes.STRING,
            celular: DataTypes.STRING,
            email: DataTypes.STRING,
            username: DataTypes.STRING,
            password: DataTypes.STRING
        }, {
            tableName: 'profissionais',
            sequelize
        })
    }

}

module.exports = Profissional