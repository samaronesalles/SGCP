const path = require('path')

const express = require("express")
const router = express.Router()

// Importação dos controllers...
const profissionaisController = require(path.resolve(__dirname, '../', 'controllers', 'profissional.controller.js'))
const profissionaisVallication = require(path.resolve(__dirname, '../', 'controllers', 'vallidations', 'profissional.vallidation.js'))


// Endpoints "Profissionais"...
router.post('/profissionais', profissionaisVallication.saveCad, profissionaisVallication.cadJaExistente, profissionaisController.novo)
router.get('/profissionais/lista', profissionaisController.lista)
router.put('/profissionais/:id/:di', profissionaisVallication.edicaoCad, profissionaisVallication.saveCad, profissionaisController.editar)
router.put('/profissionais/ativar/:id/:di', profissionaisVallication.edicaoCad, profissionaisController.ativar)
router.put('/profissionais/inativar/:id/:di', profissionaisVallication.inativar, profissionaisController.inativar)
router.delete('/profissionais/:id/:di', profissionaisVallication.exclusaoCad, profissionaisController.delete)
router.post('/profissionais/login', profissionaisVallication.login, profissionaisController.autenticaLogin)

// Endpoints "Pacientes"...


// Endpoints "Gerais"...
router.get('/health', function (req, res) {
    res.status(200).send('Servidor online!')
})

// 404
router.get('*', function (req, res) {
    res.status(404).send('Servidor online. Informe uma rota válida!')
})

module.exports = router