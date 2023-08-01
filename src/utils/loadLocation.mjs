const LocationDetails = async (location, sf_conn) => {
  try {
    const location_details = await sf_conn.query(
      `SELECT Id, Name, Parent_Location__c FROM Location__c WHERE Id = '${location}'`
    );

    if (location_details.totalSize === 0) {
      return {
        message: "Location not found",
        status: 404,
      };
    }

    return {
      message: "Location fetched successfully",
      status: 200,
      location_details: {
        location_id: location_details.records[0].Id,
        location_name: location_details.records[0].Name,
        parent_location: location_details.records[0].Parent_Location__c,
      },
    };
  } catch (err) {
    console.log(err);

    return {
      message: err.message,
      status: err.status,
    };
  }
};

export default LocationDetails;
