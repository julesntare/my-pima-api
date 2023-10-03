import { gql } from "apollo-server-express";

const FVQAsTypeDefs = gql`
  type FVQAs {
    bp_id: String!
    fv_id: String!
    qas: [QA]
  }

  type Query {
    getFVQAsByFarmVisits(fv_id: String!): AllFVQAsResponse
  }

  type AllFVQAsResponse {
    message: String!
    status: Int!
    fvQAs: FVQAs
  }

  type QA {
    practice_name: String!
    questions: [String]
    answers: [String]
  }
`;

export default FVQAsTypeDefs;
