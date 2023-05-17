CREATE SCHEMA IF NOT EXISTS "my-pima-db-design";

CREATE  TABLE "my-pima-db-design".tbl_permissions ( 
	perm_id              uuid  NOT NULL  ,
	perm_name            varchar(100)  NOT NULL  ,
	perm_status          varchar[]    ,
	added_on             date DEFAULT CURRENT_DATE   ,
	CONSTRAINT pk_tbl_permissions PRIMARY KEY ( perm_id )
 );

CREATE  TABLE "my-pima-db-design".tbl_project_roles ( 
	pr_id                uuid  NOT NULL  ,
	pr_name              varchar(100)    ,
	description          text    ,
	status               boolean DEFAULT true   ,
	added_on             date DEFAULT CURRENT_DATE   ,
	CONSTRAINT pk_tbl_project_roles PRIMARY KEY ( pr_id )
 );

CREATE  TABLE "my-pima-db-design".tbl_projects ( 
	project_id           uuid  NOT NULL  ,
	org_project_id       varchar(255)  NOT NULL  ,
	project_name         varchar(100)  NOT NULL  ,
	project_descriptions text    ,
	start_date           date    ,
	end_date             date    ,
	project_status       varchar(20)    ,
	added_on             date DEFAULT CURRENT_DATE   ,
	CONSTRAINT pk_tbl_projects PRIMARY KEY ( project_id )
 );

CREATE  TABLE "my-pima-db-design".tbl_users ( 
	user_id              uuid  NOT NULL  ,
	username             varchar(100)  NOT NULL  ,
	user_password        varchar(100)    ,
	email                varchar(100)    ,
	mobile_no            varchar(100)    ,
	role_id              uuid  NOT NULL  ,
	account_status       varchar(20)    ,
	added_on             date DEFAULT CURRENT_DATE   ,
	CONSTRAINT pk_mp_users PRIMARY KEY ( user_id ),
	CONSTRAINT unq_tbl_users_role_id UNIQUE ( role_id ) 
 );

CREATE  TABLE "my-pima-db-design".tbl_verifications ( 
	verify_id            uuid  NOT NULL  ,
	user_id              uuid  NOT NULL  ,
	verification_code    integer    ,
	expiry_time          timestamp    ,
	is_verified          boolean DEFAULT false   ,
	CONSTRAINT pk_tbl_verifications PRIMARY KEY ( verify_id )
 );

CREATE  TABLE "my-pima-db-design".tbl_logins ( 
	login_id             uuid  NOT NULL  ,
	user_id              uuid  NOT NULL  ,
	last_login           date    ,
	token                text  NOT NULL  ,
	CONSTRAINT pk_tbl_logins PRIMARY KEY ( login_id )
 );

CREATE  TABLE "my-pima-db-design".tbl_participants ( 
	part_id              uuid  NOT NULL  ,
	project_id           uuid  NOT NULL  ,
	user_id              uuid  NOT NULL  ,
	"role"               varchar[]    ,
	assigned_date        date    ,
	status               varchar(1)    ,
	added_on             date DEFAULT CURRENT_DATE   ,
	CONSTRAINT pk_tbl_participants PRIMARY KEY ( part_id )
 );

CREATE  TABLE "my-pima-db-design".tbl_roles ( 
	role_id              uuid  NOT NULL  ,
	role_name            varchar(100)  NOT NULL  ,
	role_desc            varchar(100)    ,
	permissions          varchar[]    ,
	is_default           boolean DEFAULT false   ,
	role_status          boolean DEFAULT true   ,
	added_on             date DEFAULT CURRENT_DATE   ,
	CONSTRAINT pk_tbl_roles PRIMARY KEY ( role_id )
 );

CREATE  TABLE "my-pima-db-design".tbl_training_groups ( 
	tg_id                uuid  NOT NULL  ,
	tg_name              varchar(100)  NOT NULL  ,
	tg_description       text    ,
	trainer              uuid  NOT NULL  ,
	capacity             integer    ,
	tg_status            varchar(30)    ,
	added_on             date DEFAULT CURRENT_DATE   ,
	CONSTRAINT pk_tbl_training_groups PRIMARY KEY ( tg_id )
 );

CREATE  TABLE "my-pima-db-design".tbl_training_sessions ( 
	ts_id                uuid  NOT NULL  ,
	session_name         varchar(100)    ,
	tg_id                uuid  NOT NULL  ,
	"location"           text    ,
	module_id            uuid    ,
	total_male           integer    ,
	total_female         integer    ,
	ts_status            varchar(35)    ,
	added_on             date DEFAULT CURRENT_DATE   ,
	CONSTRAINT pk_tbl_training_sessions PRIMARY KEY ( ts_id )
 );

ALTER TABLE "my-pima-db-design".tbl_logins ADD CONSTRAINT fk_tbl_logins_tbl_users FOREIGN KEY ( user_id ) REFERENCES "my-pima-db-design".tbl_users( user_id );

ALTER TABLE "my-pima-db-design".tbl_participants ADD CONSTRAINT fk_tbl_participants_tbl_users FOREIGN KEY ( user_id ) REFERENCES "my-pima-db-design".tbl_users( user_id );

ALTER TABLE "my-pima-db-design".tbl_participants ADD CONSTRAINT fk_tbl_participants_tbl_projects FOREIGN KEY ( project_id ) REFERENCES "my-pima-db-design".tbl_projects( project_id );

ALTER TABLE "my-pima-db-design".tbl_participants ADD CONSTRAINT fk_tbl_participants_tbl_project_roles FOREIGN KEY ( "role" ) REFERENCES "my-pima-db-design".tbl_project_roles( pr_id );

ALTER TABLE "my-pima-db-design".tbl_roles ADD CONSTRAINT fk_tbl_roles_tbl_permissions FOREIGN KEY ( permissions ) REFERENCES "my-pima-db-design".tbl_permissions( perm_id );

ALTER TABLE "my-pima-db-design".tbl_roles ADD CONSTRAINT fk_tbl_roles_tbl_users FOREIGN KEY ( role_id ) REFERENCES "my-pima-db-design".tbl_users( role_id );

ALTER TABLE "my-pima-db-design".tbl_training_groups ADD CONSTRAINT fk_tbl_training_groups_tbl_users FOREIGN KEY ( trainer ) REFERENCES "my-pima-db-design".tbl_users( user_id );

ALTER TABLE "my-pima-db-design".tbl_training_sessions ADD CONSTRAINT fk_tbl_training_sessions_tbl_training_groups FOREIGN KEY ( tg_id ) REFERENCES "my-pima-db-design".tbl_training_groups( tg_id );

ALTER TABLE "my-pima-db-design".tbl_verifications ADD CONSTRAINT fk_tbl_verifications_tbl_users FOREIGN KEY ( user_id ) REFERENCES "my-pima-db-design".tbl_users( user_id );
