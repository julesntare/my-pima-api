import Projects from "../models/projects.models.mjs";
import LocationDetails from "../utils/loadLocation.mjs";

const ParticipantsResolvers = {
  Query: {
    getParticipantsByProject: async (_, { project_id }, { sf_conn }) => {
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

        const participants = await sf_conn.query(
          "SELECT Id, Participant_Full_Name__c, Gender__c, Location__c, TNS_Id__c, Status__c, Trainer_Name__c, Project__c, Training_Group__r.Responsible_Staff__r.ReportsToId FROM Participant__c WHERE Project__c = '" +
            project.project_name +
            "'"
        );

        if (participants.totalSize === 0) {
          return {
            message: "Participants not found",
            status: 404,
          };
        }

        return {
          message: "Participants fetched successfully",
          status: 200,
          participants: participants.records.map(async (participant) => {
            const location = await LocationDetails(
              participant.Location__c,
              sf_conn
            );

            const reportsTo = await sf_conn.query(
              `SELECT Id, Name FROM Contact WHERE Id = '${participant.Training_Group__r.Responsible_Staff__r.ReportsToId}'`
            );

            return {
              p_id: participant.Id,
              full_name: participant.Participant_Full_Name__c,
              gender: participant.Gender__c,
              location:
                location.status === 200
                  ? location.location_details.location_name
                  : "N/A",
              tns_id: participant.TNS_Id__c,
              status: participant.Status__c,
              farmer_trainer: participant.Trainer_Name__c,
              business_advisor: reportsTo.records[0].Name || "N/A",
              project_name: participant.Project__c,
              training_group: participant.Training_Group__c,
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

    getParticipantsByGroup: async (_, { tg_id }, { sf_conn }) => {
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

        const participants = await sf_conn.query(
          "SELECT Id, Participant_Full_Name__c, Gender__c, Location__c, TNS_Id__c, Status__c, Trainer_Name__c, Project__c, Training_Group__c, Training_Group__r.Responsible_Staff__r.ReportsToId FROM Participant__c WHERE Training_Group__c = '" +
            tg_id +
            "'"
        );

        if (participants.totalSize === 0) {
          return {
            message: "Participants not found",
            status: 404,
          };
        }

        return {
          message: "Participants fetched successfully",
          status: 200,
          participants: participants.records.map(async (participant) => {
            const location = await LocationDetails(
              participant.Location__c,
              sf_conn
            );

            const reportsTo = await sf_conn.query(
              `SELECT Id, Name FROM Contact WHERE Id = '${participant.Training_Group__r.Responsible_Staff__r.ReportsToId}'`
            );

            return {
              p_id: participant.Id,
              full_name: participant.Participant_Full_Name__c,
              gender: participant.Gender__c,
              location:
                location.status === 200
                  ? location.location_details.location_name
                  : "N/A",
              tns_id: participant.TNS_Id__c,
              status: participant.Status__c,
              farmer_trainer: participant.Trainer_Name__c,
              business_advisor: reportsTo.records[0].Name || "N/A",
              project_name: participant.Project__c,
              training_group: participant.Training_Group__c,
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

export default ParticipantsResolvers;
