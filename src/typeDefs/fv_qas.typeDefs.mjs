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

  type Mutation {
    updateFVQAImageStatus(
      bp_id: String!
      field_name: FieldNames!
      image_status: Status!
    ): FVQAsResponse
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

  type FVQAsResponse {
    message: String!
    status: Int!
    fvQA: FVQAs
  }

  enum Status {
    not_verified
    approved
    invalid
    unclear
  }

  enum FieldNames {
    MainStems
    Pruning
    HealthofNewPlanting
    Nutrition
    Weeding
    IPDM
    ErosionControl
    Shade
    RecordBook
    Compost
  }
`;

export default FVQAsTypeDefs;
