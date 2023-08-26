import { gql } from "apollo-server-express";

const ProjectRoleTypeDefs = gql`
  type ProjectRole {
    pr_id: ID
    user_id: ID
    project_id: ID
    role: String
    tbl_user: User
    tbl_project: Projects
    tbl_role: Roles
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
      pr_id: ID!
      user_id: ID!
      project_id: ID!
      role_id: String
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
