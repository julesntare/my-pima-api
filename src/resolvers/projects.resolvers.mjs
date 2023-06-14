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

    getProjectById: async (_, { project_id }) => {
      try {
        const project = await Projects.findOne({
          where: { project_id },
        });

        if (!project) {
          return {
            message: "Project not found",
            status: 404,
          };
        }

        return {
          message: "Project fetched successfully",
          status: 200,
          project,
        };
      } catch (err) {
        console.log(err);

        return {
          message: err.message,
          status: err.status,
        };
      }
    },

    getProjectBusinessAdvisors: async (_, { project_id }, { sf_conn }) => {
      try {
        const project = await Projects.findOne({
          where: { project_id },
        });

        if (!project) {
          return {
            message: "Project not found",
            status: 404,
          };
        }

        const res = await sf_conn.query(
          `SELECT Staff__r.Name, Project__c FROM Project_Role__c WHERE Roles_Status__c = 'Active' AND Role__c = 'Business Advisor' AND Project__c = '${project.sf_project_id}'`
        );

        return {
          message: "Project Business Advisors fetched successfully",
          status: 200,
          leaders: res.records.map((record) => {
            return {
              name: record.Staff__r.Name,
            };
          }),
        };
      } catch (err) {
        console.log(err);

        return {
          message: err.message,
          status: err.status,
        };
      }
    },

    getProjectFarmerTrainers: async (_, { project_id }, { sf_conn }) => {
      try {
        const project = await Projects.findOne({
          where: { project_id },
        });

        if (!project) {
          return {
            message: "Project not found",
            status: 404,
          };
        }

        const res = await sf_conn.query(
          `SELECT Staff__r.Name, Project__c FROM Project_Role__c WHERE Roles_Status__c = 'Active' AND Role__c = 'Farmer Trainer' AND Project__c = '${project.sf_project_id}'`
        );

        return {
          message: "Project Farmer Trainers fetched successfully",
          status: 200,
          leaders: res.records.map((record) => {
            return {
              name: record.Staff__r.Name,
            };
          }),
        };
      } catch (err) {
        console.log(err);

        return {
          message: err.message,
          status: err.status,
        };
      }
    },

    getProjectStatistics: async (_, { sf_project_id }, { sf_conn }) => {
      // check if project exists
      const project = await Projects.findOne({
        where: { sf_project_id },
      });

      if (!project) {
        return {
          message: "Project not found",
          status: 404,
        };
      }

      try {
        // get total groups
        const total_groups = await sf_conn.query(
          `SELECT COUNT(Id) FROM Training_Group__c WHERE Project__c = '${sf_project_id}' AND Group_Status__c='Active'`
        );

        // get total participants
        // const total_participants = await sf_conn.query(
        //   `SELECT COUNT() FROM Participant__c WHERE Project__r.Id = '${sf_project_id}'`
        // );

        // get total bas
        const total_bas = await sf_conn.query(
          `SELECT COUNT(Id) FROM Project_Role__c WHERE Roles_Status__c = 'Active' AND Role__c = 'Business Advisor'
          AND Project__c = '${sf_project_id}'`
        );

        // get total fts
        const total_fts = await sf_conn.query(
          `SELECT COUNT(Id) FROM Project_Role__c WHERE Roles_Status__c = 'Active' AND Role__c = 'Farmer Trainer'
          AND Project__c = '${sf_project_id}'`
        );

        return {
          message: "Project Statistics fetched successfully",
          status: 200,
          statistics: {
            total_groups: total_groups.records[0].expr0,
            // total_participants: total_participants.records[0].expr0,
            total_bas: total_bas.records[0].expr0,
            total_fts: total_fts.records[0].expr0,
          },
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
