import { DataTypes } from "sequelize";
import sequelize from "../config/db.mjs";
import Users from "./users.model.mjs";

const UserSessions = sequelize.define(
  "tbl_user_sessions",
  {
    session_id: {
      type: DataTypes.UUID,
      primaryKey: true,
      defaultValue: DataTypes.UUIDV4,
    },
    user_id: {
      type: DataTypes.UUID,
      allowNull: false,
      references: {
        model: "tbl_users",
        key: "user_id",
      },
    },
    session_token: {
      type: DataTypes.STRING(1500),
      allowNull: false,
    },
    provider: {
      type: DataTypes.ENUM("google", "tns"),
      allowNull: false,
      defaultValue: "google",
    },
    added_on: {
      type: DataTypes.DATE,
      defaultValue: DataTypes.NOW,
    },
  },
  {
    timestamps: false,
  }
);

Users.hasMany(UserSessions, {
  foreignKey: "user_id",
  onDelete: "CASCADE",
});

UserSessions.belongsTo(Users, {
  foreignKey: "user_id",
});

export default UserSessions;
