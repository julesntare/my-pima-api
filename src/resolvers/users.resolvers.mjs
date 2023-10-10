import { Op } from "sequelize";
import Roles from "../models/roles.model.mjs";
import Users from "../models/users.model.mjs";
import bcrypt from "bcrypt";
import nodemailer from "nodemailer";
import dotenv from "dotenv";
import sendEmail from "../utils/sendMail.mjs";
import Verifications from "../models/verifications.model.mjs";

const transporter = nodemailer.createTransport({
  service: "gmail",
  auth: {
    user: "julesntare@gmail.com",
    pass: "mdrxhobifrtyipof",
  },
});

dotenv.config();

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
          "SELECT Id, Name, Email, Phone, contact_status__c FROM Contact"
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
              user_name: record.Name,
              user_password: hashed_password, // default password for all users "MP@1234
              user_email: record.Email,
              mobile_no: record.Phone,
              role_id: default_role.role_id,
              account_status:
                record.contact_status__c === "Active" ? "active" : "inactive",
            });
          } else {
            await Users.update(
              {
                user_name: record.Name,
                user_email: record.Email,
                mobile_no: record.Phone,
                account_status:
                  record.contact_status__c === "Active" ? "active" : "inactive",
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
        const users = await Users.findAll({
          include: [
            {
              model: Roles,
            },
          ],
        });

        // check in project role table if user is assigned to any project
        // users.forEach(async (user) => {
        //   const project = await ProjectRole.findOne({
        //     where: { user_id: user.user_id },
        //   });

        //   if (project) {
        //     user.project = project.project_id;
        //   }

        //   return user;
        // });

        // map tbl_roles in users as role
        users.map((user) => {
          user.role = user.tbl_role;
          return user;
        });

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
          where: { user_id },
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

    getUserBySFId: async (_, { sf_user_id }) => {
      try {
        const user = await Users.findOne({
          where: { sf_user_id },
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
    addUser: async (
      _,
      { user_name, user_email, mobile_no, user_password, role_id }
    ) => {
      // check if user email or mobile no already exists
      const user = await Users.findOne({
        where: {
          [Op.or]: [{ user_email }, { mobile_no }],
        },
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
          user_name,
          user_email,
          mobile_no,
          user_password,
          role_id,
        });

        // get role info
        const userRole = await Roles.findOne({
          where: { role_id },
        });

        userCreated.role = userRole;

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

    updateUser: async (
      _,
      { user_id, user_name, user_email, mobile_no, role_id, account_status }
    ) => {
      // check if user exists
      const user = await Users.findOne({
        where: { user_id },
      });

      if (!user) {
        return {
          message: "User not found",
          status: 404,
        };
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

      // if fields are not provided, use existing values
      user_name = user_name || user.user_name;
      user_email = user_email || user.user_email;
      mobile_no = mobile_no || user.mobile_no;
      role_id = role_id || user.role_id;
      account_status = account_status || user.account_status;

      try {
        await Users.update(
          {
            user_name,
            user_email,
            mobile_no,
            role_id,
          },
          {
            where: { user_id },
          }
        );

        // get updated user
        const updatedUser = await Users.findOne({
          where: { user_id },
        });

        // get role info
        const userRole = await Roles.findOne({
          where: { role_id },
        });

        updatedUser.role = userRole;

        return {
          message: "User updated successfully",
          status: 200,
          user: updatedUser,
        };
      } catch (err) {
        console.error(err);
        return {
          message: err.message,
          status: err.status,
        };
      }
    },

    forgotPassword: async (_, { user_email }) => {
      // check if user exists
      const user = await Users.findOne({
        where: { user_email },
      });

      if (!user) {
        return {
          message: "User not found",
          status: 404,
        };
      }

      const randomNum = Math.floor(100000 + Math.random() * 900000);

      const mailOptions = {
        from: "julesntare@gmail.com",
        to: user.user_email,
        subject: "Password Reset",
        html: `
          <p>Dear ${user.user_name || "User"},</p>
          <p>Please enter below code in reset page to reset your password:</p>
          <br />
          <p>Verification code: <em>${randomNum}</em></p>
          <p>The code expires in 24 hours.</p>
          <br />
          <p>Regards,</p>
          <p>TechnoServe, My PIMA Team</p>
          `,
      };

      // Send the email
      const result = await sendEmail(mailOptions, transporter)
        .then(async (res) => {
          // delete existing verification code
          await Verifications.destroy({
            where: { user_id: user.user_id },
          });

          // generate random 6 numbers and save to tbl_verifications, and expire in 24 hours
          await Verifications.create({
            user_id: user.user_id,
            verification_code: randomNum,
            expiry_time: new Date(Date.now() + 24 * 60 * 60 * 1000),
          });

          return {
            message: "Password reset link sent successfully",
            status: 200,
          };
        })
        .catch((err) => {
          console.log(err);

          return {
            message: "Something went wrong",
            status: 500,
          };
        });

      return result;
    },
  },
};

export default UsersResolvers;
