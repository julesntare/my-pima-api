'use strict';

/** @type {import('sequelize-cli').Migration} */
module.exports = {
  async up (queryInterface, Sequelize) {
    await queryInterface.changeColumn('tbl_users', 'user_password', {
      type: Sequelize.STRING(255),
      allowNull: false,
    });
  },

  async down (queryInterface, Sequelize) {
    await queryInterface.changeColumn('tbl_users', 'user_password', {
      type: Sequelize.STRING(100),
      allowNull: false,
    });
  }
};
