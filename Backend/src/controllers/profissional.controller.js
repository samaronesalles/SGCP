const path = require('path')
const uteis = require(path.resolve(__dirname, '../', 'utils', 'utils.js'))
const mensagens = require(path.resolve(__dirname, '../', 'services', 'messages.js'))

const ProfissionalModel = require(path.resolve(__dirname, '../', 'models', 'profissional.model.js'))
const ProfissionalRepository = require(path.resolve(__dirname, '../', 'models', 'repositories', 'profissional.repository.js'))

module.exports = {

    async novo(req, res) {
        try {
            const { nome, celular, email, ativo, username, password } = req.body

            const dados = {
                di: uteis.new_uuid(),
                nome: nome,
                celular: uteis.onlyNumbersOnString(celular || ''),
                email: email,
                ativo: ativo,
                username: username,
                password: uteis.encrypt(password)
            }

            let novo_profissional = await ProfissionalModel.create(dados)

            novo_profissional = await ProfissionalRepository.retornePeloID(novo_profissional.id)

            return res.status(200).json(mensagens.resultExternal(1001, false, novo_profissional))
        } catch (error) {
            return res.status(400).json(mensagens.resultError(error))
        }
    },

    async lista(req, res) {

        try {
            let profissionais = await ProfissionalRepository.retorneTodos()

            profissionais = profissionais.map((e) => {
                e.password = uteis.decrypt(e.password)
                return e
            })

            return res.status(200).json(mensagens.resultExternal(200, false, profissionais))

        } catch (error) {
            return res.status(400).json(mensagens.resultError(error))
        }

    },

    async editar(req, res) {
        try {
            const { id, di } = req.params
            const { nome, celular, email, ativo, username, password } = req.body

            const profissionalEncontrado = await ProfissionalRepository.retornePeloID(id)

            const dados = {
                di: uteis.new_uuid(),
                nome: nome,
                celular: uteis.onlyNumbersOnString(celular || ''),
                email: email,
                ativo: ativo,
                username: username,
                password: uteis.encrypt(password)
            }

            await profissionalEncontrado.update(dados, {
                where: {
                    email: email
                },
                returning: true,
                plain: true
            });

            profissionalEncontrado.password = uteis.decrypt(password)

            return res.status(200).json(mensagens.resultExternal(1001, false, profissionalEncontrado))

        } catch (error) {
            return res.status(400).json(mensagens.resultError(error))
        }
    },

    async delete(req, res) {
        try {
            const { id } = req.params

            await ProfissionalModel.destroy({
                where: {
                    id: id,
                }
            });

            return res.status(200).json(mensagens.resultDefault(1002))

        } catch (error) {
            return res.status(400).json(mensagens.resultError(error))
        }
    },

    async ativar(req, res) {
        try {
            const { id, di } = req.params

            const profissionalEncontrado = await ProfissionalRepository.retornePeloID(id)

            let dados = { ...profissionalEncontrado }

            dados.ativo = true
            dados.di = uteis.new_uuid()

            await profissionalEncontrado.update(dados, {
                returning: true,
                plain: true
            });

            return res.status(200).json(mensagens.resultExternal(200, false, profissionalEncontrado))

        } catch (error) {
            return res.status(400).json(mensagens.resultError(error))
        }
    },

    async inativar(req, res) {
        try {
            const { id, di } = req.params

            const profissionalEncontrado = await ProfissionalRepository.retornePeloID(id)

            let dados = { ...profissionalEncontrado }

            dados.ativo = false
            dados.di = uteis.new_uuid()

            await profissionalEncontrado.update(dados, {
                returning: true,
                plain: true
            });

            return res.status(200).json(mensagens.resultExternal(200, false, profissionalEncontrado))

        } catch (error) {
            return res.status(400).json(mensagens.resultError(error))
        }
    },

    async autenticaLogin(req, res) {
        try {
            const { email, username, password } = req.body

            const profissional = await ProfissionalRepository.retornePeloEmail(email)

            if (!profissional)
                return res.status(200).json(mensagens.resultDefault(2507))

            if (!profissional.ativo)
                return res.status(200).json(mensagens.resultDefault(2507))

            let pass = profissional.password
            pass = await uteis.decrypt(pass)

            if ((profissional.username !== username) || (pass !== password))
                return res.status(200).json(mensagens.resultDefault(2507))

            return res.status(200).json(mensagens.resultDefault(2001))
        } catch (error) {
            return res.status(400).json(mensagens.resultDefault(2507))
        }
    }

}
