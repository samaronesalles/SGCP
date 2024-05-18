const path = require('path')
const uteis = require(path.resolve(__dirname, '../', '../', 'utils', 'utils.js'))

const PacienteModel = require(path.resolve(__dirname, '../', 'paciente.model.js'))

const atributos_Paciente = ['id', 'di', 'nome', 'celular', 'email', 'ativo']

module.exports.retornePeloID = async function (id) {
    return await PacienteModel.findByPk(id, {
        attributes: atributos_Paciente,
    })
}

module.exports.retornePeloEmail = async function (email) {
    const registro = await PacienteModel.findOne({
        where: {
            email: email,
        },
    })

    return registro
}

module.exports.retorneTodos = async function () {
    return await PacienteModel.findAll()
}