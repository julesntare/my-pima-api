import Roles from "../models/roles.model.mjs";
import Users from "../models/users.model.mjs";

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
            await Users.create({
              sf_user_id: record.Id,
              user_name: record.Username,
              user_password: "MP@1234", // default password for all users "MP@1234
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
  },
};

export default UsersResolvers;
