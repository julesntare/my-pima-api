import { gql } from "apollo-server-express";

const ParticipantsTypeDefs = gql`
  type Participants {
    participant_id: ID
    user_id: ID
    project_id: ID
    createdAt: String
    updatedAt: String
  }

  type Query {
    getParticipants: ParticipantsResponse
    getParticipantById(participant_id: ID!): ParticipantResponse
    getParticipantsByUserId(user_id: ID!): ParticipantsResponse
  }

  type Mutation {
    addParticipant(user_id: ID!, project_id: ID!): ParticipantResponse
    updateParticipant(
      participant_id: ID!
      user_id: ID!
      project_id: ID!
    ): ParticipantResponse
    deleteParticipant(participant_id: ID!): ParticipantResponse
  }

  type ParticipantsResponse {
    message: String
    status: Int
    participants: [Participants]
  }

  type ParticipantResponse {
    message: String
    status: Int
    participant: Participants
  }
`;

export default ParticipantsTypeDefs;
