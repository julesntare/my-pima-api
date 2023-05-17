import { DataTypes } from "sequelize";
import sequelize from "../config/db.mjs";

const User = sequelize.define("User", {
  username: {
    type: DataTypes.STRING,
    allowNull: false,
  },
  email: {
    type: DataTypes.STRING,
    allowNull: false,
  },
  // Add more fields as needed
});

export default User;
