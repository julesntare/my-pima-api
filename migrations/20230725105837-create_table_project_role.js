"use strict";

/** @type {import('sequelize-cli').Migration} */
module.exports = {
  async up(queryInterface, Sequelize) {
    // pr_id
    // user_id
    // project_id
    // role

    await queryInterface.createTable("tbl_project_role", {
      pr_id: {
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
      role: {
        type: Sequelize.UUID,
        allowNull: false,
        references: {
          model: "tbl_roles",
          key: "role_id",
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
    await queryInterface.dropTable("tbl_project_role");
  },
};
