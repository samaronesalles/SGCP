'use strict'

module.exports = {
    up: (queryInterface, Sequelize) => {
        return queryInterface.createTable('atendimentos', {
            id: {
                allowNull: false,
                autoIncrement: true,
                primaryKey: true,
                type: Sequelize.INTEGER
            },
            di: {
                allowNull: false,
                type: Sequelize.STRING,
            },
            agenda_origem_id: {
                allowNull: true,
                type: Sequelize.INTEGER,
                references: { model: 'agendas', key: 'id' },
                onUpdate: 'CASCADE',
                onDelete: 'CASCADE',
            },
            datahora_inicio: {
                allowNull: true,
                type: Sequelize.DATE,
            },
            datahora_fim: {
                allowNull: true,
                type: Sequelize.DATE,
            },
            anotacoes: {
                allowNull: true,
                type: Sequelize.TEXT,
            },
            created_at: {
                allowNull: false,
                type: Sequelize.DATE,
            },
            updated_at: {
                allowNull: false,
                type: Sequelize.DATE,
            },
        })
    },

    down: (queryInterface, Sequelize) => {
        return queryInterface.dropTable('atendimentos')
    }
}
