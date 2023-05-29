import { gql } from "apollo-server-express";

const LoginsTypeDefs = gql`
  type Login {
    session_id: Int
    user_id: Int
    session_token: String
    provider: String
    createdAt: String
  }

  type Query {
    getLogins: LoginsResponse
  }

  type Mutation {
    saveGoogleLogin(token: String!): AddLoginResponse
    saveMailLogin(email: String!, password: String!): AddLoginResponse
  }

  type LoginsResponse {
    message: String
    status: Int
    logins: [Login]
  }

  type AddLoginResponse {
    message: String
    status: Int
    token: String
  }
`;

export default LoginsTypeDefs;
