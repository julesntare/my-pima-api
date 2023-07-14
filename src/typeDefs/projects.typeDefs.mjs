import { gql } from "apollo-server-express";

const ProjectsTypeDefs = gql`
  type Projects {
    project_id: ID
    sf_project_id: String
    project_name: String
    project_status: String
    createdAt: String
    updatedAt: String
  }

  type Query {
    loadProjects: LoadProjectsResponse
    getProjects: ProjectsResponse
    getProjectById(project_id: ID!): ProjectResponse
    getProjectsAssigned(user_id: ID!): ProjectsResponse
    getProjectBusinessAdvisors(project_id: ID!): PRResponse
    getProjectFarmerTrainers(project_id: ID!): PRResponse
    getProjectStatistics(sf_project_id: ID!): ProjectStatisticsResponse
  }

  type ProjectsResponse {
    message: String!
    status: Int!
    projects: [Projects]
  }

  type LoadProjectsResponse {
    message: String!
    status: Int!
    total_new_projects: Int
  }

  type ProjectResponse {
    message: String!
    status: Int!
    project: Projects
  }

  type PRResponse {
    message: String!
    status: Int!
    leaders: [ProjectLeaders]
  }

  type ProjectLeaders {
    name: String
  }

  type ProjectStatisticsResponse {
    message: String!
    status: Int!
    statistics: ProjectStatistics
  }

  type ProjectStatistics {
    total_groups: Int
    total_participants: Int
    total_bas: Int
    total_fts: Int
  }
`;

export default ProjectsTypeDefs;
