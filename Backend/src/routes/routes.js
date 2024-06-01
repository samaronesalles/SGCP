const path = require('path')

const express = require("express")
const router = express.Router()

// Importação dos controllers...
const profissionaisController = require(path.resolve(__dirname, '../', 'controllers', 'profissional.controller.js'))
const profissionaisValidation = require(path.resolve(__dirname, '../', 'controllers', 'validations', 'profissional.validation.js'))
const pacientesController = require(path.resolve(__dirname, '../', 'controllers', 'paciente.controller.js'))
const pacientesValidation = require(path.resolve(__dirname, '../', 'controllers', 'validations', 'paciente.validation.js'))
const agendasController = require(path.resolve(__dirname, '../', 'controllers', 'agenda.controller.js'))
const agendasValidation = require(path.resolve(__dirname, '../', 'controllers', 'validations', 'agenda.validation.js'))
const atendimentosController = require(path.resolve(__dirname, '../', 'controllers', 'atendimento.controller.js'))
const atendimentosValidation = require(path.resolve(__dirname, '../', 'controllers', 'validations', 'atendimento.validation.js'))

// Endpoints "Profissionais"...
router.post('/profissionais', profissionaisValidation.saveCad, profissionaisValidation.cadJaExistente, profissionaisController.novo)
router.get('/profissionais/lista', profissionaisController.lista)
router.put('/profissionais/:id/:di', profissionaisValidation.edicaoCad, profissionaisValidation.saveCad, profissionaisController.editar)
router.put('/profissionais/ativar/:id/:di', profissionaisValidation.edicaoCad, profissionaisController.ativar)
router.put('/profissionais/inativar/:id/:di', profissionaisValidation.inativar, profissionaisController.inativar)
router.delete('/profissionais/:id/:di', profissionaisValidation.exclusaoCad, profissionaisController.delete)
router.post('/profissionais/login', profissionaisValidation.login, profissionaisController.autenticaLogin)

// Endpoints "Pacientes"...
router.post('/pacientes', pacientesValidation.saveCad, pacientesValidation.cadJaExistente, pacientesController.novo)
router.get('/pacientes/lista', pacientesController.lista)
router.put('/pacientes/:id/:di', pacientesValidation.edicaoCad, pacientesValidation.saveCad, pacientesController.editar)
router.put('/pacientes/ativar/:id/:di', pacientesValidation.edicaoCad, pacientesController.ativar)
router.put('/pacientes/inativar/:id/:di', pacientesValidation.inativar, pacientesController.inativar)
router.delete('/pacientes/:id/:di', pacientesValidation.exclusaoCad, pacientesController.delete)

// Endpoints "Agenda"...
router.post('/agenda', agendasValidation.nova, agendasController.nova)
router.put('/agenda/:id/:di', agendasValidation.editar, agendasController.editar)
router.get('/agenda/lista/:profissional_id/:paciente_id/:inicio_de/:inicio_ate', agendasController.lista)
router.get('/agenda/:id', agendasController.getAgenda)
router.put('/agenda/cancelar/:id/:di', agendasValidation.cancelamento, agendasController.cancelamento)

// Endpoints "Atendimentos"...
router.get('/atendimentos/:id', atendimentosController.getAtendimento)
router.get('/atendimentos/lista/:status/:profissional_id/:paciente_id/:inicio_de/:inicio_ate', atendimentosController.lista)
router.put('/atendimentos/:id/:di', atendimentosValidation.editar, atendimentosController.editar)
router.put('/atendimentos/encerrar/:id/:di', atendimentosValidation.encerrar, atendimentosController.encerrar)

// Endpoints "Gerais"...
router.get('/health', function (req, res) {
    res.status(200).send('Servidor online!')
})

// 404
router.get('*', function (req, res) {
    res.status(404).send('Servidor online. Informe uma rota válida!')
})

module.exports = router