import Roles from "../models/roles.model.mjs";
import Users from "../models/users.model.mjs";
import bcrypt from "bcrypt";

const UsersResolvers = {
  Query: {
    loadSFUsers: async (_, __, { sf_conn }) => {
      let records = [],
        total_new_users = 0;

      // fetch default role id from db
      const default_role = await Roles.findOne({
        where: { is_default: true },
      });

      try {
        records = await sf_conn.query(
          "SELECT Id, Username, SenderEmail, Phone, IsActive FROM User"
        );

        const promises = records.records.map(async (record) => {
          const user = await Users.findOne({
            where: { sf_user_id: record.Id },
          });
          if (!user) {
            total_new_users += 1;
            const hashed_password = await bcrypt.hash("MP@1234", 10); // default password for all users "MP@1234
            await Users.create({
              sf_user_id: record.Id,
              user_name: record.Username,
              user_password: hashed_password, // default password for all users "MP@1234
              user_email: record.Username,
              mobile_no: "N/A",
              role_id: default_role.role_id,
              account_status: record.IsActive ? "active" : "inactive",
            });
          } else {
            await Users.update(
              {
                user_name: record.Username,
                user_email: record.Username,
                mobile_no: "N/A",
                account_status: record.IsActive ? "active" : "inactive",
              },
              {
                where: { sf_user_id: record.Id },
              }
            );
          }
        });

        await Promise.all(promises);

        return {
          message: "Users loaded successfully",
          status: 200,
          total_new_users,
        };
      } catch (err) {
        console.error(err);

        return {
          message: err.message,
          status: err.status,
        };
      }
    },

    getUsers: async () => {
      try {
        const users = await Users.findAll();
        return {
          message: "Users fetched successfully",
          status: 200,
          users,
        };
      } catch (err) {
        console.log(err);
        return {
          message: err.message,
          status: err.status,
        };
      }
    },

    getUserById: async (_, { user_id }) => {
      try {
        const user = await Users.findOne({
          where: { sf_user_id: user_id },
        });

        if (!user) {
          return {
            message: "User not found",
            status: 404,
          };
        }

        return {
          message: "User fetched successfully",
          status: 200,
          user,
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

  Mutation: {
    addUser: async (_, { user_email, mobile_no, user_password, role_id }) => {
      // check if user already exists
      const user = await Users.findOne({
        where: { user_email },
      });

      if (user) {
        return {
          message: "User already exists",
          status: 400,
        };
      }

      // if role_id not provided, fetch default role id from db
      if (!role_id) {
        const default_role = await Roles.findOne({
          where: { is_default: true },
        });
        role_id = default_role.role_id;
      }

      // check if role exists
      const role = await Roles.findOne({
        where: { role_id },
      });

      if (!role) {
        return {
          message: "Role does not exist",
          status: 400,
        };
      }

      try {
        // hash password
        user_password = await bcrypt.hash(user_password, 10);

        const userCreated = await Users.create({
          user_name: user_email,
          user_email,
          mobile_no,
          user_password,
          role_id,
        });

        return {
          message: "User added successfully",
          status: 200,
          user: userCreated,
        };
      } catch (err) {
        console.error(err);
        return {
          message: err.message,
          status: err.status,
        };
      }
    },
  },
};

export default UsersResolvers;
