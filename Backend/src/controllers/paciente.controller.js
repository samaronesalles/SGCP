const path = require('path')
const uteis = require(path.resolve(__dirname, '../', 'utils', 'utils.js'))
const mensagens = require(path.resolve(__dirname, '../', 'services', 'messages.js'))

const PacienteModel = require(path.resolve(__dirname, '../', 'models', 'paciente.model.js'))
const PacienteRepository = require(path.resolve(__dirname, '../', 'models', 'repositories', 'paciente.repository.js'))

module.exports = {

    async novo(req, res) {
        try {
            const { nome, celular, email, ativo } = req.body

            const dados = {
                di: uteis.new_uuid(),
                nome: nome,
                celular: uteis.onlyNumbersOnString(celular || ''),
                email: email,
                ativo: ativo
            }

            let novo_pessoal = await PacienteModel.create(dados)

            novo_pessoal = await PacienteRepository.retornePeloID(novo_pessoal.id)

            return res.status(200).json(mensagens.resultExternal(1001, false, novo_pessoal))
        } catch (error) {
            return res.status(400).json(mensagens.resultError(error))
        }
    },

    async lista(req, res) {

        try {
            let pacientes = await PacienteRepository.retorneTodos()

            return res.status(200).json(mensagens.resultExternal(200, false, pacientes))
        } catch (error) {
            return res.status(400).json(mensagens.resultError(error))
        }

    },

    async editar(req, res) {
        try {
            const { id, di } = req.params
            const { nome, celular, email, ativo } = req.body

            const pacienteEncontrado = await PacienteRepository.retornePeloID(id)

            const dados = {
                di: uteis.new_uuid(),
                nome: nome,
                celular: uteis.onlyNumbersOnString(celular || ''),
                email: email,
                ativo: ativo
            }

            await pacienteEncontrado.update(dados, {
                where: {
                    email: email
                },
                returning: true,
                plain: true
            })

            return res.status(200).json(mensagens.resultExternal(1001, false, pacienteEncontrado))

        } catch (error) {
            return res.status(400).json(mensagens.resultError(error))
        }
    },

    async delete(req, res) {
        try {
            const { id } = req.params

            await PacienteModel.destroy({
                where: {
                    id: id,
                }
            })

            return res.status(200).json(mensagens.resultDefault(1002))

        } catch (error) {
            return res.status(400).json(mensagens.resultError(error))
        }
    },

    async ativar(req, res) {
        try {
            const { id, di } = req.params

            const pacienteEncontrado = await PacienteRepository.retornePeloID(id)

            let dados = { ...pacienteEncontrado }

            dados.ativo = true
            dados.di = uteis.new_uuid()

            await pacienteEncontrado.update(dados, {
                returning: true,
                plain: true
            })

            return res.status(200).json(mensagens.resultExternal(200, false, pacienteEncontrado))

        } catch (error) {
            return res.status(400).json(mensagens.resultError(error))
        }
    },

    async inativar(req, res) {
        try {
            const { id, di } = req.params

            const pacienteEncontrado = await PacienteRepository.retornePeloID(id)

            let dados = { ...pacienteEncontrado }

            dados.ativo = false
            dados.di = uteis.new_uuid()

            await pacienteEncontrado.update(dados, {
                returning: true,
                plain: true
            })

            return res.status(200).json(mensagens.resultExternal(200, false, pacienteEncontrado))

        } catch (error) {
            return res.status(400).json(mensagens.resultError(error))
        }
    },

}