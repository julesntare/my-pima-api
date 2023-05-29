import { DataTypes } from "sequelize";
import sequelize from "../config/db.mjs";
import Users from "./users.model.mjs";

const Verifications = sequelize.define("tbl_verifications", {
  verification_id: {
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
  verification_code: {
    type: DataTypes.STRING(50),
    allowNull: false,
  },
  expiry_time: {
    type: DataTypes.DATE,
    allowNull: false,
  },
  is_verified: {
    type: DataTypes.BOOLEAN,
    allowNull: false,
    defaultValue: false,
  },
  createdAt: {
    type: DataTypes.DATE,
    defaultValue: sequelize.literal("CURRENT_TIMESTAMP"),
  },
  updatedAt: {
    type: DataTypes.DATE,
    defaultValue: sequelize.literal(
      "CURRENT_TIMESTAMP"
    ),
  },
});

Users.hasMany(Verifications, {
  foreignKey: "user_id",
  onDelete: "CASCADE",
});

Verifications.belongsTo(Users, {
  foreignKey: "user_id",
});

export default Verifications;
