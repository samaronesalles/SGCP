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
            const { status, profissional_id, paciente_id, inicio_de, inicio_ate } = req.params

            //TODO Implementar busca por período.

            let atendimentos = await AtendimentoRepository.retorneTodos(profissional_id, paciente_id, inicio_de, inicio_ate)

            atendimentos = atendimentos.map(e => {
                let elemento = { ...e }
                elemento.dataValues["status"] = define_status_atendimento(e)

                return elemento.dataValues
            })

            if (parseInt(status) > 0)
                atendimentos = atendimentos.filter(e => e.status === parseInt(status))

            return res.status(200).json(mensagens.resultExternal(200, false, atendimentos))
        } catch (error) {
            return res.status(400).json(mensagens.resultError(error))
        }
    },

    async editar(req, res) {
        try {
            const { id, di } = req.params
            const { datahora_inicio, datahora_fim, anotacoes } = req.body

            let Atendimento = await AtendimentoRepository.retornePeloID(id)

            // TODO Implementar cryptografia das anotacoes (NO FRONTEND)

            const dados = {
                di: uteis.new_uuid(),
                datahora_inicio: datahora_inicio,
                datahora_fim: datahora_fim,
                anotacoes: anotacoes
            }

            await Atendimento.update(dados, {
                where: {
                    id: id
                },
                returning: true,
                plain: true
            });

            const status = define_status_atendimento(Atendimento)

            Atendimento.dataValues["status"] = status

            return res.status(200).json(mensagens.resultExternal(1001, false, Atendimento))
        } catch (error) {
            return res.status(400).json(mensagens.resultError(error))
        }
    },

    async encerrar(req, res) {
        try {
            const { id, di } = req.params
            const { datahora_fim } = req.body

            let Atendimento = await AtendimentoRepository.retornePeloID(id)

            const dados = {
                di: uteis.new_uuid(),
                datahora_fim: datahora_fim
            }

            await Atendimento.update(dados, {
                where: {
                    id: id
                },
                returning: true,
                plain: true
            });

            const status = define_status_atendimento(Atendimento)

            Atendimento.dataValues["status"] = status

            return res.status(200).json(mensagens.resultExternal(1001, false, Atendimento))
        } catch (error) {
            return res.status(400).json(mensagens.resultError(error))
        }
    },

}