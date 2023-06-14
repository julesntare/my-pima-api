'use strict';

/** @type {import('sequelize-cli').Migration} */
module.exports = {
  async up (queryInterface, Sequelize) {
    // allow nulls for user_name, user_email, mobile_no
    await queryInterface.changeColumn('tbl_users', 'user_name', {
      type: Sequelize.STRING(255),
      allowNull: true,
    });
    await queryInterface.changeColumn('tbl_users', 'user_email', {
      type: Sequelize.STRING(255),
      allowNull: true,
    });
    await queryInterface.changeColumn('tbl_users', 'mobile_no', {
      type: Sequelize.STRING(50),
      allowNull: true,
    });
  },

  async down (queryInterface, Sequelize) {
    // disallow nulls for user_name, user_email, mobile_no
    await queryInterface.changeColumn('tbl_users', 'user_name', {
      type: Sequelize.STRING(255),
      allowNull: false,
    });
    await queryInterface.changeColumn('tbl_users', 'user_email', {
      type: Sequelize.STRING(255),
      allowNull: false,
    });
    await queryInterface.changeColumn('tbl_users', 'mobile_no', {
      type: Sequelize.STRING(50),
      allowNull: false,
    });
  }
};
