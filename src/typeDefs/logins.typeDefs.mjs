import { gql } from "apollo-server-express";

const LoginsTypeDefs = gql`
  type Login {
    session_id: String
    user_id: String
    session_token: String
    provider: String
    added_on: String
  }

  type Query {
    getLogins: LoginsResponse
  }

  type Mutation {
    saveGoogleLogin(token: String!): AddLoginResponse
    saveMailLogin(email: String!, password: String!): AddLoginResponse
    verifyToken(token: String!): verifyResponse
  }

  type LoginsResponse {
    message: String
    status: Int
    logins: [Login]
  }

  type verifyResponse {
    message: String
    status: Int
  }

  type AddLoginResponse {
    message: String!
    status: Int!
    user: User
    token: String
  }
`;

export default LoginsTypeDefs;
