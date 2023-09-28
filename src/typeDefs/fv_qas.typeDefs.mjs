import { gql } from "apollo-server-express";

const FVQAsTypeDefs = gql`
  type FVQAs {
    bp_id: String!
    fv_id: String!
    practice_name: String!
    questions: [String]
    answers: [String]
    best_practice_adopted: String
  }

  type Query {
    getFVQAsByFarmVisits(fv_id: String!): AllFVQAsResponse
  }

  type AllFVQAsResponse {
    message: String!
    status: Int!
    fvQAs: FVQAs
  }
`;

export default FVQAsTypeDefs;
