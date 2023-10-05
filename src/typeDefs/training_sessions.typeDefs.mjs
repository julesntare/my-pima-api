import { gql } from "apollo-server-express";

const TrainingSessionsTypeDefs = gql`
  type TrainingSession {
    ts_id: ID!
    ts_name: String!
    ts_module: String!
    ts_group: String
    tns_id: String
    farmer_trainer: String
    ts_status: String!
    total_males: Int
    total_females: Int
    session_image: String
    has_image: Boolean
    session_image_status: String
    is_verified: Boolean
    session_date: String
  }

  type Query {
    trainingSessions: AllTrainingSessionsResponse
    trainingSession(ts_id: ID!): TrainingSessionResponse
    trainingSessionsByProject(
      sf_project_id: String!
    ): AllTrainingSessionsResponse
    trainingSessionsByGroup(tg_id: String!): AllTrainingSessionsResponse
    trainingSessionImage(ts_id: ID!): TrainingSessionImageResponse
  }

  type Mutation {
    validateSession(ts_id: ID!, status: String!): TrainingSessionResponse
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

  type TrainingSessionImageResponse {
    message: String!
    status: Int!
    trainingSessionImage: String
  }
`;

export default TrainingSessionsTypeDefs;
