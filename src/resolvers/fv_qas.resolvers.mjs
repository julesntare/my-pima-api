import fetchImage from "../utils/commCareApi.mjs";

const FVQAsResolvers = {
  Query: {
    getFVQAsByFarmVisits: async (_, { fv_id }, { sf_conn }) => {
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

        const fvQAs = await sf_conn.query(
          "SELECT Id, Name, Best_Practice_Adoption__c, Farm_Visit__c, number_of_main_stems_on_majority_trees__c, photo_of_trees_and_average_main_stems__c, health_of_new_planting_choice__c, Color_of_coffee_tree_leaves__c, how_many_weeds_under_canopy_and_how_big__c, photo_of_weeds_under_the_canopy__c, take_a_photo_of_erosion_control__c, level_of_shade_present_on_the_farm__c, photo_of_level_of_shade_on_the_plot__c, planted_intercrop_bananas__c, photograph_intercrop_bananas__c, do_you_have_a_record_book__c, are_there_records_on_the_record_book__c, take_a_photo_of_the_record_book__c, do_you_have_compost_manure__c, photo_of_the_compost_manure__c FROM FV_Best_Practices__c WHERE Farm_Visit__c = '" +
            fv_id +
            "'"
        );

        if (fvQAs.totalSize === 0) {
          return {
            message: "Best Practice not found",
            status: 404,
          };
        }

        const bp = fvQAs.records[0];

        return {
          message: "Best Practices fetched successfully",
          status: 200,
          fvQAs: {
            bp_id: bp.Id,
            fv_id: bp.Farm_Visit__c,
            qas: [
              {
                practice_name: "Main Stems",
                questions: [
                  "How many main stems are on the majority of the trees?",
                  "Take a photo of the trees and average main stems",
                ],
                answers: [
                  bp.number_of_main_stems_on_majority_trees__c,
                  await fetchImage(bp.photo_of_trees_and_average_main_stems__c),
                ],
              },
              {
                practice_name: "Pruning",
                questions: [],
                answers: [],
              },
              {
                practice_name: "Health of New Planting",
                questions: [
                  "What is the health of the new planting choice?",
                  "What is the color of the coffee tree leaves?",
                ],
                answers: [
                  bp.health_of_new_planting_choice__c,
                  bp.color_of_coffee_tree_leaves__c,
                ],
              },
              {
                practice_name: "Nutrition",
                questions: [],
                answers: [],
              },
              {
                practice_name: "Weeding",
                questions: [
                  "How many weeds are under the canopy and how big are they?",
                  "Take a photo of the weeds under the canopy",
                ],
                answers: [
                  bp.how_many_weeds_under_canopy_and_how_big__c,
                  await fetchImage(bp.photo_of_weeds_under_the_canopy__c),
                ],
              },
              {
                practice_name: "IPDM",
                questions: [],
                answers: [],
              },
              {
                practice_name: "Erosion Control",
                questions: ["Take a photo of erosion control"],
                answers: [
                  await fetchImage(bp.take_a_photo_of_erosion_control__c),
                ],
              },
              {
                practice_name: "Shade",
                questions: [
                  "What is the level of shade present on the farm?",
                  "Take a photo of the level of shade on the plot",
                ],
                answers: [
                  bp.level_of_shade_present_on_the_farm__c,
                  await fetchImage(bp.photo_of_level_of_shade_on_the_plot__c),
                ],
              },
              {
                practice_name: "Record Book",
                questions: [
                  "Do you have a record book?",
                  "Are there records on the record book?",
                  "Take a photo of the record book",
                ],
                answers: [
                  bp.do_you_have_a_record_book__c,
                  bp.are_there_records_on_the_record_book__c,
                  await fetchImage(bp.take_a_photo_of_the_record_book__c),
                ],
              },
              {
                practice_name: "Compost",
                questions: [
                  "Do you have compost manure?",
                  "Take a photo of the compost manure",
                ],
                answers: [
                  bp.do_you_have_compost_manure__c,
                  await fetchImage(bp.photo_of_the_compost_manure__c),
                ],
              },
            ],
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

export default FVQAsResolvers;
