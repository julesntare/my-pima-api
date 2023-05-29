import { gql } from "apollo-server-express";

const RolesTypeDefs = gql`
  type Roles {
    role_id: ID
    role_name: String
    role_desc: String
    permissions: [String]
    is_default: Boolean
    role_status: String
    createdAt: String
    updatedAt: String
  }

  type Query {
    getRoles: RolesResponse
    getRole(role_id: ID!): RoleResponse
  }

  type Mutation {
    addRole(
      role_name: String!
      role_desc: String
      permissions: [String]!
      is_default: Boolean
      role_status: String
    ): RoleResponse

    updateRole(
      role_id: ID!
      role_name: String
      role_desc: String
      permissions: [String]
      is_default: Boolean
      role_status: String
    ): RoleResponse

    deleteRole(role_id: ID!): RoleResponse
  }

  type RolesResponse {
    message: String
    status: Int
    roles: [Roles]
  }

  type RoleResponse {
    message: String
    status: Int
    role: Roles
  }
`;

export default RolesTypeDefs;
