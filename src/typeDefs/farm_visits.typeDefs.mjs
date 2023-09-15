import { gql } from "apollo-server-express";

const FarmVisitsTypeDefs = gql`
  type FarmVisit {
    fv_id: String!
    fv_name: String!
    training_group: String!
    training_session: String
    tns_id: String
    farm_visited: String
    household_id: String!
    farmer_trainer: String!
    has_training: String!
    date_visited: String!
  }

  type Query {
    getFarmVisitsByProject(project_id: String!): AllFarmVisitsResponse
    getFarmVisitsByGroup(tg_id: String!): AllFarmVisitsResponse
    getFarmVisitsByParticipant(part_id: String!): AllFarmVisitsResponse
  }

  type AllFarmVisitsResponse {
    message: String!
    status: Int!
    farmVisits: [FarmVisit]
  }
`;

export default FarmVisitsTypeDefs;
