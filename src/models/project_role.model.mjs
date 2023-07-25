import { DataTypes } from "sequelize";
import sequelize from "../config/db.mjs";
import Projects from "./projects.models.mjs";
import Users from "./users.model.mjs";

const ProjectRole = sequelize.define(
  "tbl_project_role",
  {
    pr_id: {
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
    role: {
      type: DataTypes.UUID,
      allowNull: false,
      references: {
        model: "tbl_roles",
        key: "role_id",
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
  },
  {
    freezeTableName: true,
  }
);

Users.hasMany(ProjectRole, {
  foreignKey: "user_id",
  onDelete: "CASCADE",
});

ProjectRole.belongsTo(Users, {
  foreignKey: "user_id",
});

Projects.hasMany(ProjectRole, {
  foreignKey: "project_id",
  onDelete: "CASCADE",
});

ProjectRole.belongsTo(Projects, {
  foreignKey: "project_id",
});

export default ProjectRole;
