const { Model, DataTypes } = require('sequelize')

class Paciente extends Model {

    static init(sequelize) {
        super.init({
            di: DataTypes.STRING,
            nome: DataTypes.STRING,
            celular: DataTypes.STRING,
            email: DataTypes.STRING,
            ativo: DataTypes.BOOLEAN
        }, {
            tableName: 'pacientes',
            sequelize
        })
    }

}

module.exports = Paciente