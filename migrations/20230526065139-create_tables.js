"use strict";

/** @type {import('sequelize-cli').Migration} */
module.exports = {
  async up(queryInterface, Sequelize) {
    // Create table tbl_permissions
    await queryInterface.createTable("tbl_permissions", {
      perm_id: {
        type: Sequelize.UUID,
        primaryKey: true,
        defaultValue: Sequelize.UUIDV4,
      },
      perm_name: {
        type: Sequelize.STRING(50),
        allowNull: false,
      },
      perm_desc: {
        type: Sequelize.STRING(50),
        allowNull: true,
      },
      perm_status: {
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

    // Create table tbl_roles
    await queryInterface.createTable("tbl_roles", {
      role_id: {
        type: Sequelize.UUID,
        primaryKey: true,
        defaultValue: Sequelize.UUIDV4,
      },
      role_name: {
        type: Sequelize.STRING(50),
        allowNull: false,
      },
      role_desc: {
        type: Sequelize.STRING(50),
        allowNull: true,
      },
      permissions: {
        type: Sequelize.ARRAY(Sequelize.UUID),
        allowNull: false,
      },
      is_default: {
        type: Sequelize.BOOLEAN,
        allowNull: false,
        defaultValue: false,
      },
      role_status: {
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

    // Create table tbl_users
    await queryInterface.createTable("tbl_users", {
      user_id: {
        type: Sequelize.UUID,
        primaryKey: true,
        defaultValue: Sequelize.UUIDV4,
      },
      user_name: {
        type: Sequelize.STRING(50),
        allowNull: false,
      },
      user_password: {
        type: Sequelize.STRING(50),
        allowNull: false,
      },
      user_email: {
        type: Sequelize.STRING(50),
        allowNull: false,
      },
      mobile_no: {
        type: Sequelize.STRING(50),
        allowNull: false,
      },
      role_id: {
        type: Sequelize.UUID,
        allowNull: false,
        references: {
          model: "tbl_roles",
          key: "role_id",
        },
      },
      account_status: {
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

    // Create table tbl_user_sessions
    await queryInterface.createTable("tbl_user_sessions", {
      session_id: {
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
      session_token: {
        type: Sequelize.STRING(50),
        allowNull: false,
      },
      provider: {
        type: Sequelize.ENUM("google", "tns"),
        allowNull: false,
      },
      createdAt: {
        type: Sequelize.DATE,
        defaultValue: Sequelize.literal("CURRENT_TIMESTAMP"),
      },
    });

    // Create table tbl_verifications
    await queryInterface.createTable("tbl_verifications", {
      verification_id: {
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
      verification_code: {
        type: Sequelize.STRING(50),
        allowNull: false,
      },
      expiry_time: {
        type: Sequelize.DATE,
        allowNull: false,
      },
      is_verified: {
        type: Sequelize.BOOLEAN,
        allowNull: false,
        defaultValue: false,
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
    // Drop table tbl_verifications
    await queryInterface.dropTable("tbl_verifications");

    // Drop table tbl_user_sessions
    await queryInterface.dropTable("tbl_user_sessions");

    // Drop table tbl_users
    await queryInterface.dropTable("tbl_users");

    // Drop table tbl_roles
    await queryInterface.dropTable("tbl_roles");

    // Drop table tbl_permissions
    await queryInterface.dropTable("tbl_permissions");
  },
};
