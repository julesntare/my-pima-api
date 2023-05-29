import Permissions from "../models/permissions.model.mjs";
import Roles from "../models/roles.model.mjs";

const PermissionsResolvers = {
  Query: {
    getPermissions: async () => {
      try {
        const permissions = await Permissions.findAll();
        return {
          message: "Permissions fetched successfully",
          status: 200,
          permissions,
        };
      } catch (err) {
        console.log(err);
        return {
          message: err.message,
          status: err.status,
        };
      }
    },

    getPermission: async (_, { perm_id }) => {
      try {
        const permission = await Permissions.findOne({
          where: { perm_id },
        });
        if (!permission) {
          return {
            message: "Permission not found",
            status: 404,
          };
        }
        return {
          message: "Permission fetched successfully",
          status: 200,
          permission,
        };
      } catch (err) {
        console.log(err);
        return {
          message: err.message,
          status: err.status,
        };
      }
    },

    getPermissionsByRole: async (_, { role_id }) => {
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

        const permissions = await Permissions.findAll({
          where: { perm_id: role.permissions },
        });

        return {
          message: "Permissions fetched successfully",
          status: 200,
          permissions,
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
    addPermission: async (_, { perm_name, perm_desc }) => {
      // check if permission already exists
      const existingPermission = await Permissions.findOne({
        where: { perm_name: perm_name.toLowerCase() },
      });

      if (existingPermission) {
        return {
          message: "Permission already exists",
          status: 409,
        };
      }

      try {
        const permission = await Permissions.create({
          perm_name,
          perm_desc,
        });
        return {
          message: "Permission added successfully",
          status: 200,
          permission,
        };
      } catch (err) {
        console.log(err);
        return {
          message: err.message,
          status: err.status,
        };
      }
    },

    updatePermission: async (
      _,
      { perm_id, perm_name, perm_desc, perm_status }
    ) => {
      try {
        // check if permission exists
        const existingPermission = await Permissions.findOne({
          where: { perm_id },
        });

        if (!existingPermission) {
          return {
            message: "Permission not found",
            status: 404,
          };
        }

        // update permission
        await Permissions.update(
          {
            perm_name,
            perm_desc,
            perm_status,
          },
          {
            where: { perm_id },
          }
        );

        // get updated permission
        const permission = await Permissions.findOne({
          where: { perm_id },
        });

        return {
          message: "Permission updated successfully",
          status: 200,
          permission,
        };
      } catch (err) {
        console.log(err);
        return {
          message: err.message,
          status: err.status,
        };
      }
    },

    deletePermission: async (_, { perm_id }) => {
      try {
        // check if permission exists
        const existingPermission = await Permissions.findOne({
          where: { perm_id },
        });

        if (!existingPermission) {
          return {
            message: "Permission not found",
            status: 404,
          };
        }

        // delete permission
        await Permissions.destroy({
          where: { perm_id },
        });

        return {
          message: "Permission deleted successfully",
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

export default PermissionsResolvers;
