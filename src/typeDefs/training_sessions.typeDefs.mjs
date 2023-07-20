import { gql } from "apollo-server-express";

const TrainingSessionsTypeDefs = gql`
  type TrainingSession {
    ts_id: ID!
    ts_name: String!
    ts_module: String!
    ts_group: String
    tns_id: String
    ts_status: String!
    total_males: Int
    total_females: Int
  }

  type Query {
    trainingSessions: AllTrainingSessionsResponse
    trainingSession(ts_id: ID!): TrainingSessionResponse
    trainingSessionsByProject(
      sf_project_id: String!
    ): AllTrainingSessionsResponse
    trainingSessionsByGroup(tg_id: String!): AllTrainingSessionsResponse
  }

  type AllTrainingSessionsResponse {
    message: String!
    status: Int!
    trainingSessions: [TrainingSession]
  }

  type TrainingSessionResponse {
    message: String!
    status: Int!
    trainingSession: TrainingSession
  }
`;

export default TrainingSessionsTypeDefs;
