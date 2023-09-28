import Projects from "../models/projects.models.mjs";

const FarmVisitsResolvers = {
  Query: {
    getFarmVisitsByProject: async (_, { project_id }, { sf_conn }) => {
      try {
        // check if project exists by project_id
        const project = await Projects.findOne({
          where: { sf_project_id: project_id },
        });

        if (!project) {
          return {
            message: "Project not found",
            status: 404,
          };
        }

        const groups = await sf_conn.query(
          "SELECT Id FROM Training_Group__c WHERE Project__c = '" +
            project_id +
            "'"
        );

        if (groups.totalSize === 0) {
          return {
            message: "Training Groups not found",
            status: 404,
          };
        }

        const tg_ids = groups.records.map((group) => group.Id);

        const farmVisits = await sf_conn.query(
          "SELECT Id, Name, Training_Group__r.Name, Training_Group__r.TNS_Id__c, Training_Session__r.Name, Farm_Visited__r.Name, Household_PIMA_ID__c, Farmer_Trainer__r.Name, Visit_Has_Training__c, Date_Visited__c FROM Farm_Visit__c WHERE Training_Group__c IN ('" +
            tg_ids.join("','") +
            "')"
        );

        if (farmVisits.totalSize === 0) {
          return {
            message: "Farm Visits not found",
            status: 404,
          };
        }

        return {
          message: "Farm Visits fetched successfully",
          status: 200,
          farmVisits: farmVisits.records.map(async (fv) => {
            return {
              fv_id: fv.Id,
              fv_name: fv.Name,
              training_group: fv.Training_Group__r.Name,
              training_session: fv.Training_Session__r
                ? fv.Training_Session__r.Name
                : "N/A",
              tns_id: fv.Training_Group__r.TNS_Id__c || "N/A",
              farm_visited: fv.Farm_Visited__r
                ? fv.Farm_Visited__r.Name
                : "N/A",
              household_id: fv.Household_PIMA_ID__c || "N/A",
              farmer_trainer: fv.Farmer_Trainer__r.Name || "N/A",
              has_training: fv.Visit_Has_Training__c || "No",
              date_visited: fv.Date_Visited__c,
            };
          }),
        };
      } catch (err) {
        console.log(err);

        return {
          message: "Something went wrong",
          status: err.status,
        };
      }
    },

    getFarmVisitsByGroup: async (_, { tg_id }, { sf_conn }) => {
      try {
        // check if training group exists by tg_id
        const training_group = await sf_conn.query(
          `SELECT Id FROM Training_Group__c WHERE Id = '${tg_id}'`
        );

        if (training_group.totalSize === 0) {
          return {
            message: "Training Group not found",
            status: 404,
          };
        }

        const farmVisits = await sf_conn.query(
          "SELECT Id, Name, Training_Group__r.Name, Training_Group__r.TNS_Id__c, Training_Session__r.Name, Farm_Visited__r.Name, Household_PIMA_ID__c, Farmer_Trainer__r.Name, Visit_Has_Training__c, Date_Visited__c FROM Farm_Visit__c WHERE Training_Group__c = '" +
            tg_id +
            "'"
        );

        if (farmVisits.totalSize === 0) {
          return {
            message: "Farm Visit not found",
            status: 404,
          };
        }

        return {
          message: "Farm Visits fetched successfully",
          status: 200,
          farmVisits: farmVisits.records.map(async (fv) => {
            return {
              fv_id: fv.Id,
              fv_name: fv.Name,
              training_group: fv.Training_Group__r.Name,
              training_session: fv.Training_Session__r
                ? fv.Training_Session__r.Name
                : "N/A",
              tns_id: fv.Training_Group__r.TNS_Id__c || "N/A",
              farm_visited: fv.Farm_Visited__r
                ? fv.Farm_Visited__r.Name
                : "N/A",
              household_id: fv.Household_PIMA_ID__c || "N/A",
              farmer_trainer: fv.Farmer_Trainer__r.Name || "N/A",
              has_training: fv.Visit_Has_Training__c || "No",
              date_visited: fv.Date_Visited__c,
            };
          }),
        };
      } catch (error) {
        console.log(error);

        return {
          message: error.message,
          status: error.status,
        };
      }
    },

    getFarmVisitsBySession: async (_, { ts_id }, { sf_conn }) => {
      try {
        // check if training group exists by tg_id
        const training_session = await sf_conn.query(
          `SELECT Id FROM Training_Session__c WHERE Id = '${ts_id}'`
        );

        if (training_session.totalSize === 0) {
          return {
            message: "Training Session not found",
            status: 404,
          };
        }

        const farmVisits = await sf_conn.query(
          "SELECT Id, Name, Training_Group__r.Name, Training_Group__r.TNS_Id__c, Training_Session__r.Name, Farm_Visited__r.Name, Household_PIMA_ID__c, Farmer_Trainer__r.Name, Visit_Has_Training__c, Date_Visited__c FROM Farm_Visit__c WHERE Training_Session__c = '" +
            ts_id +
            "'"
        );

        if (farmVisits.totalSize === 0) {
          return {
            message: "Farm Visit not found",
            status: 404,
          };
        }

        return {
          message: "Farm Visits fetched successfully",
          status: 200,
          farmVisits: farmVisits.records.map(async (fv) => {
            return {
              fv_id: fv.Id,
              fv_name: fv.Name,
              training_group: fv.Training_Group__r.Name,
              training_session: fv.Training_Session__r
                ? fv.Training_Session__r.Name
                : "N/A",
              tns_id: fv.Training_Group__r.TNS_Id__c || "N/A",
              farm_visited: fv.Farm_Visited__r
                ? fv.Farm_Visited__r.Name
                : "N/A",
              household_id: fv.Household_PIMA_ID__c || "N/A",
              farmer_trainer: fv.Farmer_Trainer__r.Name || "N/A",
              has_training: fv.Visit_Has_Training__c || "No",
              date_visited: fv.Date_Visited__c,
            };
          }),
        };
      } catch (error) {
        console.log(error);

        return {
          message: error.message,
          status: error.status,
        };
      }
    },

    getFarmVisitsByParticipant: async (_, { part_id }, { sf_conn }) => {
      try {
        // check if training group exists by tg_id
        const participant = await sf_conn.query(
          `SELECT Id FROM Participant__c WHERE Id = '${part_id}'`
        );

        if (participant.totalSize === 0) {
          return {
            message: "Participant not found",
            status: 404,
          };
        }

        const farmVisits = await sf_conn.query(
          "SELECT Id, Name, Training_Group__r.Name, Training_Group__r.TNS_Id__c, Training_Session__r.Name, Farm_Visited__r.Name, Household_PIMA_ID__c, Farmer_Trainer__r.Name, Visit_Has_Training__c, Farm_Visited__c, Date_Visited__c FROM Farm_Visit__c WHERE Farm_Visited__c = '" +
            part_id +
            "'"
        );

        if (farmVisits.totalSize === 0) {
          return {
            message: "Farm Visit not found",
            status: 404,
          };
        }

        return {
          message: "Farm Visits fetched successfully",
          status: 200,
          farmVisits: farmVisits.records.map(async (fv) => {
            return {
              fv_id: fv.Id,
              fv_name: fv.Name,
              training_group: fv.Training_Group__r.Name,
              training_session: fv.Training_Session__r
                ? fv.Training_Session__r.Name
                : "N/A",
              tns_id: fv.Training_Group__r.TNS_Id__c || "N/A",
              farm_visited: fv.Farm_Visited__r
                ? fv.Farm_Visited__r.Name
                : "N/A",
              household_id: fv.Household_PIMA_ID__c || "N/A",
              farmer_trainer: fv.Farmer_Trainer__r.Name || "N/A",
              has_training: fv.Visit_Has_Training__c || "No",
              date_visited: fv.Date_Visited__c,
            };
          }),
        };
      } catch (error) {
        console.log(error);

        return {
          message: error.message,
          status: error.status,
        };
      }
    },
  },
};

export default FarmVisitsResolvers;
