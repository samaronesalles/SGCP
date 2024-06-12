'use strict'

module.exports = {
    up: (queryInterface, Sequelize) => {
        return queryInterface.createTable('pacientes', {
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
            nome: {
                allowNull: false,
                type: Sequelize.STRING,
            },
            celular: {
                allowNull: true,
                type: Sequelize.STRING,
            },
            email: {
                allowNull: false,
                unique: true,
                type: Sequelize.STRING,
            },
            ativo: {
                allowNull: true,
                default: true,
                type: Sequelize.BOOLEAN,
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
        return queryInterface.dropTable('pacientes')
    }
}
