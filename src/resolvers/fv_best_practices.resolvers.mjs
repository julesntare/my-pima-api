import fetchImage from "../utils/commCareApi.mjs";

const FVBestPracticesResolvers = {
  Query: {
    getFVBestPracticesByFarmVisits: async (_, { fv_id }, { sf_conn }) => {
      try {
        // check if training group exists by tg_id
        const farm_visit = await sf_conn.query(
          `SELECT Id FROM Farm_Visit__c WHERE Id = '${fv_id}'`
        );

        if (farm_visit.totalSize === 0) {
          return {
            message: "Farm Visit not found",
            status: 404,
          };
        }

        const fvBestPractices = await sf_conn.query(
          "SELECT Id, Name, Best_Practice_Adoption__c, Farm_Visit__c, number_of_main_stems_on_majority_trees__c, photo_of_trees_and_average_main_stems__c, health_of_new_planting_choice__c, Color_of_coffee_tree_leaves__c, how_many_weeds_under_canopy_and_how_big__c, photo_of_weeds_under_the_canopy__c, take_a_photo_of_erosion_control__c, level_of_shade_present_on_the_farm__c, photo_of_level_of_shade_on_the_plot__c, planted_intercrop_bananas__c, photograph_intercrop_bananas__c, do_you_have_a_record_book__c, are_there_records_on_the_record_book__c, take_a_photo_of_the_record_book__c, do_you_have_compost_manure__c, photo_of_the_compost_manure__c FROM FV_Best_Practices__c WHERE Farm_Visit__c = '" +
            fv_id +
            "'"
        );

        if (fvBestPractices.totalSize === 0) {
          return {
            message: "Best Practice not found",
            status: 404,
          };
        }

        const bp = fvBestPractices.records[0];

        return {
          message: "Best Practices fetched successfully",
          status: 200,
          fvBestPractices: {
            bp_id: bp.Id,
            fv_id: bp.Farm_Visit__c,
            practice_name: bp.Name,
            questions: [
              "How many main stems are on the majority of the trees?",
              "Take a photo of the trees and average main stems",
              "What is the health of the new planting choice?",
              "What is the color of the coffee tree leaves?",
              "How many weeds are under the canopy and how big are they?",
              "Take a photo of the weeds under the canopy",
              "Take a photo of erosion control",
              "What is the level of shade present on the farm?",
              "Take a photo of the level of shade on the plot",
              "Have you planted intercrop bananas?",
              "Take a photo of the intercrop bananas",
              "Do you have a record book?",
              "Are there records on the record book?",
              "Take a photo of the record book",
              "Do you have compost manure?",
              "Take a photo of the compost manure",
            ],
            answers: [
              bp.number_of_main_stems_on_majority_trees__c,
              await fetchImage(bp.photo_of_trees_and_average_main_stems__c),
              bp.health_of_new_planting_choice__c,
              bp.Color_of_coffee_tree_leaves__c,
              bp.how_many_weeds_under_canopy_and_how_big__c,
              await fetchImage(bp.photo_of_weeds_under_the_canopy__c),
              await fetchImage(bp.take_a_photo_of_erosion_control__c),
              bp.level_of_shade_present_on_the_farm__c,
              await fetchImage(bp.photo_of_level_of_shade_on_the_plot__c),
              bp.planted_intercrop_bananas__c,
              await fetchImage(bp.photograph_intercrop_bananas__c),
              bp.do_you_have_a_record_book__c,
              bp.are_there_records_on_the_record_book__c,
              await fetchImage(bp.take_a_photo_of_the_record_book__c),
              bp.do_you_have_compost_manure__c,
              await fetchImage(bp.photo_of_the_compost_manure__c),
            ],
            best_practice_adopted: bp.Best_Practice_Adoption__c,
          },
        };
      } catch (error) {
        console.log(error);

        return {
          message: error.message,
          status: error.status,
        };
      }
    },
  },
};

export default FVBestPracticesResolvers;
