const express = require("express")
const cors = require("cors")
const path = require('path')

require(path.resolve(__dirname, 'models', 'database'))

require('dotenv').config()

process.env.TZ = 'America/Sao_Paulo'

const routes = require(path.resolve(__dirname, 'routes', 'routes.js'))
const app = express()
const middlewareErrors = require(path.resolve(__dirname, 'routes', 'middlewares', 'error.middleware.js'))

app.use(cors())

app.use(express.json())
app.use(express.urlencoded({ extended: true }))

app.use('/api', routes)
app.use(middlewareErrors)

app.listen(process.env.PORTA_API, () => {
    console.log('Servidor escutando na porta: ' + process.env.PORTA_API)
})
