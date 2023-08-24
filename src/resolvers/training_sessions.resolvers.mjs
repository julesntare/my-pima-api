import Projects from "../models/projects.models.mjs";
import fetchImage from "../utils/commCareApi.mjs";

const TrainingSessionsResolvers = {
  Query: {
    trainingSessions: async (_, __, { sf_conn }) => {
      try {
        // get training sessions from soql query
        const training_sessions = await sf_conn.query(
          "SELECT Id, Name, Module_Name__c, Training_Group__r.Name, Training_Group__r.TNS_Id__c, Session_Status__c, Male_Attendance__c, Female_Attendance__c, Trainer__r.Name, Session_Photo_URL__c, Verified__c, Date__c FROM Training_Session__c WHERE Training_Group__r.Group_Status__c='Active'"
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
                ts_group: training_session.Training_Group__r.Name,
                tns_id: training_session.Training_Group__r.TNS_Id__c,
                farmer_trainer: training_session.Trainer__r
                  ? training_session.Trainer__r.Name
                  : null,
                ts_status: training_session.Session_Status__c,
                total_males: training_session.Male_Attendance__c || 0,
                total_females: training_session.Female_Attendance__c || 0,
                is_verified: training_session.Verified__c,
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
          `SELECT Id, Name, Module_Name__c, Training_Group__r.Name, Training_Group__r.TNS_Id__c, Session_Status__c, Male_Attendance__c, Female_Attendance__c, Trainer__r.Name, Project_Name__c, Session_Photo_URL__c, Verified__c, Date__c FROM Training_Session__c WHERE Training_Group__r.Group_Status__c='Active' AND Project_Name__c = '${project_name}'`
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
            async (training_session) => {
              return {
                ts_id: training_session.Id,
                ts_name: training_session.Name,
                ts_module: training_session.Module_Name__c,
                ts_group: training_session.Training_Group__r.Name,
                tns_id: training_session.Training_Group__r.TNS_Id__c,
                farmer_trainer: training_session.Trainer__r
                  ? training_session.Trainer__r.Name
                  : null,
                ts_status: training_session.Session_Status__c,
                total_males: training_session.Male_Attendance__c || 0,
                total_females: training_session.Female_Attendance__c || 0,
                is_verified: training_session.Verified__c,
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
          `SELECT Id, Name, Module_Name__c, Training_Group__c, Training_Group__r.TNS_Id__c, Session_Status__c, Male_Attendance__c, Female_Attendance__c, Trainer__r.Name, Session_Photo_URL__c, Verified__c, Date__c FROM Training_Session__c WHERE Training_Group__r.Group_Status__c='Active' AND Training_Group__r.Id = '${tg_id}'`
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
                total_males: training_session.Male_Attendance__c || 0,
                total_females: training_session.Female_Attendance__c || 0,
                is_verified: training_session.Verified__c,
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

    trainingSessionImage: async (_, { ts_id }, { sf_conn }) => {
      try {
        // check if training session exists in soql query
        const training_session = await sf_conn.query(
          `SELECT Id, Session_Photo_URL__c FROM Training_Session__c WHERE Id = '${ts_id}'`
        );

        if (training_session.totalSize === 0) {
          return {
            message: "Training session not found",
            status: 404,
          };
        }

        const session_image = training_session.records[0].Session_Photo_URL__c;
        const base64encodedData = session_image
          ? await fetchImage(session_image)
          : null;

        return {
          message: "Training session image fetched successfully",
          status: 200,
          trainingSessionImage: base64encodedData,
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

  Mutation: {
    validateSession: async (_, { ts_id, status }, { sf_conn }) => {
      try {
        // check if training session exists in soql query
        const res = await sf_conn.sobject("Training_Session__c").update(
          {
            Id: ts_id,
            Verified__c: status,
          },
          function (err, ret) {
            if (err || !ret.success) {
              return {
                message: err.message,
                status: err.status,
              };
            }

            return ret;
          }
        );

        if (!res.success) {
          return {
            message: "Training session not found",
            status: 404,
          };
        }

        return {
          message: "Training session updated successfully",
          status: 200,
          trainingSession: {
            ts_id: res.id,
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

export default TrainingSessionsResolvers;
