'use strict';

module.exports = {
    up: (queryInterface, Sequelize) => {
        return queryInterface.createTable('agendas', {
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
            profissioal_criador_id: {
                allowNull: false,
                type: Sequelize.INTEGER,
                references: { model: 'profissionais', key: 'id' },
                onUpdate: 'RESTRICT',
                onDelete: 'RESTRICT',
            },
            profissioal_agendado_id: {
                allowNull: false,
                type: Sequelize.INTEGER,
                references: { model: 'profissionais', key: 'id' },
                onUpdate: 'RESTRICT',
                onDelete: 'RESTRICT',
            },
            paciente_agendado_id: {
                allowNull: false,
                type: Sequelize.INTEGER,
                references: { model: 'pacientes', key: 'id' },
                onUpdate: 'RESTRICT',
                onDelete: 'RESTRICT',
            },
            descricao: {
                allowNull: false,
                type: Sequelize.STRING,
            },
            observacao: {
                allowNull: true,
                type: Sequelize.STRING,
            },
            evento_inicio: {
                allowNull: false,
                type: Sequelize.DATE,
            },
            evento_fim: {
                allowNull: false,
                type: Sequelize.DATE,
            },
            evento_confirmado: {
                allowNull: false,
                default: false,
                type: Sequelize.BOOLEAN,
            },
            ativo: {
                allowNull: false,
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
        });
    },

    down: (queryInterface, Sequelize) => {
        return queryInterface.dropTable('agendas');
    }
};
