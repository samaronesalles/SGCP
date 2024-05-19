const path = require('path')
const uteis = require(path.resolve(__dirname, '../', 'utils', 'utils.js'))
const mensagens = require(path.resolve(__dirname, '../', 'services', 'messages.js'))

const AgendaModel = require(path.resolve(__dirname, '../', 'models', 'agenda.model.js'))
const AtendimentoModel = require(path.resolve(__dirname, '../', 'models', 'atendimento.model.js'))
const AgendaRepository = require(path.resolve(__dirname, '../', 'models', 'repositories', 'agenda.repository.js'))

module.exports = {

    async nova(req, res) {
        try {
            const { profissional_id, paciente_id, descricao, observacao, evento_inicio, evento_fim, evento_confirmado } = req.body

            // Criando agenda...
            const dados_agenda = {
                profissioal_criador_id: profissional_id, //TODO: Alterar no futuro para usar o id do usuário autenticado na API. Obviamente quando eu implementar a autenticação.
                profissioal_agendado_id: profissional_id,
                paciente_agendado_id: paciente_id,
                di: uteis.new_uuid(),
                descricao: descricao,
                observacao: observacao,
                evento_inicio: evento_inicio,
                evento_fim: evento_fim,
                evento_confirmado: evento_confirmado || false
            }

            const nova_agenda = await AgendaModel.create(dados_agenda)

            if (!nova_agenda)
                throw new Error(mensagens.translateMessage(2516))


            // Criando atendimento...
            const dados_atendimento = {
                di: uteis.new_uuid(),
                agenda_origem_id: nova_agenda.id,
                datahora_inicio: nova_agenda.datahora_inicio
            }

            const novo_atendimento = await AtendimentoModel.create(dados_atendimento)

            if (!novo_atendimento) {
                // Necessário excluir a agenda se o atencimento falhar
                await AgendaModel.destroy({
                    where: { id: dados_agenda.id, }
                });

                throw new Error(mensagens.translateMessage(2516))
            }


            // Montando resultado final...
            const resposta_final = {
                agenda: nova_agenda,
                atendimento: novo_atendimento
            }

            return res.status(200).json(mensagens.resultExternal(1001, false, resposta_final))
        } catch (error) {
            return res.status(400).json(mensagens.resultError(error))
        }
    },

}