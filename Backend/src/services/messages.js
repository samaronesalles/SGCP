const path = require('path')

module.exports.messagesDefault = {

    200: { error: false, message: "Sucesso." },
    400: { error: true, message: "Falha." },

    // Faixa 1000 a 1999 = Mensagens genéricas (1000 a 1500 = coisas de sucesso  / 1501 a 2000 = coisas de falha)
    // MENSAGENS DE SUCESSO
    1000: { error: false, message: "Nenhum registro encontrado." },
    1001: { error: false, message: "Registro salvo com sucesso." },      // "Salvar" entende-se tanto em inclusão/alteração
    1002: { error: false, message: "Registro excluído com sucesso." },
    1003: { error: false, message: "Nenhum registro encontrado para ser alterado." },
    // 1004: { error: false, message: "xxxxxx" },
    // 1005: { error: false, message: "xxxxxx" },


    // MENSAGENS DE FALHA
    1501: { error: true, message: "Falha ao salvar o registro." },       // "Salvar" entende-se tanto em inclusão/alteração
    1502: { error: true, message: "Falha ao excluir o registro." },
    // 1503: { error: true, message: "xxxxxx" },
    // 1504: { error: true, message: "xxxxxx" },
    // 1505: { error: true, message: "xxxxxx" },


    // Faixa 2000 a 2999 = Mensagens específicas da regra de negócio da API em questão (2000 a 2500 = coisas de sucesso  / 2501 a 3000 = coisas de falha)
    // MENSAGENS DE SUCESSO
    2000: { error: false, message: "Cadastro atual no banco de dados está diferente do registro solicitado." },
    2001: { error: false, message: "Login realizado com sucesso" },
    // 2002: { error: false, message: "xxxxxx" },
    // 2003: { error: false, message: "xxxxxx" },
    // 2004: { error: false, message: "xxxxxx" },


    // MENSAGENS DE FALHA
    2501: { error: true, message: "Login ou senha do profissional não foram informados." },
    2502: { error: true, message: 'Campo "nome" do profissional é obrigatório.' },
    2503: { error: true, message: 'Campo "celular" do profissional é obrigatório.' },
    2504: { error: true, message: 'Campo "e-mail" do profissional é obrigatório.' },
    2505: { error: true, message: "Já existe um profissional cadastrado para este email." },
    2506: { error: true, message: 'Campo "e-mail" do profissional é inválido.' },
    2507: { error: true, message: "Email, Usuário ou Senha do usuário inválidos. Verifique!" },
    2508: { error: true, message: "O profissional já se encontra inativado." },
    2509: { error: true, message: 'Campo "e-mail" do paciente é obrigatório.' },
    2510: { error: true, message: "Já existe um paciente cadastrado para este email." },
    2511: { error: true, message: 'Campo "nome" do paciente é obrigatório.' },
    2512: { error: true, message: 'Campo "celular" do paciente é obrigatório.' },
    2513: { error: true, message: 'Campo "e-mail" do paciente é obrigatório.' },
    2514: { error: true, message: 'Campo "e-mail" do paciente é inválido.' },
    2515: { error: true, message: "O paciente já se encontra inativado." },
    2516: { error: true, message: "Ocorreu uma falha ao salvar a nova agenda. Tente novamente e caso a falha persista, entre em contato com o suporte." },
    2517: { error: true, message: 'O "username" informado já está sendo utilizado por outro profissional. Tente outro.' },
    2518: { error: true, message: "A data e hora do encerramento do atendimento não foi preenchida." },
    2519: { error: true, message: "O atendimento não pode ser editado, pois encontra-se encerrado." },
    2520: { error: true, message: 'Campo "anotacoes" é obrigatório.' },
    2521: { error: true, message: "Não é possível editar o atendimento, pois sua agenda está cancelada." },
    2522: { error: true, message: "A data e hora do agendamento não foi preenchida." },
    2523: { error: true, message: "O profissional selecionado não existe, ou encontra-se inativado" },
    2524: { error: true, message: "O paciente selecionado não existe, ou encontra-se inativado" },
    2525: { error: true, message: `Agendamento inválido por "conflito" de horário agendado para o profissional` },
    2526: { error: true, message: `Agendamento inválido por "conflito" de horário agendado para o paciente` },
    2527: { error: true, message: "Não é possível cancelar a agenda, pois a mesma já se encontra cancelada" },
    2528: { error: true, message: "A agenda não pode ser cancelada, pois o atendimento vinculado a mesma encontra-se encerrado" },
    2529: { error: true, message: "O profissional não pode ser excluído, pois está vinculado em alguma agenda (nova ou antiga). Ao invés de excluí-lo, você deve inativá-lo" },
    2530: { error: true, message: "O paciente não pode ser excluído, pois está vinculado em alguma agenda (nova ou antiga). Ao invés de excluí-lo, você deve inativá-lo" },
    // 2531: { error: true, message: "xxxxxx" },
    // 2532: { error: true, message: "xxxxxx" },
    // 2533: { error: true, message: "xxxxxx" },
    // 2534: { error: true, message: "xxxxxx" },
    // 2535: { error: true, message: "xxxxxx" },


    // 9999 = Reservado para "Retorno desconhecido"
    9999: { error: true, message: "Retorno desconhecido." },
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