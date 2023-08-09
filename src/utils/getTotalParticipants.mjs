const GetTotalParticipants = async (id, sf_conn) => {
  try {
    const total_participants = await sf_conn.query(
      `SELECT COUNT(Id) FROM Participant__c WHERE Training_Group__c = '${id}'`
    );

    if (total_participants.totalSize === 0) {
      return {
        message: "Participants not found",
        status: 404,
      };
    }

    return {
      message: "Participants fetched successfully",
      status: 200,
      total_participants: total_participants.records[0].expr0,
    };
  } catch (err) {
    console.log(err);

    return {
      message: err.message,
      status: err.status,
    };
  }
};

export default GetTotalParticipants;
