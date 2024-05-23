const path = require('path')
const uteis = require(path.resolve(__dirname, '../', 'utils', 'utils.js'))
const mensagens = require(path.resolve(__dirname, '../', 'services', 'messages.js'))

const AtendimentoRepository = require(path.resolve(__dirname, '../', 'models', 'repositories', 'atendimento.repository.js'))

const define_status_atendimento = function (atendimento) {

    if (atendimento.datahora_fim > 0)                                                  // Realizada
        return 4

    if (!atendimento?.agenda?.ativo)                                                   // Canceladas
        return 2

    if ((atendimento?.agenda?.evento_confirmado) && (!atendimento.datahora_fim))       // Confirmada não realizada 
        return 3

    if (!atendimento?.agenda?.evento_confirmado)                                       // Pendente de confirmação
        return 1

    return 0
}

module.exports = {

    async getAtendimento(req, res) {
        try {
            const { id } = req.params

            let Atendimento = await AtendimentoRepository.retornePeloID(id)

            const status = define_status_atendimento(Atendimento)

            Atendimento.dataValues["status"] = status

            return res.status(200).json(mensagens.resultExternal(200, false, Atendimento))
        } catch (error) {
            return res.status(400).json(mensagens.resultError(error))
        }
    },

    async lista(req, res) {
        try {
            const { status, profissional_id, paciente_id } = req.params

            let atendimentos = await AtendimentoRepository.retorneTodos(profissional_id, paciente_id)

            atendimentos = atendimentos.map(e => {
                let elemento = { ...e }
                elemento.dataValues["status"] = define_status_atendimento(e)

                return elemento.dataValues
            })

            return res.status(200).json(mensagens.resultExternal(200, false, atendimentos))
        } catch (error) {
            return res.status(400).json(mensagens.resultError(error))
        }
    },

}