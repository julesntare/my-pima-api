import { DataTypes } from "sequelize";
import sequelize from "../config/db.mjs";

const Roles = sequelize.define("tbl_roles", {
  role_id: {
    type: DataTypes.UUID,
    primaryKey: true,
    defaultValue: DataTypes.UUIDV4,
  },
  role_name: {
    type: DataTypes.STRING(50),
    allowNull: false,
  },
  role_desc: {
    type: DataTypes.STRING(50),
    allowNull: true,
  },
  permissions: {
    type: DataTypes.ARRAY(DataTypes.UUID),
    allowNull: false,
  },
  is_default: {
    type: DataTypes.BOOLEAN,
    allowNull: false,
    defaultValue: false,
  },
  role_status: {
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

export default Roles;
