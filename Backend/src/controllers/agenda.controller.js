const path = require('path')
const moment = require('moment')
const nodeSchedule = require('node-schedule') // Usar https://crontab.guru/ para gerar o comando de agendamento...
// Exemplo diário as 8 da manhã: '0 8 * * *'

const uteis = require(path.resolve(__dirname, '../', 'utils', 'utils.js'))
const mensagens = require(path.resolve(__dirname, '../', 'services', 'messages.js'))
const whatsappApi = require(path.resolve(__dirname, '../', 'services', 'whatsapp.api.js'))

const AgendaModel = require(path.resolve(__dirname, '../', 'models', 'agenda.model.js'))
const AtendimentoModel = require(path.resolve(__dirname, '../', 'models', 'atendimento.model.js'))
const AgendaRepository = require(path.resolve(__dirname, '../', 'models', 'repositories', 'agenda.repository.js'))
const AgendaEnvioConfirmacaoRepository = require(path.resolve(__dirname, '../', 'models', 'repositories', 'agenda.envio.confirmacao.repository.js'))

const atualizeMensagensEnviadasParaConfirmacao = async () => {
    // PASSO 1: Retornar do bando de dados os ids das mensagens de whatsapp enviadas
    const mensagensEnviadasAnteriormente = await AgendaEnvioConfirmacaoRepository.retorneTodas()
    const idsMsgs = mensagensEnviadasAnteriormente.map(e => e.idMsg)

    // PASSO 2: Consultar nossa API de envio de mensagem por whatsapp, a situação destes IDs. 
    if (mensagensEnviadasAnteriormente.length > 0) {
        const situacaoDasMensagens = await whatsappApi.retorneStatusMensagens(idsMsgs)

        // PASSO 2.1: Percorrer cada status retornado e atualizar em banco de dados a situação atual da agenda.
        for (let situacaoMensagem of situacaoDasMensagens) {
            if (situacaoMensagem?.status !== "respondida")
                continue

            const resposta = situacaoMensagem?.resposta?.mensagem ?? ""
            if (resposta.toUpperCase() !== "SIM")
                continue

            const idMsg = situacaoMensagem.id
            const idAgenda = mensagensEnviadasAnteriormente.find(mensagem => mensagem.idMsg === idMsg)?.agenda_id ?? 0

            if (idAgenda === 0)
                continue

            await AgendaRepository.confirmeSessao(idAgenda)
        }

        // PASSO 2.2: Excluir do nosso banco de dados, os IDs das mensagens enviadas às agendas que forem retornadas no passo 1. E, excluir TODOS
        //            os ids das mensagens de whatsapp enviadas anteriormente.
        try {
            await AgendaEnvioConfirmacaoRepository.delete(idsMsgs)
            await whatsappApi.excluirMensagens(idsMsgs)
        } catch (error) {
            console.log(`Ao "excluirMensagens()": ${error}`)
        }
    }
}

const processeConfirmacoesDeAgendamentos = async () => {

    console.log("processeConfirmacoesDeAgendamentos()")

    const now = new Date()

    const DataExecucao = now.toLocaleDateString('pt-BR') // Formato DD/MM/YYYY
    const HoraExecucao = now.toLocaleTimeString('pt-BR', { hour: '2-digit', minute: '2-digit' }) // Formato HH:mm

    // PASSO 1: Retorna mensagens enviadas solicitando confirmação, confere o status atual das mesmas e confirma os agendamentos que o 
    //          usuário respondeu "SIM" na mensagem. Em seguida, exclui do banco de dados estas mensagens.
    await atualizeMensagensEnviadasParaConfirmacao()

    // PASSO 2: Retornar do banco de dados agendamentos para o dia seguinte
    const diaSeguinte = moment().add(1, 'days')
    const inicio_de = diaSeguinte.startOf('day').toDate()
    const inicio_ate = diaSeguinte.endOf('day').toDate()

    let agendasDiaSeguinte = await AgendaRepository.retorneTodas(0, 0, inicio_de, inicio_ate)

    agendasDiaSeguinte = agendasDiaSeguinte.filter(agenda => (!agenda.evento_confirmado && agenda.ativo))

    // PASSO 3: Requisitar à nossa API de envio de mensagem por whatsapp, envio de mensagem para estes pacientes
    if (agendasDiaSeguinte.length > 0) {
        for (let agenda of agendasDiaSeguinte) {
            try {
                const idMsg = await whatsappApi.enviarMensagem(agenda)

                await AgendaEnvioConfirmacaoRepository.insert(agenda.id, idMsg)
            } catch (error) {
                console.log(`Em Loop "agendasDiaSeguinte": ${error}`)
            }
        }
    }

    // Concluindo...
    console.log(`"processeConfirmacoesDeAgendamentos()", última execução em: ${DataExecucao} ${HoraExecucao}`)
    console.log(`Resultado da execução: Sucesso`)

}

const job = nodeSchedule.scheduleJob('0 8 * * *', processeConfirmacoesDeAgendamentos)
console.log(job.nextInvocation())

module.exports = {

    async teste(req, res) {
        console.log("Entrou em teste()")

        res.status(200).json({})

        await processeConfirmacoesDeAgendamentos()
    },

    async nova(req, res) {
        try {
            const { profissional_id, paciente_id, descricao, observacao, evento_inicio, evento_fim, evento_confirmado } = req.body

            // Criando agenda...
            const dados_agenda = {
                profissional_criador_id: profissional_id, //TODO: Alterar no futuro para usar o id do usuário autenticado na API. Obviamente quando eu implementar a autenticação.
                profissional_agendado_id: profissional_id,
                paciente_agendado_id: paciente_id,
                di: uteis.new_uuid(),
                descricao: descricao,
                observacao: observacao,
                evento_inicio: evento_inicio,
                evento_fim: evento_fim,
                evento_confirmado: evento_confirmado || false,
                ativo: true
            }

            const nova_agenda = await AgendaModel.create(dados_agenda)

            if (!nova_agenda)
                throw new Error(mensagens.translateMessage(2516))


            // Criando atendimento...
            const dados_atendimento = {
                di: uteis.new_uuid(),
                agenda_origem_id: nova_agenda.id,
                datahora_inicio: nova_agenda.evento_inicio
            }

            const novo_atendimento = await AtendimentoModel.create(dados_atendimento)

            if (!novo_atendimento) {
                // Necessário excluir a agenda se o atencimento falhar
                await AgendaModel.destroy({
                    where: { id: dados_agenda.id, }
                })

                throw new Error(mensagens.translateMessage(2516))
            }


            // Montando resultado final...
            const resposta_final = await AgendaRepository.retornePeloID(novo_atendimento.id)

            return res.status(200).json(mensagens.resultExternal(1001, false, resposta_final))
        } catch (error) {
            return res.status(400).json(mensagens.resultError(error))
        }
    },

    async editar(req, res) {
        try {
            const { id, di } = req.params
            const { profissional_id, paciente_id, descricao, observacao, evento_inicio, evento_fim, evento_confirmado } = req.body

            const agendaEncontrada = await AgendaRepository.retornePeloID(id)

            const dados = {
                profissional_agendado_id: profissional_id,
                paciente_agendado_id: paciente_id,
                di: uteis.new_uuid(),
                descricao: descricao,
                observacao: observacao,
                evento_inicio: evento_inicio,
                evento_fim: evento_fim,
                evento_confirmado: evento_confirmado || false,
                ativo: true
            }

            await agendaEncontrada.update(dados, {
                where: {
                    id: id
                },
                returning: true,
                plain: true
            })

            return res.status(200).json(mensagens.resultExternal(1001, false, agendaEncontrada))

        } catch (error) {
            return res.status(400).json(mensagens.resultError(error))
        }
    },

    async getAgenda(req, res) {
        try {
            const { id } = req.params

            let Agenda = await AgendaRepository.retornePeloID(id)

            return res.status(200).json(mensagens.resultExternal(200, false, Agenda))
        } catch (error) {
            return res.status(400).json(mensagens.resultError(error))
        }
    },

    async lista(req, res) {
        try {
            const { profissional_id, paciente_id, inicio_de, inicio_ate } = req.params

            // PASSO 1: Retorna mensagens enviadas solicitando confirmação, confere o status atual das mesmas e confirma os agendamentos que o
            //          usuário respondeu "SIM" na mensagem. Em seguida, exclui do banco de dados estas mensagens.
            await atualizeMensagensEnviadasParaConfirmacao()

            // PASSO 2: Retorna finalmene a lista de agendas.
            let Agendas = await AgendaRepository.retorneTodas(profissional_id, paciente_id, inicio_de, inicio_ate)

            return res.status(200).json(mensagens.resultExternal(200, false, Agendas))
        } catch (error) {
            return res.status(400).json(mensagens.resultError(error))
        }
    },

    async cancelamento(req, res) {
        try {
            const { id, di } = req.params

            const Agenda = await AgendaRepository.retornePeloID(id)

            const dados = {
                di: uteis.new_uuid(),
                ativo: false
            }

            await Agenda.update(dados, {
                where: {
                    id: id
                },
                returning: true,
                plain: true
            })

            return res.status(200).json(mensagens.resultExternal(1001, false, Agenda))

        } catch (error) {
            return res.status(400).json(mensagens.resultError(error))
        }

    }

}