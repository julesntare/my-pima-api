import { gql } from "apollo-server-express";

const ParticipantsTypeDefs = gql`
  type Participant {
    p_id: String!
    full_name: String!
    gender: String!
    location: String!
    tns_id: String!
    status: String!
    farmer_trainer: String!
    project_name: String!
    training_group: String!
  }

  type Query {
    getParticipantsByProject(project_id: String!): AllParticipantsResponse
    getParticipantsByGroup(tg_id: String!): AllParticipantsResponse
  }

  type AllParticipantsResponse {
    message: String!
    status: Int!
    participants: [Participant]
  }
`;

export default ParticipantsTypeDefs;
