const TrainingAggregateResolvers = {
  Query: {
    getTrainingAggregates: async (_, __, { sf_conn }) => {
      try {
        // get training groups aggregate data
        const trainingGroups = await sf_conn.query(
          "SELECT COUNT(Id) FROM Training_Group__c WHERE Project__c = 'a0E9J000000DeVbUAK'"
        );

        // get active BAs
        const activeBAs = await sf_conn.query(
          "SELECT COUNT(Id) FROM Project_Role__c WHERE Roles_Status__c = 'Active' AND Role__c = 'Business Advisor' AND Project__c = 'a0E9J000000DeVbUAK'"
        );

        // get training session aggregate data
        const trainingSessions = await sf_conn.query(
          "SELECT SUM(Male_Attendance__c), SUM(Female_Attendance__c) FROM Training_Session__c WHERE Training_Module__r.Current_Previous_Module__c = 'Current' AND Project_Name__c = 'Coffee ET - Regrow Yirga Agronomy C2022'"
        );

        // store results in an model object
        const trainingAggregates = {
          training_groups_count: trainingGroups.totalSize,
          total_participants_count: trainingSessions.totalSize,
          active_ba_count: activeBAs.totalSize,
          male_attendance_count: trainingSessions.records[0].expr0,
          female_attendance_count: trainingSessions.records[0].expr1,
        };

        return {
          message: "Training Aggregates fetched successfully",
          status: 200,
          training_aggregates: trainingAggregates,
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

export default TrainingAggregateResolvers;
