import { gql } from "apollo-server-express";

const ProjectRoleTypeDefs = gql`
  type ProjectRole {
    pr_id: ID
    user_id: ID
    project_id: ID
    createdAt: String
    updatedAt: String
  }

  type Query {
    loadProjectRoles: LoadedProjectRolesResponse
    getProjectRoles: ProjectRolesResponse
    getProjectRoleById(pr_id: ID!): ProjectRoleResponse
    getProjectRolesByUserId(user_id: ID!): ProjectRolesResponse
  }

  type Mutation {
    addProjectRole(user_id: ID!, project_id: ID!): ProjectRoleResponse
    updateProjectRole(
      pr_id: ID!
      user_id: ID!
      project_id: ID!
    ): ProjectRoleResponse
    deleteProjectRole(pr_id: ID!): ProjectRoleResponse
  }

  type ProjectRolesResponse {
    message: String
    status: Int
    project_role: [ProjectRole]
  }

  type ProjectRoleResponse {
    message: String
    status: Int
    project_role: ProjectRole
  }

  type LoadedProjectRolesResponse {
    message: String
    status: Int
    total_loaded: Int
  }
`;

export default ProjectRoleTypeDefs;
