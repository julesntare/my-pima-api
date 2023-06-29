const TrainingGroupsResolvers = {
  Query: {
    trainingGroupsByProject: async (_, { project_id }, { sf_conn }) => {
      const business_advisors = [];
      try {
        const result = await sf_conn.query(
          "SELECT Id, Name, TNS_Id__c, Active_Participants_Count__c, Responsible_Staff__r.Name, Project__c FROM Training_Group__c WHERE Project__r.Project_Status__c='Active' AND Project__c = '" +
            project_id +
            "'",
          async function (err, result) {
            if (err) {
              console.error(err);

              return {
                message: err.message,
                status: 500,
              };
            }

            await sf_conn.query(
              `SELECT Staff__r.Name, Project__c FROM Project_Role__c WHERE Roles_Status__c = 'Active' AND Role__c = 'Business Advisor' AND Project__c = '${project_id}'`,
              async function (err, result2) {
                if (err) {
                  console.error(err);

                  return {
                    message: err.message,
                    status: 500,
                  };
                }

                result2.records.forEach((record) => {
                  business_advisors.push({
                    project_id: record.Project__c,
                    business_advisor: record.Staff__r.Name,
                  });
                });
              }
            );

            return result;
          }
        );

        return {
          message: "Training groups fetched successfully",
          status: 200,
          trainingGroups: result.records.map((record) => {
            return {
              tg_id: record.Id,
              tg_name: record.Name,
              tns_id: record.TNS_Id__c,
              total_participants: record.Active_Participants_Count__c,
              business_advisor: business_advisors
                ? business_advisors
                    .filter(
                      (advisor) => advisor.project_id === record.Project__c
                    )
                    .map((advisor) => advisor.business_advisor)
                : [],
              farmer_trainer: record.Responsible_Staff__r.Name,
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
  },
};

export default TrainingGroupsResolvers;
