const path = require('path')

const messages = require(path.resolve(__dirname, '../', '../', 'services', 'messages.js'))

const unknownError = (err, res) => {
    const code = 500

    let msg = ''

    if (err.name !== undefined)
        msg += `${err.name}: `

    if (err.message !== undefined)
        msg += `${err.message}`

    if (msg.trim() == '')
        msg = "An unknown error occured."

    res.status(code).send(messages.resultExternal(code, true, msg))
}

module.exports = (err, req, res, next) => {

    try {
        // if (err.name === 'ValidationError')
        //     return err = handleValidationError(err, res)

        return err = unknownError(err, res)    // Se não existir isto, não vai cair no cath NUNCA caso não encontre um dos erros conhecidos.

    } catch (err) {
        res.status(500).send(messages.resultExternal(500, true, err.message))
    }

}