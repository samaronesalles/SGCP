const path = require('path')

const express = require("express")
const router = express.Router()

// Importação dos controllers...
const profissionaisController = require(path.resolve(__dirname, '../', 'controllers', 'profissional.controller.js'))


// Endpoints...
router.post('/profissionais/novo', profissionaisController.novo)
router.get('/profissionais/lista', profissionaisController.lista)

router.get('/health', function (req, res) {
    res.status(200).send('Servidor online!')
})

// 404
router.get('*', function (req, res) {
    res.status(404).send('Servidor online. Informe uma rota válida!')
})

module.exports = router