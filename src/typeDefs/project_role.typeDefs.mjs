import { gql } from "apollo-server-express";

const ProjectRoleTypeDefs = gql`
  type ProjectRole {
    pr_id: ID
    user_id: ID
    user: User
    project_id: ID
    project: Projects
    role_id: String
    role: Roles
    createdAt: String
    updatedAt: String
  }

  type Query {
    loadProjectRoles: LoadedProjectRolesResponse
    getProjectRoles: ProjectRolesResponse
    getProjectRoleById(pr_id: ID!): ProjectRoleResponse
    getProjectRolesByUserId(user_id: ID!): ProjectRolesResponse
    getProjectRolesByProjectId(project_id: ID!): ProjectRolesResponse
  }

  type Mutation {
    addProjectRole(
      user_id: ID!
      project_id: ID!
      role_id: String
    ): ProjectRoleResponse
    updateProjectRole(
      user_id: ID!
      project_id: ID!
      role_id: String!
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
