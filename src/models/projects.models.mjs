import { DataTypes } from "sequelize";
import sequelize from "../config/db.mjs";

const Projects = sequelize.define("tbl_projects", {
  project_id: {
    type: DataTypes.UUID,
    primaryKey: true,
    defaultValue: DataTypes.UUIDV4,
  },
  sf_project_id: {
    type: DataTypes.STRING(50),
    allowNull: false,
  },
  project_name: {
    type: DataTypes.STRING(50),
    allowNull: false,
  },
  project_status: {
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
    defaultValue: sequelize.literal("CURRENT_TIMESTAMP"),
  },
});

export default Projects;
