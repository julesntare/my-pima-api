import { gql } from "apollo-server-express";

const TrainingSessionsTypeDefs = gql`
    type TrainingSession {
        ts_id: ID!
        ts_name: String!
        ts_module: String!
        ts_group: String!
        ts_status: String!
        total_males: Int!
        total_females: Int!
    }

    query TrainingSessions {
        trainingSessions: AllTrainingSessionsResponse
        trainingSession(ts_id: ID!): TrainingSessionResponse
        trainingSessionsByGroup(ts_group: String!): AllTrainingSessionsResponse
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
