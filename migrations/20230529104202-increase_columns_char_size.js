"use strict";

/** @type {import('sequelize-cli').Migration} */
module.exports = {
  async up(queryInterface, Sequelize) {
    // increase the size of the following columns: user_name, user_email
    await queryInterface.changeColumn("tbl_users", "user_name", {
      type: Sequelize.STRING(255),
      allowNull: false,
    });

    await queryInterface.changeColumn("tbl_users", "user_email", {
      type: Sequelize.STRING(255),
      allowNull: false,
    });
  },

  async down(queryInterface, Sequelize) {
    // decrease the size of the following columns: user_name, user_email
    await queryInterface.changeColumn("tbl_users", "user_name", {
      type: Sequelize.STRING(50),
      allowNull: false,
    });

    await queryInterface.changeColumn("tbl_users", "user_email", {
      type: Sequelize.STRING(50),
      allowNull: false,
    });
  },
};
