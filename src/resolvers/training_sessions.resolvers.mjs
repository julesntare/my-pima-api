const TrainingSessionsResolvers = {
  Query: {
    trainingSessionStatistics: async (_, { ts_id }, { sf_conn }) => {
      return {
        message: "Training session statistics fetched successfully",
        status: 200,
        statistics: {
          male_attendance: 0,
          female_attendance: 0,
          total_attendance: 0,
        },
      };
    },
  },
};

export default TrainingSessionsResolvers;
