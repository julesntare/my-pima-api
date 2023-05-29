import { DataTypes } from "sequelize";
import sequelize from "../config/db.mjs";
import Projects from "./projects.models.mjs";
import Users from "./users.model.mjs";

const Participants = sequelize.define("tbl_participants", {
  participant_id: {
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
  project_id: {
    type: DataTypes.UUID,
    allowNull: false,
    references: {
      model: "tbl_projects",
      key: "project_id",
    },
  },
  createdAt: {
    type: DataTypes.DATE,
    defaultValue: sequelize.literal("CURRENT_TIMESTAMP"),
  },
  updatedAt: {
    type: DataTypes.DATE,
    defaultValue: sequelize.literal("CURRENT_TIMESTAMP"),
  },
});

Users.hasMany(Participants, {
  foreignKey: "user_id",
  onDelete: "CASCADE",
});

Participants.belongsTo(Users, {
  foreignKey: "user_id",
});

Projects.hasMany(Participants, {
  foreignKey: "project_id",
  onDelete: "CASCADE",
});

Participants.belongsTo(Projects, {
  foreignKey: "project_id",
});

export default Participants;
