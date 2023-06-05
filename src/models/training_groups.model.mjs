import { DataTypes } from "sequelize";
import sequelize from "../config/db.mjs";
import Users from "./users.model.mjs";

const TrainingGroups = sequelize.define("tbl_training_groups", {
  tg_id: {
    type: DataTypes.STRING(50),
    primaryKey: true,
    allowNull: false,
  },
  tg_name: {
    type: DataTypes.STRING(50),
    allowNull: false,
  },
  tns_id: {
    type: DataTypes.STRING(50),
    allowNull: false,
  },
  active_participants_count: {
    type: DataTypes.INTEGER,
    allowNull: false,
  },
  responsible_staff: {
    type: DataTypes.STRING(50),
    allowNull: false,
  },
});

Users.hasMany(TrainingGroups, {
  foreignKey: "responsible_staff",
  onDelete: "CASCADE",
});

TrainingGroups.belongsTo(Users, {
  foreignKey: "responsible_staff",
});

export default TrainingGroups;
