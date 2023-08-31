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
          "SELECT Id, Participant_Full_Name__c, Gender__c, Training_Group__r.Project_Location__c, TNS_Id__c, Status__c, Trainer_Name__c, Project__c, Training_Group__c, Training_Group__r.Responsible_Staff__r.ReportsToId FROM Participant__c WHERE Project__c = '" +
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

        // read file data
        const chunks = [];
        stream.on("data", (chunk) => {
          chunks.push(chunk);
        });

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
          const requiredColumns = ["Farm_Size__c", "Training_Group__c"];
          const nameColumnIndex = header.lastIndexOf("Name");
          const columnIndexMap = requiredColumns.reduce((map, column) => {
            map[column] = header.indexOf(column);
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

          const houseHoldRes = await sf_conn
            .sobject("Household__c")
            .create(formattedData, { allOrNone: true }, function (err, ret) {
              return {
                err,
                ret,
              };
            });

          console.log(houseHoldRes);

          if (houseHoldRes.length > 0) {
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

            const columnIndexMap = participantsHeaders.reduce((map, column) => {
              map[column] = header.indexOf(column);
              return map;
            }, {});

            const formattedPartsData = rows.slice(1).map((row) => {
              const values = row.split(",");
              const formattedRow = {};

              for (const column of participantsHeaders) {
                const index = columnIndexMap[column];
                formattedRow[column] = values[index];
              }

              return formattedRow;
            });

            // insert res.id to Household__c field in participantsData
            const participantsData = formattedPartsData.map((part, index) => {
              return {
                ...part,
                Household__c: houseHoldRes[index].id,
                Resend_to_OpenFN__c:
                  part.Resend_to_OpenFN__c === "TRUE" ? true : false,
                Create_In_CommCare__c: false,
              };
            });

            console.log(participantsData);

            const participantsRes = await sf_conn
              .sobject("Participant__c")
              .create(
                participantsData,
                { allOrNone: true },
                function (err, ret) {
                  return { err, ret };
                }
              );

            console.log(participantsRes);
          }
        });

        // check if uploads folder exists
        // const uploadsFolder = join(
        //   getDirName(import.meta.url),
        //   "../../uploads"
        // );

        // if (!fs.existsSync(uploadsFolder)) {
        //   fs.mkdirSync(uploadsFolder);
        // }

        // name file with user_id and date
        // const newFilename = `participants-${Date.now()}${ext}`;

        // let serverFile = join(
        //   getDirName(import.meta.url),
        //   `../../uploads/${newFilename}`
        // );

        // let writeStream = createWriteStream(serverFile);

        // await stream.pipe(writeStream);

        return {
          message: "New Participants uploaded successfully",
          status: 200,
        };
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
