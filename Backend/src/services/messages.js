const path = require('path')

module.exports.messagesDefault = {

    200: { error: false, message: "Sucesso" },
    400: { error: true, message: "Falha" },

    // Faixa 1000 a 1999 = Mensagens genéricas (1000 a 1500 = coisas de sucesso  / 1501 a 2000 = coisas de falha)
    1000: { error: false, message: "Nenhum registro encontrado" },
    1001: { error: false, message: "Registro salvo com sucesso" },      // "Salvar" entende-se tanto em inclusão/alteração
    1002: { error: false, message: "Registro excluído com sucesso" },
    // 1003: { error: false, message: "xxxxxx" },
    // 1004: { error: false, message: "xxxxxx" },
    // 1005: { error: false, message: "xxxxxx" },

    1501: { error: true, message: "Falha ao salvar o registro" },       // "Salvar" entende-se tanto em inclusão/alteração
    1502: { error: true, message: "Falha ao excluir o registro" },
    // 1503: { error: true, message: "xxxxxx" },
    // 1504: { error: true, message: "xxxxxx" },
    // 1505: { error: true, message: "xxxxxx" },
    /* ... ir criando aqui novas mensagens genéricas de acordo com a necessidade e com o tempo... */

    // Faixa 2000 a 2999 = Mensagens específicas da regra de negócio da API em questão (2000 a 2500 = coisas de sucesso  / 2501 a 3000 = coisas de falha)
    // 2000: { error: false, message: "xxxxxx" },
    // 2001: { error: false, message: "xxxxxx" },
    // 2002: { error: false, message: "xxxxxx" },

    // 2501: { error: true, message: "xxxxxx" },
    // 2502: { error: true, message: "xxxxxx" },
    // 2503: { error: true, message: "xxxxxx" },


    // 9999 = Reservado para "Retorno desconhecido"
    9999: { error: true, message: "Retorno desconhecido" },
}


module.exports.translateMessage = function (cod) {

    let msg = this.messagesDefault[cod]

    if (msg === undefined)
        msg = this.messagesDefault[9999] // Desconhecido

    return msg.message

}

module.exports.resultDefault = function (statusCode, n, addInfo) {

    let msg = this.messagesDefault[statusCode]

    if (msg === undefined)
        msg = this.messagesDefault[9999] // Desconhecido

    let resposta = {
        statusCode: statusCode,
        error: msg.error,
        data: msg.message
    }

    if (n !== undefined)               // Como a informação não é obrigatória, nem sempre precisa ser exibda, por isso colocada separada.
        resposta["rowsAffected"] = n

    if (addInfo !== undefined)               // Como a informação não é obrigatória, nem sempre precisa ser exibda, por isso colocada separada.
        resposta["addInfo"] = addInfo

    return resposta
}

module.exports.resultPags = function (statusCode, error, pag, pcount, qtdItens, data) {
    return {
        statusCode: statusCode,
        error: error,
        page: pag,
        pageCount: pcount,
        count: qtdItens,
        data: data
    }
}

// Qualquer retorno muito fora do padrão que não dê para usarmos a função "resultDefault", como por exemplo 
// algum retorno externo, vamos usar esta função aqui e o retorno e ficará dentro do atributo "data" podendo ser algum objeto ou mensagem de texto.
module.exports.resultExternal = function (statusCode, error, data) {
    return {
        statusCode: statusCode,
        error: error,
        data: data
    }
}

module.exports.resultError = function (error) {
    let msg = ''
    try {
        if (!blaster.isObject(error))
            msg = error
        else {
            if (!error)
                msg = "Erro desconhecido"
            else {
                try {
                    msg = error.data.error_description || error
                } catch {
                    if (e.message)
                        msg = error.message
                    else
                        msg = error
                }
            }
        }
    } catch {
        msg = error.message || "Erro desconhecido"
    }

    return {
        statusCode: error.statusCode || 400,
        error: true,
        data: msg
    }
}

// Método que pode ser usado para exportar a tabela para CSV
module.exports.messagesToCSV = function () {

    let St = "code;error;message;" + '\r\n'

    for (var MyProp in this.messagesDefault) {
        St += MyProp + ';'

        for (var MyObj in this.messagesDefault[MyProp]) {
            St += this.messagesDefault[MyProp][MyObj] + ';'
        }

        St += '\r\n'
    }

    return St
}