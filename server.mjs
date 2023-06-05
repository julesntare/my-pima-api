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
import loadSFProjects from "./src/reusables/load_projects.mjs";
import Redis from "ioredis";
import { RedisPubSub } from "graphql-redis-subscriptions";
import {
  cacheTrainingGroups,
  cacheTrainingParticipants,
  cacheTrainingSessions,
} from "./src/utils/saveTrainingsCache.mjs";

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

app.get("/api/sf/tg", (req, res) => {
  conn.query(
    "SELECT Id, Name,TNS_Id__c, Active_Participants_Count__c, Responsible_Staff__c FROM Training_Group__c",
    function (err, result) {
      if (err) {
        return console.error(err);
      }
      console.log("total : " + result.totalSize);
      console.log("fetched : " + result.records.length);
      res.send(result);
    }
  );
});

app.get("/api/sf/ts", (req, res) => {
  conn.query(
    "SELECT Id, Name, Module_Name__c, Training_Group__c, Session_Status__c, Male_Attendance__c, Female_Attendance__c, Trainer__c  FROM Training_Session__c",
    function (err, result) {
      if (err) {
        return console.error(err);
      }
      console.log("total : " + result.totalSize);
      console.log("fetched : " + result.records.length);
      res.send(result);
    }
  );
});

app.get("/api/sf/tp", (req, res) => {
  conn.query(
    "SELECT Id, Name, Training_Session__c, Participant_Gender__c, Status__c FROM Attendance__c",
    function (err, result) {
      if (err) {
        return console.error(err);
      }
      console.log("total : " + result.totalSize);
      console.log("fetched : " + result.records.length);
      res.send(result);
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
  ],
  resolvers: [
    PermissionsResolvers,
    RolesResolvers,
    UsersResolvers,
    ProjectsResolvers,
    LoginsResolvers,
  ],
  subscriptions: { path: "/subscriptions", onConnect: () => pubSub },
  context: ({ req }) => {
    return {
      sf_conn: conn,
    };
  },
});

server
  .start()
  .then(() => {
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
        "SELECT Id, Name, Training_Session__c, Participant_Gender__c, Status__c FROM Attendance__c",
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
