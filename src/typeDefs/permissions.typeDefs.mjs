import { gql } from "apollo-server-express";

const PermissionsTypeDefs = gql`
  type Permissions {
    perm_id: ID
    perm_name: String
    perm_desc: String
    perm_status: String
    createdAt: String
    updatedAt: String
  }

  type Query {
    getPermissions: PermissionsResponse
    getPermission(perm_id: ID!): PermissionResponse
    getPermissionsByRole(role_id: ID!): PermissionsResponse
  }

  type Mutation {
    addPermission(perm_name: String!, perm_desc: String): PermissionResponse
    updatePermission(
      perm_id: ID!
      perm_name: String
      perm_desc: String
      perm_status: String
    ): PermissionResponse
    deletePermission(perm_id: ID!): PermissionResponse
  }

  type PermissionsResponse {
    message: String
    status: Int
    permissions: [Permissions]
  }

  type PermissionResponse {
    message: String
    status: Int
    permission: Permissions
  }
`;

export default PermissionsTypeDefs;
