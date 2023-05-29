import Permissions from "../models/permissions.model.mjs";
import Roles from "../models/roles.model.mjs";

const RolesResolvers = {
  Query: {
    getRoles: async () => {
      try {
        const roles = await Roles.findAll();
        return {
          message: "Roles fetched successfully",
          status: 200,
          roles,
        };
      } catch (err) {
        console.log(err);
        return {
          message: err.message,
          status: err.status,
        };
      }
    },

    getRole: async (_, { role_id }) => {
      try {
        const role = await Roles.findOne({
          where: { role_id },
        });
        if (!role) {
          return {
            message: "Role not found",
            status: 404,
          };
        }
        return {
          message: "Role fetched successfully",
          status: 200,
          role,
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
    addRole: async (
      _,
      { role_name, role_desc, permissions, is_default, role_status }
    ) => {
      try {
        // check if role already exists
        const roleExists = await Roles.findOne({
          where: { role_name },
        });

        if (roleExists) {
          return {
            message: "Role already exists",
            status: 409,
          };
        }

        // check if there are no duplicate permissions
        const uniquePermissions = [...new Set(permissions)];

        if (uniquePermissions.length !== permissions.length) {
          return {
            message: "Duplicate permissions found",
            status: 409,
          };
        }

        // check if permission ids exist (iterate over permissions array)
        const permissionsExist = await Promise.all(
          permissions.map(async (perm_id) => {
            const existingPermission = await Permissions.findOne({
              where: { perm_id },
            });
            return existingPermission;
          })
        );

        if (permissionsExist.includes(null)) {
          return {
            message: "Permission does not exist",
            status: 404,
          };
        }

        // create role
        const role = await Roles.create({
          role_name,
          role_desc,
          permissions,
          is_default,
          role_status,
        });

        return {
          message: "Role added successfully",
          status: 200,
          role,
        };
      } catch (err) {
        console.log(err);
        return {
          message: err.message,
          status: err.status,
        };
      }
    },

    updateRole: async (
      _,
      { role_id, role_name, role_desc, permissions, is_default, role_status }
    ) => {
      try {
        // check if role exists
        const role = await Roles.findOne({
          where: { role_id },
        });

        if (!role) {
          return {
            message: "Role not found",
            status: 404,
          };
        }

        if (permissions) {
          // check if there are no duplicate permissions
          const uniquePermissions = [...new Set(permissions)];

          if (uniquePermissions.length !== permissions.length) {
            return {
              message: "Duplicate permissions found",
              status: 409,
            };
          }

          // check if permission ids exist (iterate over permissions array)
          const permissionsExist = await Promise.all(
            permissions.map(async (perm_id) => {
              const existingPermission = await Permissions.findOne({
                where: { perm_id },
              });
              return existingPermission;
            })
          );

          if (permissionsExist.includes(null)) {
            return {
              message: "Permission does not exist",
              status: 404,
            };
          }
        }

        // update role
        const updatedRole = await Roles.update(
          {
            role_name,
            role_desc,
            permissions,
            is_default,
            role_status,
          },
          {
            where: { role_id },
          }
        );

        return {
          message: "Role updated successfully",
          status: 200,
          updatedRole,
        };
      } catch (err) {
        console.log(err);
        return {
          message: err.message,
          status: err.status,
        };
      }
    },

    deleteRole: async (_, { role_id }) => {
      console.log(role_id);
      try {
        // check if role exists
        const role = await Roles.findOne({
          where: { role_id },
        });

        if (!role) {
          return {
            message: "Role not found",
            status: 404,
          };
        }

        // delete role
        await Roles.destroy({
          where: { role_id },
        });

        return {
          message: "Role deleted successfully",
          status: 200,
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

export default RolesResolvers;
