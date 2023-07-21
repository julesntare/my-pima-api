import Projects from "../models/projects.models.mjs";

const TrainingSessionsResolvers = {
  Query: {
    trainingSessions: async (_, __, { sf_conn }) => {
      try {
        // get training sessions from soql query
        const training_sessions = await sf_conn.query(
          "SELECT Id, Name, Module_Name__c, Training_Group__c, Training_Group__r.TNS_Id__c, Session_Status__c, Male_Attendance__c, Female_Attendance__c, Trainer__r.Name, Date__c  FROM Training_Session__c WHERE Training_Group__r.Group_Status__c='Active'"
        );

        // check if training sessions exist
        if (training_sessions.totalSize === 0) {
          return {
            message: "Training sessions not found",
            status: 404,
          };
        }

        return {
          message: "Training sessions fetched successfully",
          status: 200,
          trainingSessions: training_sessions.records.map(
            (training_session) => {
              return {
                ts_id: training_session.Id,
                ts_name: training_session.Name,
                ts_module: training_session.Module_Name__c,
                ts_group: training_session.Training_Group__c,
                tns_id: training_session.Training_Group__r.TNS_Id__c,
                farmer_trainer: training_session.Trainer__r
                  ? training_session.Trainer__r.Name
                  : null,
                ts_status: training_session.Session_Status__c,
                total_male: training_session.Male_Attendance__c || 0,
                total_female: training_session.Female_Attendance__c || 0,
                session_date: training_session.Date__c,
              };
            }
          ),
        };
      } catch (err) {
        console.log(err);

        return {
          message: err.message,
          status: err.status,
        };
      }
    },

    trainingSessionsByProject: async (_, { sf_project_id }, { sf_conn }) => {
      try {
        const project = await Projects.findOne({
          where: { sf_project_id },
        });

        if (!project) {
          return {
            message: "Project not found",
            status: 404,
          };
        }

        const project_name = project.dataValues.project_name;

        // get training sessions
        const training_sessions = await sf_conn.query(
          `SELECT Id, Name, Module_Name__c, Training_Group__c, Training_Group__r.TNS_Id__c, Session_Status__c, Male_Attendance__c, Female_Attendance__c, Trainer__r.Name, Project_Name__c, Date__c FROM Training_Session__c WHERE Training_Group__r.Group_Status__c='Active' AND Project_Name__c = '${project_name}'`
        );

        // check if training sessions exist
        if (training_sessions.totalSize === 0) {
          return {
            message: "Training sessions not found",
            status: 404,
          };
        }

        return {
          message: "Training sessions fetched successfully",
          status: 200,
          trainingSessions: training_sessions.records.map(
            (training_session) => {
              return {
                ts_id: training_session.Id,
                ts_name: training_session.Name,
                ts_module: training_session.Module_Name__c,
                ts_group: training_session.Training_Group__c,
                tns_id: training_session.Training_Group__r.TNS_Id__c,
                farmer_trainer: training_session.Trainer__r
                  ? training_session.Trainer__r.Name
                  : null,
                ts_status: training_session.Session_Status__c,
                total_male: training_session.Male_Attendance__c || 0,
                total_female: training_session.Female_Attendance__c || 0,
                session_date: training_session.Date__c,
              };
            }
          ),
        };
      } catch (err) {
        console.log(err);

        return {
          message: err.message,
          status: err.status,
        };
      }
    },

    trainingSessionsByGroup: async (_, { tg_id }, { sf_conn }) => {
      try {
        // check if group exists in soql query
        const group = await sf_conn.query(
          `SELECT Id FROM Training_Group__c WHERE Id = '${tg_id}'`
        );

        if (group.totalSize === 0) {
          return {
            message: "Group not found",
            status: 404,
          };
        }

        // get training sessions
        const training_sessions = await sf_conn.query(
          `SELECT Id, Name, Module_Name__c, Training_Group__c, Training_Group__r.TNS_Id__c, Session_Status__c, Male_Attendance__c, Female_Attendance__c, Trainer__r.Name, Date__c  FROM Training_Session__c WHERE Training_Group__r.Group_Status__c='Active' AND Training_Group__r.Id = '${tg_id}'`
        );

        // check if training sessions exist
        if (training_sessions.totalSize === 0) {
          return {
            message: "Training sessions not found",
            status: 404,
          };
        }

        return {
          message: "Training sessions fetched successfully",
          status: 200,
          trainingSessions: training_sessions.records.map(
            (training_session) => {
              return {
                ts_id: training_session.Id,
                ts_name: training_session.Name,
                ts_module: training_session.Module_Name__c,
                farmer_trainer: training_session.Trainer__r
                  ? training_session.Trainer__r.Name
                  : null,
                ts_status: training_session.Session_Status__c,
                total_male: training_session.Male_Attendance__c || 0,
                total_female: training_session.Female_Attendance__c || 0,
                session_date: training_session.Date__c,
              };
            }
          ),
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

export default TrainingSessionsResolvers;
