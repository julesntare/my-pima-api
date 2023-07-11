import Participants from "../models/participants.model.mjs";
import Projects from "../models/projects.models.mjs";
import Users from "../models/users.model.mjs";

const ParticipantsResolvers = {
  Query: {
    getParticipants: async (_, __, {}) => {
      try {
        const res = await Participants.findAll();

        return {
          message: "Participants fetched successfully",
          status: 200,
          participants: res,
        };
      } catch (err) {
        console.error(err);

        return {
          message: err.message,
          status: 500,
        };
      }
    },

    getParticipantById: async (_, { participant_id }, {}) => {
      try {
        const res = await Participants.findByPk(participant_id);

        if (!res) {
          return {
            message: "Participant not found",
            status: 404,
          };
        }

        return {
          message: "Participant fetched successfully",
          status: 200,
          participant: res,
        };
      } catch (err) {
        console.error(err);

        return {
          message: err.message,
          status: 500,
        };
      }
    },

    getParticipantsByUserId: async (_, { user_id }, {}) => {
      try {
        const res = await Participants.findAll({
          where: {
            user_id,
          },
        });

        if (!res) {
          return {
            message: "Participants not found",
            status: 404,
          };
        }

        return {
          message: "Participants fetched successfully",
          status: 200,
          participants: res,
        };
      } catch (err) {
        console.error(err);

        return {
          message: err.message,
          status: 500,
        };
      }
    },
  },

  Mutation: {
    addParticipant: async (_, { user_id, project_id }, {}) => {
      try {
        // Check if user exists
        const user = await Users.findByPk(user_id);
        const project = await Projects.findByPk(project_id);

        if (!user) {
          return {
            message: "User not found",
            status: 404,
          };
        }

        if (!project) {
          return {
            message: "Project not found",
            status: 404,
          };
        }

        // Check if participant already exists
        const participant = await Participants.findOne({
          where: {
            user_id,
            project_id,
          },
        });

        if (participant) {
          return {
            message: "Participant already exists",
            status: 400,
          };
        }

        const res = await Participants.create({
          user_id,
          project_id,
        });

        return {
          message: "Participant added successfully",
          status: 200,
          participant: res,
        };
      } catch (err) {
        console.error(err);

        return {
          message: err.message,
          status: 500,
        };
      }
    },

    updateParticipant: async (
      _,
      { participant_id, user_id, project_id },
      {}
    ) => {
      // Check if participant exists
      const participant = await Participants.findByPk(participant_id);

      if (!participant) {
        return {
          message: "Participant not found",
          status: 404,
        };
      }

      // Check if user exists
      const user = await Users.findByPk(user_id);
      const project = await Projects.findByPk(project_id);

      if (!user) {
        return {
          message: "User not found",
          status: 404,
        };
      }

      if (!project) {
        return {
          message: "Project not found",
          status: 404,
        };
      }

      // check if user and project combination already exists
      const participantExists = await Participants.findOne({
        where: {
          user_id,
          project_id,
        },
      });

      if (participantExists) {
        return {
          message: "Participant already exists",
          status: 400,
        };
      }

      try {
        const res = await Participants.update(
          {
            user_id,
            project_id,
          },
          {
            where: {
              participant_id,
            },
          }
        );

        return {
          message: "Participant updated successfully",
          status: 200,
          participant: res,
        };
      } catch (err) {
        console.error(err);

        return {
          message: err.message,
          status: 500,
        };
      }
    },

    deleteParticipant: async (_, { participant_id }, {}) => {
      try {
        // Check if participant exists
        const participant = await Participants.findByPk(participant_id);

        if (!participant) {
          return {
            message: "Participant not found",
            status: 404,
          };
        }

        const res = await Participants.destroy({
          where: {
            participant_id,
          },
        });

        return {
          message: "Participant deleted successfully",
          status: 200,
          participant: res,
        };
      } catch (err) {
        console.error(err);

        return {
          message: err.message,
          status: 500,
        };
      }
    },
  },
};

export default ParticipantsResolvers;
