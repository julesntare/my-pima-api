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
          "SELECT Id, Name, Best_Practice_Adoption__c, Farm_Visit__c, number_of_main_stems_on_majority_trees__c, photo_of_trees_and_average_main_stems__c, Main_Stems_Photo_Status__c, health_of_new_planting_choice__c, Color_of_coffee_tree_leaves__c, how_many_weeds_under_canopy_and_how_big__c, photo_of_weeds_under_the_canopy__c, Weeds_Under_Canopy_Photo_Status__c, take_a_photo_of_erosion_control__c, Erosion_Control_Photo_Status__c, level_of_shade_present_on_the_farm__c, photo_of_level_of_shade_on_the_plot__c, Level_Of_Shade_Plot_Photo_Status__c, planted_intercrop_bananas__c, photograph_intercrop_bananas__c, Intercrop_Bananas_Photo_Status__c, do_you_have_a_record_book__c, are_there_records_on_the_record_book__c, take_a_photo_of_the_record_book__c, Record_Book_Photo_Status__c, do_you_have_compost_manure__c, photo_of_the_compost_manure__c, Compost_Manure_Photo_Status__c FROM FV_Best_Practices__c WHERE Farm_Visit__c='" +
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
                  "Status of the photo",
                ],
                answers: [
                  bp.number_of_main_stems_on_majority_trees__c,
                  await fetchImage(bp.photo_of_trees_and_average_main_stems__c),
                  !bp.Main_Stems_Photo_Status__c ||
                  bp.Main_Stems_Photo_Status__c == "not_verified"
                    ? "Not Verified"
                    : bp.Main_Stems_Photo_Status__c,
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
                  "Status of the photo",
                ],
                answers: [
                  bp.how_many_weeds_under_canopy_and_how_big__c,
                  await fetchImage(bp.photo_of_weeds_under_the_canopy__c),
                  !bp.Weeds_Under_Canopy_Photo_Status__c ||
                  bp.Weeds_Under_Canopy_Photo_Status__c == "not_verified"
                    ? "Not Verified"
                    : bp.Weeds_Under_Canopy_Photo_Status__c,
                ],
              },
              {
                practice_name: "IPDM",
                questions: [],
                answers: [],
              },
              {
                practice_name: "Erosion Control",
                questions: [
                  "Take a photo of erosion control",
                  "Status of the photo",
                ],
                answers: [
                  await fetchImage(bp.take_a_photo_of_erosion_control__c),
                  !bp.Erosion_Control_Photo_Status__c ||
                  bp.Erosion_Control_Photo_Status__c == "not_verified"
                    ? "Not Verified"
                    : bp.Erosion_Control_Photo_Status__c,
                ],
              },
              {
                practice_name: "Shade",
                questions: [
                  "What is the level of shade present on the farm?",
                  "Take a photo of the level of shade on the plot",
                  "Status of the photo",
                ],
                answers: [
                  bp.level_of_shade_present_on_the_farm__c,
                  await fetchImage(bp.photo_of_level_of_shade_on_the_plot__c),
                  !bp.Level_Of_Shade_Plot_Photo_Status__c ||
                  bp.Level_Of_Shade_Plot_Photo_Status__c == "not_verified"
                    ? "Not Verified"
                    : bp.Level_Of_Shade_Plot_Photo_Status__c,
                ],
              },
              {
                practice_name: "Record Book",
                questions: [
                  "Do you have a record book?",
                  "Are there records on the record book?",
                  "Take a photo of the record book",
                  "Status of the photo",
                ],
                answers: [
                  bp.do_you_have_a_record_book__c,
                  bp.are_there_records_on_the_record_book__c,
                  await fetchImage(bp.take_a_photo_of_the_record_book__c),
                  !bp.Record_Book_Photo_Status__c ||
                  bp.Record_Book_Photo_Status__c == "not_verified"
                    ? "Not Verified"
                    : bp.Record_Book_Photo_Status__c,
                ],
              },
              {
                practice_name: "Compost",
                questions: [
                  "Do you have compost manure?",
                  "Take a photo of the compost manure",
                  "Status of the photo",
                ],
                answers: [
                  bp.do_you_have_compost_manure__c,
                  await fetchImage(bp.photo_of_the_compost_manure__c),
                  !bp.Compost_Manure_Photo_Status__c ||
                  bp.Compost_Manure_Photo_Status__c == "not_verified"
                    ? "Not Verified"
                    : bp.Compost_Manure_Photo_Status__c,
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

  Mutation: {
    updateFVQAImageStatus: async (
      _,
      { bp_id, field_name, image_status },
      { sf_conn }
    ) => {
      // map field name to salesforce photo field name
      const photo_fields = {
        MainStems: "Main_Stems_Photo_Status__c",
        Pruning: "Pruning_Photo_Status__c",
        HealthofNewPlanting: "Health_Of_New_Planting_Photo_Status__c",
        Nutrition: "Nutrition_Photo_Status__c",
        Weeding: "Weeds_Under_Canopy_Photo_Status__c",
        IPDM: "IPDM_Photo_Status__c",
        ErosionControl: "Erosion_Control_Photo_Status__c",
        Shade: "Level_Of_Shade_Plot_Photo_Status__c",
        RecordBook: "Record_Book_Photo_Status__c",
        Compost: "Compost_Manure_Photo_Status__c",
      };

      try {
        const bp = await sf_conn.sobject("FV_Best_Practices__c").update({
          Id: bp_id,
          [photo_fields[field_name]]: image_status,
        });

        // check if best practice exists in soql query
        if (!bp.success) {
          return {
            message: "Best Practice not found",
            status: 404,
          };
        }

        return {
          message: "Best Practice updated successfully",
          status: 200,
          fvQA: bp,
        };
      } catch (error) {
        console.log(error);

        return {
          message: "Internal Server Error",
          status: 500,
        };
      }
    },
  },
};

export default FVQAsResolvers;
