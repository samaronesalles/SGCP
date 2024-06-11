const path = require('path')
const Sequelize = require('sequelize')

const dbConfig = require(path.resolve(__dirname, '../', '../', 'config', 'mysql.config.js'))

// Importando models criados...
const Profissional = require(path.resolve(__dirname, '../', 'profissional.model.js'))
const Paciente = require(path.resolve(__dirname, '../', 'paciente.model.js'))
const Agenda = require(path.resolve(__dirname, '../', 'agenda.model.js'))
const Atendimento = require(path.resolve(__dirname, '../', 'atendimento.model.js'))
const AgendaEnvioConfirmacao = require(path.resolve(__dirname, '../', 'agenda.envio.confirmacao.model.js'))

// criando conexão com o banco de dados...
const connection = new Sequelize(dbConfig)


// para cada model, "instanciar" chamando seu método init, passando a nossa conexão por parâmetro...
Profissional.init(connection)
Paciente.init(connection)
Agenda.init(connection)
Atendimento.init(connection)
AgendaEnvioConfirmacao.init(connection)

Agenda.associate(connection.models)
Atendimento.associate(connection.models)
AgendaEnvioConfirmacao.associate(connection.models)

module.exports = connection