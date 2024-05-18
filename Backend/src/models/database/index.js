const path = require('path')
const Sequelize = require('sequelize')

const dbConfig = require(path.resolve(__dirname, '../', '../', 'config', 'mysql.config.js'))


// Importando models criados...
const Profissional = require(path.resolve(__dirname, '../', 'profissional.model.js'))
const Paciente = require(path.resolve(__dirname, '../', 'paciente.model.js'))


// criando conexão com o banco de dados...
const connection = new Sequelize(dbConfig)


// para cada model, "instanciar" chamando seu método init, passando a nossa conexão por parâmetro...
Profissional.init(connection)
Paciente.init(connection)

module.exports = connection