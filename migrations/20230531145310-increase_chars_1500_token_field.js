'use strict';

/** @type {import('sequelize-cli').Migration} */
module.exports = {
  async up (queryInterface, Sequelize) {
    await queryInterface.changeColumn('tbl_user_sessions', 'session_token', {
      type: Sequelize.STRING(1500),
      allowNull: false,
    });
  },

  async down (queryInterface, Sequelize) {
    await queryInterface.changeColumn('tbl_user_sessions', 'session_token', {
      type: Sequelize.STRING(50),
      allowNull: false,
    });
  }
};
