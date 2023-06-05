import TrainingGroups from "../models/training_groups.model.mjs";
import TrainingParticipants from "../models/training_participants.model.mjs";
import TrainingSessions from "../models/training_sessions.model.mjs";

const cacheTrainingGroups = (res, redis) => {
  const trainingGroups = res.records.map((record) => {
    return TrainingGroups.build({
      tg_id: record.Id,
      tg_name: record.Name,
      tns_id: record.TNS_Id__c,
      active_participants_count: record.Active_Participants_Count__c,
      responsible_staff: record.Responsible_Staff__c,
    });
  });

  redis.set("trainingGroups", JSON.stringify(trainingGroups));
};

const cacheTrainingSessions = (res, redis) => {
  const trainingSessions = res.records.map((record) => {
    return TrainingSessions.build({
      ts_id: record.Id,
      ts_name: record.Name,
      module_name: record.Module_Name__c,
      tg_id: record.Training_Group__c,
      session_status: record.Session_Status__c,
      male_attendance: record.Male_Attendance__c,
      female_attendance: record.Female_Attendance__c,
      trainer: record.Trainer__c,
    });
  });

  redis.set("trainingSessions", JSON.stringify(trainingSessions));
};

const cacheTrainingParticipants = (res, redis) => {
  const trainingParticipants = res.records.map((record) => {
    return TrainingParticipants.build({
      tp_id: record.Id,
      tp_name: record.Name,
      ts_id: record.Training_Session__c,
      tp_gender: record.Participant_Gender__c,
      tp_status: record.Status__c,
    });
  });

  redis.set("trainingParticipants", JSON.stringify(trainingParticipants));
};

export {
  cacheTrainingGroups,
  cacheTrainingSessions,
  cacheTrainingParticipants,
};
