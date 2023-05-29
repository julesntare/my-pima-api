"use strict";

/** @type {import('sequelize-cli').Migration} */
module.exports = {
  async up(queryInterface, Sequelize) {
    // Create table tbl_projects
    await queryInterface.createTable("tbl_projects", {
      project_id: {
        type: Sequelize.UUID,
        primaryKey: true,
        defaultValue: Sequelize.UUIDV4,
      },
      sf_project_id: {
        type: Sequelize.STRING(50),
        allowNull: false,
      },
      project_name: {
        type: Sequelize.STRING(50),
        allowNull: false,
      },
      project_status: {
        type: Sequelize.ENUM("active", "inactive"),
        allowNull: false,
        defaultValue: "active",
      },
      createdAt: {
        type: Sequelize.DATE,
        defaultValue: Sequelize.literal("CURRENT_TIMESTAMP"),
      },
      updatedAt: {
        type: Sequelize.DATE,
        defaultValue: Sequelize.literal("CURRENT_TIMESTAMP"),
      },
    });

    // Create table tbl_participants
    await queryInterface.createTable("tbl_participants", {
      participant_id: {
        type: Sequelize.UUID,
        primaryKey: true,
        defaultValue: Sequelize.UUIDV4,
      },
      user_id: {
        type: Sequelize.UUID,
        allowNull: false,
        references: {
          model: "tbl_users",
          key: "user_id",
        },
      },
      project_id: {
        type: Sequelize.UUID,
        allowNull: false,
        references: {
          model: "tbl_projects",
          key: "project_id",
        },
      },
      createdAt: {
        type: Sequelize.DATE,
        defaultValue: Sequelize.literal("CURRENT_TIMESTAMP"),
      },
      updatedAt: {
        type: Sequelize.DATE,
        defaultValue: Sequelize.literal("CURRENT_TIMESTAMP"),
      },
    });
  },

  async down(queryInterface, Sequelize) {
    // Drop table tbl_participants
    await queryInterface.dropTable("tbl_participants");

    // Drop table tbl_projects
    await queryInterface.dropTable("tbl_projects");
  },
};
