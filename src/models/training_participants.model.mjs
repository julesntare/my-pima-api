// Id, Name, Training_Session__c, Participant_Gender__c, Status__c, Participant__c

import { DataTypes } from "sequelize";
import sequelize from "../config/db.mjs";

const TrainingParticipants = sequelize.define("tbl_training_participants", {
    tp_id: {
        type: DataTypes.STRING(50),
        primaryKey: true,
        allowNull: false,
    },
    tp_name: {
        type: DataTypes.STRING(50),
        allowNull: false,
    },
    ts_id: {
        type: DataTypes.STRING(50),
        allowNull: false,
        references: {
            model: "tbl_training_sessions",
            key: "ts_id",
        },
    },
    tp_gender: {
        type: DataTypes.ENUM("m", "f"),
        allowNull: false,
    },
    tp_status: {
        type: DataTypes.ENUM("active", "inactive"),
        allowNull: false,
        defaultValue: "active",
    },
});

export default TrainingParticipants;
