import { DataTypes } from "sequelize";
import sequelize from "../config/db.mjs";

const Permissions = sequelize.define("tbl_permissions", {
  perm_id: {
    type: DataTypes.UUID,
    primaryKey: true,
    defaultValue: DataTypes.UUIDV4,
  },
  perm_name: {
    type: DataTypes.STRING(50),
    allowNull: false,
  },
  perm_desc: {
    type: DataTypes.STRING(50),
    allowNull: true,
  },
  perm_status: {
    type: DataTypes.ENUM("active", "inactive"),
    allowNull: false,
    defaultValue: "active",
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

export default Permissions;
