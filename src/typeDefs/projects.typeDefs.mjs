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
    getProjects: ProjectsResponse
    loadProjects: LoadProjectsResponse
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
`;

export default ProjectsTypeDefs;
