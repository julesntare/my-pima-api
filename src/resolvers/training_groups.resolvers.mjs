const TrainingGroupsResolvers = {
  Query: {
    trainingGroupsByProject: async (_, { project_id }, { sf_conn }) => {
      try {
        const res = await sf_conn.query(
          "SELECT Id, Name, TNS_Id__c, Active_Participants_Count__c, Responsible_Staff__r.Name, Responsible_Staff__r.ReportsToId, Project__c FROM Training_Group__c WHERE Project__r.Project_Status__c='Active' AND Project__c = '" +
            project_id +
            "' AND Group_Status__c = 'Active'",
          async function (err, result) {
            if (err) {
              console.error(err);

              return {
                message: err.message,
                status: 500,
              };
            }

            const ba_result = await sf_conn.query(
              `SELECT Name FROM Contact WHERE Id = '${result.records[0].Responsible_Staff__r.ReportsToId}'`,
              async function (err, result2) {
                if (err) {
                  console.error(err);

                  return {
                    message: err.message,
                    status: 500,
                  };
                }

                return result2;
              }
            );

            // get total participants from Participant__c where Training_Group__c = result.records[0].Id
            if (result.records.length > 0) {
              await sf_conn.query(
                `SELECT COUNT(Id) FROM Participant__c WHERE Training_Group__c = '${result.records[0].Id}'`,
                async function (err, result3) {
                  if (err) {
                    console.error(err);

                    return {
                      message: err.message,
                      status: 500,
                    };
                  }

                  result.records[0].Active_Participants_Count__c =
                    result3.records[0].expr0;
                }
              );
            }

            return result.records.map((record) => {
              return {
                tg_id: record.Id,
                tg_name: record.Name,
                tns_id: record.TNS_Id__c,
                total_participants: record.Active_Participants_Count__c || 0,
                business_advisor: ba_result.records[0].Name,
                farmer_trainer: record.Responsible_Staff__r.Name,
              };
            });
          }
        );

        return {
          message: "Training groups fetched successfully",
          status: 200,
          trainingGroups: res,
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
