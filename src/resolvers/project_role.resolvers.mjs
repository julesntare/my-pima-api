import ProjectRole from "../models/project_role.model.mjs";
import Projects from "../models/projects.models.mjs";
import Users from "../models/users.model.mjs";

const ProjectRoleResolvers = {
  Query: {
    getProjectRoles: async (_, __, {}) => {
      try {
        const res = await ProjectRole.findAll();

        return {
          message: "ProjectRole fetched successfully",
          status: 200,
          project_role: res,
        };
      } catch (err) {
        console.error(err);

        return {
          message: err.message,
          status: 500,
        };
      }
    },

    getProjectRoleById: async (_, { pr_id }, {}) => {
      try {
        const res = await ProjectRole.findByPk(pr_id);

        if (!res) {
          return {
            message: "Project Role not found",
            status: 404,
          };
        }

        return {
          message: "Project Role fetched successfully",
          status: 200,
          project_role: res,
        };
      } catch (err) {
        console.error(err);

        return {
          message: err.message,
          status: 500,
        };
      }
    },

    getProjectRolesByUserId: async (_, { user_id }, {}) => {
      try {
        const res = await ProjectRole.findAll({
          where: {
            user_id,
          },
        });

        if (!res) {
          return {
            message: "ProjectRole not found",
            status: 404,
          };
        }

        return {
          message: "ProjectRole fetched successfully",
          status: 200,
          project_role: res,
        };
      } catch (err) {
        console.error(err);

        return {
          message: err.message,
          status: 500,
        };
      }
    },
  },

  Mutation: {
    addProjectRole: async (_, { user_id, project_id }, {}) => {
      try {
        // Check if user exists
        const user = await Users.findByPk(user_id);
        const project = await Projects.findByPk(project_id);

        if (!user) {
          return {
            message: "User not found",
            status: 404,
          };
        }

        if (!project) {
          return {
            message: "Project not found",
            status: 404,
          };
        }

        // Check if project_role already exists
        const project_role = await ProjectRole.findOne({
          where: {
            user_id,
            project_id,
          },
        });

        if (project_role) {
          return {
            message: "Project Role already exists",
            status: 400,
          };
        }

        const res = await ProjectRole.create({
          user_id,
          project_id,
        });

        return {
          message: "Project Role added successfully",
          status: 200,
          project_role: res,
        };
      } catch (err) {
        console.error(err);

        return {
          message: err.message,
          status: 500,
        };
      }
    },

    updateProjectRole: async (_, { pr_id, user_id, project_id }, {}) => {
      // Check if project_role exists
      const project_role = await ProjectRole.findByPk(pr_id);

      if (!project_role) {
        return {
          message: "Project Role not found",
          status: 404,
        };
      }

      // Check if user exists
      const user = await Users.findByPk(user_id);
      const project = await Projects.findByPk(project_id);

      if (!user) {
        return {
          message: "User not found",
          status: 404,
        };
      }

      if (!project) {
        return {
          message: "Project not found",
          status: 404,
        };
      }

      // check if user and project combination already exists
      const projectRoleExists = await ProjectRole.findOne({
        where: {
          user_id,
          project_id,
        },
      });

      if (projectRoleExists) {
        return {
          message: "Project Role already exists",
          status: 400,
        };
      }

      try {
        const res = await ProjectRole.update(
          {
            user_id,
            project_id,
          },
          {
            where: {
              pr_id,
            },
          }
        );

        return {
          message: "Project Role updated successfully",
          status: 200,
          project_role: res,
        };
      } catch (err) {
        console.error(err);

        return {
          message: err.message,
          status: 500,
        };
      }
    },

    deleteProjectRole: async (_, { pr_id }, {}) => {
      try {
        // Check if projectRole exists
        const projectRole = await ProjectRole.findByPk(pr_id);

        if (!projectRole) {
          return {
            message: "Project Role not found",
            status: 404,
          };
        }

        const res = await ProjectRole.destroy({
          where: {
            pr_id,
          },
        });

        return {
          message: "Project Role deleted successfully",
          status: 200,
          project_role: res,
        };
      } catch (err) {
        console.error(err);

        return {
          message: err.message,
          status: 500,
        };
      }
    },
  },
};

export default ProjectRoleResolvers;
