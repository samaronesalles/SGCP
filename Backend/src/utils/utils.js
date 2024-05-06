const uuid = require('uuid')

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

module.exports.new_uuid = function () {
    return uuid.v4()
}