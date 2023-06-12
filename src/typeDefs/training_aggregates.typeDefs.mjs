import { gql } from "apollo-server-express";

const TrainingAggregatesTypeDefs = gql`
  type TrainingAggregates {
    training_groups_count: Int
    total_participants_count: Int
    active_ba_count: Int
    male_attendance_count: Int
    female_attendance_count: Int
  }

  type Query {
    getTrainingAggregates: TrainingAggregatesResponse
  }

  type TrainingAggregatesResponse {
    message: String
    status: Int
    training_aggregates: TrainingAggregates
  }
`;

export default TrainingAggregatesTypeDefs;
