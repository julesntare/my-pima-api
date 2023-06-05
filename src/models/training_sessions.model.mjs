import { DataTypes } from "sequelize";
import sequelize from "../config/db.mjs";
import TrainingGroups from "./training_groups.model.mjs";

const TrainingSessions = sequelize.define("tbl_training_sessions", {
  ts_id: {
    type: DataTypes.STRING(50),
    primaryKey: true,
    allowNull: false,
  },
  ts_name: {
    type: DataTypes.STRING(50),
    allowNull: false,
  },
  module_name: {
    type: DataTypes.STRING(50),
    allowNull: false,
  },
  tg_id: {
    type: DataTypes.STRING(50),
    allowNull: false,
    references: {
      model: "tbl_training_groups",
      key: "tg_id",
    },
  },
  session_status: {
    type: DataTypes.ENUM("active", "inactive"),
    allowNull: false,
    defaultValue: "active",
  },
  male_attendance: {
    type: DataTypes.INTEGER,
    allowNull: false,
  },
  female_attendance: {
    type: DataTypes.INTEGER,
    allowNull: false,
  },
  trainer: {
    type: DataTypes.STRING(50),
    allowNull: false,
  },
});

TrainingSessions.belongsTo(TrainingGroups, {
  foreignKey: "tg_id",
});

TrainingGroups.hasMany(TrainingSessions, {
  foreignKey: "tg_id",
  onDelete: "CASCADE",
});

export default TrainingSessions;
