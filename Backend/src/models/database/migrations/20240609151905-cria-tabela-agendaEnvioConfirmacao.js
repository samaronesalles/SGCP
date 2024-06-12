'use strict'

module.exports = {
    up: (queryInterface, Sequelize) => {
        return queryInterface.createTable('agendaEnvioConfirmacao', {
            id: {
                allowNull: false,
                autoIncrement: true,
                primaryKey: true,
                type: Sequelize.INTEGER
            },
            agenda_id: {
                allowNull: false,
                type: Sequelize.INTEGER,
                references: { model: 'agendas', key: 'id' },
                onUpdate: 'CASCADE',
                onDelete: 'CASCADE',
            },
            id_Msg: {
                allowNull: false,
                type: Sequelize.STRING,
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
        return queryInterface.dropTable('agendaEnvioConfirmacao')
    }
}
