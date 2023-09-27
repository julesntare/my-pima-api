import { gql } from "apollo-server-express";

const FVBestPracticesTypeDefs = gql`
  type FVBestPractices {
    bp_id: String!
    fv_id: String!
    practice_name: String!
    questions: [String]
    answers: [String]
    best_practice_adopted: String
  }

  type Query {
    getFVBestPracticesByFarmVisits(fv_id: String!): AllFVBestPracticesResponse
  }

  type AllFVBestPracticesResponse {
    message: String!
    status: Int!
    fvBestPractices: FVBestPractices
  }
`;

export default FVBestPracticesTypeDefs;
