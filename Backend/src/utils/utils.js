const path = require('path')

const uuid = require('uuid')
const crypt = require(path.resolve(__dirname, '../', 'services', 'encrypt.js'))

module.exports.onlyNumbersOnString = function (text) {
    let st = text

    return st.replace(/\D/g, "")
}

module.exports.fillLeft = function (tam, numero) {
    return `000000000${numero.toString()}`.slice(-tam)
}

module.exports.fillLeftFloat = function (tam, numero) {
    return `00000000000000${numero.toString()}`.slice(-tam)
}

module.exports.insertStr_inStr = function (strOriginal, StrInserir, posInicial) {
    return (""
        + strOriginal.substring(0, posInicial)
        + StrInserir
        + strOriginal.substring(posInicial)
    )
}

module.exports.isObject = function (variavel) {
    return typeof variavel === 'object'
}

module.exports.isNumber = function (val) {
    return !isNaN(parseFloat(val)) && isFinite(val)
}

module.exports.strEmpty = function (val) {
    if (!val)
        return true

    return (val === "")
}

module.exports.new_uuid = function () {
    return uuid.v4()
}

module.exports.encrypt = function (str) {
    try {

        if (!str)
            return ""

        if (str.trim() === "")
            return ""

        return crypt.encrypt(str)

    } catch (error) {
        return ""
    }
}

module.exports.decrypt = function (str) {
    try {
        return crypt.decrypt(str)
    } catch (error) {
        return str
    }
}

module.exports.checagem_di = async function (registro, di) {
    /*
    Retorno:
       -1 = ERRO
        0 = Tudo OK
        1 = Registro não encontrado
        2 = Registro passado para comparação é diferente do encontrado no banco de dados
    */

    if (!registro?.id)
        return 1
    else {
        if (di !== registro.di)
            return 2
    }

    return 0
}