import { gql } from "apollo-server-express";

const ParticipantsTypeDefs = gql`
  scalar Upload

  type Participant {
    p_id: String!
    full_name: String!
    gender: String!
    location: String!
    tns_id: String!
    status: String!
    farmer_trainer: String!
    business_advisor: String!
    project_name: String!
    training_group: String!
    household_id: String
  }

  type Query {
    getParticipantsByProject(project_id: String!): AllParticipantsResponse
    getParticipantsByGroup(tg_id: String!): AllParticipantsResponse
  }

  type Mutation {
    uploadParticipants(parts_file: Upload!): UploadResponse
  }

  type AllParticipantsResponse {
    message: String!
    status: Int!
    participants: [Participant]
  }

  type UploadResponse {
    message: String!
    status: Int!
  }
`;

export default ParticipantsTypeDefs;
