const TrainingModulesResolvers = {
  Query: {
    getAllTrainingModules: async (_, __, { sf_conn }) => {
      try {
        const training_modules = await sf_conn.query(
          "SELECT Id, Current_Training_Module__c, Current_Previous_Module__c, Date__c, Module_Number__c, Module_Status__c, Module_Title__c, Project__c, Name, Unique_Name__c, OwnerId FROM Training_Module__c WHERE Module_Status__c = 'Active'"
        );

        if (training_modules.totalSize === 0) {
          return {
            message: "Training Modules not found",
            status: 404,
          };
        }

        return {
          message: "Training Modules fetched successfully",
          status: 200,
          training_modules: training_modules.records.map(
            async (training_module) => {
              return {
                tm_id: training_module.Id,
                tm_name: training_module.Name,
                tm_title: training_module.Module_Title__c,
                tm_module_number: training_module.Module_Number__c,
                tm_project: training_module.Project__c,
                tm_status: training_module.Module_Status__c,
                tm_is_current: training_module.Current_Training_Module__c,
                tm_date: training_module.Date__c,
              };
            }
          ),
        };
      } catch (error) {
        console.log(error);

        return {
          message: error.message,
          status: error.status,
        };
      }
    },

    getTrainingModulesByProject: async (_, { project_id }, { sf_conn }) => {
      try {
        const training_modules = await sf_conn.query(
          "SELECT Id, Current_Training_Module__c, Current_Previous_Module__c, Date__c, Module_Number__c, Module_Status__c, Module_Title__c, Project__c, Name, Unique_Name__c, OwnerId FROM Training_Module__c WHERE Project__c = '" +
            project_id +
            "' AND Module_Status__c = 'Active'"
        );

        if (training_modules.totalSize === 0) {
          return {
            message: "Training Modules not found",
            status: 404,
          };
        }

        return {
          message: "Training Modules fetched successfully",
          status: 200,
          training_modules: training_modules.records.map(
            async (training_module) => {
              return {
                tm_id: training_module.Id,
                tm_name: training_module.Name,
                tm_title: training_module.Module_Title__c,
                tm_module_number: training_module.Module_Number__c,
                tm_project: training_module.Project__c,
                tm_status: training_module.Module_Status__c,
                tm_is_current: training_module.Current_Training_Module__c,
                tm_date: training_module.Date__c,
              };
            }
          ),
        };
      } catch (err) {
        console.log(err);

        return {
          message: err.message,
          status: err.status,
        };
      }
    },
  },
};

export default TrainingModulesResolvers;
