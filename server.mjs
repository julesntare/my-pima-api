import express from "express";
import dotenv from "dotenv";
import jsforce from "jsforce";
import { ApolloServer } from "apollo-server-express";
import LoginsTypeDefs from "./src/typeDefs/logins.typeDefs.mjs";
import LoginsResolvers from "./src/resolvers/logins.resolvers.mjs";
import ProjectsTypeDefs from "./src/typeDefs/projects.typeDefs.mjs";
import ProjectsResolvers from "./src/resolvers/projects.resolvers.mjs";
import PermissionsResolvers from "./src/resolvers/permissions.resolvers.mjs";
import PermissionsTypeDefs from "./src/typeDefs/permissions.typeDefs.mjs";
import RolesTypeDefs from "./src/typeDefs/roles.typeDefs.mjs";
import RolesResolvers from "./src/resolvers/roles.resolvers.mjs";
import usersTypeDefs from "./src/typeDefs/users.typeDefs.mjs";
import UsersResolvers from "./src/resolvers/users.resolvers.mjs";
import cron from "cron";
import cors from "cors";
import loadSFProjects from "./src/reusables/load_projects.mjs";
import Redis from "ioredis";
import { RedisPubSub } from "graphql-redis-subscriptions";
import {
  cacheTrainingGroups,
  cacheTrainingParticipants,
  cacheTrainingSessions,
} from "./src/utils/saveTrainingsCache.mjs";
import TrainingSessionsTypeDefs from "./src/typeDefs/training_sessions.typeDefs.mjs";
import TrainingSessionsResolvers from "./src/resolvers/training_sessions.resolvers.mjs";

const app = express();

const redis = new Redis({
  host: "redis-12533.c15.us-east-1-2.ec2.cloud.redislabs.com",
  port: 12533,
  password: "rgyzuNLcxfcLnLkGyqauBQrPqezHEPft",
  retryStrategy: (times) => {
    // reconnect after
    return Math.min(times * 50, 2000);
  },
});

// Set up Redis pub-sub for real-time subscriptions (optional)
const pubSub = new RedisPubSub({
  publisher: redis,
  subscriber: redis,
});

dotenv.config();

const PORT = process.env.PORT || 6000;

const creds = {
  username: process.env.SF_USERNAME,
  password: process.env.SF_PASSWORD,
  securityToken: process.env.SF_SECURITY_TOKEN,
  sf_url: process.env.SF_URL,
};

app.get("/api", (req, res) => {
  res.send("Hello, My PIMA API Service!");
});

var conn = new jsforce.Connection({
  // you can change loginUrl to connect to sandbox or prerelease env.
  loginUrl: creds.sf_url,
});

conn.login(
  creds.username,
  creds.password + creds.securityToken,
  function (err, userInfo) {
    if (err) {
      return console.error(err);
    }
    // Now you can get the access token and instance URL information.
    // Save them to establish a connection next time.
    console.log(conn.accessToken);
    console.log(conn.instanceUrl);
    // logged in user property
    console.log("User ID: " + userInfo.id);
    console.log("Org ID: " + userInfo.organizationId);
    console.log("Salesforce : JSForce Connection is established!");
  }
);

app.get("/api/sf/tg", async (req, res) => {
  conn.query(
    "SELECT Id, Name, TNS_Id__c, Active_Participants_Count__c, Responsible_Staff__r.Name, Project__c FROM Training_Group__c WHERE Project__r.Project_Status__c='Active'",
    async function (err, result) {
      const business_advisors = [];

      if (err) {
        console.error(err);

        return err;
      }

      const projectIds = result.records.map((record) => record.Project__c);

      // return unique project ids
      const uniqueProjectIds = [...new Set(projectIds)];

      await conn.query(
        `SELECT Staff__r.Name, Project__c FROM Project_Role__c WHERE Roles_Status__c = 'Active' AND Role__c = 'Business Advisor' AND Project__c IN ('${uniqueProjectIds.join(
          "','"
        )}')`,
        function (err, result2) {
          if (err) {
            console.error(err);

            return err;
          }

          result2.records.forEach((record) => {
            business_advisors.push({
              project_id: record.Project__c,
              business_advisor: record.Staff__r.Name,
            });
          });
        }
      );

      return res.json({
        message: "Training groups fetched successfully",
        status: 200,
        totalSize: result.totalSize,
        trainingGroups: result.records.map((record) => {
          return {
            tg_id: record.Id,
            tg_name: record.Name,
            tns_id: record.TNS_Id__c,
            active_participants_count: record.Active_Participants_Count__c,
            project_id: record.Project__c,
            business_advisor: business_advisors
              ? business_advisors
                  .filter((advisor) => advisor.project_id === record.Project__c)
                  .map((advisor) => advisor.business_advisor)
              : [],
            farmer_trainer: record.Responsible_Staff__r.Name,
          };
        }),
      });
    }
  );
});

app.get("/api/sf/ts", (req, res) => {
  conn.query(
    "SELECT Id, Name, Module_Name__c, Training_Group__c, Training_Group__r.TNS_Id__c, Session_Status__c, Male_Attendance__c, Female_Attendance__c, Trainer__c  FROM Training_Session__c WHERE Training_Group__r.Group_Status__c='Active'",
    function (err, result) {
      if (err) {
        return console.error(err);
      }
      console.log("total : " + result.totalSize);
      console.log("fetched : " + result.records.length);

      return res.json({
        message: "Training sessions fetched successfully",
        status: 200,
        totalSize: result.totalSize,
        trainingSessions: result.records.map((record) => {
          return {
            ts_id: record.Id,
            ts_name: record.Name,
            module_name: record.Module_Name__c,
            tg_id: record.Training_Group__c,
            tns_id: record.Training_Group__r.TNS_Id__c,
            session_status: record.Session_Status__c,
            male_attendance: record.Male_Attendance__c,
            female_attendance: record.Female_Attendance__c,
            farmer_trainer: record.Trainer__c,
          };
        }),
      });
    }
  );
});

app.get("/api/sf/tp", (req, res) => {
  conn.query(
    "SELECT Id, Participant_Full_Name__c, Phone_Number__c, Gender__c, Location__c,	TNS_Id__c, Training_Group__r.Name, Status__c, Trainer_Name__c, Farm_Size__c, Project__c FROM Participant__c",
    function (err, result) {
      if (err) {
        return console.error(err);
      }
      console.log("total : " + result.totalSize);
      console.log("fetched : " + result.records.length);

      return res.json({
        message: "Training participants fetched successfully",
        status: 200,
        totalSize: result.totalSize,
        trainingParticipants: result.records.map((record) => {
          return {
            tp_id: record.Id,
            tp_name: record.Participant_Full_Name__c,
            phone_number: record.Phone_Number__c,
            gender: record.Gender__c,
            location: record.Location__c,
            tns_id: record.TNS_Id__c,
            tg_name: record.Training_Group__r.Name,
            status: record.Status__c,
            farmer_trainer: record.Trainer_Name__c,
            farm_size: record.Farm_Size__c,
            project_id: record.Project__c,
          };
        }),
      });
    }
  );
});

const server = new ApolloServer({
  typeDefs: [
    PermissionsTypeDefs,
    RolesTypeDefs,
    usersTypeDefs,
    ProjectsTypeDefs,
    LoginsTypeDefs,
    TrainingSessionsTypeDefs,
  ],
  resolvers: [
    PermissionsResolvers,
    RolesResolvers,
    UsersResolvers,
    ProjectsResolvers,
    LoginsResolvers,
    TrainingSessionsResolvers,
  ],
  subscriptions: { path: "/subscriptions", onConnect: () => pubSub },
  csrfPrevention: true,
  cache: "bounded",
  context: ({ req }) => {
    return {
      sf_conn: conn,
    };
  },
  introspection: true,
  playground: true,
});

server
  .start()
  .then(() => {
    app.use(cors());

    server.applyMiddleware({ app });

    // Define a cron job to fetch data from the remote database and update the local database
    const fetchDataJob = new cron.CronJob("0 0 */24 * * *", async () => {
      await loadSFProjects(conn);

      // get trainings data
      conn.query(
        "SELECT Id, Name,TNS_Id__c, Active_Participants_Count__c, Responsible_Staff__c FROM Training_Group__c",
        function (err, result) {
          if (err) {
            return console.error(err);
          }
          cacheTrainingGroups(result, redis);
        }
      );
      conn.query(
        "SELECT Id, Name, Module_Name__c, Training_Group__c, Session_Status__c, Male_Attendance__c, Female_Attendance__c, Trainer__c  FROM Training_Session__c",
        function (err, result) {
          if (err) {
            return console.error(err);
          }
          cacheTrainingSessions(result, redis);
        }
      );
      conn.query(
        "SELECT Id, Name, Farm_Visit__c, Participant__c, Participant_Gender__c, Status__c,	Training_Session__c, Date__c FROM FV_Attendance__c",
        function (err, result) {
          if (err) {
            return console.error(err);
          }
          cacheTrainingParticipants(result, redis);
        }
      );

      pubSub.publish("dataUpdated", { dataUpdated: true });
    });

    // Start the cron job
    fetchDataJob.start();

    app.listen({ port: PORT }, () => {
      console.log(
        `🚀 Server ready at http://localhost:${PORT}${server.graphqlPath}`
      );
    });
  })
  .catch(function (error) {
    console.log(error);
  });
