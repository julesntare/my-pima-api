import { OAuth2Client } from "google-auth-library";
import UserSessions from "../models/user_sessions.model.mjs";
import Users from "../models/users.model.mjs";
import dotenv from "dotenv";
import bcrypt from "bcrypt";
import jwt from "jsonwebtoken";
import Roles from "../models/roles.model.mjs";

dotenv.config();

const client = new OAuth2Client(process.env.GOOGLE_AUTH_CLIENT_ID);

const LoginsResolvers = {
  Query: {
    getLogins: async () => {
      try {
        const logins = await UserSessions.findAll({
          attributes: { exclude: ["updatedAt"] },
        });
        return {
          message: "Logins fetched successfully",
          status: 200,
          logins,
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
    saveGoogleLogin: async (_, { token }) => {
      try {
        const ticket = await client.verifyIdToken({
          idToken: token,
          audience: process.env.GOOGLE_AUTH_CLIENT_ID,
        });

        const payload = ticket.getPayload();
        const googleEmail = payload.email;

        const user = await Users.findOne({
          where: {
            user_email: googleEmail,
          },
          include: {
            model: Roles,
          },
        });

        if (user) {
          // create session
          const jwt_token = jwt.sign(
            { user_id: user.user_id },
            process.env.TOKEN_SECRET
          );

          await UserSessions.create({
            user_id: user.user_id,
            session_token: jwt_token,
          });

          user.role = user.tbl_role;

          return {
            message: "Authenticated Successful!",
            status: 200,
            user,
            token: jwt_token,
          };
        }

        return {
          message: "Authentication failed.",
          status: 401,
        };
      } catch (err) {
        console.log(err);

        return {
          message: err.message,
          status: 500,
        };
      }
    },

    saveMailLogin: async (_, { email, password }) => {
      // check if email exists
      const user = await Users.findOne({
        where: { user_email: email },
        include: {
          model: Roles,
        },
      });

      if (!user) {
        return {
          message: "Email not found",
          status: 404,
        };
      }

      // check if password is correct
      const validPassword = await bcrypt.compare(password, user.user_password);

      if (!validPassword) {
        return {
          message: "Incorrect Credentials",
          status: 401,
        };
      }

      // create session
      const token = jwt.sign(
        { user_id: user.user_id },
        process.env.TOKEN_SECRET
      );

      await UserSessions.create({
        user_id: user.user_id,
        session_token: token,
        provider: "tns",
      });

      user.role = user.tbl_role;

      return {
        message: "Login added successfully",
        status: 200,
        user,
        token,
      };
    },

    verifyToken: async (_, { token }) => {
      try {
        const decoded = jwt.verify(token, process.env.TOKEN_SECRET);

        const userSession = await UserSessions.findOne({
          where: { session_token: token },
        });

        if (!userSession) {
          return {
            message: "Invalid token",
            status: 401,
          };
        }

        return {
          message: "Valid token",
          status: 200,
        };
      } catch (err) {
        console.log(err);

        return {
          message: err.message,
          status: 500,
        };
      }
    },
  },
};

export default LoginsResolvers;
