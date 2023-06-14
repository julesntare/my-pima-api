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

    type Query {
        trainingSessions: AllTrainingSessionsResponse
        trainingSession(ts_id: ID!): TrainingSessionResponse
        trainingSessionsByGroup(ts_group: String!): AllTrainingSessionsResponse
        trainingSessionStatistics(ts_id: ID!): TrainingSessionStatisticsResponse
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

    type TrainingSessionStatisticsResponse {
        message: String!
        status: Int!
        statistics: TrainingSessionStatistics
    }

    type TrainingSessionStatistics {
        male_attendance: Int
        female_attendance: Int
        total_attendance: Int
    }
`;

export default TrainingSessionsTypeDefs;
