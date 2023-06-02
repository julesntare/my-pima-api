import Projects from "../models/projects.models.mjs";

const loadSFProjects = async (conn) => {
  let records = [],
    total_new_projects = 0;
  try {
    records = await conn.query(
      "SELECT Id, Name, Project_Status__c FROM Project__c WHERE Project_Status__c = 'Active'"
    );

    const promises = records.records.map(async (record) => {
      const project = await Projects.findOne({
        where: { sf_project_id: record.Id },
      });
      if (!project) {
        total_new_projects += 1;
        await Projects.create({
          sf_project_id: record.Id,
          project_name: record.Name,
        });
      } else {
        await Projects.update(
          {
            project_name: record.Name,
          },
          {
            where: { sf_project_id: record.Id },
          }
        );
      }
    });

    await Promise.all(promises);

    return {
      message: "Projects loaded successfully",
      status: 200,
      total_new_projects,
    };
  } catch (err) {
    console.error(err);

    return {
      message: err.message,
      status: err.status,
    };
  }
};

export default loadSFProjects;
