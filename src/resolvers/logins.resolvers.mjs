import { OAuth2Client } from "google-auth-library";
import UserSessions from "../models/user_sessions.model.mjs";
import Users from "../models/users.model.mjs";
import dotenv from "dotenv";
import bcrypt from "bcrypt";
import jwt from "jsonwebtoken";

dotenv.config();

const client = new OAuth2Client(process.env.GOOGLE_AUTH_CLIENT_ID);

const LoginsResolvers = {
  Query: {
    getLogins: async () => {
      try {
        const logins = await UserSessions.findAll(
          // exclude updatedAt column
          { attributes: { exclude: ["updatedAt"] } }
        );
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
        });

        if (user) {
          await UserSessions.create({
            user_id: user.user_id,
            session_token: token,
          });

          return {
            message: "Authenticated Successful!",
            status: 200,
            token,
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
      const user = await Users.findOne({ where: { user_email: email } });

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

      const login = await UserSessions.create({
        user_id: user.user_id,
        session_token: token,
        provider: "tns",
      });

      return {
        message: "Login added successfully",
        status: 200,
        token,
      };
    },
  },
};

export default LoginsResolvers;
