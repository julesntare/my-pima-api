import Projects from "../models/projects.models.mjs";
import { join, parse } from "path";
import fs, { createWriteStream } from "fs";
import { getDirName } from "../utils/getDirName.mjs";

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
          "SELECT Id, Participant_Full_Name__c, Gender__c, Training_Group__r.Project_Location__c, TNS_Id__c, Status__c, Trainer_Name__c, Project__c, Training_Group__c, Training_Group__r.Responsible_Staff__r.ReportsToId, Household__c FROM Participant__c WHERE Project__c = '" +
            project.project_name +
            "'"
        );

        if (participants.totalSize === 0) {
          return {
            message: "Participants not found",
            status: 404,
          };
        }

        const res1 = await sf_conn.query(
          `SELECT Id, Location__r.Name FROM Project_Location__c`,
          async function (err, result) {
            if (err) {
              console.error(err);

              return {
                message: err.message,
                status: 500,
              };
            }

            return result;
          }
        );

        const reportsTo = await sf_conn.query(
          `SELECT Id, Name FROM Contact`,
          async function (err, result) {
            if (err) {
              console.error(err);

              return {
                message: err.message,
                status: 500,
              };
            }

            return result;
          }
        );

        return {
          message: "Participants fetched successfully",
          status: 200,
          participants: participants.records.map(async (participant) => {
            return {
              p_id: participant.Id,
              full_name: participant.Participant_Full_Name__c,
              gender: participant.Gender__c,
              location:
                res1.records.find(
                  (location) =>
                    location.Id ===
                    participant.Training_Group__r.Project_Location__c
                ) === undefined
                  ? "N/A"
                  : res1.records.find(
                      (location) =>
                        location.Id ===
                        participant.Training_Group__r.Project_Location__c
                    ).Location__r.Name,
              tns_id: participant.TNS_Id__c,
              status: participant.Status__c,
              farmer_trainer: participant.Trainer_Name__c,
              business_advisor:
                reportsTo.records.find(
                  (contact) =>
                    contact.Id ===
                    participant.Training_Group__r.Responsible_Staff__r
                      .ReportsToId
                ) === undefined
                  ? null
                  : reportsTo.records.find(
                      (contact) =>
                        contact.Id ===
                        participant.Training_Group__r.Responsible_Staff__r
                          .ReportsToId
                    ).Name,
              project_name: participant.Project__c,
              training_group: participant.Training_Group__c,
              household_id: participant.Household__c,
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
          "SELECT Id, Participant_Full_Name__c, Gender__c, Location__c, TNS_Id__c, Status__c, Trainer_Name__c, Project__c, Training_Group__c, Training_Group__r.Responsible_Staff__r.ReportsToId, Household__c FROM Participant__c WHERE Training_Group__c = '" +
            tg_id +
            "'"
        );

        if (participants.totalSize === 0) {
          return {
            message: "Participants not found",
            status: 404,
          };
        }

        const res1 = await sf_conn.query(
          `SELECT Id, Location__r.Name FROM Project_Location__c`,
          async function (err, result) {
            if (err) {
              console.error(err);

              return {
                message: err.message,
                status: 500,
              };
            }

            return result;
          }
        );

        const reportsTo = await sf_conn.query(
          `SELECT Id, Name FROM Contact`,
          async function (err, result) {
            if (err) {
              console.error(err);

              return {
                message: err.message,
                status: 500,
              };
            }

            return result;
          }
        );

        return {
          message: "Participants fetched successfully",
          status: 200,
          participants: participants.records.map(async (participant) => {
            return {
              p_id: participant.Id,
              full_name: participant.Participant_Full_Name__c,
              gender: participant.Gender__c,
              location:
                res1.records.find(
                  (location) =>
                    location.Id ===
                    participant.Training_Group__r.Project_Location__c
                ) === undefined
                  ? "N/A"
                  : res1.records.find(
                      (location) =>
                        location.Id ===
                        participant.Training_Group__r.Project_Location__c
                    ).Location__r.Name,
              tns_id: participant.TNS_Id__c,
              status: participant.Status__c,
              farmer_trainer: participant.Trainer_Name__c,
              business_advisor:
                reportsTo.records.find(
                  (contact) =>
                    contact.Id ===
                    participant.Training_Group__r.Responsible_Staff__r
                      .ReportsToId
                ) === undefined
                  ? null
                  : reportsTo.records.find(
                      (contact) =>
                        contact.Id ===
                        participant.Training_Group__r.Responsible_Staff__r
                          .ReportsToId
                    ).Name,
              project_name: participant.Project__c,
              training_group: participant.Training_Group__c,
              household_id: participant.Household__c,
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

  Mutation: {
    uploadParticipants: async (_, { parts_file }, { sf_conn }) => {
      try {
        const obj = await parts_file;
        const { filename, createReadStream } = obj.file;
        // Invoking the `createReadStream` will return a Readable Stream.
        let stream = createReadStream();

        let { ext } = parse(filename);

        // check if file is csv
        if (ext !== ".csv") {
          return {
            message: "File must be a csv",
            status: 400,
          };
        }

        // read file data
        const chunks = [];
        stream.on("data", (chunk) => {
          chunks.push(chunk);
        });

        const streamEndPromise = new Promise((resolve, reject) => {
          stream.on("end", async () => {
            const fileData = Buffer.concat(chunks);

            const rows = fileData.toString().split("\n");

            const header = rows[0].split(",");

            // replace header values with Salesforce API names
            header.forEach((value, index) => {
              if (value === "HouseHold Name") {
                header[index] = "Name";
              } else if (value === "HouseHold Number") {
                header[index] = "Household_Number__c";
              } else if (value === "Last Name") {
                header[index] = "Last_Name__c";
              } else if (value === "Primary Household Member") {
                header[index] = "Primary_Household_Member__c";
              } else if (value === "TNS Id") {
                header[index] = "TNS_Id__c";
              } else if (value === "Gender") {
                header[index] = "Gender__c";
              } else if (value === "Age") {
                header[index] = "Age__c";
              } else if (value === "Phone Number") {
                header[index] = "Phone_Number__c";
              } else if (value === "Farm Size") {
                header[index] = "Farm_Size__c";
              } else if (value === "Training Group") {
                header[index] = "Training_Group__c";
              } else if (value === "Project") {
                header[index] = "Project__c";
              } else if (value === "Resend to OpenFN") {
                header[index] = "Resend_to_OpenFN__c";
              } else if (value === "Check Status") {
                header[index] = "Check_Status__c";
              } else if (value === "Create in Commcare") {
                header[index] = "Create_In_CommCare__c";
              }
            });

            // Get the indexes of the required columns
            const requiredColumns = [
              "Farm_Size__c",
              "Training_Group__c",
              "Household_Number_Test__c",
              "Primary_Household_Member__c",
            ];
            const nameColumnIndex = header.lastIndexOf("Name");
            const columnIndexMap = requiredColumns.reduce((map, column) => {
              map[column] = header.indexOf(column);
              if (column === "Household_Number_Test__c") {
                map[column] = header.indexOf("Household_Number__c");
              }

              return map;
            }, {});

            // Process each row of data
            const formattedData = rows.slice(1).map((row) => {
              const values = row.split(",");
              const formattedRow = {};

              for (const column of requiredColumns) {
                const index = columnIndexMap[column];
                formattedRow[column] = values[index];
              }

              formattedRow["Name"] = values[nameColumnIndex];

              return formattedRow;
            });

            // group data by Household_Number__c and take the row with Primary_Household_Member__c = 'Yes', and get total number of rows in each group and assign total number to Number_of_Members__c
            const groupedData = formattedData.reduce((acc, curr) => {
              const key = curr["Household_Number_Test__c"];

              if (!acc[key]) {
                acc[key] = [];
              }

              acc[key].push(curr);

              return acc;
            }, {});

            const groupedDataArray = Object.values(groupedData);

            const finalFormattedHHData = groupedDataArray.map((group) => {
              const primaryMember = group.find(
                (member) => member["Primary_Household_Member__c"] === "Yes"
              );

              return {
                ...primaryMember,
                Number_of_Members__c: group.length,
              };
            });

            // check training group from formattedPartsData by looping through each row
            // if training group does not exist, return error
            for (const part of finalFormattedHHData) {
              const tg_id = part.Training_Group__c;

              try {
                const tg_res = await sf_conn.query(
                  `SELECT Id FROM Training_Group__c WHERE Id = '${tg_id}'`
                );

                if (tg_res.totalSize === 0) {
                  resolve({
                    message: `Training Group with id ${tg_id} does not exist`,
                    status: 404,
                  });

                  return;
                }
              } catch (error) {
                console.log(error);
                reject({
                  message: "Training Group not found",
                  status: 500,
                });

                return;
              }
            }

            // Query existing records by Household_Number__c
            const existingHouseholdNumbers = finalFormattedHHData.map(
              (record) => record.Household_Number_Test__c
            );
            const query = `SELECT Id, Household_Number_Test__c FROM Household__c WHERE Household_Number_Test__c IN ('${existingHouseholdNumbers.join(
              "','"
            )}')`;

            const HHdataToInsert = finalFormattedHHData.map((item) => {
              const { Primary_Household_Member__c, ...rest } = item;

              return rest;
            });

            const HHResult = await sf_conn.query(
              query,
              async function (queryErr, result) {
                if (queryErr) {
                  return {
                    status: 500,
                  };
                }

                const existingRecords = result.records;

                const recordsToUpdateInSalesforce = [];
                const newRecordsToInsertInSalesforce = [];

                HHdataToInsert.forEach((record) => {
                  const existingRecord = existingRecords.find(
                    (existing) =>
                      existing.Household_Number_Test__c ===
                      record.Household_Number_Test__c
                  );

                  if (existingRecord) {
                    // If the record already exists, update it
                    record.Id = existingRecord.Id;
                    recordsToUpdateInSalesforce.push(record);
                  } else {
                    // If the record does not exist, insert it
                    newRecordsToInsertInSalesforce.push(record);
                  }
                });

                const returnedResult1 = await sf_conn
                  .sobject("Household__c")
                  .update(
                    recordsToUpdateInSalesforce,
                    function (updateErr, updateResult) {
                      if (updateErr) {
                        return { status: 500 };
                      }

                      return {
                        status: 200,
                        data: updateResult,
                      };
                    }
                  );

                const returnedResult2 = await sf_conn
                  .sobject("Household__c")
                  .create(
                    newRecordsToInsertInSalesforce,
                    function (insertErr, insertResult) {
                      if (insertErr) {
                        return { status: 500 };
                      }

                      return {
                        status: 200,
                        data: insertResult,
                      };
                    }
                  );

                return [...returnedResult1, ...returnedResult2];
              }
            );

            if (HHResult.length > 0) {
              // query household records by Household_Number__c
              const HHRecords = await sf_conn.query(
                `SELECT Id, Household_Number_Test__c FROM Household__c WHERE Id IN ('${HHResult.map(
                  (record) => record.id
                ).join("','")}')`
              );

              // map data and headers for Participant__c
              const participantsHeaders = [
                "Name",
                "Last_Name__c",
                "Gender__c",
                "Age__c",
                "Phone_Number__c",
                "Primary_Household_Member__c",
                "TNS_Id__c",
                "Training_Group__c",
                "Resend_to_OpenFN__c",
                "Check_Status__c",
                "Create_In_CommCare__c",
                "Household__c",
              ];

              const columnIndexMap = participantsHeaders.reduce(
                (map, column) => {
                  map[column] = header.indexOf(column);
                  return map;
                },
                {}
              );

              const formattedPartsData = rows.slice(1).map((row) => {
                const values = row.split(",");
                const formattedRow = {};

                for (const column of participantsHeaders) {
                  const index = columnIndexMap[column];
                  formattedRow[column] = values[index];
                  formattedRow["Household__c"] = HHRecords.records.find(
                    (record) =>
                      record.Household_Number_Test__c ===
                      values[header.indexOf("Household_Number__c")]
                  ).Id;
                }

                return formattedRow;
              });

              // insert res.id to Household__c field in participantsData
              const participantsData = formattedPartsData.map((part, index) => {
                return {
                  ...part,
                  Resend_to_OpenFN__c: false,
                  Create_In_CommCare__c: false,
                };
              });

              // Query existing records by Participant__c
              const existingParticipants = participantsData.map(
                (record) => record.TNS_Id__c
              );

              const query = `SELECT Id, TNS_Id__c FROM Participant__c WHERE TNS_Id__c IN ('${existingParticipants.join(
                "','"
              )}')`;

              const partsResult = await sf_conn.query(
                query,
                async function (queryErr, result) {
                  if (queryErr) {
                    return {
                      status: 500,
                    };
                  }

                  const existingRecords = result.records;

                  const partsToUpdateInSalesforce = [];
                  const newPartsToInsertInSalesforce = [];

                  if (existingRecords.length > 0) {
                    participantsData.forEach((record) => {
                      const existingRecord = existingRecords.find(
                        (existing) => existing.TNS_Id__c === record.TNS_Id__c
                      );

                      if (existingRecord) {
                        // If the record already exists, update it
                        record.Id = existingRecord.Id;
                        record.Resend_to_OpenFN__c = true;
                        partsToUpdateInSalesforce.push(record);
                      } else {
                        // If the record does not exist, insert it
                        newPartsToInsertInSalesforce.push(record);
                      }
                    });
                  } else {
                    newPartsToInsertInSalesforce.push(...participantsData);
                  }

                  // Update existing records
                  const partsReturnedResult1 = await sf_conn
                    .sobject("Participant__c")
                    .update(
                      partsToUpdateInSalesforce,
                      function (updateErr, updateResult) {
                        if (updateErr) {
                          return { status: 500 };
                        }

                        return {
                          status: 200,
                          data: updateResult,
                        };
                      }
                    );

                  const partsReturnedResult2 = await sf_conn
                    .sobject("Participant__c")
                    .create(
                      newPartsToInsertInSalesforce,
                      function (insertErr, insertResult) {
                        if (insertErr) {
                          return console.error(insertErr);
                        }

                        return {
                          status: 200,
                          data: insertResult,
                        };
                      }
                    );

                  return [...partsReturnedResult1, ...partsReturnedResult2];
                }
              );

              // check if every item in partsResult has success:true
              if (partsResult.length > 0) {
                const success = partsResult.every(
                  (result) => result.success === true
                );

                if (success) {
                  // check if uploads folder exists
                  const uploadsFolder = join(
                    getDirName(import.meta.url),
                    "../../uploads"
                  );

                  if (!fs.existsSync(uploadsFolder)) {
                    fs.mkdirSync(uploadsFolder);
                  }

                  // name file with user_id and date
                  const newFilename = `participants-${Date.now()}${ext}`;
                  stream = createReadStream();

                  let serverFile = join(
                    getDirName(import.meta.url),
                    `../../uploads/${newFilename}`
                  );

                  let writeStream = createWriteStream(serverFile);

                  await stream.pipe(writeStream);

                  resolve({
                    message: "Participants uploaded successfully",
                    status: 200,
                  });

                  return;
                }
              }

              resolve({
                message: "Failed to upload new participants",
                status: 500,
              });

              return;
            }

            resolve({
              message: "Failed to upload new participants",
              status: 500,
            });
          });
          stream.on("error", (error) => {
            reject({
              message: "Failed to upload new participants",
              status: 500,
            });
          });
        });

        try {
          const streamResult = await streamEndPromise;

          if (streamResult.status === 200) {
            return {
              message: streamResult.message,
              status: streamResult.status,
            };
          }

          return {
            message: "Failed to upload new participants",
            status: 500,
          };
        } catch (error) {
          console.error(error);

          return {
            message: "Failed to upload new participants",
            status: 500,
          };
        }
      } catch (error) {
        console.error(error);

        return {
          message: "Failed to upload new participants",
          status: 500,
        };
      }
    },
  },
};

export default ParticipantsResolvers;
