const path = require('path')
const uteis = require(path.resolve(__dirname, '../', '../', 'utils', 'utils.js'))

const ProfissionalModel = require(path.resolve(__dirname, '../', 'profissional.model.js'))

const atributos_Profissional = ['id', 'di', 'nome', 'celular', 'email', 'ativo', 'username', 'password']

module.exports.retornePeloID = async function (id) {
    return await ProfissionalModel.findByPk(id, {
        attributes: atributos_Profissional,
    })
}

module.exports.retornePeloEmail = async function (email) {
    const registro = await ProfissionalModel.findOne({
        where: {
            email: email,
        },
    })

    return registro
}

module.exports.retorneUmOpcional = async function (condicao) {
    const registro = await ProfissionalModel.findOne({
        where: condicao,
    })

    return registro
}

module.exports.retorneTodos = async function () {
    return await ProfissionalModel.findAll()
}