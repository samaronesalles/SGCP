const path = require('path')
const uteis = require(path.resolve(__dirname, '../', 'utils', 'utils.js'))
const mensagens = require(path.resolve(__dirname, '../', 'services', 'messages.js'))

const ProfissionalModel = require(path.resolve(__dirname, '../', 'models', 'profissional.model.js'))

const atributos_Profissional = ['id', 'nome', 'celular', 'username', 'password']

module.exports = {

    async novo(req, res) {
        try {
            const { nome, celular, username, password } = req.body

            const dados = {
                nome: nome,
                celular: uteis.onlyNumbersOnString(celular || ''),
                username: username,
                password: password
            }

            let novo_profissional = await ProfissionalModel.create(dados)

            novo_profissional = await ProfissionalModel.findByPk(novo_profissional.id, {
                attributes: atributos_Profissional,
            })

            return res.status(200).json(mensagens.resultExternal(1001, false, novo_profissional))
        } catch (error) {
            console.log(error)
            return res.status(400).json(mensagens.resultError(error))
        }
    },

    async lista(req, res) {

        try {

            const profissionais = await ProfissionalModel.findAll({
                attributes: atributos_Profissional
            })

            return res.status(200).json(mensagens.resultExternal(1001, false, profissionais))

        } catch (error) {
            console.log(error)
            return res.status(400).json(mensagens.resultError(error))
        }

    },

}
