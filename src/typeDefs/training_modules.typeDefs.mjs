import { gql } from "apollo-server-express";

const TrainingModulesTypeDefs = gql`
  scalar Upload

  type TrainingModule {
    tm_id: ID!
    tm_name: String!
    tm_title: String!
    tm_module_number: Int!
    tm_project: String!
    tm_status: String!
    tm_is_current: Boolean!
    tm_date: String
  }

  type Query {
    getAllTrainingModules: AllTrainingModulesResponse
    getTrainingModulesByProject(project_id: String!): AllTrainingModulesResponse
  }

  type AllTrainingModulesResponse {
    message: String!
    status: Int!
    training_modules: [TrainingModule]
  }

  type UploadResponse {
    message: String!
    status: Int!
  }
`;

export default TrainingModulesTypeDefs;
