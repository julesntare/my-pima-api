import Projects from "../models/projects.models.mjs";
import loadSFProjects from "../reusables/load_projects.mjs";

const ProjectsResolvers = {
  Query: {
    loadProjects: async (_, __, { sf_conn }) => {
      const res = await loadSFProjects(sf_conn);

      return res;
    },

    getProjects: async () => {
      try {
        const projects = await Projects.findAll();
        return {
          message: "Projects fetched successfully",
          status: 200,
          projects,
        };
      } catch (err) {
        console.log(err);

        return {
          message: err.message,
          status: err.status,
        };
      }
    },
  },
};

export default ProjectsResolvers;
