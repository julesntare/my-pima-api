--
-- PostgreSQL database dump
--

-- Dumped from database version 15.3
-- Dumped by pg_dump version 15.3

-- Started on 2023-06-26 12:10:46

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 853 (class 1247 OID 74369)
-- Name: enum_tbl_logins_provider; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.enum_tbl_logins_provider AS ENUM (
    'google',
    'tns'
);


ALTER TYPE public.enum_tbl_logins_provider OWNER TO postgres;

--
-- TOC entry 844 (class 1247 OID 74293)
-- Name: enum_tbl_permissions_perm_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.enum_tbl_permissions_perm_status AS ENUM (
    'active',
    'inactive'
);


ALTER TYPE public.enum_tbl_permissions_perm_status OWNER TO postgres;

--
-- TOC entry 877 (class 1247 OID 74496)
-- Name: enum_tbl_projects_project_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.enum_tbl_projects_project_status AS ENUM (
    'active',
    'inactive'
);


ALTER TYPE public.enum_tbl_projects_project_status OWNER TO postgres;

--
-- TOC entry 847 (class 1247 OID 74306)
-- Name: enum_tbl_roles_role_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.enum_tbl_roles_role_status AS ENUM (
    'active',
    'inactive'
);


ALTER TYPE public.enum_tbl_roles_role_status OWNER TO postgres;

--
-- TOC entry 868 (class 1247 OID 74467)
-- Name: enum_tbl_user_sessions_provider; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.enum_tbl_user_sessions_provider AS ENUM (
    'google',
    'tns'
);


ALTER TYPE public.enum_tbl_user_sessions_provider OWNER TO postgres;

--
-- TOC entry 850 (class 1247 OID 74321)
-- Name: enum_tbl_users_account_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.enum_tbl_users_account_status AS ENUM (
    'active',
    'inactive'
);


ALTER TYPE public.enum_tbl_users_account_status OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 214 (class 1259 OID 74429)
-- Name: SequelizeMeta; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."SequelizeMeta" (
    name character varying(255) NOT NULL
);


ALTER TABLE public."SequelizeMeta" OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 74509)
-- Name: tbl_participants; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tbl_participants (
    participant_id uuid NOT NULL,
    user_id uuid NOT NULL,
    project_id uuid NOT NULL,
    "createdAt" timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.tbl_participants OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 74434)
-- Name: tbl_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tbl_permissions (
    perm_id uuid NOT NULL,
    perm_name character varying(50) NOT NULL,
    perm_desc character varying(50),
    perm_status public.enum_tbl_permissions_perm_status DEFAULT 'active'::public.enum_tbl_permissions_perm_status NOT NULL,
    "createdAt" timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.tbl_permissions OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 74501)
-- Name: tbl_projects; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tbl_projects (
    project_id uuid NOT NULL,
    sf_project_id character varying(50) NOT NULL,
    project_name character varying(50) NOT NULL,
    project_status public.enum_tbl_projects_project_status DEFAULT 'active'::public.enum_tbl_projects_project_status NOT NULL,
    "createdAt" timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.tbl_projects OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 74442)
-- Name: tbl_roles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tbl_roles (
    role_id uuid NOT NULL,
    role_name character varying(50) NOT NULL,
    role_desc character varying(50),
    permissions uuid[] NOT NULL,
    is_default boolean DEFAULT false NOT NULL,
    role_status public.enum_tbl_roles_role_status DEFAULT 'active'::public.enum_tbl_roles_role_status NOT NULL,
    "createdAt" timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.tbl_roles OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 74471)
-- Name: tbl_user_sessions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tbl_user_sessions (
    session_id uuid NOT NULL,
    user_id uuid NOT NULL,
    session_token character varying(1500) NOT NULL,
    provider public.enum_tbl_user_sessions_provider NOT NULL,
    added_on timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.tbl_user_sessions OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 74453)
-- Name: tbl_users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tbl_users (
    user_id uuid NOT NULL,
    user_name character varying(255),
    user_password character varying(255) NOT NULL,
    user_email character varying(255),
    mobile_no character varying(50),
    role_id uuid NOT NULL,
    account_status public.enum_tbl_users_account_status DEFAULT 'active'::public.enum_tbl_users_account_status NOT NULL,
    "createdAt" timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    sf_user_id character varying(50)
);


ALTER TABLE public.tbl_users OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 74482)
-- Name: tbl_verifications; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tbl_verifications (
    verification_id uuid NOT NULL,
    user_id uuid NOT NULL,
    verification_code character varying(50) NOT NULL,
    expiry_time timestamp with time zone NOT NULL,
    is_verified boolean DEFAULT false NOT NULL,
    "createdAt" timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.tbl_verifications OWNER TO postgres;

--
-- TOC entry 3400 (class 0 OID 74429)
-- Dependencies: 214
-- Data for Name: SequelizeMeta; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."SequelizeMeta" (name) FROM stdin;
20230526065139-create_tables.js
20230526084405-create_projects_and_participants_tables.js
20230529101740-add_sf_user_id.js
20230529104202-increase_columns_char_size.js
20230531143509-create_remove_timestamps_table.js
20230531145048-increase_chars_token_field.js
20230531145310-increase_chars_1500_token_field.js
20230601074043-increase_size_for_users_passwords.js
20230614073328-allow-nulls-users.js
\.


--
-- TOC entry 3407 (class 0 OID 74509)
-- Dependencies: 221
-- Data for Name: tbl_participants; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tbl_participants (participant_id, user_id, project_id, "createdAt", "updatedAt") FROM stdin;
\.


--
-- TOC entry 3401 (class 0 OID 74434)
-- Dependencies: 215
-- Data for Name: tbl_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tbl_permissions (perm_id, perm_name, perm_desc, perm_status, "createdAt", "updatedAt") FROM stdin;
63078e60-9a21-48e4-81fb-037797608842	read	permission for viewing/reading data	active	2023-05-29 10:41:17.819922+02	2023-05-29 10:41:17.819922+02
d9dc8fda-29c9-44a7-949a-b55364e841cf	reg_participants	permission for registrering participants	active	2023-06-02 15:43:38.255008+02	2023-06-02 15:43:38.255008+02
\.


--
-- TOC entry 3406 (class 0 OID 74501)
-- Dependencies: 220
-- Data for Name: tbl_projects; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tbl_projects (project_id, sf_project_id, project_name, project_status, "createdAt", "updatedAt") FROM stdin;
b5daf310-d8b3-4a17-be1e-bd178e2c4022	a0E0600000pULKZEA4	Coffee ET Nespresso C2021	active	2023-05-26 11:07:41.703345+02	2023-06-09 10:02:01.432897+02
78353f91-7206-44d9-9124-5f6aab34664c	a0E0600000s5iPLEAY	Coffee - DRC Minova C2021	active	2023-05-26 11:07:41.722422+02	2023-06-09 10:02:01.441482+02
7989e7bf-c82c-4949-a461-9dbfce2ba1e2	a0E1o00000krP5jEAE	Coffee Zimbabwe - Agronomy	active	2023-05-26 11:07:41.735194+02	2023-06-09 10:02:01.448373+02
3e1a50c1-3888-4b3d-a30d-5a70350d3f16	a0E1o00000nM1hfEAC	Coffee ZW Nespresso (Ag) - c2	active	2023-05-26 11:07:41.743756+02	2023-06-09 10:02:01.454726+02
b4835b46-81fd-4166-a950-42d4d60b22e8	a0E1o00000nM6MeEAK	Coffee - DRC SVC (Ag) - c2	active	2023-05-26 11:07:41.768657+02	2023-06-09 10:02:01.458203+02
68828be4-34eb-4164-ba98-4e783ba52c03	a0E7S0000009KjZUAU	Coffee ET- HWG JCP C2022	active	2023-05-26 11:07:41.772401+02	2023-06-09 10:02:01.461835+02
cbf37832-90db-4eec-9821-50fa2ebc4890	a0E7S0000009VQWUA2	Coffee ET Nespresso C2022	active	2023-05-26 11:07:41.779456+02	2023-06-09 10:02:01.464818+02
8b046738-9389-4273-9612-3cb94c09f328	a0E7S0000009aIAUAY	Coffee ZW (Ag) - C2021	active	2023-05-26 11:07:41.786448+02	2023-06-09 10:02:01.467923+02
912ce709-8553-4d7d-a569-2bd346c58062	a0E7S0000009dxVUAQ	Coffee ET - Regrow Yirga Agronomy C2022	active	2023-05-26 11:07:41.791359+02	2023-06-09 10:02:01.47191+02
c8c8c0a0-a0c5-492a-921f-c3f5662cc09a	a0E7S000000lCMJUA2	Coffee Puerto Rico 2022	active	2023-05-26 11:07:41.795648+02	2023-06-09 10:02:01.477858+02
1ebb3843-34da-4d54-99fe-af0a9670b4a3	a0E0600000qUeWwEAK	Coffee - DRC SVC  C2021	active	2023-05-26 11:07:41.711732+02	2023-06-09 10:02:01.482747+02
b03454b1-bcde-4d9c-9d21-9fe315306868	a0E9J000000DeVbUAK	Coffee DRC - GCA Kalehe 2022	active	2023-05-26 11:07:41.802448+02	2023-06-09 10:02:01.487469+02
4b633ce6-b8db-4d68-8c19-f90d9cd0b4f8	a0E9J000000DeWAUA0	Coffee DRC - GEF Kalehe 2022	active	2023-05-26 11:22:11.412139+02	2023-06-09 10:02:01.49038+02
08954f95-5c41-4145-97e9-666c59e7304f	a0E9J000000KjhSUAS	Coffee ET HWG JCP - Beekeeping 2022C	active	2023-05-26 11:22:11.415474+02	2023-06-09 10:02:01.496457+02
d2066cb3-435b-4502-8710-e9ea10f827f3	a0E9J000000KrqmUAC	Coffee ET - Regrow Yirga Agronomy C2023	active	2023-05-26 11:20:10.28224+02	2023-06-09 10:02:01.502243+02
2e0040db-000c-4f58-8adb-d8f7d3d1d71f	a0E9J000000L53sUAC	Coffee ET- HWG JCP C2023	active	2023-05-26 11:28:18.328559+02	2023-06-09 10:02:01.506872+02
bf38b34d-b70c-48fb-a24f-04deb8d37c97	a0E9J000000NTjpUAG	Coffee - Kenya Nespresso 2023C	active	2023-05-26 15:08:43.475973+02	2023-06-09 10:02:01.517634+02
b8bc6a55-aea1-46b9-a197-030db2364734	a0E9J000000DeVlUAK	Coffee DRC - GCA Virunga 2022	active	2023-05-26 11:07:41.805955+02	2023-06-09 10:02:01.521501+02
\.


--
-- TOC entry 3402 (class 0 OID 74442)
-- Dependencies: 216
-- Data for Name: tbl_roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tbl_roles (role_id, role_name, role_desc, permissions, is_default, role_status, "createdAt", "updatedAt") FROM stdin;
afd4cf48-4a81-41bb-939e-1faff919c04d	lu	Default Role	{63078e60-9a21-48e4-81fb-037797608842}	t	active	2023-05-29 12:28:50.497411+02	2023-05-29 12:28:50.497411+02
75f0816a-b447-4244-8f0b-e554544fc39d	business_advisor	Role for business advisors	{63078e60-9a21-48e4-81fb-037797608842}	f	active	2023-06-02 15:19:21.189736+02	2023-06-02 15:19:21.189736+02
d7ca787c-68d3-4164-b416-212b2aea8445	super admin	Role for top level user	{63078e60-9a21-48e4-81fb-037797608842}	f	active	2023-05-29 11:24:54.121424+02	2023-06-14 10:12:50.664482+02
\.


--
-- TOC entry 3404 (class 0 OID 74471)
-- Dependencies: 218
-- Data for Name: tbl_user_sessions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tbl_user_sessions (session_id, user_id, session_token, provider, added_on) FROM stdin;
\.


--
-- TOC entry 3403 (class 0 OID 74453)
-- Dependencies: 217
-- Data for Name: tbl_users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tbl_users (user_id, user_name, user_password, user_email, mobile_no, role_id, account_status, "createdAt", "updatedAt", sf_user_id) FROM stdin;
6e80c1a4-5049-40fa-a5f4-0faf8c047a73	Christian Ramos	$2b$10$P0.jknn4m1SUGxrKaIed/OrXDT8d4sapugHpeGQ0C8N9kLa4aylJq	\N	9395393242	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:36.474783+02	2023-06-14 09:49:36.234192+02	00306000020ejtoAAA
db4d4645-0736-452b-b160-4f5a5470df5a	Howard Jones	$2b$10$6XVv3dw1SEBccjdwykGLxehDIL74Z6SVZlO79CMX2r2AA8NCMrS7G	info@salesforce.com	(212) 555-5555	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:20:46.823311+02	2023-06-14 09:49:44.537349+02	00324000002sAiwAAE
b9d22780-e80d-4fa4-8c49-2375318824ad	Leanne Tomlin	$2b$10$SwKDq9Y/z5jsa2g8w0QYVOoz704ixBg2bBggL2VSzXx1rUrEE2tDK	info@salesforce.com	(212) 555-5555	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:20:46.827082+02	2023-06-14 09:49:44.552582+02	00324000002sAixAAE
f36cb71d-0bfa-40fd-827b-ee39d8a92730	Marc Benioff	$2b$10$hZWLdQulZ44qw5E5tTZWwuqxyUPx1gGYwmxhWmK/aQUI6SfXpFNx2	info@salesforce.com	(415) 901-7000	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:20:46.831446+02	2023-06-14 09:49:44.568466+02	00324000002sAiyAAE
53bd558f-7db1-437b-acc4-7a3c9d0f737c	Susan Mlangwa	$2b$10$BqJ6ggU68D6ve/gZCLoqyeRRzNlwiVdp1LizH0yRX0nxMxroxEmZm	smlangwa@tns.org	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:20:46.835952+02	2023-06-14 09:49:44.575972+02	0032400000kwF3EAAU
1e7400c4-aac2-43b6-bd46-c5c415cec5ce	Amanda Satterly	$2b$10$P2L7E0.rpksSxmsn39RHJeqta4fHlMbdjyESupDDBPJoeNdVtD9rq	asatterly@tns.org	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:20:46.840623+02	2023-06-14 09:49:44.583709+02	0032400000kwF3FAAU
afd8a5a6-ef06-4725-98ee-1328ca6478f5	Leigh Shepherd	$2b$10$uOHW3JxwAsnAdZ9TLWmxBOvwTg6hojERMxJZfsJyYG6o1VgfaWWFa	lshepherd@tns.org	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:20:46.880252+02	2023-06-14 09:49:44.592764+02	0032400000kwF3GAAU
c4f382d1-fd35-40dd-aad9-7ded6e9b952b	Meab Mdimi	$2b$10$oBBcd3ViprrDCQmSbNjd4.ZT9g7pYlSdY7fDKgcnebmJD/4q4H306	mmdimi@tns.org	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:20:46.970228+02	2023-06-14 09:49:44.606876+02	0032400000kwF3IAAU
e5e81aa7-3133-478b-bce3-1e20ec71b70d	Reginald Mpolo	$2b$10$eYZc9pr6swbLqrrsLTcx4erO/JK0efwv84/NToZvt/jQrm5aTnCp.	rmpolo@tns.org	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:20:47.075952+02	2023-06-14 09:49:44.613424+02	0032400000kwF3JAAU
c4eb0a65-8775-409d-810f-20fd821b7a62	Monica Obedi	$2b$10$i.txr6iu5.Eu8qGgf141ie9V0jbSUkNclOOpXzOXlZwZuLhUw/x/2	mobedi@tns.org	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:20:47.16716+02	2023-06-14 09:49:44.619657+02	0032400000kwF3KAAU
b67cc3a8-2dd0-434e-bc3c-54da19115470	Benedicta Utou	$2b$10$QqHUZsulawa.dQOqPqKWD./NFcfw6K.fF3tsh8jCG1twql3JqJ3Ri	butou@tns.org	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:20:47.19703+02	2023-06-14 09:49:44.633939+02	0032400000kwF3MAAU
62184160-c0cd-45ff-b445-67ff7d6656f3	Skeeter Sinare Godwins	$2b$10$lG1y072LEftwI4geNygns.L2rtF86jc.AFKf.fd4t2FmHLxpty83m	sgodwin@tns.org	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:20:47.25635+02	2023-06-14 09:49:44.644687+02	0032400000kwF3NAAU
01164634-32b8-49ab-94f2-c83733eacc70	Brenda Lema	$2b$10$tQRcHgh/c.P5QzBM7ol0NuzSV0SF.yEX/.8zPRmci91ntgPD36Xkm	blema@tns.org	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:20:47.305442+02	2023-06-14 09:49:44.651108+02	0032400000kwF3OAAU
3635d21e-627b-4cf2-9398-b6c144fc71fb	Janeth Mdete	$2b$10$9HngMwI8Mf4TBfGrNhQ64eLyYK9GzGxLwLpGIL9vuwAeRFe0fIgl6	jmdete@tns.org	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:20:47.28807+02	2023-06-14 09:49:44.663231+02	0032400000kwF3PAAU
d08b9390-5bb3-4d4f-92e7-a01a47ddd130	Theresia Mwaisumbe	$2b$10$ZCBg4JR9rbaKqkLGS8Ah3e816rKNqQqB5VDTSldJNbDTbVFCwdBL.	tmwaisumbe@tns.org	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:20:47.340696+02	2023-06-14 09:49:44.669055+02	0032400000kwF3QAAU
bd6bc8b9-8234-42e0-98a6-2fcbff0d6cbf	Gudila Mtei	$2b$10$x9qIi6O1B9eORdSdOr/ETu4jfiNWkAkQnjbZsbdlQl2IYhWuXjJGy	gmtei@tns.org	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:20:47.350752+02	2023-06-14 09:49:44.681369+02	0032400000kwF3RAAU
9918367e-3839-4ac3-aff2-4a61dca7459d	Happy Myovela	$2b$10$bSsknvOTx7Zu9U.uBhLpeeGt/XA9.BZc.93ZBV2HT.z7IITbNdMcq	hmyovela@tns.org	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:20:47.407454+02	2023-06-14 09:49:44.686834+02	0032400000kwF3SAAU
ce21dc9b-1daf-4e4a-9d10-27c592a638fb	Magdalena Komba	$2b$10$giS8BB48IUEai92Ab15.jOe1hMykerCqM5Pwbau96jDxc3LrrA/Mi	mkomba@tns.org	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:20:47.389019+02	2023-06-14 09:49:44.698885+02	0032400000kwF3TAAU
2c6b4919-bc70-4ff9-8c16-af380ba8286a	Jane Lotti	$2b$10$/1s5pUg/Ay3AJvGzT8e9MOaKLp4tDtfXKvRlU2exRn7w.YAHPcDoy	jlotti@tns.org	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:20:47.433733+02	2023-06-14 09:49:44.712835+02	0032400000kwF3UAAU
0e8d5c36-d67f-4f28-b290-63941d8112ea	Juma Kibisu	$2b$10$NzHK/XYHsZ3nv.KXnQwbdeUfT/Hy5B.ha.o93zO35YJxsTsFWQijO	jkibisu@tns.org	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:20:47.452668+02	2023-06-14 09:49:44.909669+02	00324000011YiuYAAS
b0d20a69-54d1-4c9c-9f11-b5d1942e4454	Wondwossen Shiferaw	$2b$10$2S7.OYAMyhoQGU0m2.3D5evjIN2Nmad/bqNAMU8apcv46BvwJhqq2	swondwossen@tns.org	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:20:47.469326+02	2023-06-14 09:49:47.48537+02	0032400001OHpWEAA1
7e650180-9b0c-465b-97b8-632158744768	Natnael Andachew	$2b$10$GWsmYouTjrkmsnL9cTzu1u05gWFqOh.tjbOMEx24N1pI7ETr3u9eK	nandachew@tns.org	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:20:47.48636+02	2023-06-14 09:49:47.513753+02	0032400001OHpWFAA1
946a6ba0-b7d7-4553-b2dc-1f09ad536056	Beza Teklu	$2b$10$xBbnDi5DaJNLLOmnAPi4Y.Sn0DZam1XmUX3eivIIYyCCuwqVql0M.	bteklu@tns.org	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:20:47.502571+02	2023-06-14 09:49:47.528444+02	0032400001OHpWGAA1
1862ca6a-a756-45b3-b398-34d05222a888	Sadam Umer	$2b$10$fote1Rw6XeY7fbpFrGqai.9FOpVtIpBnXLZ63wuQW1hvEnS8pTAJS	sumer@tns.org	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:20:47.513566+02	2023-06-14 09:49:47.536128+02	0032400001OHpWHAA1
c71424af-013f-4919-840a-ebd911290828	Shimelis Bogale	$2b$10$UZ5NEUcasmf6VajEAwYDTeqC3qWUae20U4D/DaShI4XjROU3cR4Xu	sbogale@tns.org	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:20:47.547484+02	2023-06-14 09:49:47.550996+02	0032400001OHpWIAA1
c0a6e6a3-a9e2-41a1-b485-c4238ea300b4	Tendai Matimbe	$2b$10$nN7h9K2qGuAyAs6byRbT9..mYtOvbkDKEXqcrdaz6vpYWj7i2naxm	\N	775201791	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:48.90317+02	2023-06-14 09:49:49.683112+02	0039J0000029Z1RQAU
4d85d3f1-828c-4c70-9a86-be3dc447a880	Tichaona Panganayi	$2b$10$NuavkGD/whStd7EXLsyTCOmLnfmESy1osYZl064wzqvzzYlaw1Lgq	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:36.635062+02	2023-06-14 09:49:36.204427+02	0030600001z8OPMAA2
dc23eff6-3a37-4dcb-b43b-40694119858b	Damaris Torres	$2b$10$K0IEkBuX8UTwfvimT4LzWO3jMH0kfn9KAyEzHZ6gsg8GXNWIb.dIG	\N	9392244721	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:36.709807+02	2023-06-14 09:49:36.246146+02	00306000020ejtpAAA
d98993cb-e0b8-4344-b6e9-3ef26b3a5b3e	Jeidy Rodriguez	$2b$10$Dej6v.JEKve85fpHdEC3VuWCvq/L5FfWbLExkhKUVeK5lAblhkFMC	\N	7876421047	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:36.790642+02	2023-06-14 09:49:36.254576+02	00306000020ejtqAAA
244e8d9a-ac1d-4dd5-813b-bef7b5300130	Sylvia Natandula	$2b$10$pqebLq61YXj0WfOLq.T/XuBoahn76oSCJQJ8KmO/qKtXiQ/zwxIhG	\N	772253383	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:36.930833+02	2023-06-14 09:49:36.282867+02	00306000020fiVVAAY
ea660a24-f1f5-4ba9-9274-057c6b0355b6	Ambrose Ngabirano	$2b$10$uQ5XRt3wvWiPy.Bp4EYRV.SSNFk75K8sMBqUABDQV79Bq2y.FIX2y	\N	789658286	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:37.011958+02	2023-06-14 09:49:36.288667+02	00306000020fiVYAAY
edbed373-fc43-4630-aab2-03195b660d1e	Emmanuel Mutebi Jjuuko	$2b$10$5wDKEQyyjPtNaf.MF5M27OG6VjTz9ItZCiz8D1aI8n..heRUzzhge	\N	700403294	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:37.231399+02	2023-06-14 09:49:36.299911+02	00306000020fiVZAAY
d3539607-4c57-4318-8289-d68a68e948f1	Andrew Watuma	$2b$10$hXnhQne7rF.xJ65jl/q2Eu02FqHz5AFrwSr2JU9ufMvXv1mBctAVq	\N	779079479	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:37.114993+02	2023-06-14 09:49:36.305755+02	00306000020fif3AAA
8ec75d21-1dcc-4845-b1d7-02d78433b309	Samuel Okello	$2b$10$AutAqGQ2AzCMUCtGAL3ZLuBUG7VVEfGVGiVcHhaIqvqg77dBKLGVS	\N	785364676	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:37.737704+02	2023-06-14 09:49:36.349595+02	00306000020fifhAAA
3c822b57-4b2e-4c43-a433-49642575d6f6	Jon Amos	$2b$10$ty4176ivQxbGkThVoxmFP.RQABU6s134mnrLrlpwztFZCVZ/46dyu	info@salesforce.com	(905) 555-1212	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:20:46.802773+02	2023-06-14 09:49:44.511698+02	00324000002sAiuAAE
ef83f339-0006-4d2d-9ce6-05e5e5aa1ac4	Achi Manua	$2b$10$ZANcq95JmQ/sIOvqD23JBOab2XRerPYtQLLqpWaSwJeaG.4zcP0ki	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:36.568253+02	2023-06-14 09:49:36.219056+02	0030600001zPpu5AAC
68d9ee59-a60a-4d07-bbbe-95c11cc9934d	Edward Stamos	$2b$10$UOeoTrNzbeAwpmHa.wvdve2H0RVCngqVmfjoe/heLfROCXre9r9B.	info@salesforce.com	(212) 555-5555	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:20:46.818587+02	2023-06-14 09:49:44.527009+02	00324000002sAivAAE
4049ea86-8d5c-4388-bdf7-69061c57b4e6	Ddumba Badiru	$2b$10$PoCMEyn57hIHWK26okUWguAksi/rkWJWh/YcBr8.Alw1LkEKaqR7K	\N	751095458	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:38.116036+02	2023-06-14 09:49:36.618779+02	00306000020fifoAAA
b76f9b84-bbec-434f-82df-28393e7c179e	Agnes Nakurut	$2b$10$zZYLW8I8ckf6oQWaZ3FF4OfXMGp/RL/FgUW9n6HGDB.E3hFuUEG/q	\N	782354752	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:38.41339+02	2023-06-14 09:49:36.714667+02	00306000020fifsAAA
ec5197e5-8e60-47dd-ab94-8672036f7a7a	Peter Mugweri	$2b$10$Sttae9KU7oJjgSaAIqCN/e1d/X084CRZmgqwt4JIZzAZMzFNgEU/C	\N	752941536	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:38.83169+02	2023-06-14 09:49:36.766694+02	00306000020fifxAAA
1d286e62-8dc9-4413-9622-c5ed6fe3dd0f	Jonah Kwiita	$2b$10$.9DqHjvN/nes9slGcYQfx.pE9Fu53UAr4bHQeyzsL9blTPhFIQlsK	\N	752862096	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:39.111788+02	2023-06-14 09:49:36.803542+02	00306000020fig2AAA
b6f7c22d-d0f4-4692-ae9b-296c1cc885e8	Samson Mutaawe	$2b$10$7/7flJlP.srM3fv0MDZQRedG/X/MHDdvi3Ph/ugj1IpemNs8mOpL2	\N	750031080	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:39.13048+02	2023-06-14 09:49:36.867003+02	00306000020fig7AAA
c707a077-817d-4330-b978-0aa2e87cecd4	Brian Kirata	$2b$10$N1O0rg2NtTC0Wp1SNSdFw.akluyf27papvadVMPXVbUjz.Vy3MeY6	\N	789017908	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:39.151207+02	2023-06-14 09:49:36.908515+02	00306000020figCAAQ
82a654e4-ed30-49f4-bc1e-584c6b585c74	Stephen Kintu	$2b$10$La1wdxBfxPr7pN2F/U/IUOp2eUil6435k4SFQ9wiReWcfn0Abjp3a	\N	702753746	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:39.394997+02	2023-06-14 09:49:36.945698+02	00306000020figHAAQ
c605696c-8eac-4605-9ec5-ce2ead3f5094	Esther Nampera	$2b$10$yuyUwgZ7HAq6I8Rhks9IEeUX.102MhxfqZcfiqhXLinOEKDek9iZG	\N	706239035	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:39.78301+02	2023-06-14 09:49:37.048369+02	00306000020figMAAQ
6c848a43-ba3c-4b0f-961c-be8d7982c4be	Winnie Waota	$2b$10$P0tETpWhXL.chUNDsW6yqObZqRmEY3K5wg546NzZ0LNjIfhUCr.3y	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:40.157552+02	2023-06-14 09:49:37.098507+02	00306000020tCFDAA2
481aff54-cfda-4311-8b42-4c04c981f0c7	Amini Ntampaka Alliance	$2b$10$FnaoVzpXMODAaaj0ud5qO.0yYCEDeJJKGjUYWMrGWEmRvmYkzN/VG	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:40.3185+02	2023-06-14 09:49:37.114416+02	00306000020tCIzAAM
1cd0a7c6-0959-45dc-8aec-062717003735	Malick Hussein Yanick	$2b$10$B2cv6fpjNkzhefBPGGjDRuVMgXXuixzPmaFtvPKnobd6H908ceMzO	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:40.869422+02	2023-06-14 09:49:37.202253+02	00306000020tCJ8AAM
559ff818-6164-4f57-8826-fd499c9c86b9	Tegera Zihindula Justin	$2b$10$K/t6ZuHV7Dkc1Z7QoNGUsuvgkg.U/g7qUgyrUjliXF99fn5qvk8jq	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:41.704591+02	2023-06-14 09:49:37.327268+02	00306000020tCJMAA2
0458fc08-05e6-497a-9671-e577b1ba8f04	John Robert Okello	$2b$10$EjTA3ofVlwb/gtbqHEra0e.wA4cWgEhczUkSB6Gq0/FRn1Gsfl0LW	\N	782929928	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:42.213499+02	2023-06-14 09:49:37.399704+02	00306000022HQqzAAG
b2e72155-d38d-4e5b-9ec9-cc30a5eef5f5	Shimelis Beyene	$2b$10$rXGJZ8YoYIH7tmG/Ap4s5ORKkiLvCHhh6nBe2cUV7pG2QmgQkefO.	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:42.567638+02	2023-06-14 09:49:37.446758+02	00306000022HppIAAS
56a6aa94-59a9-4c84-a5bf-c8c7d0a411a8	Amriya Ahmedin	$2b$10$sR/agLx58VUnckroDSd/yeqzB202HlK7G60IZUPn70HvTxV6ntL2K	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:42.781867+02	2023-06-14 09:49:37.49297+02	00306000022HppNAAS
0711faa5-511e-4e48-85ea-f5fb18254384	Gizachew Girma	$2b$10$4Bzo6Yxq4h98OWGwgoyqfOQknSIr8rmYsdgNEJXwxqjls42L3prtm	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:42.9573+02	2023-06-14 09:49:37.540302+02	003060000237JNyAAM
e7b1cdb2-7971-47ab-a974-e6f3b611fd75	Shambel Kebede	$2b$10$Ft5flG/vq5rx4ZGEqzIwiOdcDQtFoFFdPZy5QqpciuHJS0kaCJhO2	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:43.224562+02	2023-06-14 09:49:37.582416+02	003060000237JO2AAM
9406b97c-97f3-4371-a8d8-0e392629de74	Judith Zawadi Kazimwe	$2b$10$UJ5FPtiViBzKWZyQGW5z3eSQ7OeGbVdiAeNmesmUyw9CYHSwdhfo.	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:43.530107+02	2023-06-14 09:49:37.663079+02	00306000024klQiAAI
8fe72530-019b-4a23-b173-56d0050ca951	Ghyslaine Weregemere Florida	$2b$10$dBZDjMBpe.CWh1SrQBphbupgIHF4KXxaMoHfYA.sNedQAE3tkPI2e	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:43.776092+02	2023-06-14 09:49:37.757382+02	00306000024klQnAAI
86661d93-f1fb-4851-a901-64c59f1178cd	Ann Mugweru	$2b$10$Aakpkg.FZULHUCERHEP8.Or1arYfcQrqLjnItGld8uMflp674u6CW	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:44.045308+02	2023-06-14 09:49:37.807704+02	0031o00001T4njMAAR
270cafdb-789f-46d4-92a2-ad6dd246a701	Richard Murage	$2b$10$vvtQMPz/Weg5UV.kjp8qr.Zua60D15qsBQIKYw/U/ZyEZZDl3gsUe	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:44.291686+02	2023-06-14 09:49:37.839089+02	0031o00001T4njQAAR
df290ca2-dd82-434b-b532-7c9797e246b2	Kennedy Mwangi	$2b$10$FCFjA8KSfEH1doyxZVd.9O08hHIXcww7Udw3hQIbNLm/DoUGkARU6	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:44.600636+02	2023-06-14 09:49:37.877824+02	0031o00001T4njVAAR
04cc5f22-ab29-481c-8ab3-65516e0f124d	Samuel Karimi	$2b$10$u3oQX7Q9slEozHtfoEMuH.l4P6B31zWHY1qOfPceuxCnRKRGj27j.	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:44.911706+02	2023-06-14 09:49:37.929193+02	0031o00001T4njaAAB
bb70888f-6721-4d59-b134-0a2e6e217c7c	Christine Maina	$2b$10$xR5YmPXJrNx4/joNiP9mPOB./bz19rTlDfj4u6CZfyyRR3P1EBa4S	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:45.217+02	2023-06-14 09:49:38.02336+02	0031o00001T4njeAAB
1809602c-e7a3-40f9-aa07-2b5688c920fa	Joseph Karoki	$2b$10$nvb5ZJIC1drbEI9sM9XX2.C.1IQx6BpoMRHsA4PZC3huFFcFhtq8i	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:45.46127+02	2023-06-14 09:49:38.092005+02	0031o00001T4njkAAB
c1b227ca-9c7f-4152-ad51-4772f9e46c48	Beth Wangui	$2b$10$nOX9piy0l6IYeA1UDW0Nxet1VrK6b2q5uOYC4YaEEhruHTRBQnCXy	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:45.718897+02	2023-06-14 09:49:38.162475+02	0031o00001T57OoAAJ
ec8633cc-fe0c-419b-9074-9820b0c50f26	Benard Mugo	$2b$10$bV8leLF4r4yru2r/y2DNrOXUblnHflZLWeysqfqpv.bpEl6MitL3y	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:45.958095+02	2023-06-14 09:49:38.209754+02	0031o00001T665GAAR
74893fd6-9da7-4676-b2db-2dbff541da2f	Dorcas Chepkurui	$2b$10$05c2feFaggMJrLjwfVqZOOzJ5IDKu/CdkM5upC.9CL55FVdQmCsp.	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:46.236166+02	2023-06-14 09:49:38.25655+02	0031o00001T665LAAR
56d1c1fe-5479-436a-8361-3cd08016e48d	Jesca Chepkoech	$2b$10$mdEVp6C4e5oB8l3tl.8kMOPfyvDKQWDSdyGp5Ga7G59unoYBHXp3W	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:46.466211+02	2023-06-14 09:49:38.284184+02	0031o00001T665RAAR
6c366f15-c9c9-42b4-86db-ce646ad51174	Lydia Koimburi	$2b$10$a3G26xnQDyw.5p2qnQcv5.4eCfMQIsObJbZuR2akhj1I74IM6xDUS	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:46.854108+02	2023-06-14 09:49:38.320866+02	0031o00001T665UAAR
43f61f96-c593-4516-a345-ace722fd176d	Stanley Kamau	$2b$10$684ALUw.PyHt/3uYMd800.NuaHt1nSEtplJbgFUeBci36kflPcKQG	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:47.1117+02	2023-06-14 09:49:38.387221+02	0031o00001T665ZAAR
a2113c8c-cff6-4b10-a619-4f9cbd94f975	Alice Ngugi	$2b$10$6Fr9uc9gvI8RuZXAVpXQuOX2S/WWOy2DV.XSijHG2XqVfOJr6OvrS	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:48.529022+02	2023-06-14 09:49:38.473613+02	0031o00001VZd44AAD
97c031d6-f31e-48dc-ae90-3ee19219c42b	Mengistu Shima	$2b$10$nZi1Re6f1kAVQ8AP/CH8tesM71dI4/tKUE4ps0zjULEmNYXFcacJG	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:49.12584+02	2023-06-14 09:49:49.719424+02	0039J000002OGXCQA4
ed81392e-6776-495d-ba6c-2652cdba2d8b	Saba Mulugeta	$2b$10$dov8f6fyIrtEDjuv1eQyIO/yqE6FzmU8lzY8AAWFeTMtPcr/vTX1m	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:49.521175+02	2023-06-14 09:49:49.776868+02	0039J000002OGXFQA4
66c89a5b-ef3d-4c8e-956f-9a177a03bdda	Ivan Eyoga *inactive	$2b$10$EkpSbBYOBG4XtlAbXCJV0eawgu8l2LaQiUAwTDnXVIBI7BtXRKt/2	\N	758496817	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:38:37.366031+02	2023-06-14 09:49:36.321947+02	00306000020fif5AAA
4b7eb97b-532d-4f44-8db3-c8d448d853b4	James Bamuleseeyo	$2b$10$zMTNMaTgzAcNCFrykemRPeI0ToA0kc2wm.vKfzxNIajKltZ/2s6cm	\N	706122221	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:37.810437+02	2023-06-14 09:49:36.370196+02	00306000020fifjAAA
e86c8210-0135-4223-aa8d-52c95260bcd7	Mwirakiza Kabumba Papy	$2b$10$8hygLJWcnx2NtpdiC9f4Oe/r7GKvNxtqrDSu.vcGkxAE.znBun7Ne	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:41.130318+02	2023-06-14 09:49:37.233487+02	00306000020tCJBAA2
e29a35e3-5f95-4c33-a8c3-b7e87e2c24e3	Edson Tweheyo	$2b$10$P4vx/QD2S3PywZEY.KQ8S.QF4C7nLCBXqiCmZkBRn87LXyHxzveL2	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:41.986637+02	2023-06-14 09:49:37.372574+02	00306000021sWROAA2
125d4f9c-5552-45eb-9e31-5c136bc179da	Agegnew Getachew	$2b$10$xMSdlHdAB4WpAKE0UQnHkeCWb7CRYFrjR/aheze/T.mNbO.bHebrG	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:49.30522+02	2023-06-14 09:49:49.746704+02	0039J000002OGXDQA4
b91fad50-2891-40b0-bb30-f5990df3b48d	Ingrid Alikoba	$2b$10$G0dKz6xVEIYmBDHO9xsTKOG5wg3vwSoMY.jElK1QkRmXYXPpq/Hga	\N	759213981	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:38.193782+02	2023-06-14 09:49:36.512473+02	00306000020fifmAAA
f1ed2abf-ae40-47e9-9e9a-d228882d0739	Franco Maguma	$2b$10$s6Sw2x61OYjrAaI35XCFIO9xTvL.OQkJB2yDMrn.TM6V8V2fdHbm.	\N	704755798	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:38.469675+02	2023-06-14 09:49:36.730001+02	00306000020fiftAAA
31130139-362b-41a5-86af-2099730fcb4f	Sadati Mwesigwa	$2b$10$47D69zvjiGIk8ZNKACdAuuoxTppxtr2fSnHZuUSeyEPTwr3k6Tn6S	\N	774777534	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:38.956302+02	2023-06-14 09:49:36.783753+02	00306000020fifzAAA
a7fc8fba-27a9-4141-ac83-6e07f85f4a0a	Ismail Adaku	$2b$10$M.3uN0tWHrxse.RY2QQJ4uYI.jUdKnb6aMG4XdD08oDkmymivyk96	\N	785425028	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:39.115638+02	2023-06-14 09:49:36.819221+02	00306000020fig3AAA
9f67442f-e0fd-414b-8bf3-cdc372c3c9cb	Rose Namusisi	$2b$10$ZAoirXRVPWg9TKsTEeQ38.zoA4EQJjXep4N5F.3K62p3sxQ99sf/m	\N	700693075	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:39.134184+02	2023-06-14 09:49:36.88004+02	00306000020fig9AAA
95964677-ca06-48d6-b9b2-81b52ff6480d	Godfrey Walusimbi	$2b$10$Z2yrlXjAyWZR56gOT2orM.18M9K0dTNLARIke6vQi0G5QN2kfkhtu	\N	703405122	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:39.460739+02	2023-06-14 09:49:36.949733+02	00306000020figIAAQ
83f278e1-494a-4933-80a8-d3dde1a3081c	Emmanuel Sanya	$2b$10$bRkxJb.xaQNPL1cPgRkxU.Tj9rgLyPb8OIrYDlcwB/Cbm5.u3z39m	\N	708544203	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:39.870723+02	2023-06-14 09:49:37.062417+02	00306000020figNAAQ
70fa74dc-8248-4b60-8017-d2c84f68a588	Aline Libakale Monique	$2b$10$rvA8YqXUxcs6PoUAUZVV0eSNPYnTnThPf646Zvk2C8c4IfAkZ5aoS	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:40.197377+02	2023-06-14 09:49:37.108369+02	00306000020tCIyAAM
d90441cd-54ed-4320-9e58-149136924abe	Bikuba Didier Josue	$2b$10$ZFpieN/cyz3JRVNEoK7TGO3xgiHzIeDQbBLZraAv3HKUUurFCMCwK	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:40.608566+02	2023-06-14 09:49:37.159232+02	00306000020tCJ4AAM
663b2467-111c-47be-a5ad-7c6b7f3f3013	Imani Bagwiriza Christian	$2b$10$4wOg.uTRUips9APNO5xnXuuJZfjGD74ObvBtrNnOt6s1lMz.2Ucoy	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:40.983772+02	2023-06-14 09:49:37.19505+02	00306000020tCJ7AAM
0eb3f570-ce37-48b2-80fb-4de98a0b9f1e	Nakihumba Kabarati Jules	$2b$10$VG.Fas2pybsJQXKfoFVsBOnZXfvo3ZzbGJicIHipYHz/HUXS6TJ/C	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:41.229898+02	2023-06-14 09:49:37.250717+02	00306000020tCJDAA2
8108c0da-00ea-4ad3-a75b-868bf3541189	Sebazungu Moise Jackson	$2b$10$lJKuFIin.wMrAnQllGXkdeP/7v4QJhkNlgRh0BxTFXGLSi.AsCHi.	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:41.46817+02	2023-06-14 09:49:37.292809+02	00306000020tCJIAA2
48d5c2ba-5132-4e0c-a455-3006cf876cf0	Tuliya Karumba Justine	$2b$10$uSOr0FaAPcyhOiHz5mbzn.zdcvROqj86GWG/l2byx1Ls6.M4YjDIW	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:41.751432+02	2023-06-14 09:49:37.331535+02	00306000020tCJNAA2
4fca9eb4-6117-486d-9eb4-d80dfad2f496	Aime Ndatabayi	$2b$10$hzbG9ekiwukopahOGwGZPOgiinNfIlB8WMajQaTGxWBumC0LbIuc6	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:42.065536+02	2023-06-14 09:49:37.362811+02	00306000021jFYCAA2
fbd29841-9c41-4c11-b386-a46ba2765234	Adane Abera	$2b$10$2OFfRg8zhkDxylo4QDotxeHxs3t4uWbTgAJeN9Az/2KRhKuHyKwzi	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:42.265225+02	2023-06-14 09:49:37.406834+02	00306000022HppEAAS
15fb4c79-94be-4bd2-a866-eee226b50d67	Kefelegn Kamiso	$2b$10$m15xuZbbFazpICXgrh4v/eOVO3G63OeFtj0wtT60cTANEUAytPpuG	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:42.592301+02	2023-06-14 09:49:37.456058+02	00306000022HppJAAS
d64bf2b0-848e-42f5-b827-71578d58a650	Behailu Shiferaw	$2b$10$HvuRFnAlG4igGkzbAUKOYOuVPtk.SXAebfbN7Unc712xtfIPqoMWe	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:42.82872+02	2023-06-14 09:49:37.508851+02	00306000022HppPAAS
261c446f-9d24-4c5f-b8bc-e54efc5fe1bb	Yordanos Hailu	$2b$10$GBlBkNACo/vA8K3A6qxqf.PkvKSgxu7QwjVdliEhSjXDR22JCctGu	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:43.014643+02	2023-06-14 09:49:37.528801+02	003060000237JNxAAM
2ebf7044-796a-4865-9ddb-40d04102a4d3	Felekech Petros	$2b$10$0ILShsEg9bF.nnSGNbI9eu1UBq382lRyFpdK30z/k7vH7A.K829qm	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:43.306942+02	2023-06-14 09:49:37.607091+02	003060000237JO3AAM
d151e6f6-256f-41b7-aa1a-e83326886d95	Pascal Ombeni Chirwisa	$2b$10$WAjarUcc17jp4V4ykO9AYen32bogEbtXEPFr88orvQ0OAHLtcwBse	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:43.585471+02	2023-06-14 09:49:37.703739+02	00306000024klQkAAI
6c739b96-c6b3-48cf-bd8f-6fe8f3cb94fd	James Gitonga Kamakia *inactive*	$2b$10$LTTS3eYalluLB8z332.VceEEoU6tgh/GlAh7.qae4713hTitnRjXe	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:38:43.838559+02	2023-06-14 09:49:37.778197+02	0031o00001T4nhfAAB
365b02c6-c667-4366-ba09-b3ef34145139	Alice Muriithi	$2b$10$nmiL85rkI1xcbiiqwj0PiusRMBpgccoeBsbiLr79dM.x4pbubFgdG	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:44.070507+02	2023-06-14 09:49:37.796398+02	0031o00001T4njLAAR
03299635-895b-438c-97cb-72e3bd22db94	Efrem Ejigu Old	$2b$10$50DC/uq4xvBvMxZfz8nXq.jIiAFqGzVubs2VAV6KEfu2/Fs0CxuI2	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:45.782346+02	2023-06-14 09:49:38.176864+02	0031o00001T5fi4AAB
09c583de-8cc9-4174-b943-2a1950744d2a	Jackson Mwaniki	$2b$10$jfpT.2TjAYAQ7pIpASMuJuJQOUMuouQnRySpByuz5uRmAcDql4y2i	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:44.336501+02	2023-06-14 09:49:37.844306+02	0031o00001T4njRAAR
47cda59f-698b-49b2-96a1-7c9642a4df11	Judy Wanjeri	$2b$10$YihLUe94NQNMHwOyn0EqLOXw3SsNq15swyiVXyV3vvq88A9nvlfWy	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:44.642845+02	2023-06-14 09:49:37.905346+02	0031o00001T4njXAAR
ca33ff0e-b8db-44fc-aabe-af952882c4ed	Simon Kariuki	$2b$10$cgUZknUT9NxQ2VZesz1XDu7Ge4OnSLStD7M.oq9YxvWF.aDQNPtfi	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:44.980464+02	2023-06-14 09:49:37.941524+02	0031o00001T4njbAAB
7b537d3f-eddd-4ed6-ad73-66f9705bee48	Joseph Gathuka	$2b$10$qksfaOqhvtwER/qotZLh2OITxwabL0NHZN8LF1ob7cqwk/piaDiuC	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:45.280211+02	2023-06-14 09:49:38.045515+02	0031o00001T4njhAAB
c103f7f9-f2c2-449b-84ec-16d3c8827bec	Teresa Wanjiru	$2b$10$AzmHeZW5WX/Z9hrdkVLGeO39CqBG6uCBUaoZTJWKLctmj07boUCg2	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:45.505409+02	2023-06-14 09:49:38.078995+02	0031o00001T4njjAAB
25ac5434-36d8-4427-812a-cf168e8b165c	James Njoroge Wangari	$2b$10$RS2F2D2Q4j9F/crPLg74h.7MRbuWnwaN7JA8MuXbV7O4j9Y56tceS	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:48.673128+02	2023-06-14 09:49:38.500711+02	0031o00001VbqCTAAZ
ab2f57f6-2150-42c3-8275-815e7054867c	Monica Kirunyu	$2b$10$PADMCRP08QlRZeRh.pSv..7NzJZz.LwOC42B/VFJj/9ESLEbjJGZW	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:46.007434+02	2023-06-14 09:49:38.226615+02	0031o00001T665IAAR
416c5adf-4f7e-489c-b91d-83b08eabf83e	Hannah Wahu	$2b$10$/cSrRx59RhcEaLaw0UG3pePlT9G43XK3e48ArcMUEyiFjqXG7gVwa	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:46.287758+02	2023-06-14 09:49:38.274723+02	0031o00001T665PAAR
51b02819-66ac-41f1-b8e3-7df56a6a6209	Kelvin Mwangi	$2b$10$vT.uO6uSKDvRJZ0Zu09/yuj9pbnarwtOSGH4kP7ORUdcK1AiSUzVa	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:46.530073+02	2023-06-14 09:49:38.307373+02	0031o00001T665TAAR
89e1291b-a2ea-48c0-b56e-b8ae47ca9ff6	Naomi Chepkosgei	$2b$10$6QDisoYtY0R18Chfwa6HBOihz2w04yUbu8FWyNCqrJfBnEXhNd5m2	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:46.912345+02	2023-06-14 09:49:38.33661+02	0031o00001T665WAAR
2efb1ba7-1942-49f5-b688-e3e6320f97d7	Stuart Kazibwe	$2b$10$VTD1L1N3u4A6cqF3jd8UVubs.9vnAg3/ztQXeMWxi/ETv8uHlm2Py	\N	775235123	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:47.181941+02	2023-06-14 09:49:38.404391+02	0031o00001TKKmvAAH
e1e08d67-03fd-4ec5-bfc8-c50d284cafca	Aganze Banyanga Didace *inactive*	$2b$10$nBcxLUL1qkzpNeoNW86Ms.e6xZJXgNBw9k5t0fct9xXLUUfkf2soq	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:38:52.033047+02	2023-06-14 09:49:38.924715+02	0031o00001Zxz7aAAB
d3147ed3-a876-42da-a243-9f37d4e4b43e	Sabrina Bintu *inactive*	$2b$10$sktA2/8AN.7/IaUX8bhX6e.RTj5s4tCAfhMgwhPyDWsvM4p35GP82	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:38:55.166382+02	2023-06-14 09:49:39.898421+02	0031o00001d6u9aAAA
d1acc28c-c4e2-4632-8a7d-147c7f853eb3	Lilliane Fida Nangonzi	$2b$10$YemhDo.uo0RKeTjKCj6AKuUzuKnBJrfwCTbtYvgBopvJQVSUFTj8G	\N	774070521	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:37.877036+02	2023-06-14 09:49:36.357079+02	00306000020fifiAAA
d0ea4fb9-7a4a-4ab0-b5dc-448acd99d68c	Brenda Tibebuza	$2b$10$8QkkpNsIYi9w7xsbrgkx7evoAH1vDjRnQLl7qkfBoAGGnKmaGzNq6	\N	787227548	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:37.426275+02	2023-06-14 09:49:36.316574+02	00306000020fif4AAA
7f31cd66-c761-4516-a837-81c7eeeec516	Alex Modi	$2b$10$ZGxHjdlHLJVEEm69TB7YL.Ss8p3mLgtwdbvgnnI5458yWbXiWvPS.	\N	700382855	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:38.25721+02	2023-06-14 09:49:36.634955+02	00306000020fifpAAA
947f1589-7b9b-4e8d-b3f6-0c5c3e000a2b	Moses Mabinda	$2b$10$rynzXnpO5gO1eumnbNSCCeUEmc8U.k4rC5OwIj2c5g5ZMDhmc42AW	\N	704136493	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:38.551394+02	2023-06-14 09:49:36.737851+02	00306000020fifuAAA
88046382-a45e-47c6-ba65-dc09435cdfcb	Brian Lumala	$2b$10$OTnfC7IvMd1mwxgEC2c.UOAuNRz/jx27Ib2GEofPq3HiKDUzJIJUe	\N	756364200	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:39.100801+02	2023-06-14 09:49:36.779065+02	00306000020fifyAAA
d60f20cd-18f1-4456-a852-3fefa5144b43	Alice Nankungu *inactive	$2b$10$VziNmUTFXsKAwqizG3bJNOKz5WyJc3xLQAaqkg7Ck7nHhZYQlCXWu	\N	778793442	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:38:39.119296+02	2023-06-14 09:49:36.847148+02	00306000020fig4AAA
0b86db03-eba5-46b4-a9bf-41709a2a9ac1	Godfrey Bwayo	$2b$10$OCyHPb/JqgcNJ1L573Xpe.9hX0bDzhr8Yft.h/qxyxD4dyeYDjK8q	\N	704588464	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:39.138022+02	2023-06-14 09:49:36.87479+02	00306000020fig8AAA
55e853bd-afa7-4b87-a53c-429ba806c338	Asuman Kigenyi	$2b$10$nabTYC9zkt0/eGxE/uuZbOIR4rLOnLIyuMOE3q.DX8F38ng83sUlW	\N	704122269	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:39.158386+02	2023-06-14 09:49:36.926967+02	00306000020figEAAQ
a76476b3-064f-4023-8713-664a6383025e	Robert Koli	$2b$10$NdmkvuHY3be0mUtm4JMmCO7u8kK70h4cixEhPc0FCWaMYHK.EseP6	\N	705515046	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:39.526459+02	2023-06-14 09:49:36.95555+02	00306000020figJAAQ
32d1099c-22b7-4628-ab24-d862c5cf51db	Yasin Kanusu	$2b$10$su45vbP55ioU85NUFBrYHuLGH5VbUsDVfZCQq8jakBPEmMVzJUH1W	\N	700620588	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:40.004412+02	2023-06-14 09:49:37.075219+02	00306000020figOAAQ
96e39fb2-166f-419c-8f83-de77c2de0dad	Ayale Petro Providence	$2b$10$zVzNvW8lfcv4njnYF799HefKczwUOLkhsnKsgFCScLfu6MYc6aF/2	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:40.276222+02	2023-06-14 09:49:37.126953+02	00306000020tCJ0AAM
87d8ed95-7d7a-484e-887a-0eb2663764ca	Bikanaba Bidahwa Theobald	$2b$10$8zVnfGfpFbko5s8iCLz3EuA7HtEfwD6lEItxGInPQZhoYl7yi3qUe	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:40.651922+02	2023-06-14 09:49:37.150595+02	00306000020tCJ3AAM
9774bff0-b724-4ba3-8aac-c2e0b642b7c2	Mambo Bahati Daniel	$2b$10$MgnGgs56soB6aboM.s9cP.ws20IlKjymEbNuB3oYzZFZRtgSzuA/m	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:41.019821+02	2023-06-14 09:49:37.215908+02	00306000020tCJ9AAM
7bdce6e8-6d6d-4f17-b676-bda4e02c8aa8	Neema Bulonza Jasmine	$2b$10$7L1dD9YnLJD/n20YsNE/AOK2.v6fDe0Jgu2ZltgQcEUUMmh4SPW7q	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:41.277792+02	2023-06-14 09:49:37.263323+02	00306000020tCJEAA2
9384ba5b-efd4-4979-87c1-222cd6649450	Sifa Sauda Charline	$2b$10$VjbhVlvXRn67Jkdv1qcO4e/6u8pglnojs5AW82MBWERkjbZWc/jSa	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:41.5183+02	2023-06-14 09:49:37.312075+02	00306000020tCJKAA2
959add9a-6166-414b-98aa-1a91f2a7fa86	Valentine Akonkwa Nsimire	$2b$10$uC68vhLNIaHSl6RlMzbIP.bM71s9kZWuM93C8Z90jXTnXpXLxfY2m	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:41.812618+02	2023-06-14 09:49:37.342077+02	00306000020tCJOAA2
3521fb62-f183-4fd0-ace7-8fa006d9ce75	Nobert Ahebwa	$2b$10$.kJzc2/AUSZjdIFvAN3MEuzL75e.p21b9SpgpX8sGw3HzzXUWI6pC	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:42.114472+02	2023-06-14 09:49:37.378212+02	00306000021sWRPAA2
6d35a30c-16ef-4dec-885d-fe2dce96a14d	Eyerusalem Bogale	$2b$10$wP/LokjkVd/ih2nYcJQkuu9Lfe3iVaoJhU99mDAFVmtmSwli3V2qi	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:42.328944+02	2023-06-14 09:49:37.41704+02	00306000022HppFAAS
91a70083-886d-4178-863a-e6633caa97b2	Tinsae Solomon	$2b$10$wzTvsMoGEWYviwt7yky/3u1oflj8IhoklCOQ0Q.fxQVszajyDyZ1a	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:42.655834+02	2023-06-14 09:49:37.475514+02	00306000022HppLAAS
5626f919-843c-4dc7-84af-250ac7182366	Nabiyu Matiwos	$2b$10$LE4BRG/UOdXdOfbb.VcLXuZ88.m6kC84rRtXjG3BEhOTBKkCEqNdK	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:42.878477+02	2023-06-14 09:49:37.498206+02	00306000022HppOAAS
4b6a6e65-ddf4-4ae2-8b3d-7db28abd311a	Tewedaje Gezahegn	$2b$10$GqKmfa/sXIrdOzvGe2nQlOPweBP8tE9U/MEJEdhrHZfQ7CTphOH1G	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:43.042459+02	2023-06-14 09:49:37.545059+02	003060000237JNzAAM
c414237a-f4ee-4d50-b71f-d10e1c2dbe9f	Miliyon Markos	$2b$10$cx8EpJ6yFngFfb0FFBuZteB0VmK4Vrp2lo1BVQ5St0YS81WOtu2DW	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:43.354185+02	2023-06-14 09:49:37.612863+02	003060000237JO4AAM
c25f6dfd-4b30-49fe-97eb-a3474645a6a6	Patrick Kasuku Albin	$2b$10$XLcJiLVNON7YjYtCvXmXX.J8WHBvAyC1MPi/QyiMO16ax5nzmISuu	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:43.634313+02	2023-06-14 09:49:37.677455+02	00306000024klQjAAI
5f4f1b6e-a884-46ee-b1e6-b31f23119ea2	Susan Awandu *inactive*	$2b$10$dEb6SOcKTnchJONRqeJAy.VtR8XaRGkaXoYtDG4ZTKQ1QOWGKpdwO	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:38:43.886797+02	2023-06-14 09:49:37.774978+02	0031o00001T4nheAAB
0384d2a4-0588-4378-a6c2-d0773f23bf60	Morris Munene	$2b$10$APEQ5yUOk1kUNhf1r1abBe56mgeIw7wG95U9MAZyGXygTToDQZwWS	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:44.168373+02	2023-06-14 09:49:37.81259+02	0031o00001T4njNAAR
aa3a707a-1a9e-443e-9227-17ef85b586b3	Piah Mwai	$2b$10$tol8UqCER6ahF9OOwyJSJOYD84d78znuYplD.1C3Ro8Z178F2HYii	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:44.455934+02	2023-06-14 09:49:37.87275+02	0031o00001T4njUAAR
74de5296-8750-4cbb-861f-d05f50336448	Lydiah Gathigia	$2b$10$q/lmqFa/Pu.RQGI.XBPnfeNi4fijlbO7hhFJoMyGi8yVs5fPLGhnW	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:44.698304+02	2023-06-14 09:49:37.891263+02	0031o00001T4njWAAR
2b598de9-8c82-4cb7-944f-884860c74f71	Ann Kenyako	$2b$10$h8uBmfq7WcOldc12Lo2pZesdD2AYcxI1/u6YEF3UQwYFw5xfPxMJu	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:45.024997+02	2023-06-14 09:49:38.003891+02	0031o00001T4njdAAB
6ed42e56-e198-4644-8e2c-160ef228fb5a	Charles Mwangi	$2b$10$699yAsnUKE.KGvSOc3eHDeWUHTjt2C3zx/34D73pPu5LX2Fwi0kv6	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:45.324776+02	2023-06-14 09:49:38.039003+02	0031o00001T4njgAAB
bf9b9585-347d-4d1f-80fb-02ffdc66d4f9	Joyce Mumu	$2b$10$bObEageBFUpOZ/gbVnK95OfKq/YAgBjuy/oxQMdDsSHQiwXa/Xssq	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:45.540195+02	2023-06-14 09:49:38.111542+02	0031o00001T4njmAAB
33fb35e3-d4ee-4b82-92cb-c7d57a715424	Bizuayehu Workinehe	$2b$10$r64yZBqr9Q9MDnF9LFZtK.VNXYP4W8HffXWbL2ozs.gMuK5pwXI.S	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:45.825449+02	2023-06-14 09:49:38.18616+02	0031o00001T5fi5AAB
0fdcbd1b-1836-432a-ac4f-a1f7a9ab6dcc	Brette Mwende	$2b$10$3FvVLees/oqZ8g1JN9f7ie5geuIYP3Aiz1Te1QQuccu/FSG86RwNC	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:46.079176+02	2023-06-14 09:49:38.218265+02	0031o00001T665HAAR
0e3a8ef1-b5a8-49df-9e67-1c9419283553	Evalyne Kabui	$2b$10$SGr0nkhKEb8COfekc0H0m.V2MicUkH50qKVKez7vYPRJC3cIBWUUC	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:46.346469+02	2023-06-14 09:49:38.26805+02	0031o00001T665NAAR
7d00a996-6a80-4c32-944a-832496f21d02	Jacob Odongo	$2b$10$dMSzvjyVZi0QM7k0Ex5IKeaIvbMtvGDpNQ63sTY8Wv.QGUUwajUM6	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:46.585653+02	2023-06-14 09:49:38.277153+02	0031o00001T665QAAR
56a51dc2-0608-4d4c-ace8-423820e1bd2d	Peter Maingi	$2b$10$r9bxIUn.Db8wsdjfVbIxmePLEaQzMWZvQbd/4VqJUG7B5K6IxDxvW	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:46.982137+02	2023-06-14 09:49:38.356138+02	0031o00001T665XAAR
c0a256cf-8bc7-493b-a315-7d5eed55b98b	Caroline Bora *inactive*	$2b$10$MjLcdwzMUOQwQvZqgxWXlu.018uxIlCSPtQ.9Ga1vgu2vX15BshRm	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:38:55.080129+02	2023-06-14 09:49:39.893953+02	0031o00001d6u9QAAQ
9558b6c5-ab0b-46ce-8d8e-ec41c2d67b63	Gabriel Ehiaghe	$2b$10$LCfvYFqqMYonlirdwCmMRO5ZTaM39cyPpxoukq0BjgobGnlWi.nji	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:04.549334+02	2023-06-14 09:49:41.684926+02	0031o00001lRdFBAA0
c4185020-1ada-4c49-87a6-f8a931515ef9	Mary Auma	$2b$10$QPE/EbKADjzs3FdgkLwfXeyG878XS2wpdKfllEg5ggjPWxpgHLgFi	\N	770939766	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:37.589118+02	2023-06-14 09:49:36.332786+02	00306000020fif6AAA
76849803-c599-47bd-9530-f07c9fbfa95d	Immaculate Nakaayi	$2b$10$eOIO68GUlqDOTb.XnEddzemyKSPE0zGHfhjxMQx.3/Bsj4/Ix1dma	\N	701685732	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:37.931977+02	2023-06-14 09:49:36.373631+02	00306000020fifkAAA
460e7973-092f-41a8-9905-241c976c04d8	Albert Bula	$2b$10$rFEmrnUtBQl8Gn4y5hO1q.sab7rPE/1ZM12MTSooEvy53RuRhzyYi	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:04.759019+02	2023-06-14 09:49:41.738612+02	0031o00001lRdMPAA0
d19903b6-9552-498d-bec6-03a6433588d7	Feyisel Husen	$2b$10$Y8gol1vXZxtkT/Qvi907euQSi7xbteFlF32OPiApY1M0hu0I25Ypy	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:49.592925+02	2023-06-14 09:49:49.814885+02	0039J000002Pf5hQAC
960ca9e4-5deb-4e9c-b78d-e3f0c41690b1	Alex Mulambuzi	$2b$10$V1l5.w9/G6Jj17RqeWfECOYf2lKIxLIvEp0G8orEMPe9RNK1NWawG	\N	705112048	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:38.636067+02	2023-06-14 09:49:36.751006+02	00306000020fifvAAA
4d3813a5-9a33-4d1a-87ac-04ca6335f2d4	Hamidu Kigemuzi	$2b$10$PcSWOApjuXhORMHzd5Wkf.jEjKXOa1xXjTkCNtpBt9Snw6BdjJfcy	\N	707556123	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:39.104573+02	2023-06-14 09:49:36.793552+02	00306000020fig0AAA
12ac57a4-a10a-4403-9665-a59e51a95fdb	Eveline Nambaziira	$2b$10$dsHXQ8SUVS8Bh/Y7pim4X.r.NDCKhaOgiSt4Y8ri6RjfhjOTBXWKa	\N	784575237	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:39.123352+02	2023-06-14 09:49:36.853106+02	00306000020fig5AAA
d0884bfb-59e6-448c-b38e-102229d15c21	Sylvia Kwagala	$2b$10$/I/XdfkmXrDRAHEC46RfE.a0kKBK1micSbIVjiGxuPufTZlqrmj62	\N	700392276	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:39.141618+02	2023-06-14 09:49:36.885567+02	00306000020figAAAQ
676c5e0b-2af2-4635-9e94-a297c5785b6c	Agnes Apeduno	$2b$10$8GQuYH0GpIPN.aJ9ZdrVtu9bONbufGI/N5zFTGrNGJlH6zHcyTRSq	\N	777079777	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:39.161921+02	2023-06-14 09:49:36.933317+02	00306000020figFAAQ
31b86af2-6168-4304-a91c-930a007b836a	Yeseri Kamya	$2b$10$yXj4vMd1fyHiQFCxiU8/COrN4cV9DrQyRQ3nSD2h3PgAoT.5xkgX2	\N	781517147	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:39.599863+02	2023-06-14 09:49:37.034051+02	00306000020figLAAQ
a3a5168b-a936-4210-b11e-4bed6ddc8557	Salim Sekandi Isanga	$2b$10$OSRXdqvrKISC5Ym1gTwETuLXspgdv8WlZ7FJZbc/2chKhAHKbJ/ie	\N	703285168	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:40.055961+02	2023-06-14 09:49:37.081862+02	00306000020figPAAQ
51dca4f5-73c8-42b7-a622-9ccb5004b493	Emmanuel Libakale Minani	$2b$10$.fRyC6guwLieGfS/H5dw0e8pTcuVo70RIJfZLK1N.gTQQquuwuTAC	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:40.733929+02	2023-06-14 09:49:37.168707+02	00306000020tCJ5AAM
40b6d405-66aa-4123-8c81-246bdb8c787c	Mapenzi Bora Christine	$2b$10$irtlILo4iQX1HqXwFI1/IOYGPvwygGiS.bOgNYZWzYCBjrK242ZAG	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:41.074924+02	2023-06-14 09:49:37.229006+02	00306000020tCJAAA2
98f6cc79-6d81-4764-8ad2-72407cff849f	Nicole Bulonza Mafuko	$2b$10$a5UpTMU/LrQTHqwpr5l.j.GyQ2wFdrnKr2lS85Na2dOUisb9My.UW	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:41.330008+02	2023-06-14 09:49:37.267472+02	00306000020tCJFAA2
f4acd08b-c5cd-4512-a524-9e435016d154	Sourire Tumusifu Likale	$2b$10$OenuvHO6h8RDLS2S.fAA4ueEvWc2KsI9za2sy9C9CXAdXn0NzjYAi	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:41.597668+02	2023-06-14 09:49:37.31619+02	00306000020tCJLAA2
9746663a-e27a-4c28-9fd8-a55c3d0cbf6e	Zawadi Baguma Valence	$2b$10$9KnsSUFRUmmGnhkMYbC.muOqa/0bZa6iEUKlVfz1.UsmFSGCUZ5ki	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:41.871974+02	2023-06-14 09:49:37.347156+02	00306000020tCJPAA2
7966de22-4373-4332-bd41-35ce83b3e221	Evaristo Nuwenyesiga	$2b$10$zEHPvHbnOBkkBA/IgMmSaO1ZC152qyF9xQFUjePOQOWR35IQkBn9S	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:42.12885+02	2023-06-14 09:49:37.383049+02	00306000021sX2RAAU
24f97d75-8f74-434f-b542-9977000b5a86	Shilimat Yimura	$2b$10$wwcFaVUpUK./xxlVFgRs3uIYPV/HntXu4U.iP1B2OH2qr0cQvsskK	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:42.711219+02	2023-06-14 09:49:37.463567+02	00306000022HppKAAS
454ecd80-a947-485f-b9c3-7bfdc66a84fb	Teshale Muluneh	$2b$10$WWpnO6UI.K8NVCDT2xuDDuhp1MtcoQHJMbghq9jz.BTcREBmdVgWy	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:43.096526+02	2023-06-14 09:49:37.576453+02	003060000237JO1AAM
0d34eef7-2672-480b-9f0a-4f430b7677f6	Gizachew Bogale	$2b$10$kcpQzBSR9uss/Wf.KvJzRujuR7xxLLSaHogR4cccjqBtWxBEGL5/u	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:42.391251+02	2023-06-14 09:49:37.427751+02	00306000022HppGAAS
ef7a30f5-5814-4183-af22-22cea40bc834	Adéline Tusifu Kavano	$2b$10$rHUp.Avx9luN8G9QxQDxBeSG9Gc.9PMgIgQleYTz4C2cf87AeG6UK	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:38:43.929667+02	2023-06-14 09:49:37.762753+02	00306000024klQoAAI
a8b3f199-0877-43f2-9d5c-2c6a8a2db146	Elias Ergato	$2b$10$wQEts7QJlpofrq00uUD4v.EvnRCRuhxJZmLi6XxUw1UIdL1ONgqVy	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:43.417909+02	2023-06-14 09:49:37.626028+02	003060000237JftAAE
7dac661e-03f6-48ae-b12c-f5c194453d74	Justin Ndamwira Malekera	$2b$10$ZWz4dNfElsv.wix2zMRE4uwrLDyfmEK5WRmGAEck57ezdU8nj.zDu	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:43.702911+02	2023-06-14 09:49:37.74434+02	00306000024klQmAAI
c2555ffe-395d-4716-9f22-34c553a15628	John Baptist Mbarebaki	$2b$10$eBxeOFNxgRM5tlIbBnt84u88SmA.IoqbfVp//s.OGCvNU59EH8hua	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:42.900981+02	2023-06-14 09:49:37.513513+02	00306000022taP3AAI
c01d40fd-b4e3-4392-96e6-928127bad830	Harrison Kariuki	$2b$10$cu4K1gh9T8NBHxY5Zoe.0e3SNAnEtljEla8ARPdF2NSimzZ/vtFVe	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:38:44.196742+02	2023-06-14 09:49:37.827404+02	0031o00001T4njPAAR
7f343533-cd0a-4bd4-9f61-d37ea9359d25	James Murimi	$2b$10$n7CcLGtF1yNeacqiyx20L.5PEQTnRIC2mxTfcAZ.hN.Wlu3L.figm	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:44.520252+02	2023-06-14 09:49:37.856271+02	0031o00001T4njSAAR
7adb7e73-0a65-4129-b126-85233664fc98	Zelipha Muthoni	$2b$10$bWakhauyc42SBK18XXpx4.iVeZKUGmlpitiYbp2dLTjZh1Sza5XCu	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:44.752444+02	2023-06-14 09:49:37.923655+02	0031o00001T4njZAAR
42261310-302c-4f74-89c2-0e1bcfd57c6c	John Kanyui	$2b$10$ToSi8NgWIPp3sHE3SUZZ0uyJoSLpeD1DNqr1vXH2cMyOHWA2QOHYO	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:45.104704+02	2023-06-14 09:49:37.956893+02	0031o00001T4njcAAB
43a8eae5-0d07-4567-9251-f3c0087402da	James Githinji *inactive*	$2b$10$5ZZSA7a4lzahiLl08Oa2Suhdl7FlxPIh3QtHVQzl6mRQsobSfkmlG	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:38:45.376583+02	2023-06-14 09:49:38.058266+02	0031o00001T4njiAAB
3330de0a-d517-4571-ba7d-fb62e89b2958	Arthur Ng'ang'a	$2b$10$NJpiodSt7y.SxPU5X9pcoekbWCT0Ac0i.mOepWsHo0c0cU/sy0t7i	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:45.584985+02	2023-06-14 09:49:38.154807+02	0031o00001T57OKAAZ
b133b211-0b29-4bb8-b098-f57c1ab8109f	Mary Mbuve	$2b$10$wcP923UIrfaEHDLXCxzbLe2Yj9AzvLpoOXXx.wWS/dr0s1xvjZ/si	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:45.866477+02	2023-06-14 09:49:38.192505+02	0031o00001T6651AAB
8f177132-89ef-4cc9-8815-a89845009bbd	Collins Kanda	$2b$10$NSXMAY/V8IoS45a6qynZmuZ/izdhFzs0HyQ8EaxEogyCOQ046QV6C	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:46.138058+02	2023-06-14 09:49:38.238652+02	0031o00001T665JAAR
f5414dee-db72-4812-b553-68359c9fc0cf	Everlyne Mweru	$2b$10$g6qCA3eYiOiUU4ysO/BzyO/ZTEJWkeywJrGzUxdUsjdTRaRRipzbq	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:46.375731+02	2023-06-14 09:49:38.272122+02	0031o00001T665OAAR
a0ad27ff-a087-43a3-b140-c822b085a977	Jescah Chepkirui	$2b$10$osT1jh8cOrf1bj19f2OVGe1jGBa5AKUhhUI/4MW79XIf7gVXK9GoO	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:46.644903+02	2023-06-14 09:49:38.292792+02	0031o00001T665SAAR
3cea772e-e7b7-4e8d-af0a-4b84cfd36584	David Ojara	$2b$10$1rBFeLJmrZtyRICIWQc06OTQEClwPIFlPE8.F0Zg18GSjDmA..MHW	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:47.016085+02	2023-06-14 09:49:38.389645+02	0031o00001TKKmuAAH
5b0551c2-28e2-449c-8cd3-6aae315f6fff	Hayat Adem	$2b$10$xiEy8WYC/qO8f84ypDIgoe2UPYMmuigKK4t4JaWgLPBe0gDaGbizS	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:49.823305+02	2023-06-14 09:49:49.831128+02	0039J000002PgXTQA0
990452fb-338a-4035-8442-c320f1ccfc4d	Mamadsali Aba Simal	$2b$10$A8pmW8HSw01wA00fgLPo8O8M.r6WBuurhn4cAdUu7t8BCYTvE/nF.	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:49.853307+02	2023-06-14 09:49:49.844483+02	0039J000002Po7JQAS
4a3820b3-eff6-47b1-bf80-0c8d49282b8e	Miftahe A/Lulesa	$2b$10$YDlWkPJqp7YE9uJq3C.DXe1OQF2EpWmYj3NNjKWnxOmsF3uNZD7EK	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:49.931933+02	2023-06-14 09:49:49.85118+02	0039J000002PpwAQAS
5611aff2-cdda-416b-b2dd-ff91f94852b6	Hikma Kemal	$2b$10$oeEudSnPaaCVLy5zODpGh.b/V7n.jl2LrBQBaUi4PIMIdE3sUAJme	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:50.089706+02	2023-06-14 09:49:49.866084+02	0039J000002Q5ChQAK
98e0d00c-b89b-4b9e-ab2a-df7cfe4aeb08	Abdulbasit Faris	$2b$10$l/7XheZgxThlTKRSJieDHuAJCGK97B8iraqojzg9rrPQ7xOGzbNB2	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:50.432355+02	2023-06-14 09:49:49.885035+02	0039J000002Q7bMQAS
10f8e01d-5bd1-4992-ab11-13c9a7510036	Rehima Aba Fira	$2b$10$in5Iz.Wm7kJb5J4Qvpurnutbme0J.zy9n/FLElNQT76UGhy2gmC7y	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:50.393805+02	2023-06-14 09:49:49.895238+02	0039J000002Q87CQAS
6165736b-9736-42c1-9078-4c6ba26b61ee	Karim Tenhwa	$2b$10$toVXVAvrkmxZNSbcacOecuz29NN9JvrxmY7Jz7rUtSTirPk2Jl9e2	\N	788276928	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:38.002284+02	2023-06-14 09:49:36.582583+02	00306000020fifnAAA
5f77acac-3d63-48d0-9ae2-f7d19b59e187	Moses Matovu	$2b$10$SWYQxaEeKU96Bqw2g9p4HuKXjtPRJZFVeux7Egnxmj/SXcvAW3twK	\N	789591270	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:38.309655+02	2023-06-14 09:49:36.650745+02	00306000020fifqAAA
6cec0609-5e13-406e-9763-070f5c450774	Muhamadi Kwiri	$2b$10$P4fyxk5rCcrltpPW4kuHouPzW2.W0KD0rWsRjIatT5TmnbnwTl44O	\N	777176128	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:38.739254+02	2023-06-14 09:49:36.761761+02	00306000020fifwAAA
32a75d76-048c-4feb-96c6-de1d8feee6e3	Herbert Kijambu	$2b$10$OgI2h2FdY9yA3K9M0UWpuuEX49QAYjDEOQfSe0kvlgUt2hgIzv5r.	\N	758044012	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:39.108225+02	2023-06-14 09:49:36.798306+02	00306000020fig1AAA
89854764-2fe9-4cc5-a581-275b46c883b5	Hussein Kyeyune	$2b$10$jSu3EQ/IkSP7fOFGkYwiPe2viKqAGSZoaZ76xRf.kzFG7X17K3hQS	\N	782979703	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:39.126946+02	2023-06-14 09:49:36.861837+02	00306000020fig6AAA
117b0742-9816-4942-9f3a-43c3cb1c58c2	Ronald Mbodhe	$2b$10$ivZUIgM.vF6w9OhSTIDRYOLI5P4HqiC/r95YTzTHg7HS9GcU.wpE.	\N	755696729	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:39.145352+02	2023-06-14 09:49:36.892375+02	00306000020figBAAQ
e7f6f57c-2071-4d1e-be67-38008d3c4fd9	John Francis Kalule	$2b$10$Dr4Z3R1uruUNFOTpzJ3nluTBSWz73Sw2/BdP8VhOO8DJgLq8neH6q	\N	777814518	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:39.280856+02	2023-06-14 09:49:36.938984+02	00306000020figGAAQ
be3d8b66-ad50-4bc6-8ecb-98e4f3c67cc1	Sirive Chabbi	$2b$10$XkHc.me6e7nW8OjwUptVKONxNesubuaRh5b8tCUyEaaflcf.pZw/2	\N	784919758	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:39.728866+02	2023-06-14 09:49:36.99309+02	00306000020figKAAQ
bca27458-3317-454d-a68b-3c9d17f01eb0	Aime Ndatabayi	$2b$10$qIQ7.rGggax2Q7fiSP.zMueQaWReiYe0oPfW/w9qt8T0EqdXHPg8C	\N	977899726	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:40.10169+02	2023-06-14 09:49:37.093005+02	00306000020tCEyAAM
9a82fea8-e5c3-4f24-9f4f-5a01ae77dbc8	Bahagaze Koko Dorcelle	$2b$10$LZGQqE/R/X0zepO1Py13aO9sq0PFLt/4cFbIgpaE8grijQrG3d62W	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:40.387202+02	2023-06-14 09:49:37.13072+02	00306000020tCJ1AAM
bd71e0bb-1b54-4847-84ca-d774b2ceba3d	Esther Chanceline Mahusi	$2b$10$C2.j0JKO1fTFxPrbFBsyH.wtzKlzx5zzjRcYKGARg.wWiTYMhI4cW	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:40.785618+02	2023-06-14 09:49:37.182828+02	00306000020tCJ6AAM
288b271e-7ff9-4b32-87a2-13210addb22e	Sadiki Bitwayiki Jospin	$2b$10$8XDC//PyrnfaNo6ZIJBczeJ4mGA2Ih9sQe4GKKMmwcyjSdQG.l.d.	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:41.372602+02	2023-06-14 09:49:37.278162+02	00306000020tCJGAA2
cb964769-72de-4079-802f-37ef24562703	Shamuka Mulezi Marc	$2b$10$BAN4aDrMsjKN5X03ffPfeO/7m/CaimU2XYAaUAVRdzdiOLCMRfI.i	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:41.666184+02	2023-06-14 09:49:37.297388+02	00306000020tCJJAA2
833207ba-0a0c-4e37-8be4-6e7d6a8b7305	Aimable Shauri Midumbi	$2b$10$hNGyqpLxVf.CaVz87MnX7utzz446tKeGvJyouRPBLR.ciKpPrqvhO	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:41.927639+02	2023-06-14 09:49:37.357175+02	00306000020tCJqAAM
b6b94eaa-50b1-480b-9691-7328d88220cb	Christopher Byabasaija	$2b$10$KZ2CvvPTHPwoGY/hO9LiFOrlv3yCU.tuHm125EmbdKsYCpe9MsZmG	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:42.192006+02	2023-06-14 09:49:37.391002+02	00306000021sX2SAAU
3f0d8319-9ed5-4f2d-82d5-eb2c9c9e5888	Matiwos Mengistu	$2b$10$zyEQRXhabeZrMsBARpyoD.q3X2PCKp5vcQNy47Y1dDXYMsgsy3rPK	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:42.445494+02	2023-06-14 09:49:37.442103+02	00306000022HppHAAS
c171fb4a-4fa5-4f33-b0fc-99bbb79f10bc	Mimi Fantaye	$2b$10$DVe11yI9Wf6XRf6ra7WUIeZQXAHPhM3ZVJI.03Kw43rQ6FqtDNsce	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:42.742806+02	2023-06-14 09:49:37.481853+02	00306000022HppMAAS
63711dc0-2969-485c-8bb1-126b66ac719f	Racheal Kyobutungi	$2b$10$7lXPrN0uAF4Wz./6V0TZfuz7VF5h/j7EHPm135coL..x5a5Eua9uG	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:42.930413+02	2023-06-14 09:49:37.524194+02	00306000022td5fAAA
55a3bf29-9ca1-4053-bd8c-20c81a09bf35	Cherinet Dawit	$2b$10$jklJrhF8WNUNnkfcyR6AXO7zSvxovRqNsp51mhBLNedBc1mQAl4Qe	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:43.151405+02	2023-06-14 09:49:37.560804+02	003060000237JO0AAM
0c01a14e-040c-4ef0-8ef9-41bf75fe1501	Meritzi Pagan	$2b$10$RfmCl2/HZydbmGZ1IfNXbutsqXGKyN9sr1JOjW7Q5rqUgEnNPJ.Wu	\N	7873176617	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:43.461487+02	2023-06-14 09:49:37.643146+02	00306000023rEfDAAU
560d5e9e-c212-4a66-b8c9-59bc06b8cfd8	Valence Baraka Kasidika	$2b$10$5qynr.FgoR2qtaDQ5wxMK.4mCrcaXP6Dhx4nzRLeeevqGRJ9QSCVG	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:43.724662+02	2023-06-14 09:49:37.714891+02	00306000024klQlAAI
1bb5959d-47c5-431f-9d12-874ff8e2a21e	Jim Nyaga	$2b$10$7oyrjsA4ew3kht2ypy98XupYhAena9w2nK6Jx9pjddZLYvAmYrUmK	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:43.976949+02	2023-06-14 09:49:37.791383+02	0031o00001T4nhgAAB
c2213f79-9d83-471f-b1a3-628fa8713515	Eric Muthii	$2b$10$d.ennwcCb8lutTzukgw0WOOm5mCC.hcXLUIgaVyn9odroU5xUk20e	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:44.242698+02	2023-06-14 09:49:37.822088+02	0031o00001T4njOAAR
594d3f63-4de0-4f1a-94b7-f7566d3b39b8	Millicent Ngatia	$2b$10$Gxrz4Njrt2P.1XzNQN8y5eK0/ZO/E2BD.WF2QctbK36RGJH37svnW	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:44.571492+02	2023-06-14 09:49:37.86008+02	0031o00001T4njTAAR
281b91fa-3065-45dc-8b30-4c1d90527309	Lawrence Mwangi *inactive*	$2b$10$pNP1dLDxrChtMBfC/zKNlOKuuxM7kFakriuCKwnsvvknrntqevRRy	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:38:44.782833+02	2023-06-14 09:49:37.909879+02	0031o00001T4njYAAR
3c06f1b9-95c4-43de-8f19-f8430f76d311	John Kagai	$2b$10$Jdhq/kd.i4RHtp827oUInerTALSBWz48PPr6RE04hEDyq0EaGMJIG	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:45.17306+02	2023-06-14 09:49:38.027329+02	0031o00001T4njfAAB
f976b6da-883f-4399-9482-ed470a4e1bfe	Nancy Gaturuku	$2b$10$RAV7Q3NSOydThrV0EtBiX.3PlJU2t1tA/Z8kxjzQ50KWY/bNqkEb6	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:45.42028+02	2023-06-14 09:49:38.106586+02	0031o00001T4njlAAB
e2cbef2a-2c7e-4e04-9a49-b944978f169e	Eliud Gateri	$2b$10$4zMO9uZSutFtxDrEQ4TQs.hRFej2YS2mWma1JLQtmTC.Uje6pa91K	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:45.651466+02	2023-06-14 09:49:38.12687+02	0031o00001T4njnAAB
8cdf840f-117d-471d-98e3-6a53e35f7e1a	Charles Ng'ang'a	$2b$10$uqF6wYEKayvOjspykDclXeCLcTDXBkpTqYnOiDueaVeX8w7aaTS7S	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:45.90909+02	2023-06-14 09:49:38.204557+02	0031o00001T6652AAB
ca289fb5-80a2-4d12-84ce-2e2b14a0b04a	Denis Kihoro	$2b$10$2Hwr4cvabbdYxI4ZtzG8Ruhi4c5Q.KVLpElFV2k3p1BLDrAwkwAwW	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:46.191556+02	2023-06-14 09:49:38.244568+02	0031o00001T665KAAR
9b877b71-d63b-4bc4-98dd-b828728df51e	Eunice Muchuna	$2b$10$advxCC6NSz/XRqZ.tbvXdeybmskD4dwhFzQmKb3qnKEkFnClAsAbC	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:46.42337+02	2023-06-14 09:49:38.260536+02	0031o00001T665MAAR
d6364dba-0492-47ff-b753-622eaa5bf4bf	Mercy Cheruto	$2b$10$Prk8Go9m71n.9g9yXTQMfupvW2qn4zLyLUvVeE8VgfaISGEgBGl3S	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:46.81841+02	2023-06-14 09:49:38.325376+02	0031o00001T665VAAR
7b3f0290-ace9-4876-853c-6443621a669e	Ruth Mueni	$2b$10$bVmWDTmYQz2Z0nFzWeOoyuihS9.2tSZwt25lXIzV/C35Ei9rOg46K	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:47.075568+02	2023-06-14 09:49:38.370978+02	0031o00001T665YAAR
a63b8aee-e49a-423f-9777-279b750f5853	Joel Kakaire *inactive*	$2b$10$OVkNiInuFXRhg9ci9ZEfjeMZ5ECN1jNIOkrj3otzc3uk405CydTWC	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:38:48.128578+02	2023-06-14 09:49:38.409269+02	0031o00001TKKmwAAH
76e9e0cb-8545-45e9-ab65-9ef719122602	Ssemaganda Geofrey	$2b$10$fv2YpAJgMyKYbrLuIuXETeXAnXR/i86gqr3Hf5mKJAj4pMCMNX.y.	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:48.201098+02	2023-06-14 09:49:38.418207+02	0031o00001TKKmxAAH
b473eeee-1719-429f-9bec-125bf2c576a6	Jawuharah Nambabaali *inactive*	$2b$10$b6QRpr0ZJqwRR.hxHKqza.ZNxd4uJkvUfjT5nwYIH1bJLkE073IBK	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:38:48.263487+02	2023-06-14 09:49:38.425108+02	0031o00001TKKmyAAH
f53fbacc-1e58-4550-80a5-5c7112de1af3	Kasozi John Bosco	$2b$10$J6mQ1U.wO/UqzVvF/JckMOgFVn6yN2mFyQy7wsHFralf2U/0WL2w6	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:48.321018+02	2023-06-14 09:49:38.436447+02	0031o00001TKKmzAAH
e84871fb-bdb8-46f2-8ab0-401b091c070d	Namatovu Jalia	$2b$10$ZxVoBdQTmkstFaSO021jmuUq7kJY59AVZzcgjut0QkF3KDvI2vufK	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:48.453418+02	2023-06-14 09:49:38.456828+02	0031o00001UJ3yRAAT
cd9eb4eb-43d1-4edc-98e5-36f3f0d391fe	Nambaale Godfrey	$2b$10$qS0wjsrryFMy9ykFlE3AkuUOUHBcQDmm3Wp1/7UHkwNaC47Qz7G3W	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:48.375392+02	2023-06-14 09:49:38.466856+02	0031o00001UJ3yvAAD
d5c407f5-d9b4-469a-9b95-dcf338d838a6	Enock Mwanje	$2b$10$jxrbp5..qMXrP6BUwFzwwO1KgOzZsZytYYV9IfiYj16zbXFS998f6	\N	756818458	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:38.065411+02	2023-06-14 09:49:36.431377+02	00306000020fiflAAA
91aa9819-63c5-46ab-b85a-31a1c924965e	Ibra Magino	$2b$10$FBOlT0/ModsJd.DcHQu2b.K6WR.5YliDK0ffvYYtKJJleX07hdbnm	\N	788117055	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:38.352435+02	2023-06-14 09:49:36.665002+02	00306000020fifrAAA
2d568791-608f-4fd1-9df8-546acf9448f2	Waliou Yessoufou	$2b$10$QR7JhCk4GxwpgHvULd.qCe12Oi.zzNG5X24JXhAdX3IBJ27Ut6lg6	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:49.718551+02	2023-06-14 09:49:38.568036+02	0031o00001Y78gRAAR
6545999e-b80c-4453-a9e4-d327dcd8e4bf	Marc Orekan	$2b$10$ejr.6jH.XkxorqVYjB.6s.eA.EeAbFFthe033X7P.RGS3qpB4KbGy	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:50.018595+02	2023-06-14 09:49:38.606493+02	0031o00001Y78gWAAR
f20bb495-fcc1-4f17-ac61-cdb44870309b	Romary Dedehou	$2b$10$EU9bVT.RpWSqT/HK10R7suh809MFm/6f5.1dWXseH7oFgJ2qaANNK	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:50.407014+02	2023-06-14 09:49:38.640467+02	0031o00001Y78gbAAB
77ca2c39-6dbb-400a-95b5-4ed507469952	Mah Rouane ISSAKA	$2b$10$kpItzfdqVc8gvvevJoSHRuZutdBiLTQBaW0ipd7Gg01mIbVJmUWXG	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:50.625886+02	2023-06-14 09:49:38.671963+02	0031o00001Y78gfAAB
ab7dfa37-68a5-4215-bde9-abcf17fb1112	Midway Bhunu PM	$2b$10$nuey3fVEfF8c/oJi21dc6OlRsVGSe3r0LwaiszrWxsysSnEczeXQC	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:50.984694+02	2023-06-14 09:49:38.720064+02	0031o00001YkGjIAAV
5f0c75da-33bb-4e57-b506-6db22d45ce45	Ann Karendi	$2b$10$YvJ0QmgogVIOPn0ZfAqIUOS9PsvU4jlnU/2WRQdovS9bO8viVkdei	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:51.354937+02	2023-06-14 09:49:38.785834+02	0031o00001YwN82AAF
08baaa9c-39f6-4de9-a038-b42122720a0a	Joyce Rotich	$2b$10$3M7K1bEAKry5lNdoUpXsmOuwz86GKuWDX82BSEb08AUhgSWplSng6	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:51.662798+02	2023-06-14 09:49:38.83103+02	0031o00001YwN88AAF
f25539a8-5807-4886-b9b9-458953c59677	Edmond Amani	$2b$10$peorq8kFYb0SroPANo15huVLkYvZz95V7XvN4tXIe0dwloAgVALKW	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:38:51.797852+02	2023-06-14 09:49:38.882386+02	0031o00001Zxz4uAAB
b08f59f0-bfe2-488b-8b03-7dc540e870c4	Jean Baptiste Mugisho *inactive*	$2b$10$ekqIQ/VIDKITiWxZ/v/BRuzGLxSZrxbkXehI8xF/dINnMBYA7rZbq	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:38:51.985313+02	2023-06-14 09:49:38.91899+02	0031o00001Zxz6wAAB
a0b855fa-e229-4f8c-a0dd-de6f48b87836	Christoph Kulimushi	$2b$10$iUEWbs8UrIl8.YDbKASUMe4/QH5cfTMRg0JI38o9AN3PnYoBvNNF6	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:52.196942+02	2023-06-14 09:49:38.982431+02	0031o00001Zxz7eAAB
997e657d-dd76-4b51-896b-4cde5ccb4e59	Germain Ntwali	$2b$10$sIehXUWiM84EDbCFj9kd8.D8w9dTn0E8StYmyxvvzG6D7MFrVAeXO	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:52.454056+02	2023-06-14 09:49:39.021002+02	0031o00001Zxz7jAAB
41ded320-7389-4bde-8abf-977b6fbc235d	Mubulanyi Wirhumana Alain	$2b$10$JvovpJGHYdeK4mrL17YUaeRbvEqDHl6VlC7Phmwg0NHJiT7x3SQdC	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:52.92499+02	2023-06-14 09:49:39.072826+02	0031o00001Zxz7nAAB
cf5db594-9d8c-47a3-bf51-8951d46912b0	Patience Cirinda	$2b$10$fg3/XdIV2QVp9dHwBySFIue.OH0eHTCJqNfJH9xdIsJh.HwjJ.2k6	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:53.145726+02	2023-06-14 09:49:39.106222+02	0031o00001Zxz7rAAB
43df0716-1c90-4735-9a6c-0adc772aab0c	Theophile Ruta	$2b$10$UbSGnwFEQK0fcIgL8jof2uHtWh54mNl0QNCEWeKOU.hFxgG7U8IXa	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:53.461978+02	2023-06-14 09:49:39.151998+02	0031o00001Zxz7wAAB
9b76463a-eaa6-48f6-8f41-51193dbd3141	Girma Tizita	$2b$10$RLYyFQUaA1RfU2PvXX434OU7ybC1khuWsGTO5xQD8AZu5iQ0af/U2	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:53.721795+02	2023-06-14 09:49:39.327995+02	0031o00001ZzvNXAAZ
68c3d32f-29ab-4a03-b081-03b38a9372ec	Ssali Emmanuel	$2b$10$3fNNZOLPlRyVymiXbnJSDOvX9H9tvCROtFbabDTSdIGVSxBZatWNe	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:54.119762+02	2023-06-14 09:49:39.595103+02	0031o00001a0dTOAAY
9be47012-fef4-4369-acaa-dae3511c75d6	Fiturinda Yoweri	$2b$10$Ref.mE4QCo.62q9YSMOcpeDaQa1nAkZtORI.FOWu7c0UoHd3W4hl2	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:54.403045+02	2023-06-14 09:49:39.662908+02	0031o00001a0dTUAAY
12ce5a4e-1dc9-4e04-b257-997699b3d84b	Tumusiime Evas	$2b$10$pEV2LfQZLsrm/3pYuW/nIuMzhh5jJk9zFcsSRWIbcyu0gKfAYAAjC	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:54.673046+02	2023-06-14 09:49:39.791617+02	0031o00001a0dVRAAY
9560820b-6fec-4eaa-bae3-883913f9cfc5	Tumuhimbise Evas	$2b$10$jqrJMEhWk8p7SI.nzDqyLebemrB2XGkHQfk/xrziJL65s8zMeh.Yq	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:54.935364+02	2023-06-14 09:49:39.877105+02	0031o00001a0dVWAAY
cf9e7ba9-11e1-4dd7-9d6a-c486f722712d	Adnan Temam	$2b$10$2/77twSY8kuzqpsvORaxX.cZktnm2WTU41qfDsZbtYxqXUw4k1rhu	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:55.517316+02	2023-06-14 09:49:39.945298+02	0031o00001gEM4yAAG
3a39acd6-4e96-47e7-bca4-65d5f8787113	Birhane Negash	$2b$10$IlWnw.pMM0gEbfujQZ1D3O/5NLhPpIQkGAi27HU1isHI6zOhWrRGS	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:38:55.819007+02	2023-06-14 09:49:40.032833+02	0031o00001i7jCvAAI
46e30d53-bc6f-412c-b85c-59140a2e9f9f	Yihunbelay Yohannes	$2b$10$uRm.Lj0QTVhCkUKpAvbEBuJ6q8jEkNTiDH2LOAPoFKUYgftmCtw3C	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:56.059454+02	2023-06-14 09:49:40.048508+02	0031o00001i7jCxAAI
49fde8c4-11d4-4523-a512-ead16015d206	Abreham Belayineh	$2b$10$89JJsYu9/qBVCEGGOyqCDOzWffDKXy77QZ5pDvlE6jOUrm5MqNeQa	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:38:56.343275+02	2023-06-14 09:49:40.099406+02	0031o00001i7jDEAAY
f6b9211b-a09f-405e-9d5f-f4c754591b96	Afrika Geremu	$2b$10$0XUyg.LQa/HUkJ5ZgCOcOOznBp7.SkNy2R026q19CTr.g2bUIRokC	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:56.611378+02	2023-06-14 09:49:40.141174+02	0031o00001i7jDJAAY
aab60fe6-a818-4053-b948-ff12cb6194a2	Anato Tsegaye	$2b$10$oTnr9Ha38P6egpVW1xqG6.ps83HDlQ0vjeNBZfutcB/b3HdCnT9TO	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:56.867918+02	2023-06-14 09:49:40.191923+02	0031o00001i7jDPAAY
15268ab3-591d-46f4-9d64-ca3d53da58a1	Asenake Lenjisho	$2b$10$L3Bz3fL2hYYm7U54Q5yUU.H1HUqcKA/xdRb.Yab787KMeDB9qzTq2	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:57.004321+02	2023-06-14 09:49:40.208054+02	0031o00001i7jDSAAY
42c7ac05-69e8-43d7-b988-375fe7b8a9cc	Betelehim Yohannes	$2b$10$QwaQAcurv5K7nCc60F3RReyOIE4karuK5KJ/nCmXb9SsItFFLYRBm	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:57.06339+02	2023-06-14 09:49:40.439359+02	0031o00001i7jDbAAI
a16bb9f7-a805-46a6-8746-5ac40887157b	Degsew Dereje	$2b$10$NV9nD.w4TDILNiQN8mJTL.khEwLjhl/iXg3rCtCV2t3BWUnxfKPGa	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:58.066619+02	2023-06-14 09:49:40.542635+02	0031o00001i7jDeAAI
409c1192-9497-43c5-ab09-dafec5ceb322	Derese Buteto	$2b$10$OcHanvWZaPOgVsAq29so1.XVxPqyQ5OlvuLF.NudX71/7qF30z/na	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:57.340777+02	2023-06-14 09:49:40.547791+02	0031o00001i7jDfAAI
41a8562a-f518-4667-8baa-3ed9248119d1	Genet Geremu	$2b$10$YOPy2lVbPVAeQ67OX6Dw1OFhBhq2pvWlqNSleOSgabyZ2egu2XH8S	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:57.60238+02	2023-06-14 09:49:40.603398+02	0031o00001i7jDkAAI
e1f4fa23-9b2d-4c48-8a36-45470400f549	Lemlem Beyene	$2b$10$XGiCvs/JIm4lBwJjRVvm7OkEXSKzpe/y/ycuo1u0n2A/WvjLVBqiW	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:57.834525+02	2023-06-14 09:49:40.720491+02	0031o00001i7jDrAAI
c9264288-4af8-4aae-afd7-f5b6d45ff2c2	Merid Markos	$2b$10$YQaSUjHQM3XxPfDvLgzroOmZIrmEp96YlD/xDKKs0/Ab6TxB5VygS	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:59.767585+02	2023-06-14 09:49:40.74532+02	0031o00001i7jDwAAI
86560f22-013a-4de0-8691-245b60cc67f0	Mignot Lemma	$2b$10$zqau8i2G/A4owOZIYFdZ7.fncnq2Zk7.S4.Km69JCY2NkB9.vk1ji	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:58.453716+02	2023-06-14 09:49:40.760627+02	0031o00001i7jDyAAI
1545bc89-e084-4c1e-ba11-16253b404609	Roman Matiwos	$2b$10$5lA6oClUmf7zeZibZSGANuKjEWBsS4xAaB0/Ib9Aeo9g7Ikb4ipeW	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:58.879522+02	2023-06-14 09:49:40.810024+02	0031o00001i7jE3AAI
d67a31a6-41a9-4a9d-b178-5e27ac4ea2dc	Tingerina Werana	$2b$10$uQGYcQFXkxzDIvqCjaKsQ.0S0WCpcHVlA4t9NENnTT8KOWR4auRAW	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:59.185623+02	2023-06-14 09:49:40.885154+02	0031o00001i7jEAAAY
e208a862-1168-42a1-8f7d-25f6b9a8ebe5	Yohannis Yota	$2b$10$b/tet95jsDlzvN0wHlZ2eOqlpWPpzdqVgyMxy3sjeP.YutcBNTG6m	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:59.484064+02	2023-06-14 09:49:40.940931+02	0031o00001i7jEGAAY
4c025735-dd9c-47e3-a662-07b2d0c03ce7	Gezahegn Tessema	$2b$10$SL5bBrJGbu2gNQAXZOjNhOWWxY.ezFOitZ2.85BByaqW5EjXkPcR6	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:00.277365+02	2023-06-14 09:49:41.026735+02	0031o00001i7jkGAAQ
9d87f74d-9aa8-45f0-9506-230c2fbaa6c4	Vincent Kariuki Mucee	$2b$10$Fj.kwTQr1vTYd0ToW7Awaez/LWv0I.4fN5y6bO.1pVTZIKYyVTmw.	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:48.721511+02	2023-06-14 09:49:38.508293+02	0031o00001VbqCYAAZ
7f8306d7-1928-4f98-927b-fc870e47da20	Kevin Zeigler	$2b$10$Yq0.Lu8oKM9IbRzM55.vc.7E2YbBmCGTxZJKUzA7s0hj4L7qjeia.	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:49.311766+02	2023-06-14 09:49:38.52101+02	0031o00001VcUcXAAV
b75df53c-a699-40ad-b418-839a50d966cc	Fresnelle Ahouangbenon	$2b$10$s6tgnnA0SSCrVItJLYIrfeOVbUzvWTKxOsfDv2kP61lDcL.TGbMQa	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:50.082691+02	2023-06-14 09:49:38.61849+02	0031o00001Y78gXAAR
7ebd1e3a-4529-4d09-9c74-691665839483	Camille Quenum	$2b$10$H9h8onO9HEgi5WOiW5Yq2ehzd87IFBRxZmrs6gaOvWZI/FUcsJ/16	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:50.462196+02	2023-06-14 09:49:38.65001+02	0031o00001Y78gcAAB
f7afdf47-92a4-4762-8a81-06a5f7a3e61d	Narcisse KINDOHOUNDE	$2b$10$jXmoCoQaNgZbNGGSyqrdYOufOC/qMtf7AlAPFAvrE4yVMwWP2hTtq	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:50.687037+02	2023-06-14 09:49:38.687862+02	0031o00001Y78ghAAB
00086397-b512-45a9-a6c4-e0b2e649abd4	Midway Bhunu	$2b$10$PdZn0mTHvhkkKlOgDxREb.eML23/XJdJGaEPV0nH1W6HynhNLejUe	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:51.027858+02	2023-06-14 09:49:38.725463+02	0031o00001YkGjJAAV
1d84a2e4-7c73-43cb-934c-5d5a8abb2083	Elizabeth Wanjiku	$2b$10$k8NiUrn.uqPK6/pPcMYq1uX3leH2Q9srCrPg5zE5rCaFXpFwEDZIe	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:51.456636+02	2023-06-14 09:49:38.80153+02	0031o00001YwN84AAF
be3f211a-d84c-48c3-beb7-890b219a63e1	Jerusha Njeri	$2b$10$vVPD6TMTHtVxMFx8o.twnuHVKEOdMikt0o/IbKZ14K3PSag3zTAxi	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:51.679737+02	2023-06-14 09:49:38.822583+02	0031o00001YwN87AAF
534a9df2-5dc4-4ad1-bd40-c4cf44f6e5b6	Chansard Kizungu	$2b$10$zA2EvK0iQSHibCMTt8G53emjXaoRLoojlFiF0pKxi7cfEkehIc/4m	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:51.817196+02	2023-06-14 09:49:38.897228+02	0031o00001Zxz6tAAB
c5d3af98-3101-42f9-a2e8-1b989ad98487	Desire Mulume	$2b$10$Vf/fIryGLIryez2t1TT7P.hS3r7nYX7/lMT68GMk.uOZQseuKj9Xq	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:52.244799+02	2023-06-14 09:49:39.001131+02	0031o00001Zxz7gAAB
a2d513fb-ef16-425a-a18b-bcfb366b0323	Jean Marie Centwali	$2b$10$LU0sGz17Sf.frqJe.pzZieHdjqzI6SfZDFcviUCgl0J2W0zF0AA1e	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:52.529493+02	2023-06-14 09:49:39.03092+02	0031o00001Zxz7kAAB
1ab8b36f-21fe-40ee-97a8-e9fa7ac90ea3	Murhula Bahidika Placide	$2b$10$zyeZv0zPY0ntTYvhJ7qUQu8D//t5Xa/qx4i/GtE0iUO21vkmqn9wu	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:52.982712+02	2023-06-14 09:49:39.086236+02	0031o00001Zxz7oAAB
63a8d56e-e5c8-4d15-8dc6-f62a5fa9106a	Prince Mugisho Chabira	$2b$10$0ZrmuVvOu7xw3a1phopsG.mlMOcY9Cxsr4GJJr7lXNcflwhGkNJHS	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:53.212137+02	2023-06-14 09:49:39.119255+02	0031o00001Zxz7sAAB
1d3ba84e-f421-4d68-9e74-1e4e6f7fd1a8	Yvonne Nsimire Purusi	$2b$10$53k1ACRS0gI5TYnk0hv6ZufkLE5T1rJUNgRWH0smrOtBKkzBf0fJ.	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:53.555331+02	2023-06-14 09:49:39.162671+02	0031o00001Zxz7xAAB
2877f1f4-58e9-4066-b712-455e733d95d1	Akot Jane *inactive*	$2b$10$mL2Jbe00fYHuRInwcFRO1.WWKun7iOjVj7ANCDgqFKoY9wnrjAfGy	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:38:53.766388+02	2023-06-14 09:49:39.383593+02	0031o00001a08pNAAQ
b5c55249-df5e-4c0e-b417-d494a498c173	Atuhaire Fortunate	$2b$10$Izot6sTXKntpH9U5UpmHtOYrcNvHQG8ejEYgeDeFKJYkqzHGDaP0W	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:54.182661+02	2023-06-14 09:49:39.61215+02	0031o00001a0dTPAAY
c6ef7d44-d1d5-4cc6-9868-f9c4d9519445	Niwagaba Alex	$2b$10$cvgZ8pU5ahVZCZ3jNPPCjOOO4/bEAfoD2jR52Y6tcaWX4bYXHJ3FK	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:54.471821+02	2023-06-14 09:49:39.652445+02	0031o00001a0dTTAAY
a71e3a6c-7c25-4423-96d3-d02d780fe115	Muwonge Julius	$2b$10$QWO8caU0l7rMd1hWhBXwdOGcNYNodhfadAPB002DZlibQ0yW4tXze	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:54.734964+02	2023-06-14 09:49:39.801863+02	0031o00001a0dVSAAY
58cee8e8-ab61-4085-ab6b-5b0bca5c9dd0	Matsiko John	$2b$10$m0MsPWUuoYaVW1a2fZ5mi..nYdjD30E5bURbkoFkwMDfE9LgEdImu	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:55.003838+02	2023-06-14 09:49:39.881529+02	0031o00001a0dVXAAY
42dde061-8289-48d7-b7b0-4be428d00ecd	Rose Caroline Nabukwasi	$2b$10$bTxoAOAhVxP1IybJfZVsLux2NN4uxmx4WAG69Hx7bcYxEAEn5X1.C	\N	759473773	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:55.312185+02	2023-06-14 09:49:39.92675+02	0031o00001gE7XNAA0
048e2e42-edfd-4a89-af75-ab2e30f4c317	Marvin Mbogo	$2b$10$oBR/0jlLcS8XvBegEDRfvOGGSKEKRTI8guV2g8P8cgjsPImQm/1n6	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:55.584838+02	2023-06-14 09:49:39.962541+02	0031o00001i5EWDAA2
1ccd6264-1123-43f8-95cd-65814c4c945b	Adanech Tumsido	$2b$10$mQcWF.QyjOwkUfGKGsz2c.AF5jbkgHNQeMDQlM3yEAhlQnNch5MDa	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:55.85202+02	2023-06-14 09:49:40.025394+02	0031o00001i7jCuAAI
e0199482-736c-4ed6-9a87-7b51108d75dd	Shewangizaw Shibire	$2b$10$bF0uudYKW6biToRV6LZ8Y.iI9YxUgc6QMbDx.XXYjsRI/lOa5d4NO	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:56.153489+02	2023-06-14 09:49:40.077228+02	0031o00001i7jD0AAI
cd4a7c1f-87e0-46fc-b502-250776b7cffb	Adanech Tona	$2b$10$BO.1Lvm30KXZV1pVLnFyWO0NfpRdDHrOw6zSk0M4wu/SAUiNm8Jni	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:56.403258+02	2023-06-14 09:49:40.111079+02	0031o00001i7jDFAAY
9b6ac224-e26d-45b1-a234-c224015fa437	Aklilu Legese	$2b$10$F7pLn.1QFBQeYyMNJIC18eJoh7E4XfTcBHlEofYqkQj9c9EtE9acO	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:56.673259+02	2023-06-14 09:49:40.145358+02	0031o00001i7jDKAAY
d415cc2d-c970-486a-b635-ec61c4d9f32f	Amsalech Farsamo	$2b$10$VMnHQzZ1w/h7pCJ6p/H6zu8ACgUYBKCYN9tloPIn76kSraZEOe8qG	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:56.879986+02	2023-06-14 09:49:40.182338+02	0031o00001i7jDOAAY
061fb81c-bf02-435d-baf7-7753285bcc79	Ashagire Hayilu	$2b$10$TEDiOKFJ0.RaouRtDykXPup2rSahflkm75JV3Q8/qiAbNat3lDft6	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:57.019075+02	2023-06-14 09:49:40.221085+02	0031o00001i7jDUAAY
51f480a5-070f-420c-820d-adcce106a2aa	Astedaderu Ashagre	$2b$10$0QVA2X1wD4.veFYSbyzJbOlAnD8pgAIJi0Ms2KShggMyCLhWSG0Dq	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:57.077192+02	2023-06-14 09:49:40.240968+02	0031o00001i7jDXAAY
649a4e81-25cc-4a15-aa6c-d85d7ddfa16d	Eshetu Gosaye	$2b$10$5iwSLbf2vBnaejfpWliExeM3ZSTPnNLUHHo2IgWRTLN2kNfur/A0m	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:57.39824+02	2023-06-14 09:49:40.569988+02	0031o00001i7jDgAAI
6e0e04bd-4a8d-43ae-b83f-c7ddaafb70f0	Girma Kachaw	$2b$10$a.rX8WqjS0tnYuOhWIAY8eysVaQB6s517dZ5le/bjxon3fBOJvBkC	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:57.632123+02	2023-06-14 09:49:40.610529+02	0031o00001i7jDlAAI
7f31b630-910f-4f25-b250-ffe1ac404aad	Hana Bogale	$2b$10$au4oqrooYBq2lx/aSS5FEexAexAk5yZTXlCR0U5lyJUIK/ZwCj6/O	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:58.12385+02	2023-06-14 09:49:40.668635+02	0031o00001i7jDoAAI
5d22efda-557e-425d-8dc8-1f1570318f62	Markos Mengesha	$2b$10$cyvqN5vaEl.cMYePVbJGae4IhF3.J5FATSbKB0jWCuzTbBmIMFPce	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:57.879487+02	2023-06-14 09:49:40.724988+02	0031o00001i7jDsAAI
6ebd3fec-82e9-4c72-8f59-f355c61d74e9	Mulatu Mamo	$2b$10$NG1QMEMQihF9Ww8Roucwn.Hmw.Jlh91JrN9Kf7PsiXaSJrqYSMJyG	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:58.567685+02	2023-06-14 09:49:40.769971+02	0031o00001i7jDzAAI
b47c960e-18ef-45d8-9c83-513335a9a0e9	Shimeles Mulugeta	$2b$10$smw452uIDZB63O7AqVJek.upU2hzwg0QOzZIUT0nL.bKDVG2mvSfi	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:58.942987+02	2023-06-14 09:49:40.835449+02	0031o00001i7jE5AAI
eb1db972-bf81-46dd-9f1a-c8364836a779	Simagegn Seyoum	$2b$10$WQejwknIAn5QHSyEeyNs1.EcpYemulQ14rS5kp847vkmat.sIOrke	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:59.865051+02	2023-06-14 09:49:40.840682+02	0031o00001i7jE6AAI
25823e9b-7dbb-4098-b237-4c690dcd6c3d	Tsehaynesh Debaleke	$2b$10$mnu9B9cYRNN8PzwlaEBOde.DFT7TSJvV3X8sfNtcXzw96NbBghipq	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:59.24085+02	2023-06-14 09:49:40.91774+02	0031o00001i7jEDAAY
a6338d9b-005d-4191-9f34-bc95603c2ea3	Yosef Shunta	$2b$10$th3.JTSl0K28PeLmLo4V3uKNWeyPIiXJdm0MNJahAZ0AVNDV/umgu	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:59.515068+02	2023-06-14 09:49:40.945237+02	0031o00001i7jEHAAY
49cad745-8fa1-400c-90d6-f8712801a4df	Fikadu Sori	$2b$10$3pNI3/OVJ/Y6KQMY7fTjLeWc3NqEN4gbyIj7jvmm/FXou0oaq1Rmm	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:00.354028+02	2023-06-14 09:49:41.038164+02	0031o00001i7jkHAAQ
bc70b2d6-dda9-4912-aa80-c2976cdf611e	Amida Aba Temam	$2b$10$cdOonsdIN8jrQQn2MZ2IkOIgNPwghXCLl6ix2S8Kf/jxIjg08s1L6	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:00.655884+02	2023-06-14 09:49:41.086018+02	0031o00001i7jl7AAA
22087d50-1866-42e3-b647-72466dc63334	Gregory Valadie	$2b$10$nzh.H0nULeWlU7de7tlzv.9KRCVjEpUQLoYeLtG7ZlnviuQB8HlgK	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:49.415867+02	2023-06-14 09:49:38.532182+02	0031o00001Y78gNAAR
70547933-27da-4bbe-87e9-6ad2246665a4	Amelia Houeto	$2b$10$.hYLwo78N0J4C7rrGwjl5.Rf2RmQYU0N42oYaqp/yiwcVoG/F7w76	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:49.755054+02	2023-06-14 09:49:38.572687+02	0031o00001Y78gSAAR
e811d1e0-7614-40e4-8bb6-5bc864e1ce9b	Nicaise Deguenonvo	$2b$10$MLy5IP9tnBIilcjtEvdWsebzj7zJ.MarwsLkzSRp7f7bh7H3JiqxO	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:50.224037+02	2023-06-14 09:49:38.621864+02	0031o00001Y78gYAAR
1abeeabc-4ff9-44f2-9892-ef8818ed3b0a	Bernice Amadou	$2b$10$tnOHNQ2jZu3.dQbHt5Z4fO432sI6PJWJAeq41VPkEiqQuQ1owbVVy	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:50.502047+02	2023-06-14 09:49:38.655532+02	0031o00001Y78gdAAB
68bded54-e34a-43df-bad1-fff40c8b97f4	Mocktar BABA DOUADA	$2b$10$KUjFA4UWKN0p7rpNvECyfeuHz6p9/L4KakYqX0T0SM22nzAYRD2Su	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:50.739976+02	2023-06-14 09:49:38.69863+02	0031o00001Y78giAAB
9e60e346-72ce-462e-8a88-cc8884f41731	Barnabas Chikomo	$2b$10$6YkfoROhnex2xzFfX6bXTuP8kX36ZQl.8eAblbesxgqp3rdPYMo0u	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:51.080259+02	2023-06-14 09:49:38.737635+02	0031o00001YkGjKAAV
dbf17da1-2007-4659-abfd-83fb78d839e6	Ann Karimi	$2b$10$JYue/Me.e3.3ydeBX9ZS2eepdZrDUAwgEOSF8b9ER3M8CocEaytA6	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:51.543519+02	2023-06-14 09:49:38.793108+02	0031o00001YwN83AAF
14818da7-8a59-46de-895e-602c40eb078d	Priscilla Kendi	$2b$10$jeipnpZJGNFiSjIYAUuS5eJa.xELo1/txRteiNrMVFrNzU8gq05jK	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:51.70662+02	2023-06-14 09:49:38.838955+02	0031o00001YwN89AAF
cf3c2b9f-9d25-439d-9452-e1d27dcb6d63	Purity Chepchirchir	$2b$10$mtqRlv9gItnv4gkV99/kZuxhpNJu9HCmUIHKH4sBV2G2IqloQ.gli	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:53.024721+02	2023-06-14 09:49:38.853534+02	0031o00001YwN8AAAV
120ad67e-2a71-4c0b-ba49-60c88580f2d0	Lyliane Bahati *inactive*	$2b$10$J5vTPzwF3IMa6U/59ILJ8Ot9Ogd60nnpaZ71N.GGf/i/jkYjYijsa	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:38:51.85048+02	2023-06-14 09:49:38.886753+02	0031o00001Zxz6sAAB
6575b073-386d-44bb-a36b-904129794b0d	Bernard Mukengere	$2b$10$W2N6/PwR8ah3XGVrVBQqJ.ofcDmQjNCxHRkJxm8Abr9qq1oa8f5Wm	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:52.050799+02	2023-06-14 09:49:38.947553+02	0031o00001Zxz7cAAB
1c0873ad-9b07-4c48-bbff-ee72aa626579	Cubaka Shalukoma Marcellin	$2b$10$VckrSEIwNO6ckgj3h0tNoOqXUoQIDR5bs.Rnv4DNrRgDghn0l67UW	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:52.27868+02	2023-06-14 09:49:38.990334+02	0031o00001Zxz7fAAB
bb08936e-42a8-4a9d-a555-0f4bf653fe83	Jean Pierre Byamungu	$2b$10$Xrb0RRBkD0iuf71BJ2.tbe4gxI.SWaryxHHvwvzUdUvDDMFOrJv2e	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:52.673385+02	2023-06-14 09:49:39.053832+02	0031o00001Zxz7lAAB
2477c988-6898-45fd-8cac-adbe23353541	Ronsard Ajabu	$2b$10$xu8C2mmnbe9rJxHrWpePxeMXj.klAdONBeo7ETyhi5ZX7stipZ1Dq	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:53.304179+02	2023-06-14 09:49:39.132095+02	0031o00001Zxz7tAAB
50f734d8-b8c6-4ef5-90e8-d1434bc13a8a	Sophie GBESSO	$2b$10$j/P93sdzfL/F6tZX9MzAae51v3sJb1xcqtq68U3fNT4zw.XFlLLp2	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:53.592693+02	2023-06-14 09:49:39.168197+02	0031o00001ZzoawAAB
8ffcae79-b0bc-49ca-87d3-bf0f4133ad44	Mutagubya Richard	$2b$10$q4jEp9vF218xRxrMLEVEBO72frVCTSOVd/hMrj76u7gIIk8ceMn4C	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:53.845265+02	2023-06-14 09:49:39.434339+02	0031o00001a0dTLAAY
fb70ccbb-4e47-4c52-bd2b-89c3bbb97ca4	Mugerwa John	$2b$10$ZbdC5w50iXDqUaSFIYbSBOa74PpOj.Y.4eZtwDiA5bXfm6MD3n3QW	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:54.209925+02	2023-06-14 09:49:39.616656+02	0031o00001a0dTQAAY
0018189d-996d-4bde-8171-e6fea875bb7e	Tumusime Robert	$2b$10$myvQMVqVV90Y.AWq/8kYIOcsBKw15x6v/WBBZZ61gxzUC.3hQINS2	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:54.53586+02	2023-06-14 09:49:39.668356+02	0031o00001a0dTVAAY
b594592c-3982-40f8-ac96-caf39751b0d8	Ssekandi Emmanuel	$2b$10$U4Xu99DIOHQrlHpiEpPWk.3wYjzcCB2WdBoxNlzdA47/OCFUqjmb6	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:54.765042+02	2023-06-14 09:49:39.807817+02	0031o00001a0dVTAAY
d65a251d-206a-4cef-8c65-2063d4ccc295	Abebe Fikadu	$2b$10$lZcP2juHDuYPLrnf7qrySu7kK35cv7tZui.eMkdtYC2Kvo5R1eVpe	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:55.363852+02	2023-06-14 09:49:39.940748+02	0031o00001gEM3cAAG
bf8316c1-aa91-4e7b-9132-7c69cf463d40	Desalegn Debele	$2b$10$/W8pWeG62j/8i6yt5p1qPuQ.JrK0tUP10wajefeQSzoFNU.QbwNXy	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:55.673579+02	2023-06-14 09:49:39.999142+02	0031o00001i7jCYAAY
963ff562-4a86-48d2-9362-e29bca18c7a4	Hundatu Ayana *inactive*	$2b$10$RHsJF9a8aQU.GVNrwowSZ.Lg25n5Sd9tcUnpCEuPlbuBQLNjV3.HO	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:38:55.905423+02	2023-06-14 09:49:40.043959+02	0031o00001i7jCwAAI
41cf8729-34ac-49b3-9770-78ef2cf0a8ee	Abate Belayneh	$2b$10$Y0L2wsCGTr0MEZYG/n3j1uU/toNJNvv6R1gDZz28hoFI2hsDu6EJe	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:56.192561+02	2023-06-14 09:49:40.081924+02	0031o00001i7jDBAAY
b624d057-a375-4b6a-8d9f-8e84e58c450b	Adisu Bogale	$2b$10$cCXqDjwIF8GxJnNw1DkROO00Lg27XAi/x9peXGK57R2jWt.FfLeO.	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:56.472446+02	2023-06-14 09:49:40.125581+02	0031o00001i7jDHAAY
a199349a-c937-4492-b428-64e9ac32ed28	Alemu Anewo	$2b$10$nUfTx7UdzedfFGs7ExtTn.IaNwmCP3Jhf2xuq2TPvnmuFL42i8H0O	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:56.733053+02	2023-06-14 09:49:40.154638+02	0031o00001i7jDLAAY
2c6d1674-e997-48d2-a4ef-d0060a45d3d5	Andinet Asefaw	$2b$10$xbbu3Y4L8InlCjtkYurMru4IqHFzQHkhnR9e6Aj8R4wRjbjxd9QtS	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:56.916659+02	2023-06-14 09:49:40.195194+02	0031o00001i7jDQAAY
2bc53cc6-91a0-49b3-a13b-94de31420fad	Assefa Adola	$2b$10$Js5wQfkv0aJPUSfQ48HuCe7KVu8lkBM3kBUfHxHAecbnIjrTZEU/O	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:57.033866+02	2023-06-14 09:49:40.235481+02	0031o00001i7jDWAAY
b8adcdd4-d6a8-41f6-8517-d1e4f2571ae7	Azenagash Siyum	$2b$10$zfueDM.0DDg35zjp9cUfnOY8c.CAxXeAq.b83mrI5fI3O8SohSUkK	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:57.203342+02	2023-06-14 09:49:40.292379+02	0031o00001i7jDYAAY
f8012219-7c4e-4f04-a3be-b41f56cc02f4	Eyasu Endashaw	$2b$10$G5ndHhOfYAncE6ZiItHj7uAXCvtaRf1CTu/Abiji23Tj1tuw5QZQG	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:57.446585+02	2023-06-14 09:49:40.57902+02	0031o00001i7jDhAAI
13beb93e-8525-449b-b607-a0bb35575844	Habtamu Lenjisho	$2b$10$hkei6xi3s/0WGCbgDDIaNeszWa81CCevS0s7qbnAtueXJCa9Cu04i	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:57.691036+02	2023-06-14 09:49:40.619871+02	0031o00001i7jDmAAI
08de0fcf-a6ee-4dad-87f9-5131d97ed55b	Habte Tsegaye	$2b$10$eok7w50XaD0JUbgZEISqreZrODJ1jud4MttN6Gxbhwjc33AzVevSm	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:38:58.175939+02	2023-06-14 09:49:40.656331+02	0031o00001i7jDnAAI
0674acc3-2b0f-4ed0-add3-7b6f4d7b8901	Marta Mengesha	$2b$10$z0tPoHl1oOnKbunvxSXkR.nY4CNBkpqSFGfiU1kdIPeSG8TcXlzf2	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:57.925834+02	2023-06-14 09:49:40.727947+02	0031o00001i7jDtAAI
74d63be7-fb60-40cc-9700-840b536fc5c3	Muse Tuke	$2b$10$qzei8UtPeyjwggSgO1mF3OcBJ2OFipBqmOoodFN3V7dVjHgn6sRMy	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:58.677042+02	2023-06-14 09:49:40.778017+02	0031o00001i7jE0AAI
d3c6a9bf-11ef-4e17-9af0-cd28b89a5eee	Tenaye Engiso	$2b$10$KMdM7Ab.oVkgm9mawEbtgurOj/hRkTt6hUZ6pfZ9nTgWWVDZhCHOe	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:58.998426+02	2023-06-14 09:49:40.854428+02	0031o00001i7jE7AAI
0d4cc182-6c36-4d92-8c61-685dccd07857	Tsedalech Tsegaye	$2b$10$ok6f/RVCg1OB4MU2AaSuhOKkrxafqxF6edOjzrduQCXiY4ZVPQUJ.	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:59.303151+02	2023-06-14 09:49:40.906135+02	0031o00001i7jECAAY
53e5b942-57cc-483a-9150-7cde72d41b60	Yaekob Hailu	$2b$10$4ec52YJVP8yBY3ZmSGdoMusFwbSzk8TssaddfBpJgrotyXFg.44L2	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:59.570882+02	2023-06-14 09:49:40.934234+02	0031o00001i7jEFAAY
b51afb38-05c4-4841-b20a-a6d3436e1e7c	Zeritu Dasa	$2b$10$rYqLFTfeQIS.PI7umrHWGuZ5FgB1ap.ooPcxCZTxGR2BZWmMoV12.	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:00.11104+02	2023-06-14 09:49:41.00732+02	0031o00001i7jEKAAY
640c743d-ac3d-40ad-a627-8921f63a2c84	Efrem Ejigu	$2b$10$XVzGAsQ7IWvbDYPhxxEnpOSxOP8jIRZzYfz.P1i529Jok1JjglvIS	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:00.426919+02	2023-06-14 09:49:41.052953+02	0031o00001i7jkIAAQ
248305b9-317e-4fda-b1ef-73e7bdd22907	Alewa Aba Biya	$2b$10$liTQkLjwnm7vggRVo5wl.ekM7pw1Fnffl3sJQyECp/46TxpJcNMuC	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:00.695671+02	2023-06-14 09:49:41.072671+02	0031o00001i7jl6AAA
fb259992-2a9a-4164-9c7b-e794d6379c08	Florice Sagbohan	$2b$10$1vPwK9rXRYH.bVqMYG6RYOoOPFMAQASvnblI.rtGH25jNrqlHuoOW	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:49.531425+02	2023-06-14 09:49:38.539386+02	0031o00001Y78gOAAR
aff9e77a-c222-451b-9247-25149bbe4275	Marlene Capo Chichi	$2b$10$lHUHl3WrGUKF7tjKYgthnOp2pO8c9hHIIP8by.sfz7wWhLsZ4ejCi	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:49.812327+02	2023-06-14 09:49:38.586137+02	0031o00001Y78gTAAR
d60e899d-14a7-4b43-a16c-ab50181c582b	Romuald Hounkpe	$2b$10$baxWlvm/kopZQwS5AvBteeqQY0LZaKe6Lbk6ced6t4CDfH2QkPTXe	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:50.291524+02	2023-06-14 09:49:38.62501+02	0031o00001Y78gZAAR
4270cc18-af40-4f94-9f0c-2c9a931a3814	Parfait Dadaho	$2b$10$AUmnpnGwEMdKHTw05MnYJeg2sWL/cLOXHkuAkvDnEQxHz.hQcUpry	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:50.555226+02	2023-06-14 09:49:38.665373+02	0031o00001Y78geAAB
b6963bcc-73ac-4b3b-8620-81b5db4b3d96	Chabi Benoit KPASSI GOBI	$2b$10$X2Qpv.eQJVajZgrr7zlEkOEhD9uMISqRgBpvCZ767I5Juin6lOGQ6	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:50.813849+02	2023-06-14 09:49:38.715117+02	0031o00001Y78gkAAB
fd59fb5f-5f2a-42fb-b21d-831865ce9935	Tafadzwa Nyakuchena	$2b$10$A/ijpAcugoyLGizOb9J7Hua9.BCOjEPYMuBetNIJgWgyVJEtS9Jhu	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:51.134456+02	2023-06-14 09:49:38.74729+02	0031o00001YkGjLAAV
d784b2ee-5063-4737-a72e-d091aae7190a	Isaac Karonji	$2b$10$tF8DSMPfgv8Z9oRb7tbVP.j4L190BRsS0CBZgBBcjWhSzUgi4je2i	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:51.571276+02	2023-06-14 09:49:38.807127+02	0031o00001YwN85AAF
a1d730f1-10b7-46ef-a46d-26029cc9fc60	Seraphine Adhiambo	$2b$10$5j9c3gbWFh4U.XnUsYD2I.fLL9JS4c6PaiR4wSPPPnZfjAGEOQoPe	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:51.735343+02	2023-06-14 09:49:38.857945+02	0031o00001YwN8BAAV
103952ad-61ae-4462-8d18-d22ec53deca3	Aime Mihigo	$2b$10$MtOqBQIBn81ymtj0uBMiqu0oFqClXkQ4oRZ69ScElaCwVt67fpg9G	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:51.887214+02	2023-06-14 09:49:38.913302+02	0031o00001Zxz6vAAB
0c60108e-064e-4433-a881-123cd574e142	Anna Ndamuso Michal	$2b$10$.1kbcwSlri9mMny0FulezuD95go7s7xEMt5hEJNn9Eyef7QviOi5y	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:52.094327+02	2023-06-14 09:49:38.936694+02	0031o00001Zxz7bAAB
48314cae-9831-4db1-a8a5-a411d1b5b717	Florantine Dijasa	$2b$10$EDbxm4omRJaM/qHghbQjlONgXNQumsyAkJh1uz.i62OllYxRUOGMS	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:52.334968+02	2023-06-14 09:49:39.006313+02	0031o00001Zxz7hAAB
3a3c3649-51cb-402f-b0f8-3f866f4760ac	Justine Imani Mupenda	$2b$10$uDUx6quhI55zp.r5Wiq7v.q86DlSJ30NSN0QfXwPB.dS5ocy27iaC	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:52.68151+02	2023-06-14 09:49:39.064469+02	0031o00001Zxz7mAAB
827ac48c-58b8-4ab4-9208-be5f33ef56eb	Nabalyahamwabo Solange	$2b$10$Kio3jgwOLySXqzfu3gMz7eLbZRQXgsC9qDEEGj6Ri3wko/V50zWJG	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:53.074019+02	2023-06-14 09:49:39.097963+02	0031o00001Zxz7pAAB
55795ac3-2155-491b-b012-b21d791d58f4	Solange Mastaki	$2b$10$Y4az4OrYRSrdJDTLk1qKFuB.zeNQH7EM.q8y9bC/nDqb9BpfyzHmm	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:53.357095+02	2023-06-14 09:49:39.136927+02	0031o00001Zxz7uAAB
998507a0-04ad-4c08-9f4b-790948e92d64	Mariette DOSSOU	$2b$10$jpJAte9h6p.DL1o2MSIDYOtWXx/PPnA0u.I0tp0qfdIe.2gGtV2A.	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:53.635213+02	2023-06-14 09:49:39.221771+02	0031o00001ZzobLAAR
805ce9fc-e200-4312-b93d-892e621eedd4	Kaliika John	$2b$10$yCCCgc045mnw7K4gV8NV6.UPAmaWi8amLD02nT7o018Pm39ILCK.i	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:53.968321+02	2023-06-14 09:49:39.494029+02	0031o00001a0dTMAAY
872d75a2-396c-494d-8c50-2fde581b7e4f	Bukirwa Noeline	$2b$10$MIfx2U5cLNnD9pEPUCiOAuKyOmvkRcGsTe.B3fhcvHMhF6bHwXME2	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:54.280068+02	2023-06-14 09:49:39.62648+02	0031o00001a0dTRAAY
e0fcc371-d86f-4386-9167-ea9d2dd167cb	Nankunda Brendah	$2b$10$4nlz1gNPwOkCMYTSSe/dKekYpTRG2WZzu9uIIqNKkDLviDPS5mriq	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:54.567368+02	2023-06-14 09:49:39.678264+02	0031o00001a0dTWAAY
b440f4f9-abd5-466e-8575-c868e6034e24	Nakanwagi Joweria	$2b$10$4ehv6QUsiwPlj87yCP2LG.V3vf7txVTM75JsVKQBrysRqwjrQODMS	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:54.841486+02	2023-06-14 09:49:39.827547+02	0031o00001a0dVUAAY
5721e7c4-dabe-4ec2-9af1-89343c687770	Lilian Anena	$2b$10$rYlCYZr/mZeljlE51f9z2.z4z5LoZ8/G.on6Vwqc5lafu4xpme8EW	\N	757450469	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:55.410808+02	2023-06-14 09:49:39.93069+02	0031o00001gE7XcAAK
1459868b-f5c3-46c2-b20e-3d803484349d	Markos Matusala	$2b$10$p/DgzzGmwsZl6BG/wJvLceDsha47LBh8tkQKW5Eo813oQN.vuHV/a	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:55.698584+02	2023-06-14 09:49:40.010339+02	0031o00001i7jCsAAI
45ffe3c1-c9b8-4917-985f-cbde9b3f9f87	Melese Lema *inactive*	$2b$10$aZ8hg.bwaq0nD90K5EoUAe6NCqM2H8Uc.VpEsVaRO4tmwkDO7tCbG	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:38:55.946582+02	2023-06-14 09:49:40.066048+02	0031o00001i7jCzAAI
8124cd33-abb1-40f7-bef3-6160c95cb183	Abinet Asheber	$2b$10$9tNwslYBFKlaX144nNE21e7DCuDqgazvXxVjRbHokwBZDRBXzbz2q	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:56.244025+02	2023-06-14 09:49:40.09558+02	0031o00001i7jDDAAY
3779216b-353b-4dca-b76e-ce4417648d66	Adato Kechela	$2b$10$nBzeTv79/.ohhnYc6Kgy7.bfzX4m/MQNum3CdKmktcFaa0EV1y0zm	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:56.497794+02	2023-06-14 09:49:40.115006+02	0031o00001i7jDGAAY
dfc5c1a1-5356-4a63-a791-f8c9aa2e8727	Alemu Botite	$2b$10$1MMro.2aKCJ5yt2FpPXAx./kr.uId9OXegGzCIDx/5FTvS9mVCYgO	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:56.795676+02	2023-06-14 09:49:40.165233+02	0031o00001i7jDMAAY
24fe508e-f803-4909-b8ed-ba02791b4c90	Asdesach Gidamo	$2b$10$dQ5OiaHm6cQ998MHJMX2J.4ChcomGuZtD7PMXSLklRyJUz1KuXfBC	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:56.949329+02	2023-06-14 09:49:40.203468+02	0031o00001i7jDRAAY
2f007585-ac91-4b15-933f-655b65af22b1	Asnakech Ayele	$2b$10$XJbTwgVB1xD/jS8XauFVw.k6Pm40RMgTuvhaw3xiEG5p1I2Ilaahy	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:38:57.038855+02	2023-06-14 09:49:40.22806+02	0031o00001i7jDVAAY
3a3f4092-9ee7-480a-aea5-28db4bcb31b6	Bereket Demise	$2b$10$//61qQ3X4A.LmDT5AjXjUedxJsOXGH2mQ0kdwVLYnAIzbGEy9u98C	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:57.264308+02	2023-06-14 09:49:40.403172+02	0031o00001i7jDaAAI
ac6005da-4582-4d79-be9f-c2a9823e2c53	Felekech Shawol	$2b$10$ybURlKODDWaBZPJNhOJ6Geu9mZiZvR15jJfrSRISDJFpx3tRgr6Ui	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:57.480013+02	2023-06-14 09:49:40.589432+02	0031o00001i7jDiAAI
829cf745-45f9-426e-9e93-c6b59d130b10	Kabitu Gurato	$2b$10$SmP7mDhVibmJHSVOldV8Ve4/30CE5mho21xyKVg/QaHVaMOAIU1w2	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:57.740901+02	2023-06-14 09:49:40.705155+02	0031o00001i7jDpAAI
fb2389d0-4cd8-495d-a86a-9a860d0977c0	Marta Sire	$2b$10$JGOfWZ6ad2t35NRbgxzYVufBxXrnpYEPIsXKUhsqU2BDgCNZjUdQa	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:57.979318+02	2023-06-14 09:49:40.73733+02	0031o00001i7jDuAAI
b7bdf74f-1ff1-4963-85bd-0960d10e9f37	Menen Mesfine	$2b$10$4mC/Z.jwqFhe3C4zCWh3yegrpDOX4gGXSloCDb6cwEC7zpZ7bXu9S	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:58.276171+02	2023-06-14 09:49:40.741456+02	0031o00001i7jDvAAI
e56c01e7-5432-4040-8fc7-d53f792b8e43	Netsanet Ejigu	$2b$10$onsI4Oyt9lEGSepiHHHV0e7HHoyAg6axbxQddIQCN1NfAcvmEIaTa	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:58.757237+02	2023-06-14 09:49:40.785453+02	0031o00001i7jE1AAI
c41f7bcc-6191-4ac1-bc20-a55ade9cc383	Selamawit Kasa	$2b$10$VLuduf36Cmd2areTAo8LtuGG6vKO4sksZSG.4Pp7aVPC3PRDmm25G	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:00.174421+02	2023-06-14 09:49:40.822972+02	0031o00001i7jE4AAI
52481864-efa7-48cf-a715-0bf58fa967eb	Terefe Dawala	$2b$10$ZzpsyAtniX7RJk.LOXR4LOIny2E3UxJOxLVY90im/ENAsIxhIhNIO	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:59.061711+02	2023-06-14 09:49:40.869025+02	0031o00001i7jE8AAI
b00b4d21-14c6-411a-9e4b-8a8b6f831416	Tinsae Girma	$2b$10$G9BcTi2BkGjxk0Vyo93ole7kmuc09HOe.maDNQK/GtV/CC07n7ng6	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:59.340669+02	2023-06-14 09:49:40.890019+02	0031o00001i7jEBAAY
b209ca99-1077-4e32-aa4c-cc59262bf237	Zegaye Fanura	$2b$10$6HdyeMdnqIjne4ARCdda6OTaxNbcBmH8fT8KwQv6QycmwOYhLIBkq	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:59.617858+02	2023-06-14 09:49:40.953015+02	0031o00001i7jEIAAY
31b358f0-9068-4742-ade9-ecfb5ee3b69e	Abas Aba Rijal	$2b$10$o4rOYwGNg9mrX6ixDbT3IeKX4tAMJOow27Yo3SswKNC3z5nDQeNVK	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:00.492697+02	2023-06-14 09:49:41.057451+02	0031o00001i7jl4AAA
b11a89d9-a9e5-4653-8244-f60dae2c9174	Awel Mohammedsani	$2b$10$2KcvXC75JKyAXjwryg2Ize3Hm4u123KiUNvaBQb9.xgYYCtLgLwDO	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:00.758235+02	2023-06-14 09:49:41.101132+02	0031o00001i7jl9AAA
73e6106e-4d1d-4183-b9ea-2e256bd60b47	Moubarakatou Tassou	$2b$10$klwrGSICV5qG5ta94e68K.hip2PMIHxxLkjwXtxY4i2dgTKOVqzKG	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:49.57582+02	2023-06-14 09:49:38.545418+02	0031o00001Y78gPAAR
6ae66d26-a578-49ef-8143-dc8202c3c547	Esdras Dadjo	$2b$10$jMLJRjlJJPl.r9yVSHahSOL.15xMwIb5aku5cZwY0RKVhzwioKqxu	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:49.865639+02	2023-06-14 09:49:38.589943+02	0031o00001Y78gUAAR
ff88a29b-1f59-4405-bd12-49107cab51a4	Zime Lafia N	$2b$10$N18o9.OwwMSdnFpeSjYovuJ/kzFQgARGWM1Cde9YCjOGrwZ7yH4pa	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:50.354294+02	2023-06-14 09:49:38.636222+02	0031o00001Y78gaAAB
d1247ec8-3f32-4908-a598-d26894c77b39	Pierre-Marie KAKPOHOUE	$2b$10$HsvYbz0wuoGVwHeHLb05jeJilUV4dif6YpKd9TgXd8HQF75mcA4ee	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:50.611461+02	2023-06-14 09:49:38.681766+02	0031o00001Y78ggAAB
94a55209-5be8-4c06-9374-79ffe91ecb84	William CODJO	$2b$10$.oWs5VChGO0vY3qgwUsv/.gzsTD/kbxDwqLm3SFB4jdgXEmlqmozO	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:50.873215+02	2023-06-14 09:49:38.706438+02	0031o00001Y78gjAAB
3cfdabb1-1810-4ad1-8c6b-da0cea1e6d53	John Masolo	$2b$10$qgg255ujF8oIaBjghv8.nuaWU8bMq69LTIv/3NImkH61lAdGXRn4q	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:51.239646+02	2023-06-14 09:49:38.774272+02	0031o00001YwN81AAF
11f594e5-69c7-4f7e-bc9f-08d9bc56e1f6	Jackline Barkeben	$2b$10$MBj8M0.9YRfT8qSuKFbTsulyCJxhUGB7frky1kewrIuM8uCFk6/hm	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:51.618405+02	2023-06-14 09:49:38.81888+02	0031o00001YwN86AAF
81be5ca2-b8c7-424a-99b0-7572e840356a	Janno Van Der Laan	$2b$10$./63snfT/qwv3xCSWVa8i.dF9ZyrJW4HZnoz5dIKdY2UbTFoWCdlO	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:51.762888+02	2023-06-14 09:49:38.870421+02	0031o00001Zxz46AAB
fc4d2507-bdac-4515-a9e0-eb2a5bcab77b	Tite Mbenia	$2b$10$ph5dm4ZLoYYbNEhxVODG9e0Hv/VLbdJO6VulBct0szoTNNjVXYKum	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:51.931462+02	2023-06-14 09:49:38.902802+02	0031o00001Zxz6uAAB
d5ae1505-9aa7-4222-bab5-17157c0a4351	Bienfait Bahati Buraye	$2b$10$xkFgTINnv9nCVxJwdarO6eoyOZ04Isgym.8OzYfx3pRTJBmQVKOi.	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:52.147449+02	2023-06-14 09:49:38.957828+02	0031o00001Zxz7dAAB
03912ab1-fd8f-4454-ac91-2364c25cea4a	Francine Sifa	$2b$10$mL98BKBIr9yCSjbn.s.nruPQ86a7hdnoLdUorPj9vCzmR6G38FERK	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:52.397869+02	2023-06-14 09:49:39.016205+02	0031o00001Zxz7iAAB
5e521c19-91d9-4a69-8546-cf69846a5276	Nataile WANI	$2b$10$BqX1LmWSorXh.1qupxG24.fhrPjc1oIhHCdJRCnWS8BGx/r7Z7ZDa	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:53.121104+02	2023-06-14 09:49:39.102828+02	0031o00001Zxz7qAAB
964ed28b-c60d-47ab-b381-393dda6a158c	Theophile Kanyenye	$2b$10$yjaNThkPbk6105i9.K9IEOs2jG2j6pTNKAfDjlq0gQFHoCzQOP2b2	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:53.411627+02	2023-06-14 09:49:39.14623+02	0031o00001Zxz7vAAB
6afe7014-f513-49d0-96e2-712d8cd70cb9	Cynthia SOSSOU	$2b$10$m9fmWY8VEaNUfX4inUM0LOcLbGux0GArZE6FSxuk/zEZi78A8h2c2	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:53.691559+02	2023-06-14 09:49:39.283015+02	0031o00001ZzobQAAR
2844be18-070c-46c8-8ee5-8f8f40d9ea63	Mujabi Lawrence	$2b$10$hiwpyKxrS1CIBD0y.3O./uafUx6BPvXW4kElQl4XzImgaS8bSDsBO	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:54.030646+02	2023-06-14 09:49:39.527403+02	0031o00001a0dTNAAY
f61e6a73-5ed2-493d-a582-8fe5ae0b45cb	Miyingo Benjamin	$2b$10$ugBxJuxvTNN4CPRqltxR1.K/Lrg0ZPX1ydHMH4NE5FOgXFcTF2edO	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:54.330784+02	2023-06-14 09:49:39.641851+02	0031o00001a0dTSAAY
16d26075-4d75-4b21-b5a5-c08cb0d3accc	Kyobuhwezi Zipholar	$2b$10$2hRHvWPjSgp68dVa5ptPHOz351ZHmINjyiwFh7vh3ot9nIBxbX/Su	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:54.869598+02	2023-06-14 09:49:39.866125+02	0031o00001a0dVVAAY
4913b369-6c98-4a6d-a4aa-e3b93963f93d	Moise Shushano *inactive*	$2b$10$.sTfX6l1/Ao2.p.oiu2ptu0d/wq37fMhNHyT9tdnz0R7z/C3ahIGS	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:38:55.199472+02	2023-06-14 09:49:39.909283+02	0031o00001d6u9fAAA
44d3ca80-bb8a-4f27-b132-9b418e6fc98c	Nugusu Sora	$2b$10$Y/aEmhg8BhErt9elTNSdsuOzbdiuuvjATWX.JW66sTktISRfGezxa	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:55.461325+02	2023-06-14 09:49:39.949148+02	0031o00001gEM6uAAG
f5183e72-3b54-4e60-88bd-f12d996c224a	Selamwit Samuel	$2b$10$npfB26qjtUVEeFwVZGU1auncEvz6pIS.j4ChNj4bRf5WGMqh7a2WS	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:55.761632+02	2023-06-14 09:49:40.016188+02	0031o00001i7jCtAAI
dad2f386-7248-45f8-bb55-780e0e49fd9c	Bizuayehu Workneh	$2b$10$zmJ8OzoYqD2odMWWqGFmo.NTcsTDtCB7Sc/VffXtB9HVR8uNQe3gy	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:56.008367+02	2023-06-14 09:49:40.057026+02	0031o00001i7jCyAAI
e521e11c-6cea-4e16-8c60-0cfcfae91ee1	Abebayehu Lema	$2b$10$4UKA2dDW4.N3QrRjGWnGceIG5z/1cQuh9OBwU3b0NcOsB6RwLGxxe	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:56.321847+02	2023-06-14 09:49:40.091636+02	0031o00001i7jDCAAY
a5a31afc-61b5-41de-ba7a-012f8c78448c	Adugna Abayneh	$2b$10$tGyH2VHAUDdyZOMKM2EUreSWUfDqu4TFzC717XvhpVdq2E0IajxgG	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:56.554045+02	2023-06-14 09:49:40.132881+02	0031o00001i7jDIAAY
9a1be7b7-b1f0-4009-b8d5-e40ce9d04499	Amare Rorato	$2b$10$5MFnMERP.5hD8X/GLlovX.HoWm3Au7Ubah1YoJDhN1dD5ZKbcXn9e	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:56.824791+02	2023-06-14 09:49:40.174501+02	0031o00001i7jDNAAY
4a72d419-28ca-48de-9fc4-2a508b51b2ea	Asfaw Petros	$2b$10$I6C5dFWEBOTLr0bnt1uomudLdLtvzRAmyIG1RPtahzkDGlkzfTHoK	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:56.974203+02	2023-06-14 09:49:40.212011+02	0031o00001i7jDTAAY
bc11e031-c71d-4b19-8d93-9381e7fbdc31	Belayneh Gobena	$2b$10$w1dVCEyUpRf5Ly752kbyp.P7b0pKSEGuZesQF2McLd3D0HuPUs/d6	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:57.057579+02	2023-06-14 09:49:40.359546+02	0031o00001i7jDZAAY
c51a1b76-f61b-4657-a5f2-0c803586e77c	Dagne Asfaw	$2b$10$YQsZbB7cQD0FcamIs9EvruuTBSUD/Fapr3vrW7SXZod3D/hZDaG6.	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:57.291905+02	2023-06-14 09:49:40.480304+02	0031o00001i7jDcAAI
f745f1d6-c3e2-49bf-878b-6dfba171ebc1	Debrework Demise	$2b$10$jSt1ic.1Ke.pRjlzZ4nzZeLIjijU8ZSAdPmDOXrufWu.S6GiSYTDa	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:58.020609+02	2023-06-14 09:49:40.493328+02	0031o00001i7jDdAAI
fd70f2a8-7f2d-4004-acd2-f15163bd13cf	Fikadu Tumicha	$2b$10$Kn1hwaVH9XgEBxAO5O1vGuhlGeU23Cwc5.ZMEmGAEX6t20eVKrJ0u	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:57.543744+02	2023-06-14 09:49:40.59445+02	0031o00001i7jDjAAI
14faa36b-2cf3-49ec-a9d2-11e6587b3ef4	Kumlachew Fekadu	$2b$10$FnXSSk.a9hs6wAYMjJ6EAuVQa7KOyeJ1bULmZWUwZYIZ5A7o71Etu	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:57.780807+02	2023-06-14 09:49:40.709432+02	0031o00001i7jDqAAI
00bb98ce-5f82-474c-b1ee-09ab080f4ae2	Mestawet Mebratu	$2b$10$ZrGzrUJkibDaRhUkWMQyee70IxejGADZneG2j0PCAz4eubdrJJGoC	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:58.351852+02	2023-06-14 09:49:40.752572+02	0031o00001i7jDxAAI
7b7ef202-92c9-4408-a021-aa5df62941f0	Netsanet Yakob	$2b$10$u4HBnpcmP2pMIDtMKYUF9.NcB7snfDKt/MTj6BF2sE6NS2gXIk2qO	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:58.794629+02	2023-06-14 09:49:40.794203+02	0031o00001i7jE2AAI
fe2d0d52-63ad-4515-8a35-ad6ec16e18ee	Tihtina Birhanu	$2b$10$PCMLN6JSse6buRqkDUKqFeUPkgx1rqfl4/ZEY7YRQ.nQRXhR19Yrq	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:59.139506+02	2023-06-14 09:49:40.877408+02	0031o00001i7jE9AAI
777f97a2-5543-4473-b1ab-b1140a69f5d4	Wegene Letamo	$2b$10$iTbNJEn8xzUOGfEPf.DiaeyyW/zx0sRfGNscmcK1aF6Nak/L3HBG6	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:59.414183+02	2023-06-14 09:49:40.925398+02	0031o00001i7jEEAAY
d3cb7313-3c36-4702-ba64-5a6cd455a6d7	Zerihun Zewde	$2b$10$c4YEBxm84LBs0DybbrLisOrFNciZRVzO58G51dQoopQPuf6PhMpUO	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:59.663943+02	2023-06-14 09:49:40.957313+02	0031o00001i7jEJAAY
21358b7a-8356-4877-b455-040b6b228a86	Beyene Desta *inactive*	$2b$10$n2sthfR5oHCrsAPbtwSevO53rV5IBSkYszO2JUZXOF7LpdwjBOlZC	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:00.231356+02	2023-06-14 09:49:41.020921+02	0031o00001i7jjmAAA
c0aabfe8-bc3a-4c17-8bdb-01c127e21e20	Abdulbasit Aba Selam	$2b$10$dgpPGcgnb6Fo7Mp0C5LwL.gT9FxdvnmWLuvQ9FjWo.h1yqtXg9PL6	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:00.512514+02	2023-06-14 09:49:41.065794+02	0031o00001i7jl5AAA
4474ac7d-51d5-4ccf-ab1d-cf4fc89f779e	Beker Jebel	$2b$10$/fTmS4/KwbJ/cXgHzi8C/enOivVZCCZXiPkyLnfW3w9SkpL7ZZAV2	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:00.790942+02	2023-06-14 09:49:41.104717+02	0031o00001i7jlAAAQ
1e8b9518-e65c-4909-bbfa-44de44d46f08	Meskerem Mekiso	$2b$10$kj9IhLgI0vd77Ot01RItt.HDAIyeJYthTMA1m.Tpt2hnU2YpvZqFa	mmekiso@tns.org	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:20:47.539883+02	2023-06-14 09:49:47.563696+02	0032400001OHpWJAA1
3e1bd74f-c21b-4608-8872-c837829ad3e6	Wilfrid Atchamou	$2b$10$9wt2pqJLURAa4QfyCNp8WOMI58va97PSKLoRpdms9TE9e4AE2H/1K	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:49.659191+02	2023-06-14 09:49:38.553833+02	0031o00001Y78gQAAR
8498ab7b-53a2-4b04-a8ef-651f12803024	Reine Amabarka	$2b$10$VL6Atz4vq14lMYIZGf5AQ.xisdkv27IHJ.U.N0X9ibbHB3/6mCXii	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:49.925765+02	2023-06-14 09:49:38.601844+02	0031o00001Y78gVAAR
71b12071-d849-4332-84e8-ca61eb6b430e	Nezif Nuredin	$2b$10$f340aR1quwmnAzFgZ7hDLOcs2k6J01/D/02Dweg7XE5UcUNaogwhu	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:01.502406+02	2023-06-14 09:49:41.219901+02	0031o00001i7jlLAAQ
3e8d7fa9-d165-44cb-9bd1-e3e1ce669ed2	Zinash Tesfaye	$2b$10$CBqfdMz2ZX3Jd7L6pzxttuM8RZcIbeIlCvhp.YjVTyeXm27ikmVfq	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:01.709057+02	2023-06-14 09:49:41.275047+02	0031o00001i7jlRAAQ
ba6f34f5-5ad9-4273-9708-3c64bbbfa381	Aklilu Dawit	$2b$10$GI45xVm9gfkQ7SxwwA8ubeCmhAa/qDSlovis67wxDJ1lgl0BoH9ce	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:01.924308+02	2023-06-14 09:49:41.31809+02	0031o00001i7kGbAAI
602740ff-63d9-4063-8a02-4b0296ca0c45	Engida Endashaw	$2b$10$.kybTEZ3O1VayVtFEMJeheAF6NWSiUtkN3Ebb9vNAXwcfwzgqvD2q	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:02.374565+02	2023-06-14 09:49:41.354851+02	0031o00001i7kGgAAI
16292d15-e9df-4a27-8f4f-2c7689e1cdf6	Ali Jelle	$2b$10$b59Wa9G/uxGzfZ.Z8XPP4.RV0xfmGF9Q.f28slUl75Ng9hILqMMJa	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:02.680916+02	2023-06-14 09:49:41.420251+02	0031o00001i99VfAAI
ada065a1-2339-4caa-82a5-21f0443f77c2	Edwina Mwebi	$2b$10$bI6D49j7rxrYq/5u3wR47uauMnrvxLbmop2PxcxNJ/B8YuZxftkei	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:04.158503+02	2023-06-14 09:49:41.455602+02	0031o00001i99VjAAI
03ba4e82-08ff-4475-9b74-9b61becff82c	Salim Athmani	$2b$10$t3aBlXZkn.mgUvvaBtBQ7..av33FlL7CH46CxIHaJxd1a9ftPagyi	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:02.976767+02	2023-06-14 09:49:41.465994+02	0031o00001i99VkAAI
51007520-eb6c-4d8a-87ec-5b39bc8ed2d7	Beatrice Munjiru	$2b$10$fkxUEm/dLYwh5ceuq5D18u4A5mU.hYj40.n9yv6AlDVcHiOom9HnO	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:03.269619+02	2023-06-14 09:49:41.505148+02	0031o00001k2IzFAAU
8a263d4a-ad7a-4993-8902-ba76567dc69e	Tunsime Kyando	$2b$10$aosZXKSDdeWDHEpAGk0SFeQz.CChcE9lil6.s5qnUpUi7QKUcXlOG	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:03.627645+02	2023-06-14 09:49:41.547261+02	0031o00001lRdEwAAK
c45b720b-5c85-4652-80c4-adcd076ec085	Kenendy Okorie	$2b$10$eeEy76U8/dsZDy7italbkO0anLIT3MdZhIdZlX.uwIMse2KxmRuy.	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:03.894484+02	2023-06-14 09:49:41.589018+02	0031o00001lRdF1AAK
c3cdafef-cc71-424e-a398-116dbf9233ab	Ayodeji Isreal	$2b$10$D5zUF7Np4CBCXuxiISOI1eLIvrF1NHU4VBeLzH3kcEw2bnrFH1Gze	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:04.434611+02	2023-06-14 09:49:41.649192+02	0031o00001lRdF8AAK
6f33c557-8f32-4297-971d-6bee99cb4838	Peculiar Nwosu	$2b$10$2j/nQ634VNX0ONredu7izeIfbJvj/BJvbBA0HVycYIBIPqMLZJ6Pm	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:05.780107+02	2023-06-14 09:49:41.695255+02	0031o00001lRdFCAA0
c3fe0ab1-d6c8-4d4a-8987-e05e2c635c30	Joel Aboa	$2b$10$3UTAw8.AcXRi7rdjh7KhKu9E3YK6cp9bp/kZ/glFINSjZM1kw0lXW	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:04.702512+02	2023-06-14 09:49:41.733696+02	0031o00001lRdMOAA0
f3f9cdcf-b880-4834-a9c6-bbb5153bd4e1	Cathrine Sithole	$2b$10$pjygZT9k7fv.8nXx6B9opOd61Ng/Mx8cAHZevtY/tv6Kk/KJERrli	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:05.022716+02	2023-06-14 09:49:41.767029+02	0031o00001nX6YwAAK
aa6a1cda-e4bb-40fa-b153-2d3e01aa7ecf	Zewude Shashemo	$2b$10$fuFE/0biFS2GgFz/cMJP1e36u0P/ItvFCjIB05ixDc71dgxNV3uSu	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:05.276867+02	2023-06-14 09:49:41.813731+02	0031o00001nXmcrAAC
31d60ed7-22ff-4e49-8f2a-770f83cefa32	Consolee Nabintu	$2b$10$zD8w5RwGIGsW6ijJsSoA/eegTiJvgJQBG/EB1R1pjSSUQ8aUCEI72	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:05.481976+02	2023-06-14 09:49:41.863102+02	0031o00001nYrSuAAK
75efa49d-df7a-48e5-a12b-87d6f215bd7d	Fabrice Kaningu Shamamba	$2b$10$CofAPQCvsVO6bacQIc57t.O354HBKf76obLxY4c4F2AG1KX8DY7W6	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:06.055745+02	2023-06-14 09:49:41.926863+02	0031o00001nYrUtAAK
0e1e3424-a4a1-4ffd-aa9e-bc6332a46d70	Christian Fazili Banywesize	$2b$10$6lpvSqzcWvepdW3D7mhOWO2HopmZLJjvpPEoL5e49d3ySGMp3vyMC	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:06.604461+02	2023-06-14 09:49:42.050453+02	0031o00001nYrW4AAK
97934f55-7b35-4d9e-923b-773bf66d7068	Olivier Lukeka Ngoyi	$2b$10$5UqCF8pFQ.iCeAa2C96k9OszAJiW5ScvPLvjkFHFIZDn91RNCSelS	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:06.886251+02	2023-06-14 09:49:42.092803+02	0031o00001nYrW9AAK
ae8cb2f3-c19c-4bc3-b05c-de9e09a62621	Evelyne Nabintu Karoha	$2b$10$TEAQ7PZorySgz0LDhNJ1O.nY061Qv5i4UEaxtc3PuZJe3A/iFBM26	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:07.144221+02	2023-06-14 09:49:42.132972+02	0031o00001nYrWEAA0
d3cbcedb-64d7-4218-98b3-d6d986cd8a1d	Justus Benderana	$2b$10$7qaafHCFmk2IQRBBADvPbev.cpIXkJSALj0WL29k6S4fZAfuf.oL.	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:07.382471+02	2023-06-14 09:49:42.17776+02	0031o00001nYrdeAAC
c3dcab3a-bfee-44d7-8f22-6ea52bcc71aa	Dan Ampeire	$2b$10$rv6WXGULPTpIZWOI1ghQnO8ux1VTXewXfedYS89d2OHC/cDNqSVPi	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:07.599463+02	2023-06-14 09:49:42.231045+02	0031o00001nYrdjAAC
a2667fb6-6f74-477c-81b2-711fdcbba253	Angelo Kwesiga	$2b$10$jgHiYCo6grAdzPw6N7r1N.IT6nycJd5Fn.r9xMcKdGlZ.v7A205zC	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:07.862919+02	2023-06-14 09:49:42.264607+02	0031o00001nYre3AAC
f2464118-e994-4acf-9e6b-7b6874180d75	Bruce Naijuka	$2b$10$BI9lzZ9QHCO2TDpdO81mIuQZTU0izibOy4sPpmbQqr3g.YyYiM9iW	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:08.124381+02	2023-06-14 09:49:42.297074+02	0031o00001nYre8AAC
babba079-56c3-40e8-a15b-19e1c00cf64f	Deus Tukundane	$2b$10$YkuOBVgFqvEdhIvcY9nADeMhnfnSMliELwAWEs6r0Kv8hT38xVIlW	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:08.471183+02	2023-06-14 09:49:42.34201+02	0031o00001nYreDAAS
5c075680-d4d0-46c6-9828-5a19de0b1b39	Enock Kansiime	$2b$10$CbPbvv9zUPx5lPU4HdUq..4Bpv4iOlr3T3Y4nzALyNnC..RfEg51S	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:08.690749+02	2023-06-14 09:49:42.3805+02	0031o00001nYreIAAS
68e044f8-080f-4a0d-83c7-f80a97a9d5a9	Godwin Kansiime	$2b$10$JiCxAaKfH/uU1en2xc.J7uX2IJ2F4EV6X1AKhYdAKhQ1hGZEAw9PW	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:08.926738+02	2023-06-14 09:49:42.418324+02	0031o00001nYreNAAS
576306ca-58ce-4ae9-a7f0-59c68d69868e	Judith Tukwasibwe	$2b$10$qUjsSBoWqsImpsk6gSTkzuAYosSzPkgb7r6vms7vJh9fCFOGCfING	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:09.232761+02	2023-06-14 09:49:42.451927+02	0031o00001nYreSAAS
80fe5ae7-0dfd-4193-9fbe-4738bcd75449	Micheal Naturinda	$2b$10$I.iDisfR4vzdM7f3vT7O1.lcdakD63CCF.kSt0VoTddcNS55rqf7q	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:09.491109+02	2023-06-14 09:49:42.493743+02	0031o00001nYreXAAS
720c96f7-4188-4c41-8c63-648d9abafb77	Patience Nahabwe	$2b$10$d0/10kpON4P1DlFyxGcS.ud5MOz4HOwUmdFxGfmZlrALr2973EcZy	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:09.789457+02	2023-06-14 09:49:42.523867+02	0031o00001nYrecAAC
aa1ef851-2c6d-44a0-853e-937395abde13	Sam Bakoola	$2b$10$KTroXwSrdBEa35H1dxvcTOSbSiozRF6OlJKFXq0YLrrhZf12i8HZe	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:10.242892+02	2023-06-14 09:49:42.573557+02	0031o00001nYrehAAC
c0dd7568-8d5e-406e-9423-0a1dc3212564	Wicliff Ndyamuhaki *inactive*	$2b$10$G4X/ZubFhpG/9H.krBJ7r.hCsG9trISBpcaYZ/3lMyOGUobtbop0u	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:10.605844+02	2023-06-14 09:49:42.626252+02	0031o00001nYremAAC
42c8712e-dee6-4ec9-9058-8019bf9c1495	Moses Twesigye	$2b$10$5oVFKAzUAje4GpIJ0CqOz.BWcpqftpL.5QNjO18FBwDon2gJPpy1u	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:11.032163+02	2023-06-14 09:49:42.709115+02	0031o00001oyZGmAAM
2c58d313-c81e-49b3-9a0b-875128fe302f	Minche Girma	$2b$10$muBXh303X9nBf3Z5jLQ0PulkzLJTUhTyuiTJVsJlaRWVH664duUCS	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:11.192242+02	2023-06-14 09:49:42.747788+02	0031o00001pwrbsAAA
d5898161-6834-416b-8323-5fadafcf4284	Tesfaye Fanta	$2b$10$AS02YZ6HMv0zR9o3Mu2QAOJMV/XTXbMzUNBccYcCt8UilP0qC6KS2	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:11.536354+02	2023-06-14 09:49:43.078036+02	0031o00001rDc6vAAC
0364b7c4-1c6a-4883-b7e0-cd26e6ba45eb	Rafael Morales	$2b$10$AxviD8KBiZw8yMD9ByRXTu4iMIrpa13vcPlpnlJtls4kDX/vAIc.u	\N	7873700442	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:11.799149+02	2023-06-14 09:49:43.1885+02	0031o00001rFWM0AAO
c4a77696-4ae1-424e-b3a0-1086611f3baa	Isaac Kashumu - C2018	$2b$10$rj3.bhz96nMlYozvAOsKo.kolJDpCVLnHms1l1U29jerQvkPPzGXS	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:12.055946+02	2023-06-14 09:49:43.307457+02	0031o00001t2irwAAA
fd6c0641-d2c5-4914-81f9-e76ebbbdbecf	Bilal Abdo	$2b$10$yvaFT61fiXBNhCQg7pUwiO8FNcvrjfq4TGwTcp8xVcs7PTYqRvyzO	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:00.833115+02	2023-06-14 09:49:41.12011+02	0031o00001i7jlCAAQ
2f92770b-3b7e-4d4d-b000-d4e0da260a4b	Gissa Tekile	$2b$10$SzX43kSaauoOKTyAnLRI4.KB.hk2sGsjfKW6J8aJ3O85fcBWhhMj.	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:01.264794+02	2023-06-14 09:49:41.13844+02	0031o00001i7jlEAAQ
ab99c9d9-0d38-4f6c-85eb-51e6c97c0eaf	Radia Kedir	$2b$10$W8UiHR4bqzo0iK8nL/ilc.EQARDG3LZMvO7lTQ.wyFmZbaNMqBs7q	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:01.540038+02	2023-06-14 09:49:41.235602+02	0031o00001i7jlNAAQ
e8487fad-ec58-4701-a204-2fb56997cd9e	Megertu Negash	$2b$10$YnRTczTVPPwoA1oi50p2w.V3WTNwNGigVZkU8YRNqC4FQx2q13t5u	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:01.769361+02	2023-06-14 09:49:41.291938+02	0031o00001i7kFwAAI
be92f58c-5726-4a7f-bd14-fdde6b7c9e07	Rediet Seyoum	$2b$10$bDvZFPctFDrpj1llBLgVpOBJAznHY0iQnQrAm3ATKwWn65WV69nby	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:02.379111+02	2023-06-14 09:49:41.369671+02	0031o00001i7kGiAAI
6b363288-6106-4fa0-a93d-e27ec2e47be5	Dorcas Nganga	$2b$10$JbZpFYaqZVyZ2.qI5OdEzeFmZ/QukkKFpqTVMnSb1qe2.nS4aqs6O	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:02.702973+02	2023-06-14 09:49:41.424313+02	0031o00001i99VgAAI
bab45d9d-f7de-4523-8026-cbaed59fde5e	Nina Komora	$2b$10$7GR92jTVEPDeSKDNh9YN/e/2al1FHZqJTjfiKpGjhUki1ogJCGQRy	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:03.037029+02	2023-06-14 09:49:41.472086+02	0031o00001i99VlAAI
55d5d109-fdd9-4528-9baf-157bb1a9112d	Didace Aganze Banyanga	$2b$10$.35215DZ6N6S9I9fZGq6heQFRnuj8jzPF.TF5gQD6klS8W4daspc2	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:03.403211+02	2023-06-14 09:49:41.517178+02	0031o00001keqbvAAA
af169886-3f2f-4242-91ab-50d779ec6f0d	Chinwe Owhorji	$2b$10$D0HyP2SkV2wi0zuEptpbFOb4u5tLyAfoH.y5thfT8HH6uPmRyQfCm	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:03.658604+02	2023-06-14 09:49:41.551765+02	0031o00001lRdExAAK
4c258014-afb6-4ae6-b735-53640fb911c9	Nickson Mapunda	$2b$10$JPgYzCPLsou1iHMZiVkvNep7LnFFXULrpvdBQAhU20DhN7Zr04Cz6	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:03.945016+02	2023-06-14 09:49:41.599742+02	0031o00001lRdF2AAK
4dd82a9f-d708-48e7-bfa4-6ad9c024dc71	Gabriel Mwakalukwa	$2b$10$ISWdNA.5aCmHL3ssrb7Naem20bCElPtU69MtBLwJbnXSaE1AHY/k2	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:04.190732+02	2023-06-14 09:49:41.615666+02	0031o00001lRdF4AAK
deb75e27-050a-4fbe-abcc-86a1edb91787	Samson Ugbebor	$2b$10$f11bRWhEFRZyyNOjq3cPlOHjQAErZRWBv7ETXoGPPvuUVvxmu2Ldi	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:04.459971+02	2023-06-14 09:49:41.656125+02	0031o00001lRdF9AAK
91db36eb-9d17-4b9a-8566-f3f3a85f18c3	Alexis Annuan	$2b$10$rnplX7DTRy7pcgwjIqzzAO2VAyB3Fh5U0VHJ7seBIa16l0T5gzFe2	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:05.870601+02	2023-06-14 09:49:41.703479+02	0031o00001lRdMMAA0
d1f4131d-d151-4a4b-ab39-3ef648c29b6e	Caroline Bonyongwa	$2b$10$cg/CeXEP75xNrwV7z1kvn.mf8saOeFeg5P1UXpLpPN9sY8lU15nWO	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:05.074724+02	2023-06-14 09:49:41.778159+02	0031o00001nX6YxAAK
2cd6f444-57b7-42d2-9699-721e854dcb5f	Abate Beyene	$2b$10$T36Uso9a3UtHD/mVshAace05PhqiQqx3.YP4I7tq6gaPtBE3YLNSy	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:05.345928+02	2023-06-14 09:49:41.834373+02	0031o00001nXrAoAAK
35afd16c-dd54-4ea2-9eb2-9d75c3ab4b51	Nicole Ndamuso	$2b$10$dHbrIDzdPQK4nm9VlV4rROF25t0Rm9NF3hHBxwYAP/yT5BYIxrLVG	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:05.546471+02	2023-06-14 09:49:41.866931+02	0031o00001nYrSvAAK
7ac1d29f-ac8f-45ba-acea-eab4a238fa5d	Blaise Maisha Lushobe	$2b$10$IuWGOF240WIDfyriOshHJeiP0kgZ43we44mYGf2SO9N/gdrYvyh.S	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:06.121318+02	2023-06-14 09:49:41.945785+02	0031o00001nYrUuAAK
329f96f7-ea68-454e-a37b-7e3cbb8c53fe	Joffre Sadiki Ndyanabo	$2b$10$Fd1MMR0fOHpzF6eKkP9Xq.mhpb8XWWeJtTzCFnEVBS6LQqoNQDvHK	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:06.389823+02	2023-06-14 09:49:42.018708+02	0031o00001nYrUzAAK
262caeeb-5e72-4cef-af55-e9bac7e1ea43	Agnes Furaha Yalala	$2b$10$/.ct6G3AurYI8NZXTqGll.andQz5voH/LZ.nG/TP9enKS4Y6kIEU.	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:06.66482+02	2023-06-14 09:49:42.059679+02	0031o00001nYrW5AAK
545f445e-315c-485b-bf5b-052c557bf3aa	Claude Lukogo Mulengero	$2b$10$sVtBL1HGKBHss0eEEKp0curAoyKVQqvOoqSEKq7gJeC7bWdRoS4Le	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:06.941202+02	2023-06-14 09:49:42.097818+02	0031o00001nYrWAAA0
811dc400-1948-4809-b6ea-9ad3072eef40	Marcelline Safina Lingoma	$2b$10$BaH6ebWhVlChFu/DWB4pHuNRXSMi0W3.mrY/NjxnNWjGcF3H0gKxG	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:07.185436+02	2023-06-14 09:49:42.142981+02	0031o00001nYrWFAA0
08b6820c-e5ee-4339-8c6e-b58b7f2d67d2	Johnson Kansiime	$2b$10$HzcPeE.IbmH5c0yUNzDLWORllvBqE9ictj59rYrrLf.FDrznnQ8Hi	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:07.423499+02	2023-06-14 09:49:42.184609+02	0031o00001nYrdfAAC
8c84adbb-7878-413d-97c5-6cc4a3c8f71d	Bright Muhumuza	$2b$10$lOHzaLFNPOJA1c04d.x5Be1ibjskkqRolVvVkFKur5uN9gOIAcW3W	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:07.677364+02	2023-06-14 09:49:42.234998+02	0031o00001nYrdkAAC
bdf385ca-7080-4279-9a05-a75b3f3d75df	Annet Mbabazi	$2b$10$hn3DpaKrDbcVpZ0ehhWoiOZ2Y29swA1fmJEzGYURVfYoEe.f83CGq	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:07.917191+02	2023-06-14 09:49:42.275406+02	0031o00001nYre4AAC
f700e9d2-dea9-4e82-967c-1129171bc025	Caroline Ikiriza	$2b$10$ySwdbYCprV/mRAFHMpE5B.pqzUK6.Tst2ydF4au902vKZrNcARGp6	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:08.234409+02	2023-06-14 09:49:42.306489+02	0031o00001nYre9AAC
46285e24-128d-455e-b1c5-4a84fb89565f	Deziderio Tindyetaho	$2b$10$DmTjcO9mu7Ut5mly1JIOSup5UPqyPGH2cFfhd4NO/UKyUSE19yf.O	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:08.51836+02	2023-06-14 09:49:42.350127+02	0031o00001nYreEAAS
c8d5d122-eee9-4ebc-a1dc-1ba7694b19c5	Ernest Agaba	$2b$10$8zLaL6rKx1z7sANYU6KVYOP6s2ig2uSwfolwM7/D302g09daZAFsW	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:08.735891+02	2023-06-14 09:49:42.384501+02	0031o00001nYreJAAS
950fab27-ebca-4dfd-ad5f-02f4f1408c2b	Isaac Natumanya	$2b$10$QwVYo3R/zXy7Lw919I5BeuKsCydT0U7.zv9tQeEtI9gz3hr767ljq	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:09.003277+02	2023-06-14 09:49:42.429514+02	0031o00001nYreOAAS
3c4c6107-11ca-4847-94f0-041136b534ec	Julius Arinaitwe	$2b$10$N1I00lPKSuvxz04kyhfAie/OtkcaHDYPatQJyyjFKlcEktbbtNIJ2	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:09.290323+02	2023-06-14 09:49:42.465974+02	0031o00001nYreTAAS
71ec618f-115c-4707-901c-5ff9e245c933	Moses Mweteise	$2b$10$AC2Q91.bOlDi42cslWI2JeWXGVFYlaw.CSSczT5rNv3p6AR7OkVhO	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:09.573233+02	2023-06-14 09:49:42.497642+02	0031o00001nYreYAAS
fcb1c8ab-ce92-4b95-b26d-259842eca9bc	Penlope Namanya	$2b$10$942w5DGdScfwMLwXG.S15uZZaBSXPvXJRlw1ue0m3P.VdwfpaTnN6	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:09.894801+02	2023-06-14 09:49:42.537172+02	0031o00001nYredAAC
735698ae-76db-4f0f-a3a5-bd8ba43ff653	Sarah Amutuhaire	$2b$10$UqMJ41OKL4wcXaHPTF5PneTQXrUqx1HEanFH/y3c3RBmgD1yoaEMW	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:10.30168+02	2023-06-14 09:49:42.579185+02	0031o00001nYreiAAC
6ff1b60e-7c1d-4adf-8d2f-0ebe6463c17e	Zeriba Nangumya	$2b$10$sdT1e4HxqFZrmmLDWINO5OhspnvnlEOJNpfzq0bmtp5GJ14VfauL2	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:10.713751+02	2023-06-14 09:49:42.640562+02	0031o00001nYrenAAC
bbe0c33d-1000-401b-be9f-da7fd4279e22	Emmanuel Chirakarhula Ndusha	$2b$10$HcHoTj/4q24btGWXmhiYE.05.t1LFarJzBhDh1ALzWC5v9BuTReVS	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:11.102679+02	2023-06-14 09:49:42.714984+02	0031o00001pwaavAAA
bcb83f39-88d1-4c2f-819d-9d0556007ad6	Tamiru Elias	$2b$10$3lNoAnCX/CwHOn5gPLuZbeVNLDoFS0WUn1wNF04/E6pPG5HXwNtVm	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:11.249288+02	2023-06-14 09:49:42.863175+02	0031o00001pzv5HAAQ
83f98c26-ac09-4f0c-a8e7-e951331c9ebb	Yiesak Gali	$2b$10$9c2IM6IfbkfbQ0tbtWfiDu2KleLYJhvWgR2v5.70Qk/xeMm3Q14uS	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:11.564262+02	2023-06-14 09:49:43.122153+02	0031o00001rDvZMAA0
dfa1d8a3-f28c-409e-91af-c8d6f5eec37e	Alejandro Marchand	$2b$10$hXnA4kkEg7aaPMSBosZPpeN7C7rDNrUwuB8UI126a3bv.i6CGeMJK	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:11.851633+02	2023-06-14 09:49:43.194551+02	0031o00001rFWUOAA4
80572e8f-66ea-4368-8523-ee853d84ba6a	Isaac Kashumu - C2019	$2b$10$joXT1EVp/MkjEj.XMWS8DOdXmere67dREUXACwrwK/y7zUdG6p3AW	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:12.104506+02	2023-06-14 09:49:43.311771+02	0031o00001t2iysAAA
c275283e-ab2e-4283-9868-b7c9c3e31484	Gertrude Kyarisima	$2b$10$IsivV6bMxHsTVG96ko6amenZqd1PHZ4b8WjcarRX3PS5wMPHZWmLm	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:12.312448+02	2023-06-14 09:49:43.355258+02	0031o00001tPEf2AAG
f3b15fd8-b6fb-4e1b-b788-94fc900e3eab	Misira Aba Zinab	$2b$10$B0Ix1/FoEljoUPRBJwMq.ez0j09fBAzdk1iqcFtUzhWgQEjtLnCkS	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:01.327571+02	2023-06-14 09:49:41.176034+02	0031o00001i7jlHAAQ
88d9786e-5ea7-458c-8d8f-8ea73fd4942c	Nigatu Tadesse	$2b$10$DufjgKrsY267YmNKNp1mX..AdJEwa5Sq4QpRQIaxalCv4TVtu4lne	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:01.988595+02	2023-06-14 09:49:41.22413+02	0031o00001i7jlMAAQ
7f991ba8-e099-4783-a3b3-5ed15f2540cb	Abinet Dulume	$2b$10$ngQg43GT.qWCIq2sRTRI1.ngZBU5fBObGCQspExy/h2T8C.Nqpqzi	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:02.093984+02	2023-06-14 09:49:41.287533+02	0031o00001i7kFcAAI
13302341-f3c1-4bca-b9ee-7bb69c9cb8b4	Amsalu Abate	$2b$10$Vwo9FOGR41fXP1YjOO.Snu1yM9vFWlCfO7qWKOpNj3d4iVGi.swtC	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:01.79326+02	2023-06-14 09:49:41.300628+02	0031o00001i7kFxAAI
1f67f772-f0a2-4cd4-abb6-5c76a44e8561	Wolela Desalegn	$2b$10$C4UUj62xRtiMuxm7ZLPNKO.0kuQkewopxYba.C6kmSuEBF792fCiK	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:02.533383+02	2023-06-14 09:49:41.383294+02	0031o00001i7kGjAAI
dda6ef8a-25fd-48d1-b768-2a4500002818	Ian Mwadena	$2b$10$/Z96IcAjC3lsOY4jFM95x..EAtirsxm8dzf2GcTIXB2wmIH3UgQia	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:03.097692+02	2023-06-14 09:49:41.483524+02	0031o00001i99VmAAI
7a772695-feea-4fca-b8a3-f2808bc35d79	Neema Mwamini Bagalwa	$2b$10$85Xjvq.02zJW2YonLKvAXuyOPg/ntPlRUXzl9aPE0TtxOS1jXnOwK	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:03.466026+02	2023-06-14 09:49:41.521424+02	0031o00001keqfcAAA
8182d6d2-e698-4627-abe4-360b1549490f	Busara Clemence	$2b$10$fflmeUVs49KYgVleIz4SQeYb5Q3Jp7wviYoKMyu3DwFwKC57Pj4ZW	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:03.724902+02	2023-06-14 09:49:41.568444+02	0031o00001lRdEzAAK
0ba0e5bf-2c2d-4be9-81c1-fa17467d3031	Mary Gobeka	$2b$10$4ZWGc8efsEw0EW2Gc0Yhju78qMkz8zyKZbguOEEW/4JdqFX21VtGm	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:03.993845+02	2023-06-14 09:49:41.604882+02	0031o00001lRdF3AAK
972f0c7e-acdb-41c1-8676-bf397316ed9a	Michael Mwaigombe	$2b$10$QypHy80.PSE6Y1D1HJ/qteex8iOzXJbQC84WLklwfMcH7/zopICF6	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:04.235813+02	2023-06-14 09:49:41.62072+02	0031o00001lRdF5AAK
5ded2739-2ef6-478a-84eb-3a141ac84e7d	Augustina Urodhe	$2b$10$C19MxllmRiHEN8GngsC.5./ui0mnh2ZqmkMHG5hiDiG0JzpOJSUx.	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:04.508074+02	2023-06-14 09:49:41.66894+02	0031o00001lRdFAAA0
35f2be9b-5e64-4f36-a4f9-082d8acca19a	Patrick Memel	$2b$10$l8hY.aF6YgC0n9hdjKp0OOhz4JKtfu70N9Hq9o/qr5o5cw8h83n2i	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:04.842785+02	2023-06-14 09:49:41.748357+02	0031o00001lRdMQAA0
2bc78b80-14e4-4e94-ab46-10cd8451312f	Tamiru Teshome	$2b$10$GyO1/tcQ4M4XdX4LUedPR.xG6zm/MmlAXqe2efQtDYzORouWf2276	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:05.136849+02	2023-06-14 09:49:41.782272+02	0031o00001nXmcDAAS
02185156-a16c-4611-88f7-a6cea57e253b	Vicky Byanjira	$2b$10$yTHTF1y4k.AS4gh0tX/5LOSOmyUUdgjjR3xvu7IwGoSrn4sJmfRFK	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:05.435436+02	2023-06-14 09:49:41.839085+02	0031o00001nYrSrAAK
50c3786b-d6f2-4bba-8cb5-af592e6201cf	Solange Mastaki	$2b$10$rySqsDoJpXzEY34NIFtQxeGyk5kORl0kj0K5jQa5tvsDXsiSDBOcG	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:05.581555+02	2023-06-14 09:49:41.881167+02	0031o00001nYrSwAAK
563b0290-9aa4-49b4-bb3f-9aa35eb8397a	Dany Fazili Bahati	$2b$10$f0wLPeO.IDjDf5RUapAAK.BllmrqA6dx7qnhyGZqov6wvpO9m9py2	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:05.930986+02	2023-06-14 09:49:41.901209+02	0031o00001nYrUqAAK
f47ed611-3b98-498f-a4a1-70367e5780dc	Bon Muhigirwa Kayumbu	$2b$10$u.ke3nEaH/4z.muzcWqS8uxFeEEGjWFmKd29V33kC6eGeXW84d3wK	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:06.182312+02	2023-06-14 09:49:41.950932+02	0031o00001nYrUvAAK
5813a373-b870-470c-a98b-e5a1360c4b6b	Viviane Shukuru Ruchinga	$2b$10$J8YsKBtaKWZWlSoyZbsQ7u2kk3hHKOteYMV3z9T2fQbk3EpW4vofe	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:06.41182+02	2023-06-14 09:49:42.030589+02	0031o00001nYrV0AAK
adacedfe-6f9a-4b73-ab6f-53f84823401b	Norbert Habamungu Musenge	$2b$10$Kc8Kk/uSoIG0QAteQy59g.753TRKS7HmlRWX8OXqjHnPVgHLWPhFe	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:06.744092+02	2023-06-14 09:49:42.066384+02	0031o00001nYrW6AAK
4dac1b26-44b1-4e2e-a5b7-b5561c81f455	Christelle Mapenzi Rukeba	$2b$10$FX4sAjZqlk22zJgPqCY9s.JmK10p7GOG9W9sFDfHP2wQSp3cGcib6	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:06.966178+02	2023-06-14 09:49:42.112164+02	0031o00001nYrWBAA0
7d5b7e16-5a13-4367-a96e-55dfeaf67086	Jean Claude Wiragi Birikali	$2b$10$hW10qdE.TAGanv9s3H9qeeeShp7lHBZQ0KRI6rJqBPu0N1pW80w3W	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:07.248372+02	2023-06-14 09:49:42.149077+02	0031o00001nYrWGAA0
a59ef1cd-c6ac-41b4-b1fe-a25fde275e1f	Vicent Ayebare	$2b$10$KyEUuMNzDGDJoLuY/3wjJeMrRDWCkIuN9dVGr2WNWLiWUmqlqA91W	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:07.466689+02	2023-06-14 09:49:42.198569+02	0031o00001nYrdgAAC
2f085127-6f67-4dec-9a76-c0f9da3b1476	Aaron Nahwera	$2b$10$9IUKz6EFBmH5leKTeBKJcujB3sjeaLikBXb/m26RrsjtKZ.18YJdu	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:07.747729+02	2023-06-14 09:49:42.244624+02	0031o00001nYre0AAC
1dd3e44a-8a71-4cb1-bed7-2b0a5d6059ba	Benjamin Byabasajja *inactive*	$2b$10$KdoTJEwh0/UHW7T1lqKVnODxznloNPJO2vXdqqp0QuJ94ZdRstwse	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:07.97194+02	2023-06-14 09:49:42.281035+02	0031o00001nYre5AAC
0c117410-92fd-4255-87c2-0378e5c7fd6f	Charity Nasasira	$2b$10$/itwUxu0YLkdhIPprudB4ehLSRgjeh0A8cWaIMTE3mc/mN5OXzzTa	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:08.309027+02	2023-06-14 09:49:42.314071+02	0031o00001nYreAAAS
323ac62b-5256-454f-bbcd-dfb0d7053aa1	Edgar Mutamba	$2b$10$QMVMESE94ZewCZcVGjD4d.9XsaO9lcz5sgnwi9WSuAZxz5FMYfS9e	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:08.556431+02	2023-06-14 09:49:42.357552+02	0031o00001nYreFAAS
e6df2bd3-129b-4b1c-8b01-6aefddc5944a	Evas Ankunda *inactive*	$2b$10$oc8EeDiJQmEGxh7ZFJpqq.OLSYGYu9RU4./CCsaADVFJHyv27Ce8K	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:08.778122+02	2023-06-14 09:49:42.398179+02	0031o00001nYreKAAS
7e5d2f0d-0b18-448f-86c9-3df87989cbd1	Ivan Tugume	$2b$10$xAjQlyCipIG3r2o3p6mcOuHAzeEICRnrHxQU0p.yffuOxNhxVTlTu	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:09.04753+02	2023-06-14 09:49:42.433978+02	0031o00001nYrePAAS
14cf53e2-6698-4d77-aa10-198f540b1777	Liphia Atusiimirwe	$2b$10$i8XCceStrQee0wEE6VFQs..cpcKrMBOdbf/FxOqJg/xSK08ZHLLXW	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:09.347837+02	2023-06-14 09:49:42.476115+02	0031o00001nYreUAAS
3bcab5d3-a06f-422f-a4ee-9f980c3ee100	Moses Ngabirano	$2b$10$JUbMMliz9hgeN1KvgvVcD.vSN23s7DQ4r8O.Y6ysz59H4unlkm1Mi	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:09.662649+02	2023-06-14 09:49:42.501263+02	0031o00001nYreZAAS
45cfe169-416f-4811-ba26-305cc969fd45	Richard Nareeba *inactive*	$2b$10$44UGQ5Ibkz6MYWZGuNINlOe/Vza/kxYgIRwDl9i3GNucWBi4X72wi	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:10.019629+02	2023-06-14 09:49:42.547756+02	0031o00001nYreeAAC
de4e093a-f1bc-4bd2-940b-8c037c922c32	Sarah Kemgisha	$2b$10$e5g262LGZDaUgvxt3mjsxeL3OCU.9vRQRuCRW/cfjCIGwzvEKM2Qy	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:10.40087+02	2023-06-14 09:49:42.586531+02	0031o00001nYrejAAC
478643e8-67a3-4b2e-9948-c8c4c969b365	Faith Muchoki	$2b$10$SelQ2Aw0F.ZQsw/GCRhb.u19Z4j4yYhr8puaHYp4QfzejyCI46TG.	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:10.783663+02	2023-06-14 09:49:42.650657+02	0031o00001ovAvCAAU
8559043f-7c1a-4a04-bf66-027e03aebd7c	Eyob Alemu	$2b$10$RokKAJBSwSA9HimcqCSpL.r6M5d96R7Pj4yWUq4sp0whH9WXxeezC	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:11.106314+02	2023-06-14 09:49:42.725155+02	0031o00001pwoTNAAY
c69bb344-43aa-4057-8c64-ab26b10ee907	Petros Batiso *inactive*	$2b$10$rV4/16fWuL/ojYzXGzlv3OfwB63TGwKcSZROdwiYtTupzuztd/ORW	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:11.320476+02	2023-06-14 09:49:42.992745+02	0031o00001pzv6AAAQ
976b5154-587c-4a5e-ad20-cda6a8da15a2	[Inactive]Adriana Rodriquez Rivera	$2b$10$WC6HNBMJJuq0onmLqqYj2ueXi.qpMJp8tHW9w9gDQ/.oDxJlro2s2	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:11.618793+02	2023-06-14 09:49:43.140392+02	0031o00001rFVOAAA4
7086bca4-5b9d-46d2-9eff-fa093f151439	Alejandro Marchand.	$2b$10$IffziRJvXxUvQvIQfhVXG.lhfw1/tfPZ/lfET/gdFpw2LdFYyTa/K	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:11.90123+02	2023-06-14 09:49:43.22309+02	0031o00001rFfVwAAK
1ced3cf5-4955-4ad8-9068-7ffd7dfa7e47	Lemi Tagesu - Old	$2b$10$MpOWu5nWJ99GVBoCSXaI.OCBooC11ssPBoGLpTY0iAQnOID.FMP5K	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:12.144274+02	2023-06-14 09:49:43.323481+02	0031o00001tOcWtAAK
24ba4243-2bf9-4a6f-b123-3657544405db	Margaret Wangari	$2b$10$3A24s2eaIgtgiSXF/Zrqfe6qNYf8wcNhaeStNXKhhgq9VbvG5EZRm	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:12.422749+02	2023-06-14 09:49:43.361485+02	0031o00001tPErNAAW
cf20baaa-c814-44e7-b05f-13cac69d69b5	Muftawu Aba Raya	$2b$10$/j89PYNGuXBkAtp/M0VoIOo.z23MamDgZeWGk81lD5gJbd2pd.7uy	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:01.381601+02	2023-06-14 09:49:41.188427+02	0031o00001i7jlIAAQ
33f8fd38-e364-4daf-8fae-74f9fec5bff0	Rihad Taju	$2b$10$0NoUdLs862Oe45ATd44W6eu5oKe2WY/cS5NsTo0qOvoAz7aqp64C2	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:01.558665+02	2023-06-14 09:49:41.239618+02	0031o00001i7jlOAAQ
29019f82-ecb2-48b6-a3a7-f3711769cc50	Abreham Docter	$2b$10$LRQHIVnGn8UNXFW8g8Cq3ue8zGt.tdw8v4KVzrYWHbo.EVeoZ4H1C	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:01.840469+02	2023-06-14 09:49:41.307127+02	0031o00001i7kGaAAI
8a201011-2b6f-4f75-b77e-028bcd2a9fa9	Bino Birhanu *inactive*	$2b$10$D8573b3r8Mh22pYoqmjmTOJCL3fAlaiovXBSS.TBjeXoHEPqDnSmu	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:02.237194+02	2023-06-14 09:49:41.321695+02	0031o00001i7kGcAAI
1b95aed2-f909-43be-9c40-98aac0375107	Engiso Elbassa	$2b$10$TXpck/liWXyJ3X6.0wXYSejIYtqWcMY9BMXsom/Q0pGHYxj0x98F2	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:02.865546+02	2023-06-14 09:49:41.365203+02	0031o00001i7kGhAAI
ae821ee7-626d-4443-b3bb-d65b73a83518	Yaekob Warsamo *inactive*	$2b$10$9IRirenfTPLQnDhpvA0n.Oj/esjhuyHlcaxs4cRB9mZ2eFo3LhTYu	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:02.538493+02	2023-06-14 09:49:41.390237+02	0031o00001i7kGkAAI
45810868-6f13-4ce4-98bd-ff54e2107b1b	Tumaini Ruwa	$2b$10$7NTZWg/pK2q.PsjmNi9rHOFksssA/FuabTMxm/jWbgNKDvS3v7XAC	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:04.040799+02	2023-06-14 09:49:41.430444+02	0031o00001i99VhAAI
4e52f5b4-7716-4a99-8dfa-ee798203d4ed	Fatuma Hajila	$2b$10$2aSDWfholJyMU2oBiF2gruoOF0so83uoxx0fyiQyVeOzWeBZ/dAsS	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:03.13455+02	2023-06-14 09:49:41.487188+02	0031o00001i99VnAAI
673585c6-32d5-43e7-87ce-c0f9b789bc98	Emilienne Mushayuma	$2b$10$s9BhZBBxkJDv/olkI0FIyeqK9yacKsbS.QQmkEOCbutPEj3CpvQj6	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:03.50687+02	2023-06-14 09:49:41.533575+02	0031o00001keqfmAAA
b0ab4cd0-4a12-4514-a812-84ea5a497e48	Edna Mwampagama	$2b$10$ejo6GwfWi1XYPJ1rvl5xf.uD3VaDXdOSRfO0NMwTEcFLg6HBpPdEO	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:03.786158+02	2023-06-14 09:49:41.556218+02	0031o00001lRdEyAAK
9679c82b-252e-4207-96ce-fc5635879622	Yasin Swahib	$2b$10$EcEdCBYosWVVr9/zpv3SkOhp7OTsc8n5qqiZmonuSzuMlAHpIDdCm	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:04.307426+02	2023-06-14 09:49:41.630418+02	0031o00001lRdF6AAK
3266df32-2052-494f-8656-c0ff1951836c	Honour Mutambara	$2b$10$ij6hqGn8O73ghFeXb1vD/OEl6FUhMGlM1mdvyirJDrgfMKTs6SEnS	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:04.908283+02	2023-06-14 09:49:41.752715+02	0031o00001nX6XjAAK
ec8261e4-4c84-4f7d-890f-e8d3f6895426	Abate Beyene Old	$2b$10$fYx2K.T9hBrfZni9.418SeCxuq2HZYlXqtjmqjU6.0qxxJmffIFuC	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:05.18432+02	2023-06-14 09:49:41.796112+02	0031o00001nXmcXAAS
2723c292-a186-48dc-8a92-69ece5f434fa	Innocent Amani	$2b$10$b/hGqvYIVVFSoYbRpSHMpeen5dmk1dLeAlvmy8SgcLZ0ICuH0XZ8i	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:05.439647+02	2023-06-14 09:49:41.850101+02	0031o00001nYrSsAAK
ab27d4d7-b5fe-4193-9f24-4472880eae00	Mathilde Ahadi Bahati	$2b$10$8XPHYoDT2RXhtRbj5e9o8uiQpR.qG.35/wT1hcwUHJIrM9/I3mmGu	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:05.64514+02	2023-06-14 09:49:41.885751+02	0031o00001nYrUoAAK
8f07ac3b-db75-45ec-9d06-2696451591cd	Jules Iragi Habamungu	$2b$10$Rg0EF/bzqUN3HmJ93Vlb2ei9iJ1Dck1MUgntlSSDiM5htqCX1ToiW	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:05.962772+02	2023-06-14 09:49:41.912861+02	0031o00001nYrUrAAK
006f1afc-b5b8-4d70-8adc-d06d103fdb01	Prince Mupenda Abajuwe	$2b$10$CVmS9KtnkLmheEfR5QM0k.85YNeSorMy6EMU74BEtE8lNFEzISbse	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:06.224678+02	2023-06-14 09:49:41.954697+02	0031o00001nYrUwAAK
b9ebd9c0-6117-4d1d-905a-b3dc668aa0a6	Yvette Yotemema Minane	$2b$10$YtgtkcA1has9Y3egTI7fz.8xy/lv4CDzMyP6PNvQIAR1NOu8zFKCa	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:06.492445+02	2023-06-14 09:49:42.035585+02	0031o00001nYrV1AAK
06b8aa5b-e8f3-4f20-91b0-b99329049ebb	Defao Heri Shamuhuza	$2b$10$ExVkpXm38Ryudmxn2z2iBOsFQGsgcYDvcX6EG3fUnSgV/yQsgmsRe	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:06.797044+02	2023-06-14 09:49:42.076386+02	0031o00001nYrW7AAK
8da6f644-1856-48ae-a54a-f121ab1578ee	Grace Mugisho Safari	$2b$10$OohRFlQdPwafFLt.WEK7GeLqG3KIwJ0Q9D6FXKW2D6nJqvL12WZD6	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:07.026615+02	2023-06-14 09:49:42.117553+02	0031o00001nYrWCAA0
80a97720-5892-4074-b8b6-8c24d7c244d5	Francis Mugisha	$2b$10$gXo50.3fOFv9//tTYLuP..d1/QE98a09ydeDF54kVE8yIu8x.DewO	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:07.287731+02	2023-06-14 09:49:42.153375+02	0031o00001nYrdcAAC
0a1515d4-e889-411c-8f9a-805849ae3bce	Enock Ahimbisibwe	$2b$10$LD2gqRuiNSEEYbMt1J505.F8nwh/2rfXkWMthXcBCx1B7XKfpT8U6	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:07.511185+02	2023-06-14 09:49:42.202938+02	0031o00001nYrdhAAC
52773565-3d1a-46f5-b190-34606a7769eb	Allan Muhoozi	$2b$10$Eo3hug6dvdQwZzoHc1/PN.ghOS1egB4NDVAFYpnxV2VOCTKNRm8yy	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:07.76741+02	2023-06-14 09:49:42.250613+02	0031o00001nYre1AAC
1d307b6a-c5b2-4a85-b3bc-f6465777b816	Boaz Habasa	$2b$10$9t3tFlKuOhvvXsyT8JPI2es0AQRhY8w4PL7EO7vWHe89b43e5pmCm	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:08.006295+02	2023-06-14 09:49:42.285792+02	0031o00001nYre6AAC
36508b0d-2c22-4001-aa0e-fd719f07b08c	Christabella Ainomutungi	$2b$10$oh/BhqIJUdCz6eIYoiPTu.AJCz6f62hVvzaWxsr8MPmtnVOFTe4Pa	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:08.352482+02	2023-06-14 09:49:42.32581+02	0031o00001nYreBAAS
8bd96d83-1f7c-4c60-93d7-5671775f035c	Eliab Twinamatsiko	$2b$10$MRfofHE6CA0X.1Jp7ec9jOjMd2ss2M.PTqae4GQhOUxcbCbyq1che	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:08.608684+02	2023-06-14 09:49:42.36196+02	0031o00001nYreGAAS
d4202535-c74d-4cd1-9c9d-e4f7f1b2a94c	Gerald Atwine	$2b$10$0DkjG8QqKZlZcnvcFvDkVOtISPaYJ4Sxycd2G29hW/UL/IgtcfpBS	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:08.814676+02	2023-06-14 09:49:42.41351+02	0031o00001nYreMAAS
8577d93c-4555-497d-a598-213b167f6d92	Jenina Akandida	$2b$10$MDE5GEAznRDNiwZ573zdfOBfk02LsFpQXMHhxq75O0SDRSmuqUtAe	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:09.109366+02	2023-06-14 09:49:42.442194+02	0031o00001nYreQAAS
b1bd5571-840c-4809-a399-64965fea9876	Mariat Nasasira	$2b$10$TVeuvvL83Mx32EQihd3OpOBcr0IVp3EIZgr9hfF.hKe/9g6HLnyam	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:09.383363+02	2023-06-14 09:49:42.479545+02	0031o00001nYreVAAS
ef585dfa-a20d-4902-9995-3eab862c8cc3	Nelson Twesigye	$2b$10$BWFW8UtKMh.BPzwUseqhiuEPJue.eG/NmB.QHvFBwk5t2TO.sTEmu	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:09.774438+02	2023-06-14 09:49:42.509982+02	0031o00001nYreaAAC
16971865-630b-4704-9ce1-5a695b43abd8	Ritah Kyomukama	$2b$10$yg4yO3ozwg5goAyF0es/Xelj/4YY0qPEIo8Tvguu2a8jAM77NucKW	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:10.118892+02	2023-06-14 09:49:42.559658+02	0031o00001nYrefAAC
1279f1e9-d698-4bb5-90ea-1d3b08e987b7	Silver Mwereere	$2b$10$sWGUVVMZ0ixFNprK6tWEw.ijWVMHFjAX1Z68kERnNWU6s.3.FU1jy	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:10.453444+02	2023-06-14 09:49:42.593234+02	0031o00001nYrekAAC
970431ab-f272-4e8f-b0ec-c39e7cd3527b	Dan Tayebwa	$2b$10$HLltAzWjETbgAfRCKGKh7.oOhfNdu81MwipvsL5sn0qKWV9DM986m	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:10.850151+02	2023-06-14 09:49:42.680584+02	0031o00001ovBe9AAE
53396321-b957-44dd-85cd-8b27bf296e4b	Asrat Alemayehu	$2b$10$8zwfiezH2chNzDixKB8KGO2fczVeQWxSYH1nPexmDluYZ23MfZ3Ne	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:11.110179+02	2023-06-14 09:49:42.743099+02	0031o00001pwoTcAAI
a38ffd28-74e0-4a27-8dd5-3a240dfc6eb6	Hiwot Hariso	$2b$10$7BuQgGRTQzd6mG.1G0lsw.X7BVxun.Wn9rdMt2a5qw9C8xxdXN5D6	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:11.381327+02	2023-06-14 09:49:42.926121+02	0031o00001pzv5bAAA
063494e9-ff07-4101-b40c-6ec0ea5ee719	[Inactive]Alexander Maldonado	$2b$10$PsVzx5tBicKCpQ2CzkT88.9KWbSIzErE2/wmrRLv7GmhUp4prfUde	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:11.719381+02	2023-06-14 09:49:43.159708+02	0031o00001rFVOBAA4
3d743b35-c9f3-4e78-8803-a180073a3866	Samuel Bashige	$2b$10$1iRnEh9eOIsLE/9gKF9uqOgL5a1BcZ9kxavqm.EH7xazQmmeEW/xS	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:11.929332+02	2023-06-14 09:49:43.294897+02	0031o00001t2fdrAAA
540bc733-fdf5-457f-b6cd-35d2c8bc6c94	Amsalu Abate	$2b$10$2GKVqodWf0dx.nwYTk5Fru/nJhurBMfwJ7zXqJElXHMFkJgY/B/rK	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:12.17361+02	2023-06-14 09:49:43.3287+02	0031o00001tOvKCAA0
1cfeeb24-f6e0-4bbc-8d72-503d40e3f9f4	Ann Wanjiku	$2b$10$ORxF9QirlXVdF4HcVkm32O7j06u2kbl0FvE3i6YcL.7V9saq6owd.	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:12.462879+02	2023-06-14 09:49:43.368949+02	0031o00001tPEw3AAG
ba4f1460-ff6c-46ed-950d-2f10389228b9	Nejash Aba Temam	$2b$10$5DZl/XNlkXruJlViluJmJuU/9SefdUF2tTDgGBdZMgQNSoIfJEyzu	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:01.447438+02	2023-06-14 09:49:41.207205+02	0031o00001i7jlKAAQ
2bf7f853-9e72-420b-8b5c-88f0e144c6fd	Turtu Gali	$2b$10$DyYKXKj8bBKhi5uifa4EiOOL6D0DoGZzNMuKwxqBxZJSOP49GGyvS	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:01.600506+02	2023-06-14 09:49:41.257133+02	0031o00001i7jlQAAQ
9dbb36e3-10e3-40f3-b2cb-beb942b7d869	Debebe Duguna *inactive*	$2b$10$rWNvnc85AeQsyOppVrGZG.cCrTZ29mifK/T5nNDK1Uv5i1.508QeC	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:02.296399+02	2023-06-14 09:49:41.331983+02	0031o00001i7kGdAAI
f0fbf14d-7b04-4e72-be8e-8f021677d72d	Derese Boroje	$2b$10$S8LBrDLpqTamEG5GBKJxBeZli9kF3g2ZiXwmqOpBHfHZOagJBmRvS	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:01.902897+02	2023-06-14 09:49:41.337944+02	0031o00001i7kGeAAI
969fc8ee-3557-4f99-8f64-d1bd6b7ca48d	Josephine Kapaata	$2b$10$f9dPKu3Q6NLeHsErkhVmFuKy34CmRxE1ZvpxwEJTBiDwKfpHa1ASS	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:02.60813+02	2023-06-14 09:49:41.404803+02	0031o00001i8NzrAAE
d9cf4297-acbd-4560-b2a7-dd99aef72a31	Catherine Mulumbe	$2b$10$cW6dTIwi1OYijD3ees7x0OyEpQ0HPCM6U.uwm3O4k2njAoVdQJK9q	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:02.917589+02	2023-06-14 09:49:41.415789+02	0031o00001i99VeAAI
a047c2e8-bd57-4028-951c-ae96d27b59c1	Godfrey Otieno	$2b$10$L/AYDzKt0HvYkIte6nxkoe4yIUFSgnbo9/hkfxHCudpnPFnZdDOI6	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:04.10967+02	2023-06-14 09:49:41.43587+02	0031o00001i99ViAAI
a39ab306-a3fe-46a5-8369-e62015b42256	Timothy Murithi	$2b$10$JZYMYGLwec9i42rioXZUZO10lW0jrcq6DQ567CbxHNAZ1yni6WyiK	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:03.216295+02	2023-06-14 09:49:41.500895+02	0031o00001k2Iz5AAE
3fba88ec-0039-44fe-a4bd-6753bbcc606a	Alemayehu Mamuye	$2b$10$BGmM7oKiuH5VwOIKh5cOwOmGh/8.AWmZ6KwSZoVphGLnvVGd5FBmC	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:03.565191+02	2023-06-14 09:49:41.538321+02	0031o00001lQtBLAA0
2d82fc90-4e5a-441e-a16f-480de85675fb	Blessing Enetomhe	$2b$10$kOdW/vcMn1HAi7/m0LkjkegLcgHVGSqABir/A2x4rP15LzTaXR5J6	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:03.836431+02	2023-06-14 09:49:41.582053+02	0031o00001lRdF0AAK
02bbb7e6-a6e1-4caa-be5a-f418656f82a1	Joy Gabriel	$2b$10$D1Z7R4TJLYbBlOIN.A/PeevKUpcmYOLsNPL6xmATcDk1fnS7Yiu7u	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:04.34964+02	2023-06-14 09:49:41.636228+02	0031o00001lRdF7AAK
f3a41255-b858-40c1-8b43-dfcec9b6a2d7	Liberty Jack	$2b$10$SeFCkY2EKM4LBrx8mI6iLuqAM3c1gp1bh7IL.kTxrESScI1JUpCvy	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:04.971607+02	2023-06-14 09:49:41.758552+02	0031o00001nX6YvAAK
6ac86e6b-3546-423b-aedc-f940ccdd72f5	Konjit Kintamo	$2b$10$OsGfEtKoBVKVjQGK5NaWBulPAhpzps14R5vNx7HCzohoP.Pa/f4Ay	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:05.213088+02	2023-06-14 09:49:41.802681+02	0031o00001nXmchAAC
279d6dbb-7bf3-4665-9d67-13ec8ee16489	Marleine Kitoga	$2b$10$Km12IPHq9rHcns1BA7USEuEeXOvPlM0lVWqnhi608fmFeprKl8qa2	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:05.443987+02	2023-06-14 09:49:41.857902+02	0031o00001nYrStAAK
14aa5667-e27a-425c-9d9f-fa7856f2f0cb	Bertin Byamugu Hamuli	$2b$10$m1tfnAC/FF78HHn3sa0zieYKNvqHrr1ighjW6N2WYXed0GsnqSS3a	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:05.709984+02	2023-06-14 09:49:41.896413+02	0031o00001nYrUpAAK
753b55a5-5d9d-4df4-a099-8cb72a82ea01	Emmanuel Kabumba Kunywana	$2b$10$ig0LUFACqESV/pO2vdAtHe//oJ/g7fuGBKhnbS/ENcfaBzkZ/M.NC	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:06.016402+02	2023-06-14 09:49:41.919181+02	0031o00001nYrUsAAK
5b73a8e9-181a-4d37-833f-924beb37ac73	Divine Nabintu Kashosi	$2b$10$WAXW5xDpoTjULE3mcEY22um7nhmgpmb240jhUwZc9cHF5U75a35xe	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:06.280668+02	2023-06-14 09:49:41.999661+02	0031o00001nYrUxAAK
efdcda91-919a-47d3-9479-950015834568	Matthieu Byamungu Marhandanya	$2b$10$kJDqdgj6YQ3ipIOdkV9WYuc1lNR820UIPai40.wkw31UK7wIyLI/i	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:06.54257+02	2023-06-14 09:49:42.046787+02	0031o00001nYrW3AAK
ec578d82-2a9b-4eb7-9c69-087875e77d4c	Martin Kabagaya Bakengeza	$2b$10$AenhHmWDeiIIvY0z6Wq/Vu.XJrWyUic6AS.9DbhmlGpdEdAvRq7va	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:06.835503+02	2023-06-14 09:49:42.08253+02	0031o00001nYrW8AAK
7cd471b7-aabe-44aa-9d13-f13e370dff83	Enock Mulume Kahule	$2b$10$wpAkLdIto8X/FTdOfDWGEubMY8k2iYWx8ozOT8GR.5BXas7JutVDa	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:07.089973+02	2023-06-14 09:49:42.127076+02	0031o00001nYrWDAA0
cd7f3ec7-214f-4164-bdc9-5201d517202d	Micheal Ahimbisibwe	$2b$10$aTuNdMiCz1sZCc7rd38cwehxxcyFs5/Je0Yio6dxWS1uuT/HBWg0e	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:07.333858+02	2023-06-14 09:49:42.167196+02	0031o00001nYrddAAC
2d863a74-92d5-4758-9c5b-e2eb5e872c24	Edith Kebirungi	$2b$10$gcBbkqyBnJqfYbj1xstcf.3Eg5Gomd/2tQn.XHuDQV1pA9QbIPzmW	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:07.553346+02	2023-06-14 09:49:42.218105+02	0031o00001nYrdiAAC
5f46004a-9422-4358-8c52-4e590aaea1dd	Amourine Amutuhaire	$2b$10$RkqgV2zZ/CgkxAogec7cS.7u40BBa0UWB.FHBmuL481uan8ud1Y9W	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:07.815446+02	2023-06-14 09:49:42.26015+02	0031o00001nYre2AAC
39758bb9-c72a-4e7d-9693-21369bd5587b	Brenda Ainomugisha	$2b$10$QlJnTrlWfU9S8Y9zA6eD3eBzmYKNA4c0qutnWtIWIixhql9SUkdyy	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:08.064218+02	2023-06-14 09:49:42.292946+02	0031o00001nYre7AAC
d262f288-3ad7-4767-92dc-30a7bdbbabfa	Denis Twesigye	$2b$10$/rIkjReuB0zBKwzSB/ZJ1O0GN4m6QlPKr/5ygcuMt4HbZJBFiDie2	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:08.406801+02	2023-06-14 09:49:42.335118+02	0031o00001nYreCAAS
fbf65e68-836e-4ef3-b97a-f8b024f8e734	Emma Naturinda	$2b$10$dlMC7V/b6w8d5t2y/CjLXuc4dyUfYTNwrnpBKpWYU24gVFs01J/E6	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:08.660906+02	2023-06-14 09:49:42.374964+02	0031o00001nYreHAAS
72843fc4-6e3c-41c4-9b54-c17c53777605	Evas Ayebazibwe	$2b$10$07PEkrt2Vv.7iN/99k4biOL54gSyKukUklZpnP6R.tutdomZWUyCq	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:08.874136+02	2023-06-14 09:49:42.406834+02	0031o00001nYreLAAS
8c99f27f-b716-47f7-b218-31e183730c05	Johnson Bamutenga	$2b$10$qKKeNoafDu.F3esoy2I5g.zgvA4gHUjdWr6mJ3O0mMRyxZkbRsuXm	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:09.166403+02	2023-06-14 09:49:42.446528+02	0031o00001nYreRAAS
60ccd514-c125-441c-baaf-05f59ce6e219	Michael Byamugisha	$2b$10$5vQw31naOC4eFNtne44OjOFK1EcZWrkzg/.lxkbm6vauYcLTAHRqG	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:09.435396+02	2023-06-14 09:49:42.484447+02	0031o00001nYreWAAS
9997edfc-d828-4791-9be8-11f36e99d53c	Nicholas Muhereza	$2b$10$M58U3bkNQPxTWJUMQW.6XuLrobOPcuQrnoEkbf3MpjNozm60q05C.	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:09.783752+02	2023-06-14 09:49:42.516036+02	0031o00001nYrebAAC
da52e54c-b57c-4332-a2f4-bb6904dd7382	Rosemary Nsiimenta	$2b$10$yTTB/CwXnS3.e333runvn.CKimJCWAOKm.wJw85t/1DSa3cub2UF2	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:10.188373+02	2023-06-14 09:49:42.563753+02	0031o00001nYregAAC
a75ddb51-127f-42ee-af3b-dd280fe1ec7d	Silver Turyamushaba	$2b$10$ymP1QwL6pPGyVY.CQyVnsu7I2lNZ0Kyag1586oEMYR6rDKNNLGjM.	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:10.519161+02	2023-06-14 09:49:42.614307+02	0031o00001nYrelAAC
8bc34e67-6011-498a-a22d-085eeb11b0ac	Asrat Shunana	$2b$10$4qAVRTHYUvj6MTNpCtPECescAFLzF8xlk7yU8nQmyXDGhKdv1201q	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:10.943152+02	2023-06-14 09:49:42.695762+02	0031o00001ovikoAAA
579a5787-a36e-44d4-b4f6-3e53c1f5e04d	Alemitu Dida	$2b$10$2OM48B.xRemAMQ8qHMUWoe7aX2l70lW64rahdAHTwABzAfIbR3w0W	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:11.135931+02	2023-06-14 09:49:42.805599+02	0031o00001pwrcWAAQ
c8cb5ec6-6b44-401a-908b-3ee3e3422d81	Mekdes Aweku	$2b$10$AeUIe0xN5NscA46zMy0q2umRNhgNpcHfGst/tFpPxDNXgx.KWdwQi	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:11.45739+02	2023-06-14 09:49:43.026986+02	0031o00001rDc6bAAC
ebde6c7c-4e9c-4666-9aeb-2a516eb4cc18	Zuleyka Lugo Oritz	$2b$10$C9CkwsfxfZ/yCyrEv81UDugytciCaMFBozlCahRZV7PDGky2VEtaO	\N	7879515112	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:11.740787+02	2023-06-14 09:49:43.17581+02	0031o00001rFVOCAA4
605a1f93-8e9c-4fe9-8d16-caf8815bd8b3	Agegnew Bekele	$2b$10$lBIplSGwJCWXUhEfLEwQw.YxJz41iSpO6i/Q.QgdxFwjtF5/q8rdW	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:11.987787+02	2023-06-14 09:49:43.256683+02	0031o00001sRcu9AAC
c671f83e-5839-4ee6-a935-7c02f58e9ef3	Gertrude Kyarisima	$2b$10$EhUmgEnc4WuI1l4dFahyVeJoeXRYPMwW71PjHEv9boGjIJS0c1d8q	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:12.216107+02	2023-06-14 09:49:43.339065+02	0031o00001tP4KeAAK
87b7dcf8-5f00-4d5b-bad4-6bafd92dfc42	Edmund Mpamizo	$2b$10$3t31IMc6lwThso3PllOa8e/pG/eCIdkIGN33FyAc2YO65JdzpjbLy	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:12.508508+02	2023-06-14 09:49:43.376462+02	0031o00001uXe3kAAC
57a84d2b-efe5-4bcb-bc0e-583f51375598	Munir Aba Jihad	$2b$10$JbIJeY790o.e1lX7btD9DeCrWWXyQJZf4QNbByI1s.GoZOzkAKkJS	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:01.469523+02	2023-06-14 09:49:41.193178+02	0031o00001i7jlJAAQ
7c208213-e7a8-4fa2-8da7-7e2da43dd0a8	Teshale Belay	$2b$10$PubXiY.XJsSE2yn3jEGgauYu35G5WWn.Af9Gzq44MSCn2FkKp1zri	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:01.652717+02	2023-06-14 09:49:41.252914+02	0031o00001i7jlPAAQ
be86d5d5-3713-4046-a7fa-186457bad613	Kabtamu Abraham	$2b$10$dRWpy6.d7tNmV5s.pbszoenGJN2pRnn8YXD591VLagTzEe9eN053m	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:13.088083+02	2023-06-14 09:49:43.500984+02	0031o00001uxDbYAAU
b51e5224-79e0-4e97-9890-19127441471e	Natnael Mulugeta	$2b$10$fgoGYdTPAm1Rt2aKd6oa1OmoxsKkzKBgb81PbxseLZ/kJ8Jfq6bvC	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:13.328126+02	2023-06-14 09:49:43.507966+02	0031o00001uxDbZAAU
a307bf1b-4e22-477e-8acb-468a5aa363ba	Mintwab Mirga	$2b$10$nll4JdCBbm7A/cW/DcXcyuKHKGQp.r5L9lZ0euYbxKmBZYCbn4wsS	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:13.556719+02	2023-06-14 09:49:43.58883+02	0031o00001uxDdaAAE
f2977c33-cc8a-4f41-99a8-77cb08fda15a	Ugamo Uke	$2b$10$K8OrbytfLNboQyl07uO35.YEdmHXZuOiPj9zUUt6/pXZtutd39gea	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:13.796015+02	2023-06-14 09:49:43.624623+02	0031o00001uxDdfAAE
7368b77b-1dd8-4864-a6d8-cf0afb972316	Getahun G/Hiwot	$2b$10$79QMSECDBRtWkJHNxSdkO.y4MnEnJUJlCeIq8hX2egJkyzOqd9BJm	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:14.045764+02	2023-06-14 09:49:43.670621+02	0031o00001uxDdkAAE
bcc730ee-2089-4609-a626-bf13a6504aea	Turgamo Tunsisa	$2b$10$p4EMYgUQ/3Nl7484eYl4R.dQ4gesWLVRqdBUtLZI08JkeYt8vPpyu	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:14.302876+02	2023-06-14 09:49:43.708139+02	0031o00001uxDdpAAE
0b1a9e58-bb92-443b-a99e-eea1a81d5800	Melaku Meno	$2b$10$CSvU3TPXmB4BvCyv75seCeW6aw7RIvb2hbPldlMcgeTiopfW49/J2	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:14.523551+02	2023-06-14 09:49:43.74328+02	0031o00001uxDduAAE
60eb0756-235a-46ee-9e12-13694b684710	Tesfaye Tadese	$2b$10$PBq33NMWNI9rkpwa0N55I.LQlKhtvV9u0y8rRJKRgAcPhtwpaZkqm	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:14.773483+02	2023-06-14 09:49:43.788491+02	0031o00001uxDdzAAE
c29defc8-20bb-4639-90b0-4c1ef2c0e5a8	Samuel Hayeso	$2b$10$haklMbYzejonUwXWq2EW/e5ywRAoeDz7kky5lLb/SO1OQ8K1kldzO	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:15.059066+02	2023-06-14 09:49:43.835461+02	0031o00001uxDe4AAE
d3ed9e63-020c-46b2-8389-1b3d8af4f207	Petros Beje	$2b$10$YYwXDSfVkTl0XIX5EFeXVugiKbeytrWHrNOpiUA.QRX5c.2QkJDxq	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:15.390248+02	2023-06-14 09:49:44.013655+02	0031o00001uxDe8AAE
a7e99e31-a6e3-444c-ac98-42a69936f3bb	Birtukan Kendoye	$2b$10$2t80wpRtUuLZRK0MFUCFuOneYXx8jQi4GaTgWe9oNRZ1j6G18Wz/O	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:15.630859+02	2023-06-14 09:49:44.235142+02	0031o00001uxDeEAAU
79ce142e-bffe-442f-92e9-dfb20b586de5	Yeweynhareg Getachew	$2b$10$VzIhudWSrKmy/bwt7siIpew.fb4fR7X/9Ya4O8x.OKj1Uugv6qb9e	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:15.88209+02	2023-06-14 09:49:44.271796+02	0031o00001uxDeJAAU
13cd2fbb-6b4e-4454-86db-ff334df7c21e	Sadamo Wolasa	$2b$10$D1Ts4M7dkunxEjJOSQS4r.V.UIMn./wsKXvkvKLRFxxC94XZ5vAlq	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:16.144386+02	2023-06-14 09:49:44.318734+02	0031o00001uxDeOAAU
e2b21bd5-f4d5-4753-a069-da14765bd4cb	Melese Nageso	$2b$10$UxiWO5P38F0gkoWxsrWqo.7e1wq8f.j0Viv7A5y2lCacfRIYTDmxK	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:16.378785+02	2023-06-14 09:49:44.345299+02	0031o00001uxDeTAAU
1ad400b2-6eee-467f-b111-a8a223a4398c	Melkamu Mengesha	$2b$10$zX0mfQB2vMT/5DQZMDDwZuzQUrgpHu66mIoOGwi67YfUC2V1ENZ9W	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:16.571078+02	2023-06-14 09:49:44.38268+02	0031o00001uxDeYAAU
ff50987e-4927-4385-826e-252f7a353c99	Biruk Dawit	$2b$10$evCht75ANcFxeigEpJitYOgLbJ.KsRVmICZC859NKBZJuJmcWUvr2	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:16.752561+02	2023-06-14 09:49:44.421089+02	0031o00001uxDhaAAE
ee5bd3d1-40c5-401d-b8bc-0d7397b7a68a	Guest Guest	$2b$10$rAWIe3feSuDAF27WSM1AvOIpSGDZjnA6aZu6xqJm3eySNUaj5pkti	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:16.987091+02	2023-06-14 09:49:44.597361+02	0032400000kwF3HAAU
ccf77535-0f0a-4233-857e-365e94df7e5d	Violeth Mlugu	$2b$10$yJDTMV7mnnODjTTM//TjIuEm19.EpgZ3hrPSa4l5qdHgEjE1DlJ4e	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:17.385849+02	2023-06-14 09:49:44.778751+02	0032400000kwF3ZAAU
89c2eb1b-f58d-47a8-9192-5bad80332344	Debora Mashiku	$2b$10$7rY3XnCz3sT4S2FiIriUWuSlN530Oa6wBqR8X3uILY/LRNKyKg4Mi	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:17.752926+02	2023-06-14 09:49:44.816442+02	0032400000kwF3eAAE
e5e0e7ce-0169-4918-bd18-1787d05bfbde	Ndinagwe Mboya	$2b$10$2tyQDTB5wAf2Q07em0TcZeaD9dspqT5VzsEP27afUsQV8cldh.DfW	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:18.11374+02	2023-06-14 09:49:44.859732+02	0032400000kwF3jAAE
47f29242-e498-4309-b41f-135ad34d63bf	Harriet Bamurange	$2b$10$4zka4NOrw1n/nOCrru2Suu3RebrONIgssjrgIE.CMIAME2GseOC6q	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:18.363063+02	2023-06-14 09:49:44.913173+02	00324000011YiuZAAS
9a0d8786-81b7-4f09-922f-b50c3c73ecea	Jonah Mutesi	$2b$10$asoFna0boPQK/5LFxn6zWeFSsNrS5f6m.zP.IyPXdjyUmbhWrdxnq	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:18.611511+02	2023-06-14 09:49:44.932127+02	00324000011YiubAAC
009a3133-e6e9-485c-a65c-97d2ecb29ec7	Habineza Xavier	$2b$10$7RQDbS8QEGJVukPMShMHRuPo0tWtfYlorN233eTl25iQySJ6Tzt0y	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:18.935576+02	2023-06-14 09:49:45.025379+02	00324000011YiuiAAC
a95fa596-96eb-4f3f-b637-775b15431667	Munyankindi Daniel	$2b$10$DiHIQOqFQv5LGZX8zBPTw.sTXQfeo7vOPxJLd1ypSXd50YMdibvh.	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:19.199702+02	2023-06-14 09:49:45.065945+02	00324000011YiunAAC
1e7d74f6-6a8e-410d-b1a5-6747f3c4592e	Ndindayino Joas	$2b$10$xkGojr.rYmtJbQqc/nnT2ORY8n8kYInfljs4mFYINTN0bSuAbhqHC	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:19.479056+02	2023-06-14 09:49:45.113723+02	00324000011YiusAAC
674f9522-a5b6-44b9-9a32-acb7123e44bc	Niyonzima Jean Claude	$2b$10$bFQEFv8XlsDZq4HErDl0AOlNrgTyOpSX.gV0WXrqpld8/4yQ.zIwG	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:19.904461+02	2023-06-14 09:49:45.158081+02	00324000011YiuwAAC
d174557e-be82-476e-99ac-b7fd43575eb4	Ufitinema M Chantal	$2b$10$eBHdUd3nTiWVbtwhyV0X2.EzC0ZQEuNw1Glh9iZNzHPKHJwmKULCi	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:20.435747+02	2023-06-14 09:49:45.207058+02	00324000011Yiv2AAC
cd94cd92-7fdb-48eb-8007-14b38f1cae17	Yankurije M.Jeanne	$2b$10$75SjzVo1uFjod44lyzKu8uVTeBRii4SUvzusO4.2scFI4HU1ojTum	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:20.711391+02	2023-06-14 09:49:45.264589+02	00324000011Yiv8AAC
b665dae4-10fc-4fe5-a964-9abeec9d25bc	Addisalem Girma	$2b$10$yiDjhYeTTwC8k84HNaDMYOrUcjQ/T.9KiUs.d5TYOuQRlQSd/TCSq	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:20.938566+02	2023-06-14 09:49:45.293046+02	00324000015BBN6AAO
e057c6c1-03ea-4664-a0fb-1c0a3732e64c	Nugusu Sora	$2b$10$ZL7.Ag6vlFFLbAom50/MY.VXzYzyVsJHg2IhfzDWPg4jb8uvDoGNG	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:21.201434+02	2023-06-14 09:49:45.339833+02	00324000015BBNBAA4
ab64735f-e7fc-42ea-9014-a13cd4f3006a	Aga Dukele	$2b$10$1isQpjB5At0PEngZGy4NXeDxq/DwtAKha5ZLajxJpWy.k/.pW19AO	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:21.631154+02	2023-06-14 09:49:45.374388+02	00324000015BBNGAA4
050383f3-6209-4396-b31a-5f12628ecb7d	Bali DugoKorjo	$2b$10$cqT2RE8zZXEZt9.0lCM4EODN1FTxmd53KMzFXb2VAbadOP1CP8K8i	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:22.096158+02	2023-06-14 09:49:45.40828+02	00324000015BBNLAA4
20166b5b-8823-4e11-8860-06209b8e253f	Belay Dulecha	$2b$10$7X9XqycvPegzEFtIp4Cgk.4ZUlMvRySC5XsTLKyabAdefxjEUTNpq	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:22.397667+02	2023-06-14 09:49:45.459006+02	00324000015BBNQAA4
5c761f94-8e83-4541-b0c7-df0fa1b1a9ef	Boru Roba	$2b$10$fT8TTdeEp2cXNYP56.KuCOP4KLXK1/L4Hjj0cOYRkG4H5HVPLvzlW	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:22.845164+02	2023-06-14 09:49:45.515042+02	00324000015BBNVAA4
aabab538-ac3b-4ed9-bd91-5bd8eaea464d	Dugu Alemu	$2b$10$kjbDBTsjsAY2ve59zRB35uUIfzo1Y8KtMxwatIs2JN5NGZ/s5SHRq	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:23.234089+02	2023-06-14 09:49:45.557487+02	00324000015BBNaAAO
880c493a-505e-481f-8ebf-6e6057f64ea3	Hanna Waji	$2b$10$T8Cq0A87VE.ql7lkdL4FUeN6DcT7.wmRzh.pAKqWxZrg8.lm5WUeO	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:24.160038+02	2023-06-14 09:49:45.658856+02	00324000015BBNkAAO
eb8d0072-52ec-40eb-9faf-bb6111001456	Jilo Bedaso	$2b$10$3G8U5RmSg86RDS8.cKRTqeLaA1o7mucoayUxv2zo9SAM/xjC1El.O	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:24.584394+02	2023-06-14 09:49:45.705875+02	00324000015BBNqAAO
00d7853d-92f5-4102-ab81-a32c338412fc	Samuel Andachew	$2b$10$XSQX/IPR9z/F5oDASUvqdOiuv4fZxfBRMLJb7WPN473VTdetf5znW	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:12.563999+02	2023-06-14 09:49:43.385813+02	0031o00001uYtuoAAC
c8e917ca-49cc-4367-8676-259b08dc6387	Hiwot Hariso	$2b$10$WdufrrQ9vcKJIlb3jfksRukoaWZy.lVnIlKDgVuV0TJhmCYwCax2i	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:12.805074+02	2023-06-14 09:49:43.428162+02	0031o00001uxDbTAAU
1586423c-1dec-4bd8-ab1d-ae275db63e0d	Solomon Hanchach	$2b$10$.jMzTczMQUl7pBtiQzUzXeiidXnzopK980YyAqOT4h3z49YAWnnNe	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:13.367147+02	2023-06-14 09:49:43.554551+02	0031o00001uxDdHAAU
1932b686-d9b8-4611-9efb-28104617333d	Wubinesh Abebe	$2b$10$Zc6XN2sJ15LhafzsCX4XZeT/HquT3DgOj.vYbU2fZxBRFVXpJ1omO	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:13.575018+02	2023-06-14 09:49:43.593683+02	0031o00001uxDdbAAE
22c831ed-7a4e-464c-acbb-ab069c82699a	Bekurat Asefa	$2b$10$YBwMHzn3uUfV5IKrOb/3jeFn.oL6UIEBZNP2Euet56ZMqWK5Rji8O	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:13.843604+02	2023-06-14 09:49:43.640124+02	0031o00001uxDdhAAE
77fa3046-f1cb-409b-a021-41ab75a3731f	Mintiwab Hayilu	$2b$10$HhvtBiVr62XPB0oaoHe2ZupaLOi3R3leb1a3S9ZobpQrM3yQtU/9m	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:14.105365+02	2023-06-14 09:49:43.677011+02	0031o00001uxDdlAAE
3f4eb075-5376-4437-b789-ef0a3c0c5a35	Adisu Marikos	$2b$10$P0Xow3Uzd7RkN6M.sZH27eojARNZlhBYyFq7zkDeavesQZJFDze6C	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:14.368813+02	2023-06-14 09:49:43.717526+02	0031o00001uxDdqAAE
e0230127-6517-467e-902c-3bc95cd08837	Teshale Taye	$2b$10$vkxECK6BmqYuNXGdF4rzk.3Bpfl2mJc1MHAd60hcWl/99S1oe4SdK	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:14.57118+02	2023-06-14 09:49:43.75487+02	0031o00001uxDdvAAE
16b82a15-8e5c-4ae3-8fcf-a551ba1f5001	Abera Tubulu	$2b$10$8IW0ECNOyAlGY0G/LcOq6uRahrI.CCGoJ5LMQq/JjIwD0iih/mIRe	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:14.869485+02	2023-06-14 09:49:43.793508+02	0031o00001uxDe0AAE
0fd70b83-5a83-4e69-998c-a7a09268dfd6	Tadele Teshome	$2b$10$wsW83vg/wVshY9EY0DPYgOXAlRBGrRlwtvgbi/XW6GE3pw3p/XzeK	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:15.109051+02	2023-06-14 09:49:43.839575+02	0031o00001uxDe5AAE
47fd6d2b-8202-43b0-99ca-20b96ad4cd8f	Kalebe Samuel	$2b$10$bH2Ox4wscWsFrjY6Q30Ppe9wkjT2bCn52RW8iU9iBq0dRdgN8uuNy	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:15.433533+02	2023-06-14 09:49:44.140737+02	0031o00001uxDeAAAU
dd37ae77-e6f2-427e-bfc9-b23b77ce09a9	Teshome Tsegaye	$2b$10$48GrIrndiJwZbLPcwoJFeOlcoCSZlSzoQMCajDb8MgFTlpFq5cEQq	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:15.689907+02	2023-06-14 09:49:44.245803+02	0031o00001uxDeFAAU
9efd1f5d-c798-4f8c-9252-774e78d01eae	Kasech Walena	$2b$10$c.4AOxTsjSlAp9vPL1IL1O5Ewg1L8WYL9yzQ33JOzPtLIshhhT1i2	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:15.924807+02	2023-06-14 09:49:44.280201+02	0031o00001uxDeKAAU
feabd2b3-64ef-4663-a2d6-ea055e8b8acf	Amare Adisu	$2b$10$iqVrG2n95LvuocAlN6.iouNa/tW.GJbbv9YwvtH65TQAuZNPA1iXK	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:16.168171+02	2023-06-14 09:49:44.322753+02	0031o00001uxDePAAU
371e586d-d3e5-435d-ac0e-ef73a0712c9f	Bayeto Bariso	$2b$10$M8xM8f.v4G/Rd9Gfwolae.a5c5AU.D6Z/QVR57oBhkGH.WPhOFMu.	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:16.43675+02	2023-06-14 09:49:44.355132+02	0031o00001uxDeUAAU
6a3908f3-1719-4a47-ab0b-69eab9a8f554	Kebede Kachara	$2b$10$QMZ4W/Nm1.9uAp7fgwd3Zucfz5kXoybj6iS/pyTQzkKbrTIljm6oe	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:16.611325+02	2023-06-14 09:49:44.388934+02	0031o00001uxDeZAAU
4ab27263-90eb-416f-8a25-328485435079	Aster Gashu	$2b$10$717ybK6tZupNRRh0zatQfOFfP3ydBI9/BsjFYlrNgOLcsAqOa8Zd.	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:16.791825+02	2023-06-14 09:49:44.434062+02	0031o00001uxDhbAAE
b1d6ab43-6b28-41e7-861a-b64e9367e2fa	Judith Vincent	$2b$10$zykZp3clt0Vy4dbWXA.eCu3H9u6eK7fDUtdP/jD3aHCjijT0YA1gi	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:17.053458+02	2023-06-14 09:49:44.729635+02	0032400000kwF3VAAU
ad306aa7-c5f6-4840-badb-3892f2ffbbbf	Elesia Mwamahonje	$2b$10$sDatbcA0YhD5XmyETYgvo.rtrZSBGmmfHPqQO3jH6YuZx6UGoOeqO	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:17.447761+02	2023-06-14 09:49:44.789205+02	0032400000kwF3aAAE
99672823-33b6-446b-b954-b0abe14e13c5	Salome Mwasifiga	$2b$10$xHHnlRf2CpmZGUlF6UfLCuFNGzcRQ7e4TYAc7Byt4j84O.goWJpqu	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:17.861772+02	2023-06-14 09:49:44.834609+02	0032400000kwF3gAAE
a6755f89-0478-4524-a009-ba8c8eaa3196	Anastazia Makubha	$2b$10$n6OtgUNswoDvCy9yC8EiZen0A6jqQN05rQ7hsjBY3IC63ai3O/tAO	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:18.175207+02	2023-06-14 09:49:44.867119+02	0032400000kwF3kAAE
fec78399-f64b-4402-92c7-4dbb880c41a7	Theodora Kapinga	$2b$10$6Kt.j1Y1VXJ9ErdKnGuZ8u22jakZC18NRtYVTX42..3WxRfkZ/Q.G	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:18.400015+02	2023-06-14 09:49:44.903233+02	0032400000nGlYoAAK
9bc49eb4-dd41-4d55-9803-c94fdbd4bf87	Bangankira J.Bosco	$2b$10$qEIRF/gU7v3NEU13jzAhROXyFDoUBCRPuvqOdMpAkUUjMLk2UfGz6	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:18.660517+02	2023-06-14 09:49:44.957795+02	00324000011YiueAAC
8501d8dc-c446-413f-914f-3aa4932d9905	Hakundimana Emaus	$2b$10$er4AqRv6T3A.HDrmmz4uYePnR9LKMM0ZWR1RYgy19l/npg4mZts7S	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:19.000797+02	2023-06-14 09:49:45.033045+02	00324000011YiujAAC
913de962-db8b-42a2-beee-d2e3414d1cd0	Musekera Pacifique	$2b$10$nEV0qWwJylZT4SyprTdBgOjFHqLkeJxDa2kkdNfihg6oWdq0QA31O	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:19.277751+02	2023-06-14 09:49:45.076929+02	00324000011YiuoAAC
809aa6e5-606a-4c6c-8702-3ee593ceff4d	Ngirabombi Theoneste	$2b$10$fOE7xqdiLNq5PXKSlVAOBewl8jMaumufEYDbEQyPC7F4VD7Xf4yG2	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:19.530625+02	2023-06-14 09:49:45.126267+02	00324000011YiutAAC
18db097f-a730-44e6-95c0-1649ff4760a8	Nshimiyimana James	$2b$10$Zl27N1.nLgxVRfcS/MCuX.b1yERU3W4k4GaqxOw7jea91CRdNDol.	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:20.068727+02	2023-06-14 09:49:45.174854+02	00324000011YiuyAAC
6bbc4ae7-d07a-4d58-951a-96d4c7849632	Umuhoza Nadine	$2b$10$DExsDPCNp8FFzj3YnP7sJe2zbwm4844i5g0bGQN73DCQ92gS5ycRG	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:20.500236+02	2023-06-14 09:49:45.213396+02	00324000011Yiv3AAC
cf49b240-7adc-4588-991a-b6f4541ef5d6	Uwitonze Olive	$2b$10$1DTDdgCpEMYnriuVTswzm./kEAAqwEZPfIUIb9.GgycrjrZofPytq	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:20.757989+02	2023-06-14 09:49:45.25547+02	00324000011Yiv7AAC
fafc8690-662b-409c-a68e-8420f5d288b2	Boka Kebede	$2b$10$oUTKaOOzWWf0KYZltzmdL.dn/4ECPvuMeZ0Kt.ugHoxyLh6w6YQqO	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:20.97153+02	2023-06-14 09:49:45.299021+02	00324000015BBN7AAO
8f6fe767-0b27-490d-894b-f9ddc93d3568	Lemi Tagesu	$2b$10$A6YE/IhT5oAfFpwQQCQtqOfEFieLNmlMFuyBljR2cPMs7y/KXzz4K	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:21.248521+02	2023-06-14 09:49:45.346859+02	00324000015BBNCAA4
cb2659ff-1b50-4283-b34c-2aa3fff6319d	Alemitu Neno	$2b$10$k8Lcc2BM.m0UnVXod5Mod.0B.UNJAiUd8PpKNDClFlqS.fgRa1uuy	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:21.749129+02	2023-06-14 09:49:45.37881+02	00324000015BBNHAA4
77990a4f-29eb-4e68-9d19-f050d1f12820	Batu Boru	$2b$10$TEsJ30QMTw4SJaHBcVIPQOQdf2PwRXc1nL5mfoepkIz/jc3hDlabe	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:22.164214+02	2023-06-14 09:49:45.4146+02	00324000015BBNMAA4
b5960358-a13e-4d08-9a41-7921c4769de9	Beriso Birehanu	$2b$10$soiYvBR3U5Vgl4G/fJ9oY.WnSOFmD7wWgEmw016TRN0GN7ph2q8g.	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:22.499565+02	2023-06-14 09:49:45.476856+02	00324000015BBNRAA4
dd44c2f5-0136-47f0-bff2-8ccb61f028e9	Buno Godana	$2b$10$rW2GUOaYVR9WT0BZKjihNe5ZX6wUCN8CND3kk7NN96XUXzNzOJ41a	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:22.923748+02	2023-06-14 09:49:45.528343+02	00324000015BBNWAA4
1ba34cd8-b8cb-4a17-af17-f24f7ca34496	Edemtu Bedaso	$2b$10$rQJ0EaG5tTsSEKglZ4hT7.gh9ncsKR3T.Dck.nFomUyTscICqKBey	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:23.32165+02	2023-06-14 09:49:45.562394+02	00324000015BBNbAAO
91f0940e-8c8d-4889-a08d-a0a50bf4ccf6	Gemede Shekisa	$2b$10$lEbCcwcwhGdL1dG98wuP/ut1HWwV9EdcBCN11BBdQLar6AwMpz1Ei	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:23.742299+02	2023-06-14 09:49:45.619988+02	00324000015BBNgAAO
b7c4d89f-c81e-455f-8af5-780c242e2208	Jilo Elema	$2b$10$Tivm/EpyCTuIqC.8t7E8gu1qgUXp4bWnyJXgOysdaR0eFYeN.8kT6	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:24.587722+02	2023-06-14 09:49:45.714944+02	00324000015BBNrAAO
51df40aa-ce03-4de2-a2b9-1620b8328c34	Roba Haile	$2b$10$TevsF/odc/pH0Zvvao44VO.0mVpB.2alyMCol9sDAlB4zc4BoBGjO	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:24.605517+02	2023-06-14 09:49:45.761844+02	00324000015BBNxAAO
4be5e62b-8a8b-4d49-8e9e-64f7fa32f6ae	Alemayehu Mamuye	$2b$10$FpBx8LDdIdMjbkn5i5NCNe5Un/5yQKwoYvplYg6c4uJclpPWNvPoe	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:12.856777+02	2023-06-14 09:49:43.44128+02	0031o00001uxDbUAAU
bfb0adec-5227-493e-8348-9a519667e79c	Addisu Anamo	$2b$10$9aFAN9jyTs6ZfP1rA/gkdePuWn2cvVS0gDXkRnkVv/0fTMTFRj7JS	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:13.126488+02	2023-06-14 09:49:43.520809+02	0031o00001uxDbaAAE
db9685d7-8b74-42ea-b8f9-2e5532628884	Samuel Sanbato	$2b$10$E.OzMJoEmv.GqYKUcXWE..EjaszVtE0eRwsbDcbkzEQ1LWHwAk2gK	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:13.420707+02	2023-06-14 09:49:43.558868+02	0031o00001uxDdIAAU
7a49d5f5-c370-4fca-86ad-f3e3ae9cd610	Lakech Dineso	$2b$10$UbUHV7haME0/nlT3XRHS8e9.IPre1yoWdtOTYV6d6Dd6g8VWheQKy	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:13.625803+02	2023-06-14 09:49:43.603832+02	0031o00001uxDdcAAE
c8e54f18-5724-449b-895e-6140b2f2cab4	Genene Genewo	$2b$10$ootckoQIY55FCOmLRAelUuh4W49OXHKDRmOF754dtJTmuSiuSrPki	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:13.894285+02	2023-06-14 09:49:43.634915+02	0031o00001uxDdgAAE
2b8f8d3c-72b2-44db-b2e3-ade4ec921fe8	Belayneh Bora	$2b$10$Mew6UyUaPhBXnfIlys5tMuHrpdi/d4JCGD046ZW65zi.3lNpUI6zm	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:14.138903+02	2023-06-14 09:49:43.688062+02	0031o00001uxDdmAAE
f4381563-1a78-4057-bda3-4b338460c95f	Melaku Tesfaye	$2b$10$gPrQ/Vytq1IKFBj2I3qb6.Bn566259vw2gVMvVszWPMbHZsbe.KJi	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:14.406702+02	2023-06-14 09:49:43.722777+02	0031o00001uxDdrAAE
edb92c7c-8e42-4560-a9ca-ff5c171ba8a9	Hamsale Kebede	$2b$10$SK0m6VEnlCCmC104meXsyOZ7RSmCCa0F3KIIJZyIX85Vi5sSBlxHe	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:14.627289+02	2023-06-14 09:49:43.758263+02	0031o00001uxDdwAAE
7216c7bd-9983-4ccb-957c-aca9c65f79f2	Meskele Heko	$2b$10$hrGoAws29NHD5NjCs3KKaOdkcWihcyUSCrfoSf8l82qs8VMu7dpJy	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:14.923207+02	2023-06-14 09:49:43.806268+02	0031o00001uxDe1AAE
fe64ea8b-9643-4101-be86-35f9b1712f50	Yodit Elias	$2b$10$nCaeln9CeyGlq/PZ9IlgQ.ni5uMZypilkmRRdbyT8j9UxVRCJZR22	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:15.186561+02	2023-06-14 09:49:43.897589+02	0031o00001uxDe6AAE
ecde81d5-4c29-4483-ab88-4fec675b5dd2	Abatu Hanako	$2b$10$AR1lLNr4kNCzgkqD2Q/Gye7bpy/Fuvj3GvVwPN/me7AU3nFCqNw/W	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:15.4886+02	2023-06-14 09:49:44.166186+02	0031o00001uxDeBAAU
174318e5-8dae-4864-8f6b-c4f7b557e961	Melkamu Yetera	$2b$10$dHgtR6kX6fhJeLXJtksfcODOtD79.lU/GCMT5CdhSdvYWBKKFoJGa	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:15.727484+02	2023-06-14 09:49:44.253624+02	0031o00001uxDeGAAU
c934db52-42f5-4603-802a-bb435d459d46	Anchamo Becha	$2b$10$p5ewm1XcvQ2AMeoapzNGSezf7EbOzQFyFxmf7XvXTuja8n4FhWllq	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:15.982073+02	2023-06-14 09:49:44.284935+02	0031o00001uxDeLAAU
3ec72d2b-8281-49be-8346-eafce322b832	Eyasu Beshera	$2b$10$dgT4kC8L5y41IeeWtJkUHOu2.2AJXx4ywjbK/5kHJU6slr.j1voWy	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:16.213048+02	2023-06-14 09:49:44.329434+02	0031o00001uxDeQAAU
bfb12719-ddea-4f0d-bf14-237766df578f	Million Abriham	$2b$10$ykfU2GF4F.NZDl5cP0xjFO.6pclYRT7nKrkMHEKXqSvtmYRfRiDby	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:16.478078+02	2023-06-14 09:49:44.362737+02	0031o00001uxDeVAAU
c24ae6cd-f13b-4a74-b2eb-cd1507c62bcd	Abebu Daimo	$2b$10$6GR3YSzASjgKYKPfwHPSE.3O98Gv5eT7AgytpV7L/pIL/wi1Ur1PS	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:16.66122+02	2023-06-14 09:49:44.39666+02	0031o00001uxDeaAAE
59d502e1-de68-4534-9bef-dba1a597aa36	Aster Tafese	$2b$10$HP5EUT4vsE8tIwwkpTco8O4BC/6Owe1KxQUsTjbJjNYAK23cjDfa2	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:16.838133+02	2023-06-14 09:49:44.451063+02	0031o00001uxDhcAAE
61d2e916-bca7-4951-b9ef-8682a47af3ff	Mary Mushi	$2b$10$cg1MuLNAuub8IWiaiO3/2OGR.T3eiiEi/ukbC3MzXRfvivyijR/Cy	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:17.125517+02	2023-06-14 09:49:44.735939+02	0032400000kwF3WAAU
7ce0d671-8d81-4d69-acdf-751ea2bb511f	Rukia Salum	$2b$10$P17j1aNfPX0mszCgpdFkK.EPZOjWtZXSBkfuSqYBkzzEwStUZGg9e	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:17.536417+02	2023-06-14 09:49:44.794431+02	0032400000kwF3bAAE
05eb36fb-932b-4a64-b123-eca17607da64	Rachel Malongo	$2b$10$Aagtuh8tuZwilFKwcZXBD.xHZMXWG95HhXgj9mJkJSqlSFGERRKFK	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:17.92439+02	2023-06-14 09:49:44.826905+02	0032400000kwF3fAAE
c422bc64-1ec6-4a55-b8ff-d9441b53549c	Anna Ng'ogo	$2b$10$Fk/mUMUGv.ft58sJ2zPZpOot8XIp61M2urV/uWkd5tCTrWiPRDKUW	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:18.234324+02	2023-06-14 09:49:44.877174+02	0032400000kwF3lAAE
efe1b32a-f0c6-4d7c-aee9-3db67e6d3121	Catherine Ingabire	$2b$10$rD9nmyoI6dYpyR4MiMVLXO.JnkqGDf5j/bxbmEr86jvRn4pk9QqhG	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:18.455827+02	2023-06-14 09:49:44.924559+02	00324000011YiuaAAC
f9c4701c-922d-4b27-8548-a9deb9677387	Bariyanga Thadee	$2b$10$licZCW3wVnxAaT8ASr6JoObzu/OwVjwm2NIEoZXwyT0XNzIK81nHy	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:18.702401+02	2023-06-14 09:49:44.985047+02	00324000011YiufAAC
dd7be9cc-f99a-411f-9173-9d98a5fc6848	Kwibuka Uziel	$2b$10$hfnobw8cTJy/GNnMO.p35etjnFw8UPRMk6YqeQFsC1IE7S6vtfyam	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:19.062893+02	2023-06-14 09:49:45.045204+02	00324000011YiukAAC
369c624f-0773-4f59-8b86-3ddcddf0341a	Muvunyi Anastase	$2b$10$2SqZZ8sVgpvFRT7xPAr6POgO6Vq54i0Bk8CZuY8kofiN4cAPqI6v6	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:19.327517+02	2023-06-14 09:49:45.080874+02	00324000011YiupAAC
694eb5b8-5ece-4504-9491-32ed70538cf9	Nikuze Isabelle	$2b$10$Ut4V15Fev7G8t2i84VqOTuAoZ2NdWvkY.pETNDlMlU25PoXkBAr.6	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:19.626646+02	2023-06-14 09:49:45.133445+02	00324000011YiuuAAC
786be89a-673a-4ed4-a7c7-606ab42e5c42	Twiringiyimana Felicien	$2b$10$MqPa2kdGUJ.1FZitr0SV8uSQOaHxDD3lFmjTj2qasGHsRl04LBsW.	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:20.163706+02	2023-06-14 09:49:45.199042+02	00324000011Yiv1AAC
e6374d84-ae42-4bc4-8650-138a189c8825	Uwayisaba Judith	$2b$10$sV9VeDiUN0hPBiMp420EU.VQ0f0dHsIHdrFY76W2MBPjQjTMQlcIG	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:20.586591+02	2023-06-14 09:49:45.221581+02	00324000011Yiv4AAC
9832cb22-0662-4924-bf4d-d52a072444a8	Tamiru Gebre	$2b$10$Hc2YxnBpk4k6H4XpJ2qZy.W2hR.jsWXZTCTCOpX18K6DwzMb5sCXa	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:20.813954+02	2023-06-14 09:49:45.276088+02	00324000015BBN3AAO
1ca8392e-590a-4515-9dcc-73e7bf1df523	Abebe Fikadu	$2b$10$lBY/6g3jG4OmbT7x15VGSexaXyMY4zKUAMHTbDtHR2gMRsh47a2Pa	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:21.027812+02	2023-06-14 09:49:45.315374+02	00324000015BBN8AAO
bd3b4491-4673-486c-b2e5-55975862b159	Abebe Dulecha	$2b$10$c29RzbIV1OgfiMw9e7uA.ubZymSzeJs5/n5GvrxuzsM6zNVK6EWPq	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:21.30755+02	2023-06-14 09:49:45.361564+02	00324000015BBNEAA4
895741db-d5ca-44bd-ab60-c2c7d6563a78	Anteneh Birehanu	$2b$10$w7TbSoKdmXme19cvyXvZ3.U70/EP0R526E5ee9lbTff1yv1t0CZlK	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:21.822951+02	2023-06-14 09:49:45.388447+02	00324000015BBNIAA4
cf612f76-bdb7-4ee2-bf01-f4a1ab8b7c5b	Bedasa Danisa	$2b$10$tG431cuxp2ngz9gA2eWhxetZ48LKhyku1Q8DJXurUncWv6E.M5Yya	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:22.217563+02	2023-06-14 09:49:45.432115+02	00324000015BBNNAA4
852796c4-22a6-4a16-bd5c-854cf6b8d18a	Beriso Dogoma	$2b$10$jnEww45j1RK59vabzqaI6.0d3wYhTxiZQv58wqc7hPom/OB4RE592	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:22.578043+02	2023-06-14 09:49:45.488745+02	00324000015BBNSAA4
3dbd7343-ad19-4a81-889b-5991553152e6	Dabbo Kula	$2b$10$xvdEjg9vg5PQlhn7bVxjO.9OPncrI2y0/QB8QJW1gFypmg/zdkF7O	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:23.019572+02	2023-06-14 09:49:45.532035+02	00324000015BBNXAA4
d8a93e29-a698-4a9e-b191-e7ae2ec96653	Eliyas Tseggaye	$2b$10$UbEnpn0gzjX84e09fMoJc.cur7pkJy9U.Xg7rHWsbT7pkaRVMhld.	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:23.404331+02	2023-06-14 09:49:45.573601+02	00324000015BBNcAAO
70dbe85c-613c-4662-9375-6da3849f6e4f	Genale Roba	$2b$10$3HA1f8YEHbenpJgSfhf1UO5Z3DtgMa2/sCxR1EU1GhIGZ05ewu6Dm	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:23.901131+02	2023-06-14 09:49:45.626155+02	00324000015BBNhAAO
d53ac664-d866-440e-afb9-7f1d330d918d	Jaleta Bekele	$2b$10$.HbKGYBthJyhPAkW8mQAkOcVT/QHc6wcnJWfoaGvYbgANatvtouDG	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:24.369517+02	2023-06-14 09:49:45.680085+02	00324000015BBNnAAO
2a1db89c-5839-4e9e-8134-f09cd3df727d	Latu Murti	$2b$10$wUBhdg1sIqDU6avgcyIl7eFqMnlt2UTPJ8xxdxKgVVtBhJKhg7smW	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:24.591299+02	2023-06-14 09:49:45.726083+02	00324000015BBNsAAO
5ee86e8a-dbf8-4163-85d3-90cbef88147f	Gobezu Goa	$2b$10$Z/0oyxDAe7zsoacmwOptEe.hO6enz7pmYiWjHe/ghQ28NsC6WBTqS	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:12.96514+02	2023-06-14 09:49:43.454171+02	0031o00001uxDbVAAU
3e6d686e-65c9-4f43-a7be-c3cfd38c2373	Petros Batiso	$2b$10$zBRD2uJ7A1Gp1RRCBfsB1OLx4bL6jF.I8tqdbbexHPORwt7SSiyNS	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:13.163063+02	2023-06-14 09:49:43.526476+02	0031o00001uxDbbAAE
49a4cda3-2b3e-4070-b67a-53393186fdea	Alemu Gatiso	$2b$10$xlVNhQol7lQcn2VjkoJkLOGInfCapApK.oOTg4TTnMGEAsKvdcgOG	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:13.461228+02	2023-06-14 09:49:43.572304+02	0031o00001uxDdJAAU
f37c85f4-a341-40ac-9035-63445807b5cb	Shashamo Fendiga	$2b$10$OWF5P0lVDH3n/lNGtlStKe4Am5JXJsZcgOlNqCJsTZ0Pbv5fUJ4KK	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:13.732277+02	2023-06-14 09:49:43.608855+02	0031o00001uxDddAAE
ea57e242-f57b-423d-9192-eab7c8b025e2	Tesfaye Basha	$2b$10$Pn2fZ/prLyD5VeOVpaJXqeeIV2DIUs.Q1hO0I44qeln1V5tqIEVt.	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:13.927756+02	2023-06-14 09:49:43.652743+02	0031o00001uxDdiAAE
b6e406e9-289c-4b3b-9019-08b37a43bd80	Zehulku Zeleke	$2b$10$eGBjA//rDxj3cOGbNPip5uSHGupND9Rwa4YdUx4HVxtfX0AD5PlLe	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:14.20264+02	2023-06-14 09:49:43.693228+02	0031o00001uxDdnAAE
0d2968af-5562-4cc9-a706-19651a2991d3	Genene Geda	$2b$10$OxsykcqdLmt2Zbg3BT0MQ.zmr8CTtoGVshh8emzcSuguUVd3ttoiW	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:14.429546+02	2023-06-14 09:49:43.738799+02	0031o00001uxDdtAAE
ddd253f9-6ded-4587-a729-bf17e05a1d8d	Solomon Yoseph	$2b$10$o3RqSUV47hP88j68RrcEgunezuBiA7P3aeLEhpMJBMsNFLLQA2mam	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:14.655305+02	2023-06-14 09:49:43.769703+02	0031o00001uxDdxAAE
f2d097f5-82b3-4655-9df8-91a050acd474	Yohannes Gelfato	$2b$10$bnGGVM0vyogTuBobvz8xnOsjrsU.2E3QREVvPj9SFpLRgVaMatlR6	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:14.982642+02	2023-06-14 09:49:43.817256+02	0031o00001uxDe2AAE
76e02ba4-93fb-49d0-b420-c9d448bd30be	Esayas Gejisha	$2b$10$0MvSKuyi0fZ8wb2sc.bXYesOz9KFy3qtz5m26aJyoY03fogkm7gcG	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:15.535405+02	2023-06-14 09:49:44.215726+02	0031o00001uxDeCAAU
450c2646-cdca-4714-b98b-d227ecbbb16f	Natinael Ledamo	$2b$10$AgP907v/QjnjwT5S7V/snum5kRo4nDmbmiYcBHjzknGM27DtLy.0m	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:15.774081+02	2023-06-14 09:49:44.263374+02	0031o00001uxDeHAAU
e9ea6ebb-409b-417d-ba41-ae730373c200	Bereket Birhanu	$2b$10$sLMtHDgQ9eQ0OPVsu/Bxh.c4axa1.b7BiPA7fcxOqs813Bk2sAVA2	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:16.032677+02	2023-06-14 09:49:44.290026+02	0031o00001uxDeMAAU
d4ff06ca-3884-4d2a-8e91-b7363728dde2	Shokora Genboro	$2b$10$WoTQC8OxlfYTmpNseY0KNOEepo.RT.YKaDzNp4Z/427QgoXwo6ORq	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:16.284352+02	2023-06-14 09:49:44.333544+02	0031o00001uxDeRAAU
c025f505-a858-4dba-a29a-b33c73173abe	Galmessa Galcha	$2b$10$Q8ylRZOMVKZRs2p2jzMz6.TLp1190Mnh3LmqX.H7tnfvR62IhZDUS	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:16.50784+02	2023-06-14 09:49:44.367408+02	0031o00001uxDeWAAU
38833fbb-9272-448a-81e6-44b4f5df65c2	Ayalew Aragata	$2b$10$3VrW1Slbw0TDze0cX.7iT.QetUlYileZc/2DgzLaDLma0A/IZXH.i	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:16.665088+02	2023-06-14 09:49:44.400941+02	0031o00001uxDebAAE
83e84a9d-2ccc-481a-b50b-9917f533061b	Ronald Byamukama *inactive*	$2b$10$.REKyf4/dqWLJMbZFU/RnOWfqN7HxIjflJ/3.eUSLrss4kJUTgzc.	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:16.877304+02	2023-06-14 09:49:44.463864+02	0031o00001xp87YAAQ
2065cda3-c37b-4f27-9c62-41c91d2aafdf	Salma Waziri Kinyunyu	$2b$10$Ktq6U/NIyxplU8NqQCx8leyvUccWZ7ZtzhdDqZV755aGimqH4mOmC	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:17.258984+02	2023-06-14 09:49:44.746482+02	0032400000kwF3XAAU
6c98f1c1-703b-45b5-8b89-1600b1b798f6	Florence Mollel	$2b$10$iaoZsacIBJT4Vv9Q0P32iOaCmTte0pBmbpdykfkhkPzXQHdaploB2	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:17.595318+02	2023-06-14 09:49:44.803451+02	0032400000kwF3cAAE
9f10d12b-604d-45c2-a416-0745981630e8	Naice Mlay	$2b$10$MyVhCwQZrReT8oqmFwRO1u9LnF/2g7Z2RvBX1ng5A2xjSrJgYiV3S	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:17.983762+02	2023-06-14 09:49:44.839382+02	0032400000kwF3hAAE
ab3591c4-a0a9-42fb-bd38-475757409e53	Nyambuli Vedastus	$2b$10$m6aQDsNooji7CzSQYluUQupqSsIxtD6xbKHv5QcdcdWVBhDiL6ueW	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:18.251226+02	2023-06-14 09:49:44.881575+02	0032400000kwF3mAAE
94c1df32-26b8-43c1-82ab-06308ba14e4f	Babonangenda Absalom	$2b$10$.SjnUPUUbS2OlpcY6UQ/AOIlmd1xFe8QOzbItqI5Nxhn34cGt9bjy	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:18.514552+02	2023-06-14 09:49:44.949924+02	00324000011YiudAAC
4438da97-d4fc-44bf-af27-c3a1dee39a89	Domina Mushimiyimana	$2b$10$eqWjKlfFXQdeWHXvY7gx7.9Fpc9eidx5Lh5q0lHSqE7Wy.xqm8P3O	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:18.762253+02	2023-06-14 09:49:45.017082+02	00324000011YiuhAAC
1b8482cf-91f5-4b3c-984d-018d5c45304f	Mujawimana Didacienne	$2b$10$S7HjAv2YKYDTARPvDun92efRilgbbJTVieadEDQvi63DyHOJ1qwqu	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:19.105953+02	2023-06-14 09:49:45.049943+02	00324000011YiulAAC
a45d99dc-28af-4cd5-b3f3-0d07d2a0dc5b	Ndayambaje Innocent	$2b$10$of.6ex.yVCIT2aUEdud5x.65HFOyVmflEGVS6BMtrbM2r0q4LovmK	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:19.388515+02	2023-06-14 09:49:45.093548+02	00324000011YiuqAAC
41e51018-1a6b-48c0-91a9-21adb708c833	Niyonambaza Pontien	$2b$10$xyck4dcp2ltFh3gJJlclg.dlN1SiQiAQ9iqJQEzvn8BMR9w2N9Ssy	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:19.692081+02	2023-06-14 09:49:45.146067+02	00324000011YiuvAAC
fa0d5608-f436-48cf-8c88-9816e0315d36	Twagirumukiza Anatole	$2b$10$hp0tGa.b0Yt3PHPnGrka3uL0k4bZVpIQ5FCfCWK4LxKX.tUcKUUs6	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:20.211988+02	2023-06-14 09:49:45.192934+02	00324000011Yiv0AAC
de56c6f6-1a07-4d73-946a-be0b367b85bb	Uwilingiyimana Beatrice	$2b$10$tg9eK7ytUo/gNFcy84.zE.AdQyzZtejDAq7XbIk3HsdyGCWiqcgkC	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:20.622794+02	2023-06-14 09:49:45.226177+02	00324000011Yiv5AAC
fe90d0ea-d08b-4990-887c-19322f9cfe11	Dula Afework	$2b$10$ulFnzqa9KcYOZJZli6Sm1ulKEm.P/eKMKuXnPMdSiDqiVX7ZBAGhi	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:20.846233+02	2023-06-14 09:49:45.280009+02	00324000015BBN4AAO
8a1fae15-4ea9-4575-b7b5-43a76381eafe	Selamawit Samuel	$2b$10$BcsEY9UFSH17vloKfJSRVewo1.Hi5fAIUxdtZuN2CGOqoIGrb2xZW	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:21.08497+02	2023-06-14 09:49:45.323317+02	00324000015BBN9AAO
1d1b6c36-61a8-4127-aee7-ffa66134719b	Yihunbelay Yohannes *inactive*	$2b$10$LuLq6rUzRYXCeC/7rzRAXur9mJ6REF12SEJF05Pf5oK2MvBzeKJ5W	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:21.400032+02	2023-06-14 09:49:45.356989+02	00324000015BBNDAA4
0065cb72-bc25-484b-bb64-a7ee6f39cab2	Arariso Abireham	$2b$10$PiAdv2hYxsL4QC2Ln9w4funQt.LeXJva.FoGQYLEblZSy6rsv3Av2	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:21.883641+02	2023-06-14 09:49:45.392512+02	00324000015BBNJAA4
3c33a73c-15c4-43a2-9ad5-28e3e188a181	Bedatu Kilta Boneya	$2b$10$hgyhfSDcB/ySpwYOTaoydOm.fgHBdmvfT15EJ45/l2TBTSwMpMVqO	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:22.263302+02	2023-06-14 09:49:45.440411+02	00324000015BBNOAA4
dd33892d-0e69-4929-966b-057d6e342d1e	Biftu Aweke	$2b$10$fGEUhPma0FPtmfhMBu.T8u0cl6gH1aIJHwR/fM9waAju8z2I9kX6e	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:22.675289+02	2023-06-14 09:49:45.497643+02	00324000015BBNTAA4
d1ba4f14-c830-4104-8053-35d72758ec81	Danna Ayele	$2b$10$QpELdVDfbRvOCFvz3x8Vh.9qzoi2GGyxUVS2HJ1wlCwlx2qCLcOqq	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:23.107821+02	2023-06-14 09:49:45.543285+02	00324000015BBNYAA4
d1a3d742-4614-4230-b6ed-2301d92d8232	Fikiru Morketa	$2b$10$RnaJeZupWpcx4BeuNttRDeV8Er.gMeZWjuxHnBoQ7ijvfsFT36t/G	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:23.472758+02	2023-06-14 09:49:45.580583+02	00324000015BBNdAAO
79a963db-abba-4de5-9896-cc37b6322533	Goye Denbobe	$2b$10$UIx2xrgcWvBvZY3.QnhwCetivCY6sHEQd3DhguZ3Pe4hqSCK1aoSu	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:23.989272+02	2023-06-14 09:49:45.643386+02	00324000015BBNiAAO
0784f22f-4e10-494c-a5aa-ebe9db8b848a	Jemberu Niguse	$2b$10$IgR2i8n9TodWXX2coiEyl..MkB6D0yMG3Eib.W.jbFPwerbteAYOK	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:24.465019+02	2023-06-14 09:49:45.689963+02	00324000015BBNoAAO
dfe5f69f-9473-4740-b0af-ab8566071b15	Lotu Deraso	$2b$10$tbW1IGjw181kuDkvmC11c.7n8C1X6CrTiPFZ8zTuuTbwY/6aQOaSK	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:24.594999+02	2023-06-14 09:49:45.729294+02	00324000015BBNtAAO
c62ae30c-106c-4735-b384-83d2257ccafd	Sali Demeke	$2b$10$QMRWxwJF1jh70PooE9LIt.YlKLb4yFSil/RvCoe1J/sRbFJ3.xdKq	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:24.613345+02	2023-06-14 09:49:45.770394+02	00324000015BBNyAAO
43e17f5e-e15c-426e-a66c-941d29d26908	Asnake Mengistu	$2b$10$2l84Na5UDlAPk23MzWS6FORxiHoKUq6gBkEcu4guO8GBRc6WQqmFe	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:12.976908+02	2023-06-14 09:49:43.469134+02	0031o00001uxDbWAAU
3cd4b351-2ae6-4f37-8d52-854410a466ed	Amsalu Abate	$2b$10$y5.IcSc7tFyc2Sx4tfCsE.X/qPyWynCJI9oDXPWTQBYcrEx6m6N1y	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:13.221201+02	2023-06-14 09:49:43.538895+02	0031o00001uxDbcAAE
f49ac905-779a-4f9c-b44f-0be9ae9d28ed	Endale Dukamo	$2b$10$zRFGhr/UlNivoJGn7LiXQe3zjxGpqoQb27kbc26cBA2aFveJhR.dS	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:13.502419+02	2023-06-14 09:49:43.576497+02	0031o00001uxDdKAAU
ee535e94-11e2-41b6-9d0a-9ee08f2b8f58	Genet Desta	$2b$10$Sg.W7DnvKX5rUno2dmQ23.uSr5908LWeNsYI2vkEvv9vfJEhHMcCG	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:13.776664+02	2023-06-14 09:49:43.62076+02	0031o00001uxDdeAAE
83a076b9-a962-499f-be3c-c3ad08657573	Tsehaynesh Zewude	$2b$10$ONAQPlHsV3wuYpZa3Mk8auxO/xHrIuBhe3CeLSB8S7vNhbJP4JmU6	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:13.983431+02	2023-06-14 09:49:43.6574+02	0031o00001uxDdjAAE
7c3da2a6-0b71-4bc5-837c-eccb9fca0cf6	Adugna Toshe	$2b$10$8xtyc./6Ai6OmRp20lrfw.1xsfGB/6fXaUXILwbBRgJ1NQ.T82Wou	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:14.241648+02	2023-06-14 09:49:43.702644+02	0031o00001uxDdoAAE
224e5f58-618c-47e2-aed1-322c04869e78	Edilu Eshine	$2b$10$eiuQaOMPfvs6jWigonLLMO4Gyz9EgazzhrNdu6OmxvRqyVigr7rWa	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:14.48271+02	2023-06-14 09:49:43.727102+02	0031o00001uxDdsAAE
5895e090-87a1-4751-abd6-c50b1760e07c	Birtukan Tekeste	$2b$10$nQFv5BC9Mg8lXyaxyuov7.y1ytdd.6rNOhVLzoy2dI.h4DBYbixyi	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:14.704213+02	2023-06-14 09:49:43.775212+02	0031o00001uxDdyAAE
118aba94-d67d-48fb-9439-7669e39e6e8f	Medihanit Hailu	$2b$10$NfJrPiQ09167/082OANa/.kiaDaCcOOfLpeI2Zn4ZP1kngYCm.sQG	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:15.034958+02	2023-06-14 09:49:43.82243+02	0031o00001uxDe3AAE
7df70098-6349-4a0c-a47f-57d0ccbc8d7f	Tadelech Tefera	$2b$10$BYNKCrwj12afJXC3EiVGgejnhYyuqJSBCgS8g64aT1QQh8Qx0FJBe	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:15.336686+02	2023-06-14 09:49:44.107474+02	0031o00001uxDe9AAE
5f5e5a21-820e-490b-aa19-fa1a6d8ec66e	Gezahagn Geremu	$2b$10$glJ8xHTFhF1/GvnNCYvmsO8CkFTYkMRwouxki33wiv3ISdonF8Czm	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:15.580802+02	2023-06-14 09:49:44.223859+02	0031o00001uxDeDAAU
bcfdc256-980a-4e86-b37b-821f9ea1a15e	Habte Tesema	$2b$10$j32Aw.dSnPOSsfgbb25O/eISS4YwoGbwG5bZw8t8V6hHAPNrtsDea	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:15.828784+02	2023-06-14 09:49:44.266992+02	0031o00001uxDeIAAU
f1ff6b35-2d98-4211-b6b7-2a01f42720ca	Melese Abebe	$2b$10$xvRhN0QILj8xquNOGoG.TOmOK5GSrP1dB4WEc7H8q90zYjSpP8fy2	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:16.082078+02	2023-06-14 09:49:44.311367+02	0031o00001uxDeNAAU
4c3791a7-6a84-491d-b36e-35185e78ef84	Martha Yonas	$2b$10$jf3geg9Xxw.w0AAr6ZPa3OWNua2RIGy6/GTLqZteDvp5js.ulENky	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:16.333448+02	2023-06-14 09:49:44.339188+02	0031o00001uxDeSAAU
ab7adba7-e4fc-4598-96a2-5ac512cdc808	Aregash Direso	$2b$10$fQInXM2Tc8/Gv4rYlkzrEeGgyjjd4wm9J8kMIMNkeY2H0VSPyttwO	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:16.555248+02	2023-06-14 09:49:44.377142+02	0031o00001uxDeXAAU
c10bd13c-40e2-4f2c-bc61-dabfa4904bf1	Tigrawi Dubale	$2b$10$OmBIVpjIc4fL7STQitnoouHvJ0f.wY7/YXo5NZloj2wwQ7L5V0p2O	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:16.720657+02	2023-06-14 09:49:44.415283+02	0031o00001uxDgDAAU
11981d7d-f543-456d-aebe-ab67879f7c63	Francis Rwothomio	$2b$10$aNLIuZYt8kE0INbLQt2prOdKH.deTzByMVJRoYIY7RHYQGbTvk882	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:16.912605+02	2023-06-14 09:49:44.478753+02	0031o00001xp88kAAA
843eda3d-ddaf-4ac8-a7aa-313142491524	Josephine Mbedule	$2b$10$oyaN0h7EgUVQwQZMHWzZSea1fPqygjVRLDVaXVkRjpb5PePlvW5Q2	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:17.317543+02	2023-06-14 09:49:44.769503+02	0032400000kwF3YAAU
a1574a84-3860-4089-9197-36dfb2aee7a7	Leah Mwantindili	$2b$10$.PM4cLE5lih/oglmQI10kukZA98WP6qam2yCMFkUUXQYJ9Hu.zrQK	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:17.683261+02	2023-06-14 09:49:44.812099+02	0032400000kwF3dAAE
1269c833-e117-4a30-9ff7-479de58d988d	Anna Kametala	$2b$10$UTvtle/i4DhRQQ9mHLxvA.FmIcxmzRKKIwnmVtzR1eR0T2JDtyui.	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:18.046329+02	2023-06-14 09:49:44.847661+02	0032400000kwF3iAAE
a0268065-baf7-4209-8b43-01fe04149978	Jane Mbuya	$2b$10$INZKGlwhEj.0mpr5nK/r7eLAq.fa1zAClJyQIANADdcos4bYh3UZ.	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:18.302523+02	2023-06-14 09:49:44.88548+02	0032400000kwF3nAAE
856e8db3-4260-4d0c-972f-cd310d258ea3	Faustin Kabasha	$2b$10$VshK.GoHH3jG0By228uv1.dhabZyECHcuIJyHZyb4jJc2Q87HAsvK	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:18.580297+02	2023-06-14 09:49:44.943287+02	00324000011YiucAAC
245b80e9-3428-430b-b471-bc4b0879efa0	Bihoyiki Dative	$2b$10$LioxpNdy4Z1Kq5t3sEutY.asxQuokTSBwEn6YSVTVry4pK0OesnL6	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:18.822727+02	2023-06-14 09:49:45.012545+02	00324000011YiugAAC
24a67ce2-9270-49a0-a288-ba3cbe4317e9	Mukakayiro Jeannette	$2b$10$6NuQ3K5x0Tsp.8DonWLWC.igSJFmt.fOIAyElqHjwlT8ZcAWJWhsu	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:19.159138+02	2023-06-14 09:49:45.061666+02	00324000011YiumAAC
fb79543f-b711-4e33-b0df-bb5f22f68141	Ndayisabye Jean d'Amour	$2b$10$4rpXDLTvHs65LmvQvKrP2.r357QvL71pzxLKeztxtkHqRxKTO.BPC	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:19.459369+02	2023-06-14 09:49:45.100629+02	00324000011YiurAAC
e8970949-22c0-4145-b6b9-b861c568b397	Nsengiyumva Vincent	$2b$10$j3aQwy8bKkauzPNksbuzL.YF03NxAmP/KDd.Bk6UDIUlva7glbXO6	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:19.801327+02	2023-06-14 09:49:45.163866+02	00324000011YiuxAAC
9d46c2bf-8135-4622-8d7d-a8b49d0c6ab0	Ntirenganya Gilbert	$2b$10$JuDuxdUe7DtYJvAYgCOTzupt5GBaCbw9RS7SHq.tZByBzyRXxHChy	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:20.37458+02	2023-06-14 09:49:45.179028+02	00324000011YiuzAAC
491187a5-abbf-4a13-846f-ce115cabd6b4	Uwimana Antoinne	$2b$10$SaCe9vUKItkyv8GJIwJSn.TGqqzhqe.O4kHYiWPFsj0DrS6T5mNsi	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:20.656193+02	2023-06-14 09:49:45.246611+02	00324000011Yiv6AAC
5dac4340-6be8-40c2-aea0-c6a165d644c9	Abinet Dulume**	$2b$10$7Em6Og4NudyCXy9qv2PiBeY4.m8t1a1wD6rH0bQZMYjWdcmuIv7jO	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:20.897996+02	2023-06-14 09:49:45.283661+02	00324000015BBN5AAO
e349bb23-132e-4be6-8482-9fe54c381e8d	Adole Anile	$2b$10$w7BNWMRjLA1oDUyHxsB92uhh5xmhf69zvpTbrPFeFye2BT8aBP.gq	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:21.497945+02	2023-06-14 09:49:45.365503+02	00324000015BBNFAA4
29c9ab17-04b9-4eee-a7fb-c56d4baf32a4	Ashenafi Ebbela	$2b$10$8qir8Wwxs13eHxclX7BatO4UWW637PndaXx.CDU9N.Cn9ydHWuR1e	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:21.942559+02	2023-06-14 09:49:45.399658+02	00324000015BBNKAA4
e8c4531a-339e-4e31-beb1-13adea9666e7	Beftu Eliyas	$2b$10$SPHOHEW.jZcmsTcNPbK4u.5wybhMJrBuLm.eP.C.2Ggasn17KHX6C	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:22.308101+02	2023-06-14 09:49:45.455079+02	00324000015BBNPAA4
48942167-7362-4051-920b-aeffdfc17c72	Birehanu Shanko	$2b$10$ZM0.1XxPkPSKWqoH4CliqOWAZu5TLTArBMQKiFNW7qAVfIfBdrJNu	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:22.757164+02	2023-06-14 09:49:45.510671+02	00324000015BBNUAA4
2418f2e1-0889-4a04-a352-b03b393d829a	Demelash Godana	$2b$10$a/7uXVsdPFFyNBUp7Qf9juFIQm24KxPkTw1Upky04nmOBEEIgPPla	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:23.168481+02	2023-06-14 09:49:45.547572+02	00324000015BBNZAA4
218f5d6b-85c3-4f54-ac4e-499404b4e164	Fikiru Tesfaye	$2b$10$/zU1.3sdS.nWqlGwlNgfHe6R5tiLENcppqDKsraNqt.xDlYX9f07q	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:23.596142+02	2023-06-14 09:49:45.598484+02	00324000015BBNeAAO
81aa055f-d345-4f05-bafb-dd9b67f21b63	Haleke Sore	$2b$10$Vuiqcp3tQHT3dFpkfQXHi.EeZmuJM35SlHZ3z6sihD0DxLoo7Io..	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:24.06653+02	2023-06-14 09:49:45.648061+02	00324000015BBNjAAO
e6c44c94-f8dd-4cdd-b9da-07f9095736af	Jile Keto	$2b$10$24kXa90mfvfW69zDXg9ft.fGX7qQYfPldTzdpUNUPih7e9JWzmNFK	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:24.580919+02	2023-06-14 09:49:45.695908+02	00324000015BBNpAAO
4cd6fe31-795b-4686-bace-89f8bd5baf62	Mamush Temesgen	$2b$10$4/eJm2vb23fhu.k3a6mLlOoKLzaNOG5IksrU/DyrUIMAUPuxHkdmy	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:24.598532+02	2023-06-14 09:49:45.734572+02	00324000015BBNuAAO
02ae17f3-d4e3-478a-a70b-38d829b5e2ae	Sherif Mekonin	$2b$10$7JDr0JLaq0smpC5ZbC1Jrez5FM2LfNd7hm3wyhYOvuG5uRs.jRwvq	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:24.61714+02	2023-06-14 09:49:45.778357+02	00324000015BBNzAAO
82701aa1-9673-49e5-9a1c-86ff38e203b7	Nigussie Bekele	$2b$10$OiZ8t7FB3aTZYINuxSEP0uQkarWkAg0rkBKp8kiHcvM9hnNbV7ECe	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:13.052928+02	2023-06-14 09:49:43.488884+02	0031o00001uxDbXAAU
dcd2588c-56ee-4aae-8bbe-230e7d60fa55	Addisu Shume	$2b$10$ytBKa7lq9vk2hs8tMaO7l.q1pk0fQzMUaKqDs5xpleytG0PlCssS.	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:13.283017+02	2023-06-14 09:49:43.542431+02	0031o00001uxDbdAAE
5305e7b0-8db0-43aa-9d3c-a7da57770317	Yateni Degu	$2b$10$ILOVR2xdr3pTse3E80pRXO5RRQN4Zgxlv/EVF4C3zcaaH7xb6SMa.	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:25.167138+02	2023-06-14 09:49:45.871973+02	00324000015BBO9AAO
1724657a-1547-4501-a79f-a26893582b37	Dube Teneya	$2b$10$EnsmCvkxlESga6BIlyJ.Y.MmUTvBxGaJHYur0Sj7cuVIpCYFruN4K	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:25.348652+02	2023-06-14 09:49:45.919067+02	0032400001FFgmEAAT
fa1e5fd5-34d3-49e0-ac62-1b1c22751896	Chantal Nyiraminani	$2b$10$l3OK0p6Mcjlft.11RoQFguTJyXfQfjsHlsQFhWDYuUWqhhIGqzDk2	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:25.731508+02	2023-06-14 09:49:45.954667+02	0032400001G82toAAB
8f1e10a0-7450-41bd-a86a-c8eab6dd3081	Damascene Nizeyimana	$2b$10$GZr8HReKDgdur1NAeqCUo.389pw/Rx7LCjaBgsVyPcyopIll/kyg6	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:26.107419+02	2023-06-14 09:49:46.056208+02	0032400001G82tvAAB
a5e745ca-c1b3-4c8b-b8fa-eb1e12b29803	Ester Safari	$2b$10$/7rcNH8W.XbocwvxCZUA5OBpchwKoGmZK8v3rMKJ.AbGndoxnTjm.	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:26.141518+02	2023-06-14 09:49:46.089469+02	0032400001G82tzAAB
027accb8-9663-4a72-9fff-0d64b06f674b	Vincent Ngezahayo	$2b$10$ydRcMuoQjYqq6GuTgkVu1Oz2R2KIZOBhM1msqwa2iweqYmUi5BeNm	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:26.406666+02	2023-06-14 09:49:46.13958+02	0032400001G82u5AAB
ccfbbf1e-0027-4f77-b6ef-9dfa62917c6d	Aimee Providence Karwera	$2b$10$rwZli6ofhHakzU9v74GXsO6JiEuYvV1CplHLTelmO8fiq.oFqIfSK	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:26.613795+02	2023-06-14 09:49:46.159455+02	0032400001G82u8AAB
c3f556e5-98a5-4597-b3c9-eabf917bd32d	Francoise Musabyimana	$2b$10$t82e.pLS5EvzyH4uI3qRGeLmOLlJ4ea9oaON8DX3YlDKnTK.W6qC2	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:26.664683+02	2023-06-14 09:49:46.191351+02	0032400001G82uCAAR
da09c407-6ef8-41cc-b336-25981f366192	Joseph Bayibarire	$2b$10$F0EtnzBHHbzrvXIzZSvkbeZI7hHVV3FgNsjiSQUwD1XsRoyGzaM6u	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:26.701873+02	2023-06-14 09:49:46.532822+02	0032400001G82uHAAR
158df92e-e642-4625-94e4-38e6b7cfe327	Riyad Siraj	$2b$10$yuKhUAVLY0hqhDTP6aVXbeaP/VHQ0P6G97MmbQl7K32m0vY0fLKGS	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:33.950875+02	2023-06-14 09:49:48.177297+02	0037S000003MlQJQA0
5165c21b-5f06-4dcc-b901-7748522f77c4	Akiram Sali	$2b$10$tK84.3VWoTHFxgOESQghTOie2bza3KeeZkoB9yx4yEYp2afzl1FdS	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:35.992881+02	2023-06-14 09:49:48.412861+02	0037S000003MlQdQAK
1e918851-a2c1-4e7e-916a-a32cd8342ff1	Seida Nezif	$2b$10$uroyJDvn6oLH5ahfzdHGw.ie9m9JSt03f3Ba1eRU09xv8wx/8qdUm	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:36.210344+02	2023-06-14 09:49:48.423006+02	0037S000003MlQeQAK
d87e02f0-9d90-4e99-b600-aa1a4f752127	Hania Negash	$2b$10$alkWscewGbZADvbidRgvK.jY6FKN3iDeRwAc9QtKIbi3U/8Xwcl2a	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:36.266407+02	2023-06-14 09:49:48.436003+02	0037S000003NxZQQA0
c77e738b-99a8-4e95-a00b-4a7b4bdcfb58	Buzayehu Workineh	$2b$10$LE/DOpIshZKxpOogo9mvwOaVTw3j0JYHxPX8ElEzJ5FBG7yK3V3i.	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:36.34804+02	2023-06-14 09:49:48.452166+02	0037S000003NxZRQA0
94a522f1-ec11-45f5-acfe-376c3d8896e4	Hayimanot Bekele	$2b$10$b8h07rRKWfmpedPuNKVhuuQRf36bZJzJMBv.3J5QhEspR2C.lVtOq	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:36.403159+02	2023-06-14 09:49:48.47238+02	0037S000003NxZSQA0
06256f3d-356d-46b7-8963-ca5340d08819	Zelalem Lankamo	$2b$10$0LHshb9GxP/pDoFhsW/hh.zZjFqvtHGNEG3GpbbOkWUt0.WVkzGyy	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:36.572237+02	2023-06-14 09:49:48.509141+02	0037S000003NxcuQAC
1307a326-22dc-4bf8-b4a9-ae063920ad16	Wondimu Sirbato	$2b$10$qWcVJFqkaZcEqDD1OTEbiOjMtWS1g6Sc.nrjpRbT9G3MsMOH9kL6O	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:36.697271+02	2023-06-14 09:49:48.521368+02	0037S000003NxcvQAC
d874c738-0689-4b0e-83d5-acf999d5ff11	Meselech Ugamo	$2b$10$QsAKQpta25pWjGqYOFC2UutZxTQdH/sDpDn3GRxujEfnOEJVZiIe6	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:36.746441+02	2023-06-14 09:49:48.526811+02	0037S000003NxcwQAC
1ae470bb-b369-45e3-8688-69e51e6ffcdb	Mushirit Hailu	$2b$10$g58.ylpQ3D4zDdJmtAVciebU53H3iR0gkhFWZActIhfq53r0fUeFu	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:36.901858+02	2023-06-14 09:49:48.544283+02	0037S000003NxcyQAC
da93da4d-cbb2-47a9-aa1c-a67f27390e0c	Ermias Hailu	$2b$10$dPNh5aV9TOSHlwXhDZhoPOuSfbsnHof6MA8fR9YjsYPFY3z2tJ/K.	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:37.037986+02	2023-06-14 09:49:48.560686+02	0037S000003NxczQAC
db19f200-2b7e-4bc0-ad8f-291427e86082	Rediet Siyum	$2b$10$bshdcYCLbhfyJ4nVAPyKruIdk1KIUSwXcdApahr5MkhyTJk32G4Ha	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:37.073905+02	2023-06-14 09:49:48.573325+02	0037S000003Nxd0QAC
e6936032-ae00-4bdc-a5fb-997753938bb9	Beletech Bekele	$2b$10$eUlK7rhQ/2LxxDJrDEQ7nOQNbE0eGNAHx2iLGebMJitYPohR2fo4O	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:37.248524+02	2023-06-14 09:49:48.580289+02	0037S000003Nxd1QAC
64f39134-3cc9-497e-9267-b5560eae3387	Niguse Ayele	$2b$10$fPVV/GWcYufBnJ1N054ZwexTHqVEhbgixPKg0c42b6QoIs8zynpU2	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:37.189423+02	2023-06-14 09:49:48.594721+02	0037S000003Nxd2QAC
e83ca7c1-2e28-4f0a-865b-6a4fc2ca9f1e	Meskerem Esrael	$2b$10$M/UvtFWTQOUyww70W691B.dOAqFZnB57QretGLzS9JvpJR9uFtHRi	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:37.317527+02	2023-06-14 09:49:48.604845+02	0037S000003Nxd3QAC
156b712d-0932-4e7d-9ab5-77f695ab7b19	Bereket Abebe	$2b$10$SKLrooh19conYvtp/9ukz.PIniSdjUQnQokUHbuziz30e8q1j.1he	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:37.381432+02	2023-06-14 09:49:48.610499+02	0037S000003Nxd4QAC
fc4b898d-d516-4745-ab5c-fe53a2f6dd15	Abebe Kimo	$2b$10$8GTSMSKv1l3hSLCYV/V3FOvKIQg5oZWp7L5YCVdIl634MuRsxknmS	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:37.523358+02	2023-06-14 09:49:48.621006+02	0037S000003Nxd5QAC
017d4fee-8a78-4fcc-a3d4-9a8d17218f65	Tadelech Safeyi	$2b$10$QF.FwckxysP4YkA/uluYeuE/8nro9cw9PejSh8UsTt4elI.LZepnK	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:24.620644+02	2023-06-14 09:49:45.791776+02	00324000015BBO0AAO
9f004af2-e9b2-450d-aec5-f75ed1eb2dc4	Tizita Dulecha	$2b$10$oVgNzrKNAPHkSsMavgDP6.b8kUqs3vmvGjEbGyvP9emehFU2Uvir6	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:25.147813+02	2023-06-14 09:49:45.840042+02	00324000015BBO5AAO
0ca7b788-52f6-4d6c-bac3-ab738a5f77e4	Semira Akmel	$2b$10$YwCwrcEJmeVMhqcZau2N2eStsm3xCJuzQPzKovhxAWBGw6O8I1jme	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:34.139691+02	2023-06-14 09:49:48.225413+02	0037S000003MlQKQA0
e7a38e2a-de20-429a-8bdb-1f4322672351	Mahammad Hasan	$2b$10$Xd0t1NGtk9BNVaLeVFQtWOtTXnGXtOPVx8JvRvtOk8xm4DaPa9KTe	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:34.358365+02	2023-06-14 09:49:48.242079+02	0037S000003MlQLQA0
a77a6126-a324-4641-baf8-15676e7e9fb7	Teketel Kasa	$2b$10$YUcfl6KyhKoEqoMuLLvGduT7QwdCb3fN7u3j24aGGyW3ifPL8k7hO	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:24.62415+02	2023-06-14 09:49:45.807536+02	00324000015BBO1AAO
81596152-5eb8-4728-9c5b-132d131f65d1	TEST2-1 TEST2-1	$2b$10$GD.vpcIhfPn47aEPR3eYw.AuNBU9Xqvf4jOSFSupN.Cx4IeE6jyfy	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:25.444716+02	2023-06-14 09:49:45.908216+02	00324000019rqjaAAA
76e27b02-f561-4141-91ed-fd3a38be7115	Francine Nyinawumuntu	$2b$10$aVY3UD8SccNW1s.QzX.Y..l34tW1RObVMmPpAM/VZOYcWBZOliJ.u	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:25.818038+02	2023-06-14 09:49:46.004457+02	0032400001G82tqAAB
51c35af3-5397-4606-bcd4-e33fc73198a7	Emmanuel Ngiruwonsanga	$2b$10$F7BnCvc/KC47i4V08Iny/O05fBY4G.e0hwXSyG193KafaR67Evgve	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:26.110876+02	2023-06-14 09:49:46.044558+02	0032400001G82tuAAB
3944d8c5-c02d-46e0-83c2-21251cb31ed5	Vestine Nyirahakizimana	$2b$10$NNb14fc3JKIyK2q9ixa1VuRtOcny7KYARtbPbRBrzzlABrPHyzN5y	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:26.14506+02	2023-06-14 09:49:46.104763+02	0032400001G82u1AAB
b8809d65-ccbb-42c9-962b-beb9b10211b3	Liberee Niyodusaba	$2b$10$pLa.zH2LBxlMkCdF6/dsMeUFHnTnF205oPDDyCG8R5ei1uzPGIoQ.	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:26.477536+02	2023-06-14 09:49:46.127701+02	0032400001G82u4AAB
67838c47-235d-4fc4-956b-453cb4c2f4a1	Cassien Bikomeza	$2b$10$KxhH2wdMXLsbSqTWO2awWuKm.RH/jx.q8zEglm6ulAn5BhHmyGIUa	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:26.631707+02	2023-06-14 09:49:46.176024+02	0032400001G82uAAAR
bdb5a122-85e0-4032-bbd7-28d6ad3328ff	Valens Kwizera	$2b$10$bD9WyCBFqCowWApc/pB16.izkAkb6vZaSgIvk.nvxUx2OeLcFGY2q	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:26.673863+02	2023-06-14 09:49:46.358078+02	0032400001G82uFAAR
f2d85562-b55a-4110-ba02-a6191897172a	Vestine Niyonsaba	$2b$10$dqScw73OGK9JvdT4mB2TNOjeo4Hpzb4HAGwTnyNbkV.F745Y19zWS	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:26.69483+02	2023-06-14 09:49:46.467587+02	0032400001G82uGAAR
b497933b-f2cb-4964-bffb-8d948ea56808	Millicent Muriithi	$2b$10$m.O8jCOI7nSrEpqW4B1hA.pYIte/nWbQTLMA6T63MFbg3p0EvuYxS	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:30.192411+02	2023-06-14 09:49:47.233717+02	0032400001LOnRQAA1
1bb6e7d8-70c2-440d-8b43-b3bc12cf4afe	Kasahun Kambe	$2b$10$gIAayy..FQ4v0PtNpgAQtOuGvM3jA5/jI8KsG6bLHnpI8pUAPx5NC	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:49.392641+02	2023-06-14 09:49:49.753288+02	0039J000002OGXEQA4
f787b2fe-d741-48b3-8800-793a40d6eb47	Adisu Anamo	$2b$10$rpD2uqcP7.AxeWfCSuUS2.69IqouIJ7dvRCyzIErHllbm326MWhRS	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:50.878256+02	2023-06-14 09:49:49.943855+02	0039J000002TjumQAC
8608d5a3-c306-4cd8-a270-d41a9b07fefa	Redwan Ababor	$2b$10$t9phtfX1nQeQhlNc4xMqLepH7h4X0jn3G1TGB2W37ySWOVbzKbNUy	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:15.753649+02	2023-06-14 09:49:50.22482+02	0039J000002UT2vQAG
c93229fb-2e7f-473d-b7fa-b55a3812ff2a	Bontu Sano	$2b$10$f/8PU03jBAv/RToS45m4pOyOTcwZ8qVHiozhnjDlLrQx9kcwiAES2	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:15.808917+02	2023-06-14 09:49:50.441432+02	0039J000002UT2zQAG
162c3f36-0017-4dd2-8d69-675f5fba1c84	Kedija Aba Jebel	$2b$10$O.RCCa6T8q4i/MhLZceCBOwf32YiOJBSXLj1CQ.elK17psAA1NbWO	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:01.186093+02	2023-06-14 09:49:41.166975+02	0031o00001i7jlGAAQ
950347d1-d644-4311-838a-234b3fb25c57	Elias Beyene *inactive*	$2b$10$FU9F4y0A2YFsRXIfKP7miO8UBrK2pCcasGfIVHDA5lqqN2lxez2I6	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:02.811213+02	2023-06-14 09:49:41.348579+02	0031o00001i7kGfAAI
fd29b901-6433-4192-9ec5-550a4a04b81f	Rolande Nsimire Bulimanji	$2b$10$E/aBvP5b7F6qPM3plInDfuFnJnwwx69bOVOmfg8uvxgqhtsWEHfdy	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:06.335214+02	2023-06-14 09:49:42.014051+02	0031o00001nYrUyAAK
87178751-388a-443e-ad3d-bc5ac4cfcadd	Mekdes Aweku	$2b$10$qLP5FGkt5EINOBF6vPSusOd8OfJyHlJGDxBrbvoJK4WgpLNwt2knW	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:12.289426+02	2023-06-14 09:49:43.344552+02	0031o00001tPEdfAAG
f58abd39-9c0d-4e4d-b1b1-ad60d0a1baf1	Geoff Minor	$2b$10$/.uAuqehT7XdNuLoK1.W8ePdyqNKCyN2awhFF03B1M1ncxqfNH9.a	info@salesforce.com	(415) 555-1212	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:20:46.797547+02	2023-06-14 09:49:44.488625+02	00324000002sAisAAE
d2c52ea9-db5b-4ca2-8ace-72cee7783a75	Hiwot Demeke	$2b$10$CDXfE9p2/nZVsQJ7WsxacufGdDuF0eltvRQWegiB9LTLhwuFQ9uPO	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:25.151812+02	2023-06-14 09:49:45.663154+02	00324000015BBNlAAO
5862c09a-052e-4f49-b6a8-37494179697d	Mebrate Tilahun	$2b$10$xg5oO/kr44CTdI6dQqPoued1oqaKE0GhCFL8IT3vifjyaMEzX/KIe	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:24.60203+02	2023-06-14 09:49:45.739375+02	00324000015BBNvAAO
0b2969d0-a492-4aa4-8e2f-581ea32cc490	Yateni Sida	$2b$10$Tsb6s25fndbQ1yP0eiiNwexhVivN7Wm9cV8o4YqY.GcVrR6FrRQ2q	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:25.170547+02	2023-06-14 09:49:45.87709+02	00324000015BBOAAA4
e879869c-3ec0-4798-8c3b-f51ef04abee7	Rama Samman	$2b$10$y/SELZvRtH4ZQRB2q6B93OTrb2WyCmVoPMPP.mFZ3hhGLbq/jiXEC	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:50.443109+02	2023-06-14 09:49:49.903958+02	0039J000002Q8mUQAS
30287190-bf04-426c-8bc3-3c2d9fe43c2e	Tizita Damtew	$2b$10$qxWIpquA6NxYwgYw7VDE9eeM/vWDIOZXelwjsoCjEKvtXZPjkx/My	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:50.617629+02	2023-06-14 09:49:49.921269+02	0039J000002TjulQAC
9e7f3eb3-b4e0-4346-8a03-868ef856ce68	Faiz Raya	$2b$10$U6sokgj/oMKhPSMIBiK9geKVQr88vwxxYXrWfRXD0XIQlFqBQkmGG	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:15.896833+02	2023-06-14 09:49:50.732288+02	0039J000002UT39QAG
ca63dc65-f766-461c-b931-b5c23e90110a	Nesru Tamam	$2b$10$FztQW7wciGT8GKQnKtqUXO7l19baItz/o45stS8EGmuoejq44W54C	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:15.927993+02	2023-06-14 09:49:50.794507+02	0039J000002UT3DQAW
6bf5c1f5-be25-4e53-a79b-a795eb38f0c3	Nezif Sherefu	$2b$10$CbxuP8BGggHgGJ0EK8Kok.1MHr3KC1rZP9Y62A7lDL0mfnNH3QIHC	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:15.944547+02	2023-06-14 09:49:50.798825+02	0039J000002UT3EQAW
120318a0-8ede-473e-bc3a-4b138d690a28	Usini Nasir	$2b$10$SUBnOl0rN6hnLnYm1rAtYeL.PrrdZiPARApQTDcDFfRLDQZDd0b1G	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:15.979582+02	2023-06-14 09:49:50.822882+02	0039J000002UT3HQAW
00ad2bad-5dfb-4592-8802-0fce63a45cea	Birhane Negash	$2b$10$FZDbmOlV4YSmclDpMuUQO.t6OEg6a7DFl3zJnlhKA1QPcSRStnzyq	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:16.003757+02	2023-06-14 09:49:50.830648+02	0039J000002UtXFQA0
eb0c7676-184c-4130-87de-c34c98213364	Fikadu Beyene	$2b$10$LeD8hoPo/ZxadOXFv5Th3eXwD/KPCVt8VckrGlkAKKxYBPzR8fn6m	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:16.034217+02	2023-06-14 09:49:50.85576+02	0039J000002UtzMQAS
ff2434d9-1009-4119-b807-8d0e3bfea516	Adanech Tumsido	$2b$10$AJeYTF2s.aqnWSx5ZPDAVOFJ3h2ZCixKjHx/YsGiYlfHA0VkZo3Dq	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:16.050772+02	2023-06-14 09:49:50.876702+02	0039J000002UtzPQAS
66513495-6b62-4a4d-a58d-32fe22ee832c	Tamiru Elias	$2b$10$USYCL.coRMZ4h2G6LfsHX.92qB7UWLLnseOuIY/TOgCyuSzhdL4BW	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:16.084816+02	2023-06-14 09:49:50.903945+02	0039J000002UtzSQAS
01256961-22d8-4096-b7a5-55630581b29f	Wondosen Seid	$2b$10$UE8NcGgCfjB6PtMeju/zquOtZNQ1cmDwvrmeOTfyRDxTAuNnjdsxO	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:16.110802+02	2023-06-14 09:49:50.916918+02	0039J000002UtzTQAS
2e12dc71-8848-4fe1-a576-5958a3f82401	Aklilu Dogoma	$2b$10$7uLgExZeNHGrSBSCy73u2eWdIuxgaetDUlnXL/YsV.bDB6X1NU076	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:16.144054+02	2023-06-14 09:49:50.921806+02	0039J000002UuVQQA0
ebf51d34-aced-40d5-8010-53a89b5da7bc	Asnakech Meseret	$2b$10$5PnsGNgk0tKBI7KUK.sQfuJYaQzCxX8RNOFTE3oSHaYwxKUC5v/2W	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:16.137577+02	2023-06-14 09:49:50.928636+02	0039J000002UuVRQA0
bbab1398-0bfa-4756-af8f-d85634725c5d	Edilawit Getachew	$2b$10$eYc111ab3aATdSUy.uutbuDMLHHlQ9ag3K1IwM45fmJeTZyW83bdG	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:16.118596+02	2023-06-14 09:49:50.940864+02	0039J000002UuVSQA0
139191c6-356e-4d0e-a682-00de70f9c04c	Gizaw Gemeda	$2b$10$URlvpq2n6tGwUZY2Xhk53OMCI/kqpVyOZKYHSOhvxZ0eA.TsAmMT2	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:16.155347+02	2023-06-14 09:49:50.947298+02	0039J000002UuVTQA0
afa01425-0d60-4faa-8878-d10341bfe8b8	Haymanot Tefera	$2b$10$LMzg.HKRoamH32noP2Mo.uVy518aTdpOquxvK8p4byR3RcrU8oJDK	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:16.167756+02	2023-06-14 09:49:50.981646+02	0039J000002UuVUQA0
a0a99f98-eb0b-450b-afd5-41f5bca0fdb7	Bikiltu Dadi	$2b$10$x9kgEJ3MFi49V/XWtRara.TeWdfGq6mH4sFZ2q8AtXoZ8PX7WB4G6	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:00.893872+02	2023-06-14 09:49:41.109595+02	0031o00001i7jlBAAQ
faefaa68-1d8c-472d-9d46-7a7cdaa2a01d	Test BA	$2b$10$IZzgCmTfXOyq8wUkwT42Yuv/hFJxOapZHm4LkbjP/3QLB7c0jWCum	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:25.525195+02	2023-06-14 09:49:45.926153+02	0032400001G4WRqAAN
a65e8eca-d2aa-4cb6-be55-0039773f096e	J Damascene Kimonyo	$2b$10$BLM.t1dpMiUef.h40RIwDuEHshbpEfqHJwp88AuMUdfwXPd.WZ3sy	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:25.952778+02	2023-06-14 09:49:46.023956+02	0032400001G82trAAB
e42615a6-2d0a-4981-8a53-f9f02b883015	J Baptiste Dushimimana	$2b$10$brwDt3FeECLkce.zqHIs3u60w9pgjxzvEe/.zMnOZNFKCiKtD.kb.	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:26.13047+02	2023-06-14 09:49:46.060138+02	0032400001G82twAAB
038601c3-ef0d-4ca9-bff4-dd810c37e3dd	Celestin Hafashimana	$2b$10$HPVNAyWNQ96wys73QV94J.9qU2UxNjr6.cTOERjX2/V6f/e8Kux06	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:26.148381+02	2023-06-14 09:49:46.093384+02	0032400001G82u0AAB
b0311926-1f9a-4031-ac38-598afacb2204	Claudine Umubyeyi	$2b$10$mTlPCYIZq4OBh.EqKXLVOuMBYt2oMebqq9T..cKCTkDg4k3R1vDpC	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:26.533667+02	2023-06-14 09:49:46.143671+02	0032400001G82u6AAB
bddfd645-bf3f-471a-9dea-13e75f9c2c80	Alexis Manishimwe	$2b$10$7H2fk6aMnQx.MqsQ8PYINeJo.wig9l66OlATHjz4./A.tuJpufoyu	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:26.646155+02	2023-06-14 09:49:46.186272+02	0032400001G82uBAAR
21002cce-63d7-44ae-99e8-cf98e86cb8b7	Temesgen Neme	$2b$10$3uKrRXcAzZk.zHS1oC3twOvRDNjI7S4e/Q43c66cEA14fKniSkHO6	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:26.897905+02	2023-06-14 09:49:46.698628+02	0032400001KZCUEAA5
ec4623f9-6c0f-45de-8e11-3e3f8b3a4482	Admassu Engidawork	$2b$10$MCrHoqdmocAw3heGT2T/UOkQXuA1j34bcjyyuXtkLd6OnWWT.GxFC	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:27.06502+02	2023-06-14 09:49:46.703304+02	0032400001KZCUFAA5
563263dd-6a19-498e-9a81-c1e10dc124c6	Birihanu Fite	$2b$10$pqlucOgD5m8d3cOBYD9S8u/SjrxQfhEU2QMMRSb63yhNGmSZgT0uS	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:27.196542+02	2023-06-14 09:49:46.757782+02	0032400001KZCUHAA5
e7193e7f-5780-4d4c-aaf2-ecc8756c5c6b	Kimem Agonafir	$2b$10$hpdNrsXyG2WIjivg5HOBr.oAY6zAY0189IElA1wGrvsH80CcJzAzC	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:27.579402+02	2023-06-14 09:49:46.835547+02	0032400001KZCUMAA5
30fb5e49-7b92-4b2f-9e15-442e7d6911c7	Tadele Negash *inactive*	$2b$10$zl.KBx3mXmkpySAY0dEuuO8pmsqQdQNfXK4uTp5AVlJE3X/TlemUK	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:27.721649+02	2023-06-14 09:49:46.846728+02	0032400001KZCUNAA5
129f5449-fbf5-4ac8-adad-b806fa495798	Tamiru Degife *inactive*	$2b$10$K/Plq.4nVIHC14.iw5mKkePYirKF07usfTp/4nM9VYN5aW9vrLusi	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:27.761639+02	2023-06-14 09:49:46.854064+02	0032400001KZCUOAA5
bcbbacb0-9191-4198-983a-960734ee2c3f	Teshale Asefa	$2b$10$euPkOunDzgNY1sBL3cdKLO6kmTAeGzyyiqiR7AZQP2RG7EG4QJtl2	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:27.816422+02	2023-06-14 09:49:46.863558+02	0032400001KZCUPAA5
6c168d58-7646-4d3c-85c1-8e8f6fba14d7	Ashenafi Gizaw	$2b$10$4Fd09LE4jP5ozW9dxMmuWu81VqwARx0CLI6cyJa6m1VzjfjhYZfEu	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:28.071252+02	2023-06-14 09:49:46.888688+02	0032400001KZCUSAA5
5d81ead9-ee1d-4700-b89d-6a1529d97230	Bogalech Negassa	$2b$10$U3aw2bS8UBweYAVd1Y4oqeun2n3OEmUKXxmei5DYON0BRe/4mn7oG	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:28.115406+02	2023-06-14 09:49:46.900528+02	0032400001KZCUTAA5
0f014399-360d-4f57-ade9-327f392cfb62	Firdissa Oljira	$2b$10$v7DFRJzKZaGdIM./J1HCBecWw6fw4XYgzlXPt7Rk4S/J1bvLmz.XG	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:28.174539+02	2023-06-14 09:49:46.904582+02	0032400001KZCUUAA5
451fb39b-1486-48ca-8568-e61ba6654a6e	Kasahun Chala	$2b$10$OhiPQ1nRhN9R8Jm93lLLJO4UeLnPs0iaXju9.0dFi5ILpW4N6Q7z6	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:28.337736+02	2023-06-14 09:49:46.915784+02	0032400001KZCUVAA5
4dadded5-9445-4a04-bf6c-f2bbcf13bad5	Seifu Bogale	$2b$10$djX2bB09GStY/lyAZPJrJOVYiZ2zyPfK7YVbSzhdDuEo1UUruiELC	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:28.387411+02	2023-06-14 09:49:46.919994+02	0032400001KZCUWAA5
02bf86c7-20ae-4d89-a85c-9c260561026b	Geremew W/Giorigis	$2b$10$.G4pzDBMU2v2JZBJfte3IeISDGcnTB0.ehWjbB2fL2O.tywG1lgNG	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:28.471863+02	2023-06-14 09:49:46.97745+02	0032400001KZCUYAA5
f294045d-696e-4c7c-80e8-b87877984c07	Girma Guta	$2b$10$4kMEkcEhG.zOk47XRgZIE.flZTr4UFd6ZbqwAQszLhdc7JwoZ7C0q	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:28.629876+02	2023-06-14 09:49:46.993689+02	0032400001KZCUZAA5
17333df5-beda-45dd-aaf6-f7c43159419a	Meaza Tsegaye	$2b$10$yK1GhvP3GVPL6X9zrFCHT.BLxi2QnOI4bDcpD33WmP9cvK6CCa.5.	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:28.698125+02	2023-06-14 09:49:47.001522+02	0032400001KZCUaAAP
a7be5318-e01e-4169-afdb-dd7658c533a1	Mekonen Tsehay	$2b$10$.FP8vdo9.Gw2VzYLFBxpdOEjurzSM43VLk7bKUL6XGs/R7mBW9xYG	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:28.740241+02	2023-06-14 09:49:47.018719+02	0032400001KZCUbAAP
6a32e528-80b0-43ad-ae89-385c32337647	Sibhatu Derese	$2b$10$AAzxD4nQKLMjZpS0l.LQEOaU.imqKe2Z2h5KdXvbn5MNcIZjEx6o2	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:28.771236+02	2023-06-14 09:49:47.028145+02	0032400001KZCUcAAP
74ccc230-6488-49a6-82a7-f45c61f6c0cb	Tewodros Teferi *inactive*	$2b$10$x0R7S8cnDiatUyxm7MInruN8yrIjUHwmOMsMwe40OdagRKpLE9Vba	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:28.972756+02	2023-06-14 09:49:47.033715+02	0032400001KZCUdAAP
ecc75163-52c5-4ec8-bad6-a9daf0c5252a	Elsie Ngina	$2b$10$ZBzP2bAbxfHo8RmAULDzouiE3tKKNMYBqYiIYwpbIYpyFdCyKUtD2	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:29.491927+02	2023-06-14 09:49:47.105115+02	0032400001LOnRIAA1
81661188-a3cf-4087-88e2-b755783a84a0	Anne Karendii	$2b$10$KJ4JBixWiCH2xrD7I.XHxeYSQuQJC1vLmiMyPgT43esVcZqj1XBvW	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:29.608645+02	2023-06-14 09:49:47.134902+02	0032400001LOnRJAA1
f31ed80b-e88d-4d5e-b24e-74472a1f5cfa	Cynthia Kuria	$2b$10$ZXTPeMeeCKLFk3Sra3e.V.JiAtiHY4K3NownBa8KlNSIi7PiLbs3G	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:29.794314+02	2023-06-14 09:49:47.148701+02	0032400001LOnRKAA1
89259729-a3be-4c48-a848-1bdb0f1a38f3	Mercy Oyuga	$2b$10$nztTf5Oz05Z3mtDYw0sEsuwvIM15aLyguhQuuzq5Lj..ptrpgp3EG	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:30.247853+02	2023-06-14 09:49:47.21852+02	0032400001LOnRPAA1
eabf831e-2775-47ba-bea3-4c036dfed9f8	Rachael Kariuki	$2b$10$zfq8gVqzYKcnssIQ2Ih78uRGb9GhqcTJmlMYcZDo3E/.gb9wCy2aq	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:30.346624+02	2023-06-14 09:49:47.250419+02	0032400001LOnRRAA1
fc2e7a56-bcf2-46b8-b779-8075b69a2052	Paul Njuguna	$2b$10$zOOEKiwBqXKInGMRbLMtVOpeyX3W8kVXXeKh7qHpZARZ5nyiQiT/.	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:30.442398+02	2023-06-14 09:49:47.264501+02	0032400001LOnRSAA1
66fafd99-cf31-4343-beb5-aa529a34138b	Mercy Ndulu	$2b$10$Ol8kEpliONQrdveJ8CO4l.ce.XGD9e5yxpiErUuRfKzYm7SpFHWVC	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:30.560744+02	2023-06-14 09:49:47.28097+02	0032400001LOnRUAA1
b02f604d-f1da-4561-aba9-dfc27f3cae4c	Simon Njenga	$2b$10$OKMkrBzGxZUL.q7NxlRNTOZvSKoLgGTKENsPnu4rxXtILDDFWB7H.	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:30.670497+02	2023-06-14 09:49:47.303593+02	0032400001LOnRVAA1
be8817d9-e10e-400c-a400-75f345405440	Susan Njoki	$2b$10$wpA7wqa0tLrxpBjULXUVjuleWSIqAMaD2xxD5AmofEWCd9TblSrYS	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:30.734558+02	2023-06-14 09:49:47.326719+02	0032400001LOnRWAA1
4877d4c8-95ed-4431-812f-edbdd1683f09	Wesley Ruto	$2b$10$vHNSJom/.DM43MNn0rc6T.iMwWrcnmelSwtZNR/4.8P1pdK0btoFC	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:30.794853+02	2023-06-14 09:49:47.367389+02	0032400001LOnRYAA1
bdc32c6f-7eb6-4bdb-ae45-fb84241ba712	Alphonse Ochieng	$2b$10$fJ6.DWhbJS/joBKvqgzXuOPjJj1zbJKjsY00kjPFjm20xF4KaPzae	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:31.245385+02	2023-06-14 09:49:47.39363+02	0032400001LOnRaAAL
9c9d2bb9-c797-45f8-baec-8e91937d18a9	Betelihem Debasha	$2b$10$h8IIc9L1cJHcpwHirbjpAuZHmATMTaHhjaiK3NKgYhHagqzzjkbdi	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:31.7058+02	2023-06-14 09:49:47.584075+02	0032400001OHpWKAA1
831bee4e-9cbe-44a1-99e0-468a40edb56c	Tazur Gezahege	$2b$10$5AGrmWUUD7TjwbeszIUMkOGzpzMicKJAz1VpHB49NIUZbfSVVEpHe	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:31.827958+02	2023-06-14 09:49:47.601659+02	0032400001OHpWMAA1
7a2b8e21-63bc-4aef-beb9-18c41f2ea91b	Tsehainesh Tariku	$2b$10$3jjGqVvu//1x9Sx9QYMrQ.Nl8.7haYK5wQpihU2RfkAFr.UwFNuhe	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:25.155399+02	2023-06-14 09:49:45.844711+02	00324000015BBO6AAO
c4708971-905e-4bec-bed9-12f0f5ad7516	Yohanis Alemu Gude	$2b$10$t2aPnNxcODp0VWR.bd0XROE1CWGsEGtHSVcxYpJQLeTLbPSC6pnO2	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:25.174111+02	2023-06-14 09:49:45.890878+02	00324000015BBOBAA4
4a1dc083-bab1-43d9-8b2d-60e7d92ebca8	Test FT	$2b$10$8CO7nMP5TgDJafhoX0c3vu3EgbGsu8BQK8gPlN4/ifGc.4VlaLD6a	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:25.611551+02	2023-06-14 09:49:45.945148+02	0032400001G4WSUAA3
44477092-772b-4fb2-bce1-82ab088021b0	Alphonse Mpakaniye	$2b$10$PACd8VRcYCheXskrCDQ4h.XVBHGSrLUVcDV8U2Dc0qtefSu5mUwXG	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:26.100086+02	2023-06-14 09:49:46.039749+02	0032400001G82ttAAB
589d44ff-44c1-4e87-8b2d-8be6a1d8cdf2	Hawa Nyiranteko	$2b$10$BMsXA66INVi6nh1NttENtutDKzQz.Z2C6jpMA4siKr79ttvlUO//W	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:26.134353+02	2023-06-14 09:49:46.072496+02	0032400001G82txAAB
5f4e145c-4007-4e1d-8133-605b878131b1	Seraphine Yambabariye	$2b$10$JMy.t282wcuE6tiyQ12pAuhTDZQtrjLHkP.L9IcD5iT9ZO7SJWr0q	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:26.24488+02	2023-06-14 09:49:46.122629+02	0032400001G82u3AAB
3410be5a-6da4-4e53-b333-03108c4e9540	Elyse Bigirigomwa	$2b$10$..fGb.G.ALLCUIgSSeO.Cel2h0O9tpm.s8fq6RvJFUJkJM46B44tW	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:26.583974+02	2023-06-14 09:49:46.154376+02	0032400001G82u7AAB
e8828368-9967-4bc5-acc6-c2855f838bca	Leonille Mukandanga	$2b$10$5Us/xCELHkQti6ZD8PMtZuYK7VhL32FwbIR/QAKxhtoBhzTjkD1zS	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:26.651137+02	2023-06-14 09:49:46.24068+02	0032400001G82uDAAR
d95ee033-804e-4422-860e-d17787a49cb9	Marie Claire Nyirangendahimana	$2b$10$l6st5C5pmiw5Im29Z8.H.u6m8DpboI/AdD4Hhn9i3/B0RHFmIQxCe	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:26.839581+02	2023-06-14 09:49:46.68219+02	0032400001G82uJAAR
bad8434d-9519-41ea-a41e-e1089cefaa9b	Basha Baji	$2b$10$6pyyqNBQL4p4HpTpPgp6f.P/ail3pycVwdoYBKnzMkerbUvd/r2hm	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:27.238171+02	2023-06-14 09:49:46.713592+02	0032400001KZCUGAA5
f0b8d3ff-78c1-4167-9e49-eed6becc621e	Kassahun Muluneh	$2b$10$XzgYcdfZCZpcvjLEpzJ9LeTwgSnhSluLPBwdk/VVDWVdAG1cdBihW	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:27.480961+02	2023-06-14 09:49:46.820901+02	0032400001KZCUKAA5
8ccbc662-730d-4a1a-8987-214b56f633f3	Florence Wambui	$2b$10$jDLOiJqgLshCTCQYbuUiFO2eqkG6Qy95/zR5tJS5jwRVg29LxUKZ6	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:29.914855+02	2023-06-14 09:49:47.169041+02	0032400001LOnRMAA1
fd6d8598-a6ac-4413-8bb6-d2b3daa78b9e	Grace Mueni	$2b$10$57XfkcE7p5Aa4CvhSRPmsuC6aOxGum3sa21smiAPOkcR0AhhxI3ha	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:30.027142+02	2023-06-14 09:49:47.179941+02	0032400001LOnRNAA1
e84ad022-d59f-421c-a189-69aa114fba2a	Joseph Mathenge	$2b$10$c4vTA9d5wQhCZGPEEGIMf.Z9ea.dKBlRwLoTUU5gHKQCrWTaYfIYu	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:30.145919+02	2023-06-14 09:49:47.197908+02	0032400001LOnROAA1
99462afd-b2c4-41d1-aadd-ed6cf429533d	Getinet Gereye	$2b$10$whPwLRdELcr3ircMmb/Cu.yT/TCK3yfQnVxn3nHdOr/0rZdh3gWKW	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:31.765095+02	2023-06-14 09:49:47.595778+02	0032400001OHpWLAA1
643fd19f-900f-4323-8294-8ff9e9d0c339	Terafe Demsie	$2b$10$rtaLwSdR6Jal3iJSJV8L/O3JI4Zl8PKKm7NB473dHXk.NtDzc9h36	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:31.982633+02	2023-06-14 09:49:47.615664+02	0032400001OHpWNAA1
0b930f7a-eff3-47be-b4b7-7a65622e9251	Etalem Ayalew	$2b$10$xXm5TXaKLiKNGBZvMCuW2uIFRTGAmpayvX9HVxQZ6hymYBRP6gK/u	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:32.421427+02	2023-06-14 09:49:47.695049+02	0032400001OHpWUAA1
91fcef0f-febc-42ec-b1b9-883ebe5e892e	Ehetenesh Abate	$2b$10$WmWyK7oIaGtfv0Cjr7ISe.CVeQC.ei7kO.JhWBOaHPw/1x9ORuhba	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:32.518541+02	2023-06-14 09:49:47.713548+02	0032400001OHpWVAA1
4ccce81c-f291-48d0-a171-c7b9657e84be	Kiconco Prima	$2b$10$pY4IXZAt1S1TW.Ofuwu.Le2Fms2r37zVOd4BUEWCZWhoy9rVm67V6	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:32.57384+02	2023-06-14 09:49:47.726949+02	0037S000002nRb4QAE
35a15292-28f1-495e-92db-bdb325ebcf31	Julius Lakaraber	$2b$10$UrC16sIQY1WuZ1r.INtHEuntzi2BE8L7EhsWfpoDxrl4wBDb35iFm	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:32.624625+02	2023-06-14 09:49:47.732412+02	0037S000002nRcWQAU
8abbe8cf-1e43-4935-814f-d695dbdd96aa	Zinat Diga	$2b$10$cQOLZe9L90Q8Wao7WPSkRutsUVJAkrwSDoK5g8DMuYFX4I0giiX3.	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:32.94226+02	2023-06-14 09:49:47.784825+02	0037S000003MlQAQA0
c27831bf-e227-4331-8e44-4bd5c5a5f822	Hafiz Nasir	$2b$10$w1vGU1Kll4XFqHxsjPTVxOV.2Nc3k5XjdLtmK/4roFJnt8SI0I9l2	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:33.295073+02	2023-06-14 09:49:48.000168+02	0037S000003MlQFQA0
36616545-8327-4e8b-9399-e4f299119aee	Hafiz Abdulkadir	$2b$10$vazlMgNk7GKXpO94dZi92OKCCZ6gdPDcjNxGSpy9w9QWRKUW8qXEO	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:33.74783+02	2023-06-14 09:49:48.138022+02	0037S000003MlQIQA0
f69995ee-1a55-4289-b616-a408e6da4a02	Idaya Shemsu	$2b$10$ZT.gIHZRytcVIjo4cnkpQe/HBRY6PeXiuFdWjv9WLMYhO.Zoezu2C	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:34.283138+02	2023-06-14 09:49:48.247939+02	0037S000003MlQMQA0
8851f8af-0dc4-4695-9b0d-106db2925420	Yosef Kasa	$2b$10$t3MyIGUKPwn23OUDEH4BYe.xeGlqVwSQwqn96vQaJfwT.QYZDddfu	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:36.665041+02	2023-06-14 09:49:48.495232+02	0037S000003NxctQAC
4e58b25c-5740-4828-a35a-d5081cb9e8cb	Fitsum Yohannis	$2b$10$7u7srL357CEJEwQeqy3SYO3a2gbPvNQjPOZh1nealyhW0KpjF22ZK	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:36.978493+02	2023-06-14 09:49:48.538679+02	0037S000003NxcxQAC
723f5f74-60e3-4eb6-9957-17876a30aee2	Million Tesfaye	$2b$10$irTTe9jzIOAVzROQlzcWWuCyh3rqgpnJAclIhAkTtsVltJYiuY1My	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:37.566198+02	2023-06-14 09:49:48.624926+02	0037S000003Nxd6QAC
147f1251-8f9b-4ca6-bc6e-e5ac211590a8	Adisu Dadawa	$2b$10$LsFk7bU/zlL5ikl3.RxPze.p.q/.6Lb4uw72XqpFGgGL8715Ok5b6	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:37.614991+02	2023-06-14 09:49:48.636836+02	0037S000003Nxd7QAC
1823aa0e-e2cc-4c72-93ba-5d6ce1656bca	Hayimanot Buchacha	$2b$10$ZSzmQMLroESM.465abHHfOwqjmFM/bJKUmpyROx0XZfpP/Gxx1F2y	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:37.667559+02	2023-06-14 09:49:48.641674+02	0037S000003Nxd8QAC
3fd4f937-4231-4aa9-8a9b-c65e86b84adb	Abebe Mutuka	$2b$10$S7Ld1N86I71482s33TpaZ.0C.E3oB5ICXxqFYXtvz1I3w0TNtEz/m	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:37.832974+02	2023-06-14 09:49:48.645664+02	0037S000003Nxd9QAC
d4572861-27bb-48f1-9e4d-a31c2ef27b9c	Wuke Biramo	$2b$10$Z1pFutRDXKsXNPwp.ojT0OwbbOarc7M6DjkBqLBzCmheR4RhXtC/C	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:38.225231+02	2023-06-14 09:49:48.685517+02	0037S000003NxdFQAS
b52e0639-8ecb-4b74-bb44-bd1720cdd939	Netsanet Yaikob	$2b$10$g.jztzg9.z58.9JC3zrQm.qju8zhaHUmeHaTdawU.05v1mwVqilj.	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:38.338059+02	2023-06-14 09:49:48.704722+02	0037S000003NxdGQAS
78bf178e-8bc7-48d2-85f3-2116216dc4bf	Janno Van Der Laan	$2b$10$AD/KiBUZlGZbaOoAbqnCD.W3FSk0OxZC.GAmlouUVVLiS.xV.8b2u	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:38.464136+02	2023-06-14 09:49:48.710722+02	0037S000003Oy3EQAS
524f72a0-6307-4089-96ca-022857c3875a	Asmalu Abate	$2b$10$rIAowlwEeolXblDqm0V9f.WbW62pWZkqG97QV1QObv6xFd8Y.QzOG	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:38.515761+02	2023-06-14 09:49:48.723893+02	0037S000003Oy3FQAS
2a0637e2-41ac-42aa-967d-d9015030f0bf	Tuke Boneya	$2b$10$CqGsEL4iZDwRgCFDvTPwHO02q/nm9HCaFVaRfAaIKw9CHl2toy2TO	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:25.159937+02	2023-06-14 09:49:45.858039+02	00324000015BBO7AAO
3ed0ea57-39ae-447e-98fa-be07dc20b226	Yohanis Hordofa	$2b$10$ug1yP3Hu0yyL0rh3G0/Kuug0aVQMsE3kgR6L88pj6naZS2cxUnWNG	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:25.177514+02	2023-06-14 09:49:45.893952+02	00324000015BBOCAA4
228b0ebe-f66d-4181-943e-5b52f6610050	Uzefi Nasir	$2b$10$SNVnLqdOS6uZ6PcU7BOTKuT9YdkElFIBt799z6Q49CUdNMkBB84.O	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:34.625119+02	2023-06-14 09:49:48.312811+02	0037S000003MlQQQA0
1aa79c55-f633-48d8-b27c-96e1c469d0c6	Yvette Mukanyandwi	$2b$10$giVcmSBzqEP2/qR9lt42sufpjSXAc7gGOqNsiTX8ic8r9Xk1PuSCy	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:25.685972+02	2023-06-14 09:49:45.976538+02	0032400001G82tpAAB
dd2f6901-b043-4222-93aa-f2a2debfcb26	Rosette Mukabayire	$2b$10$YA0f5AUMpxm7QXzkXC6aXOSn1Sz86ZW9yrMoriN/Nt1VPdHu0o51e	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:26.104116+02	2023-06-14 09:49:46.028172+02	0032400001G82tsAAB
c7270b89-0128-447b-96ca-95bdf7465f6d	Valens Mukeshimana	$2b$10$BA0qtj6ZQLieKMlczLbVkOXaFQbUpJhlvebZjsqfV/UnN0U4hby8O	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:26.13767+02	2023-06-14 09:49:46.076619+02	0032400001G82tyAAB
511955a9-405d-4e64-bdfc-d016c00365b9	Pascal Musabyimana	$2b$10$cxh4Wde5hxkaKApPImibmePNBkUlCeZiesJ4blejlzCdR8blO8qgO	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:26.30882+02	2023-06-14 09:49:46.109105+02	0032400001G82u2AAB
e43ebe26-cec4-46ea-926c-ee11b20a69ea	Esperence Nyirimana	$2b$10$9K959canywV7G63bIyTLnOW/TfV2WPseKianF/Q3tn/v7LGy0xoYi	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:26.598613+02	2023-06-14 09:49:46.172128+02	0032400001G82u9AAB
8d915d6b-a660-43ca-b030-b054f7492f07	Gilbert Habiyaremye	$2b$10$34pq3h4g7JeeKhxKlVu7vufy.7UIT2quXSwhWR5OPB/FKOsrFQ4uO	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:26.65903+02	2023-06-14 09:49:46.310346+02	0032400001G82uEAAR
5fdfb7e2-af9f-4718-880b-7e252f450133	Jean Rukundo	$2b$10$53nq6Pt1iKElSeFSYaxpMOft4qI9995aRX/NPi1HJg93dWlwdGPse	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:26.776992+02	2023-06-14 09:49:46.590721+02	0032400001G82uIAAR
50545831-f062-43bf-b91f-ea6086936a32	Girma Keneni	$2b$10$6v5iM28hmL5jFHTuLR7XN.wM7Awrg7QT6rp7.rIYuGs5iCG9OQ8dC	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:27.283299+02	2023-06-14 09:49:46.789277+02	0032400001KZCUIAA5
ced43ba9-06d1-4a38-899d-7935ee4011e9	Hawi Mohammed *inactive*	$2b$10$I9ij09fnpx8i1z2OTufFPeR3Eg3AhGSoBGBlSv6eMnKWGYJEP0cwi	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:27.435227+02	2023-06-14 09:49:46.804213+02	0032400001KZCUJAA5
c18aa49c-aa26-4788-8f21-9239bf4cea4d	Kebede Eshetu	$2b$10$aqaOGrz9z8YlXjA.WVay.ewfwgc2FBZ4.4SH.O7LTRxJKv1QvdRbS	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:27.525459+02	2023-06-14 09:49:46.828717+02	0032400001KZCULAA5
dc5db888-c796-4823-8f2e-87223407862b	Teshale Dima *inactive*	$2b$10$47didzbA9ywIRt0HZfVKfePbKKuY32u3CT9BzphQ6Dx5GDulo1.ZK	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:27.873623+02	2023-06-14 09:49:46.871948+02	0032400001KZCUQAA5
1672b6e3-d354-4309-a2fd-3eaf17906584	Girma Itana	$2b$10$CQ8cGt5M84PLd83xyEa2g.BfQLhRoqHnPGWxZeRTFePmRyxi8V4cO	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:28.028171+02	2023-06-14 09:49:46.883807+02	0032400001KZCURAA5
45815b5e-fff7-4d67-89dd-1eea191899f0	Yetimgeta Temesgen *inactive*	$2b$10$pmct6bmKx5uwsP71HVzLce2YvKLJxdG4kWNqhKaxWN3ljHLJOHPd.	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:29.029171+02	2023-06-14 09:49:47.038478+02	0032400001KZCUeAAP
525a194c-5b90-4048-9f1d-90435df7d74c	Yonas Zerihun	$2b$10$yxu3jKKSXc2IQVV/bvmM7umkf48.n847BPxhIpoEWePthR4/Gd4Ki	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:29.08182+02	2023-06-14 09:49:47.047349+02	0032400001KZCUfAAP
9437d0ce-b27b-44b8-a35b-01fda936241b	Babur Damte	$2b$10$.QeEKVxAEqZRCVMhQulNIuicS4GEe0hhVdnmDx.DtYVIT02ELyYWS	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:29.132317+02	2023-06-14 09:49:47.053703+02	0032400001KZCUgAAP
7dc3e3f1-e6f8-4741-9978-3b0130c94324	Esayas Kero	$2b$10$cA8cbK4Uxr6xJ3Cd31ftt.dY3desDoISoofDVio1q9hAmxLNs5xMG	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:29.291107+02	2023-06-14 09:49:47.063226+02	0032400001KZCUhAAP
d6dc4cce-b10b-4793-8588-9d07c77d1738	Etenesh Terefe *inactive*	$2b$10$LDFuck2HhakRhWtOeEVygOjEusDGhvl.JEYq98Po4gfIsmeIN0Ca2	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:29.385233+02	2023-06-14 09:49:47.072801+02	0032400001KZCUiAAP
ff736da6-5a54-491f-927a-4ec856685ee9	Tseganesh Emiru	$2b$10$jaFTDo5bIg0/RaKEf3XrneG3m9op8Io9fodKQme6YJC8lzs68WX7O	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:29.426172+02	2023-06-14 09:49:47.087948+02	0032400001KZCUjAAP
c42e6020-4b0f-4824-8268-e95bde796816	Evans Irungu	$2b$10$9EuPIUT5aiwYEkKiakdBU.josNvFQr25fs3OvKrO3d13ErW9eGqPW	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:29.862752+02	2023-06-14 09:49:47.154618+02	0032400001LOnRLAA1
ec089be1-00ad-46a0-ba99-65bdbd682e69	Catherine Njeri	$2b$10$AHmj.5ZN2b5PdzmXsISPsOOoY16aTqBInPxyi6YQlBfVjjVO46Une	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:30.505068+02	2023-06-14 09:49:47.269132+02	0032400001LOnRTAA1
ae3adee2-10a1-4cc5-b7b9-c8494925f259	Morine Gathoni	$2b$10$1J5WGFWDN/lAvNnWNb4CQ.EunQEkDSg1e9zIupYY3h4YXNvuSCYz2	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:30.854216+02	2023-06-14 09:49:47.352344+02	0032400001LOnRXAA1
21243474-e848-420d-8259-9b174684f3be	Maureen Nzambi	$2b$10$5QjElWc3c.HphHsKnqR82.1bexECoGlUKqXGH6xOzFfGGeKtw4b3y	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:30.979944+02	2023-06-14 09:49:47.380617+02	0032400001LOnRZAA1
4885b864-cfad-4b78-a409-54c6778c8a41	David Lauren	$2b$10$zvRge1UZlK5ATxUK1KiGo.IXaWtju.8FaoU4IY1dN/RvTd3iTmfr.	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:31.341838+02	2023-06-14 09:49:47.429269+02	0032400001LOnRbAAL
0fe15cad-c374-4da2-b475-83d8824b3c02	Edwin Elphaz	$2b$10$zIoglAtckTLKr8srj9RRou0xA7yh4YhzycW4wUE.GYSwEiO.j1Zda	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:31.164443+02	2023-06-14 09:49:47.449095+02	0032400001LOnRcAAL
d7e87f99-b481-4fe2-8c87-c3f2b5b307b1	Abraham Merinyang	$2b$10$R0C2F1qL5XZfrLbsOEoSPO0meycvu9jRnAl5455jyyUCInOW0rlOm	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:31.435514+02	2023-06-14 09:49:47.460223+02	0032400001LOnRdAAL
f43c0a78-1ec0-4555-ba2d-d349d4fc0f9f	TBD TBD	$2b$10$f0sLypGBvBn48WtliBVmaOHtUqCHL8WpZx0/Xg0fBojHOJVVkF0sG	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:31.645242+02	2023-06-14 09:49:47.469275+02	0032400001LOnTzAAL
ac0f0bc8-20e3-4ba2-a5b6-a16d5a1cc934	Nebila Yasin	$2b$10$cbs.aBXBXcEGhnkz4AuZUOAMejpJfdSx4rr3s20uIjV708LQlDHI6	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:32.987747+02	2023-06-14 09:49:47.767907+02	0037S000003MlE9QAK
b7223ba7-7abd-4831-be56-5c49fa8378eb	Shemsedin Ahimed	$2b$10$LGhjPKB4wVGPw0vYnPzF9.L2YjdaSxm3KO1atX6xIazXZNEPJreyW	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:33.161865+02	2023-06-14 09:49:47.829151+02	0037S000003MlQCQA0
521d5718-ef75-4e96-8cf2-89b8b75729a8	Asnima Junedi	$2b$10$gdkf8eqnGn/iB.YDv/1m8ugHUtuCHNRh6WVDylZ/0amdpcTIxuOc2	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:33.260624+02	2023-06-14 09:49:47.845867+02	0037S000003MlQDQA0
8e8663a7-1d74-411b-a551-a7856679d0d4	Mohamed Jihad	$2b$10$uNx.3DpuXVChxV7AQW/9FuAt1dYNLZoRu6hj74SUpyv339MEF8vHO	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:33.823789+02	2023-06-14 09:49:48.122513+02	0037S000003MlQHQA0
a565974b-d574-46fe-80e7-25947d559dd0	Rihana Siraj	$2b$10$hvN.5BxKeN5uJpkxtSR9guGCcj/PKAWjBcym/veUSBMCa1jVM4sIK	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:34.233898+02	2023-06-14 09:49:48.277505+02	0037S000003MlQNQA0
d1aadd4f-637b-4df1-aaaa-315e4aa433b1	Lijayehu Beriso	$2b$10$aA4wBHHoHr8AOfV1nRF12uL/L/Ht/2N3G/hD/xHU5fVOMqNIG80s.	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:39.974105+02	2023-06-14 09:49:48.88483+02	0037S000003Oyr9QAC
385e8640-793b-4947-8de3-681d1650d61c	Mebiratu Kefiyalew	$2b$10$gdXKX6K6xp.vushVwGLC3O0s7iuTxhq2/Zo3BnzklS.dYelnwAloC	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:40.071659+02	2023-06-14 09:49:48.8893+02	0037S000003OyrAQAS
d98a7492-b03e-4d60-b972-5e1289768aab	Meseret Ayano	$2b$10$LTn.SxVVW44FIzxZhHDvnO1fjYLob4.TRzmNgt6PnrZh.ALsOEL7G	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:40.1897+02	2023-06-14 09:49:48.893778+02	0037S000003OyrBQAS
9acfe397-d09b-4fd2-b341-e19005d76501	Misigana Tsegaye	$2b$10$/X1ttYSSgrXIAiSFS2EcKOxuUiOoeEZJGrNB61CN2JPfgj49/dSEK	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:40.25903+02	2023-06-14 09:49:48.903322+02	0037S000003OyrCQAS
9fb4df19-3f47-4909-a5cc-51e972a44905	Mesikerem Girima	$2b$10$fUsNgBc6ZumSqnu4uCKmquuBwhRkpHktN0sj0ymEhdT3SGL/sFtHe	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:40.610473+02	2023-06-14 09:49:48.986552+02	0037S000003OyrHQAS
3adf97fd-41cc-47f3-8819-07e269a71d5a	Udesa Tadese	$2b$10$w6gA72Om.DDuGFKeE/GyG.flptpPu0dO9nv5.CTFEVEQLV3yojYr6	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:40.974754+02	2023-06-14 09:49:49.025091+02	0037S000003OyrMQAS
a8d283f9-9a82-4717-afdb-4dd82b267341	Udessa Muda	$2b$10$7tdXC5nVsfCTiFarODa.munQuQagwmgzTh8zY5s/h8TW3A16UUrrS	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:25.163736+02	2023-06-14 09:49:45.862+02	00324000015BBO8AAO
1a31ed7a-2b97-4d30-9c5a-90ce712831fd	BWC Advisor	$2b$10$JE8FqBJGFSCg3Vsie.jvN.ayCIMOBpOCQQR58KHicbvlIEwifrgy6	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:25.244477+02	2023-06-14 09:49:45.903702+02	00324000019raIpAAI
5799e7ba-1c8a-4a58-8f64-e681e96b4a09	Fuad Jemal	$2b$10$w7IFhuIZTPfEjeeTbEbppOjQrux8BmhCZ95xPLl3s3OSjr7aXCKPm	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:32.900319+02	2023-06-14 09:49:47.806785+02	0037S000003MlQBQA0
881df2f5-8c58-40c4-84b9-1f6452f70f5b	Zinet Usman	$2b$10$NSIsLXmpkEapW29HHstX3e6u15TMbL/V93JFiUg936ahj/223VdRK	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:33.355482+02	2023-06-14 09:49:47.92436+02	0037S000003MlQEQA0
4b1ea749-b077-4e85-a740-3abbcb06046c	Mubashira Jabu	$2b$10$X1uvgYaL3VvnFDC9l5.Bf.iBTgAMiyI9qoooQwJLCbelgALAo1lQe	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:33.667619+02	2023-06-14 09:49:48.0484+02	0037S000003MlQGQA0
33a76e75-ace0-4345-a59a-7299e684b6cb	Dula Afework	$2b$10$uJdqKH3wtTtiG.waHy.1su7npIEIYlOorGwD.yvTZyXkiAQLcwENm	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:15.989589+02	2023-06-14 09:49:50.826865+02	0039J000002UtLyQAK
372a875d-adb2-4c6d-9f4f-1ab2c67c6416	Terefe Alemayehu	$2b$10$NaVkkdV9Tm82PouICbCqsuX4NEGKi.PsJrkghgDyQXiZvB4/oLN.e	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:16.041073+02	2023-06-14 09:49:50.859604+02	0039J000002UtzNQAS
001b699e-56d9-473a-b33d-d161dacd09b7	Shibiru Dawit	$2b$10$lhmpBMAOQgEzaHbJJGuwFuYB2Yo2hTjWTxebShvlbA9uBpUpzQI8i	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:16.094524+02	2023-06-14 09:49:50.898193+02	0039J000002UtzRQAS
ae3b75f6-617c-4590-b146-b44d16aa09bb	Kebir Kedir	$2b$10$1tMIqr0MLATjgOTGukqTiuRENgozvP9FMkWzLF/LosBLzifavcKkK	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:01.106861+02	2023-06-14 09:49:41.154222+02	0031o00001i7jlFAAQ
d04c0560-fd3d-4d9c-b8f0-b41729dd6612	Asrat Shunana	$2b$10$LwiDvyzPWrVO5vyXbCPfC.hf8UVMqHrW/cAMWN3hw8tH5J8ClXnnm	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:12.756273+02	2023-06-14 09:49:43.422936+02	0031o00001uxDbSAAU
532aeee8-41e3-4f83-9d82-faa51cdbd296	Tilaye Gemede	$2b$10$ZQmFn.8h257mBLL4fmHm2Ookd.S69t1UdEguj5KC2uLlEIUk.fWYm	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:24.908361+02	2023-06-14 09:49:45.826973+02	00324000015BBO4AAO
5790250d-8779-4c40-88ae-64f51e556c48	Girma Itana (Mother Parkers)	$2b$10$IJUxbo9GVCsedANdyMSOzedRdgvCVhbGhGRP1Q5vXERsMCEw2x.Iq	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:28.424451+02	2023-06-14 09:49:46.953982+02	0032400001KZCUXAA5
bb2a33ba-e5be-4ad8-9856-b93f1b684a7b	Abeba Abebe	$2b$10$KDTXV6hPgOHKegluxb5dP.SUDYpJeqXv1RgNtnnhNw9I1NFQm.2XK	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:31.940922+02	2023-06-14 09:49:47.632335+02	0032400001OHpWOAA1
dea72afc-73ed-41b1-98e1-42f3c631c491	Mekdes Awoku	$2b$10$oYv.6OcMWhNGkP1szpzoy.HlY5R/V0DKD3hCc5G9Ccy2i2tniPXoC	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:50.98659+02	2023-06-14 09:49:49.996976+02	0039J000002TjvjQAC
860f05b0-b352-4b44-8f3f-e4872f948e5b	Girma Alemu	$2b$10$/fcSSU8WeyY8L4e9KrqQKuSW21lxiziJgHG9U5MA0cAxqMideGVCC	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:51.564095+02	2023-06-14 09:49:50.02111+02	0039J000002USarQAG
6dde2ed3-dad0-4571-93b7-bf1530685fc4	Debela Dufera	$2b$10$45Az0EwxTis/RPJkeMmlLe6FEYLYj/iLkcxkqj93SSRip09xaCVhu	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:51.469658+02	2023-06-14 09:49:50.035505+02	0039J000002USsxQAG
5521bd60-cbd8-43b0-a628-75f2b4b49a82	Muhibi Yayibo	$2b$10$AmWofZiikN5X9S9yZJoZeuFKjeoPhwaumGBbH5hSdFbIpg9xaj9Ei	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:15.731064+02	2023-06-14 09:49:50.136686+02	0039J000002UT2tQAG
b3f12855-8660-4d6e-b69a-2ca977da9a00	Ajaeba Tahir	$2b$10$AUIKB2/ZE7nAPcaA.HsnjeE0eEKweV/mvSTz9f4PvgTjv8Xu3oFni	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:15.797441+02	2023-06-14 09:49:50.432748+02	0039J000002UT2yQAG
cc921ee1-a3ff-42e4-8768-aa4536034d55	Kalid Husen	$2b$10$f7Ows.Mph0msfHeyr2fDpuiO5XDqHXA80je0eILMPkwlzBRKUMWUO	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:15.846427+02	2023-06-14 09:49:50.622111+02	0039J000002UT33QAG
ea9371ea-11d1-410a-b2ea-fceeb7f2a00d	Mubina Kasima	$2b$10$WwfvFeiv4yFgZbPaWGOd8erLQ43uFGUxVu2dxtuQVu81iajP/K.MG	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:15.88952+02	2023-06-14 09:49:50.675553+02	0039J000002UT37QAG
c2337618-110f-4b2e-9fd3-ef30444879e9	Geleta Dessalegn	$2b$10$4IyhQYpULQEt8CYcX1uHBORVPYI1DWe5yctPXwhb326fi1N9amFsa	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:23.660804+02	2023-06-14 09:49:45.610802+02	00324000015BBNfAAO
0dcc85dd-35d0-4574-9d4c-e92e38c0780a	Aberham HaileMariyam	$2b$10$BPPYF7ksqhStnOriXI9rT.T/lWluUuJU9OX6Df3fxICwJiEH2nWPm	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:32.019753+02	2023-06-14 09:49:47.647581+02	0032400001OHpWPAA1
2702632b-c179-4385-af6c-2bd40641f2a7	Yesuf Mohamed Ahmed	$2b$10$a/NxrQcoepTxOwGDazGjU.HbJUnELDZEbA43mpsZIldbdML8c6WRK	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:32.10055+02	2023-06-14 09:49:47.662552+02	0032400001OHpWQAA1
e7d06349-3631-4533-9299-ebcbce88f07c	Moges Tegege	$2b$10$qXEQ5WhvDnIvJDTiyCLw5u5opnvyb7vIO.WjEkAt5jlJwkktieXvC	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:32.223874+02	2023-06-14 09:49:47.675797+02	0032400001OHpWRAA1
46d8e473-dd07-46e0-b58b-05b6fd692394	Gizawnesh Endashaw	$2b$10$Ldf7FcCoD16JoOcuC/IGUejdJ.nSA10C5v1MAYyoSBB3CpkCsm8Bq	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:32.291979+02	2023-06-14 09:49:47.68039+02	0032400001OHpWSAA1
555a4d61-1c86-43c3-b527-37f3a66032bf	Etagegne Abate Tadesse	$2b$10$ipL5Z/WzYFgMJy5ZScQ1JOIX8KDRTDdsUUMp8yACtcAfYjuo824Ye	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:32.351302+02	2023-06-14 09:49:47.684954+02	0032400001OHpWTAA1
7f375f63-48f3-4fc4-b81e-a3638e79ac42	Gadisa Mekonen	$2b$10$/XPRdS/DeJatLLwmBv7Q6./TDaytn32azzrkn6ZIvkTaCQD1k6ly.	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:32.692299+02	2023-06-14 09:49:47.745928+02	0037S000003MlDLQA0
4acc8db9-bf3a-4e53-b063-cf6823106205	Tilahun Getachew	$2b$10$SqpqrWo3GVKTAO7Lf8elNeoO9fO4igElq57vXnY/Lzx41NNN9ilAG	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:32.788079+02	2023-06-14 09:49:47.761493+02	0037S000003MlDVQA0
dbb20e3a-7ea8-470c-917b-323f7d91b95a	Lencho Jihad	$2b$10$GW6UjQ8aIU0bHE.zfTSIl.N0hpg28pU7tpbL.RsvUljbyMFWMbeJm	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:15.939803+02	2023-06-14 09:49:50.789147+02	0039J000002UT3CQAW
8c213ed9-5ead-4532-9acf-5951d2ffb097	Adato Kechele	$2b$10$ZrZI75JtB8KqoAp5MrbPyOAwqVZ6kf8z400m4Gi8sLZjV1Eay3Xr.	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:38.000744+02	2023-06-14 09:49:48.669832+02	0037S000003NxdCQAS
2f9858ce-7138-430e-8708-9409d3004492	Hayimanot Melkamu	$2b$10$TaS1KXBTfyg/RdcpZVTofuXOv0pmihFBXGKaaFv7d4SfzOZjwtaxS	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:38.138746+02	2023-06-14 09:49:48.678986+02	0037S000003NxdEQAS
0e4b7dc0-fbd3-4735-b3aa-3be6fe4ab402	Mihret Tesfaye	$2b$10$uEkGAqA5opX6eOrNzqetWO72YCJj5W37F6RN.sdpm33Mky13FZhq.	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:38.573078+02	2023-06-14 09:49:48.728456+02	0037S000003Oy5tQAC
4cbaf71b-5722-47d7-947c-b4eb5335e759	Natnael Mulugeta	$2b$10$y704xvids0NM4HvFy4I2hu4ude/4neT9ArTb3Y9Qex75SsD3tvYpK	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:38.633852+02	2023-06-14 09:49:48.744314+02	0037S000003OyLNQA0
00c17c65-12e9-4788-a67b-69cdbde40dff	Marta Tegaye	$2b$10$11MlQs8yZG3XBG1bBaLVxeRFf6gt0Pj3xXoxytxMPbl4fbka9AhT6	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:38.777659+02	2023-06-14 09:49:48.759764+02	0037S000003OyLOQA0
296a6de2-ba4d-47e3-aac4-74e060941a65	Asnake Mengistu	$2b$10$IqWoIZqoAUvr3o6ionTOAOExlxfhQ1P.lZWFUeQILeZSYOYC1muzi	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:38.836735+02	2023-06-14 09:49:48.777146+02	0037S000003OyLQQA0
4355cfe5-09af-40e3-a191-24552014ebad	Asirat Shunana	$2b$10$UoVAU67ujIk90koK3t9zv.D0ieTmr921Yoa7us31q.67oFo4d1N82	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:39.191409+02	2023-06-14 09:49:48.811012+02	0037S000003OyLTQA0
0a6783c4-e7dc-41aa-9195-f709ddb8e0f5	Kabitamu Abireham	$2b$10$IiBhh2XgQ90MuVQsrXRpieNGjheizB2k/La0iWCvHth0PTc4HKVmG	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:39.255719+02	2023-06-14 09:49:48.82043+02	0037S000003OyLUQA0
2d8d6f71-451a-416d-9077-49ce48a9d25f	Yordanos Hailu	$2b$10$0kFEo8exWueGKod/n6brB.H/PMKWL/BgEPZqlvCEyclvVW6pCbMeS	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:39.308387+02	2023-06-14 09:49:48.825919+02	0037S000003OyLVQA0
48db9bfa-e533-4cea-a441-ca349a019ae6	Bruk Figa	$2b$10$xl9Bb2lBaWGNNtyXm26KoOkdNpAZP3e3foEgZAunLhyG.RsIJt0G.	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:39.515431+02	2023-06-14 09:49:48.836557+02	0037S000003Oyr3QAC
f8c80f99-66e6-4279-8225-ebde4fa2b9c4	Asinakech Hailu	$2b$10$IT1mUS2QfoZ9bFyiZsLbKeqqJ7POQCV1BGZwBdLC/XuBDq2eSrm.K	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:39.553339+02	2023-06-14 09:49:48.842413+02	0037S000003Oyr4QAC
0a61c4ff-8ca7-4605-8beb-de20d607e0e3	Desalegn Melese	$2b$10$Ynyazrkkd27DMagkEhmGs.Zs2nyhAwnQZJWOKsl9mJDaPNTkerDXS	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:39.92439+02	2023-06-14 09:49:48.871508+02	0037S000003Oyr7QAC
f13b7193-3036-4dad-a8fc-388e23513382	Mihretu Kebede	$2b$10$TfbJAoYUeQ5VhKfMOhuhouABqTEJwLCfGrx3uJZYY1VwaIght0xBC	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:40.264508+02	2023-06-14 09:49:48.91851+02	0037S000003OyrDQAS
e7457e9c-4e7b-4e41-a6bf-9692fc5211ab	Kasahun Tero	$2b$10$D0q6ksnCd38xW.L41NbjSOYy0CXZv8A2yVq2K.F5eZNDdR7vSUwgi	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:40.325178+02	2023-06-14 09:49:48.924495+02	0037S000003OyrEQAS
e52860ff-90bd-40f2-a5ce-0c8bd94e99ae	Shuna Dunika	$2b$10$yYYALYGKn59kRdG0OUrAI.h3lYnNCPTV1SV/Wnjsg2Yb46lRkHvte	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:40.556477+02	2023-06-14 09:49:48.934202+02	0037S000003OyrFQAS
85198e4c-6dd0-4de5-a286-2d2cca2e7287	Misigana Girima	$2b$10$1IaNLrGvTKvAY/VfjqCnoec9gZ5kNgzCl2MIy7bj.lFhctqeRNNi.	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:40.507068+02	2023-06-14 09:49:48.942584+02	0037S000003OyrGQAS
1b43c97f-46f3-4bcf-af7b-5f4e9a513d03	Habitamu Shebera	$2b$10$mD5aFLegehTDqAJc4OuLNOU9klFuO5Hn1zh22FBCLuVvNm3l.akRW	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:40.665206+02	2023-06-14 09:49:48.992168+02	0037S000003OyrIQAS
b3561657-a44d-4aca-9a66-9e2e00aadeee	Tariku Kiphetu	$2b$10$r6lIdx83QYBOV5lgaB8Yq.U/0y8e3.BG.2EieglQYoGR2Wg3/c/WW	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:40.760909+02	2023-06-14 09:49:49.002669+02	0037S000003OyrJQAS
552b2464-8b06-4329-9fa7-323c2fc83131	Zedagim Shiferaw	$2b$10$BNUUc72UK3m/H2Crm88Kl.EfyKA06PBE6E9JDq2.EN12tqsyfygL.	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:40.849323+02	2023-06-14 09:49:49.008279+02	0037S000003OyrKQAS
fc6e797b-c2e6-4dca-8059-d325338ced80	Asiter Mamo	$2b$10$kvWbPRnuJUbAq/Q09dPrQOfYV8qVMkRPQwtyDep1jXh.glyL5a16q	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:40.906321+02	2023-06-14 09:49:49.019594+02	0037S000003OyrLQAS
c177ad9f-7c32-47eb-a458-604ac0bed9db	Samuel Tilahun	$2b$10$FsGfupkYEZAOY1dhhAiG3ODSiDKyzbTOVaIs4r0LBEmeIdj0WBgXu	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:41.113048+02	2023-06-14 09:49:49.035491+02	0037S000003OyrNQAS
5d56caf4-e80b-4c1c-b5b7-216f13f3452f	Zekiyos Yohanis	$2b$10$n8XOTJN18B/c0C9YCVpCt.qAGkz.KEraverQm/XEMIWrSdwCdvYhO	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:41.253141+02	2023-06-14 09:49:49.053196+02	0037S000003OyrPQAS
9aacf954-163d-4732-810e-a642eae979c6	Tesifanesh Mesifin	$2b$10$fNYQ.XA0oc7LPX9pWz4yb.llIWvOfSen39ubSF39pO/YIa/QJWKOi	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:41.479939+02	2023-06-14 09:49:49.086577+02	0037S000003OyrSQAS
14745168-2f24-4fca-94e3-e5e928041099	Brother Feyisa	$2b$10$6Do62d1pmeiU.GGxzq.bKOI1aYwP2gEmdf1nDINJywOV0nBemj3qu	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:41.587758+02	2023-06-14 09:49:49.091943+02	0037S000003OyrTQAS
c95faef5-8359-4961-a753-6c5d40a598bc	Eyerusalem Gedo	$2b$10$3nCwQ3C0D7XREn6EGIOKguvih1SVtsryXiefO3e6f1XF8xgid.JUO	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:41.617256+02	2023-06-14 09:49:49.099172+02	0037S000003OyrUQAS
e5f9f052-f749-4adc-a3e9-1ff4134350c5	Habtamu Mulate	$2b$10$v80PV5MPgNq1j104.kvVc.n.rYGedy1lMIGeqL4/0FqgOdA3cl3LS	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:41.752417+02	2023-06-14 09:49:49.103537+02	0037S000003OyrVQAS
cc9bc43a-0b8e-4a2b-805f-8b6661cdca80	Hirut Tilhune 	$2b$10$H7Y0UzoO4RsiLar2llGje.k788Xt4v.atrQy4jv.pctie.vrMjjhK	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:51.084637+02	2023-06-14 09:49:49.981674+02	0039J000002TjunQAC
a40dd67e-68d5-49d0-b600-e1e9e8d9d25e	Gobezu Goa	$2b$10$gOJ7623OoSY.FcB5un4QYuc3sH9VzpYg1HknOmkUsobtGREmKIiFq	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:51.175425+02	2023-06-14 09:49:50.00195+02	0039J000002TjvkQAC
eb52c75d-a522-498b-952d-39319f27b91f	Kubsa Dekebo	$2b$10$iA./D9189RG3vkjnda54keRApAHkoC8Ls5JD30RjAodd.o7Joscve	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:51.362166+02	2023-06-14 09:49:50.013512+02	0039J000002USXEQA4
c7b2adcc-26c2-4857-adb8-06e7193c42f9	Abdulkerim Kedir	$2b$10$aFTuhhWvwg3ZKr8nIg539uTXGnYGiYITqiQVr.Ju4bAX7eTCq6s/S	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:51.620105+02	2023-06-14 09:49:50.062031+02	0039J000002UT2nQAG
3be2bc01-93d0-4402-adbf-86a63785d98a	Afiza Mamadamin	$2b$10$ZjmDcQTpuEXqVsb1fhGWm.LOkDxhed5QRaUbhAxyIlrppCjcMAAjG	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:51.761986+02	2023-06-14 09:49:50.06945+02	0039J000002UT2oQAG
97d5d027-0047-4f79-b181-ea78a26c28e1	Ayidar Abatamam	$2b$10$tKFueh7EP7uqJQjeLj4aV.tBpeL51j8s0oxbKiRFmq1p0uA5U/3n6	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:51.752367+02	2023-06-14 09:49:50.082644+02	0039J000002UT2pQAG
b0571b65-8f6c-4693-8acc-87a22a33340d	Maruwa Hawi	$2b$10$eGJbyp6vmDkKrFRWkYX3VOg0pwNQnmtErsOurjUxfGH8Xywecmcxi	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:15.72403+02	2023-06-14 09:49:50.129123+02	0039J000002UT2sQAG
86b48856-8059-40f9-9223-e040a02988c8	Mesret Mengstu	$2b$10$WSu.5Fknqu27C7tLGKzGW.VVyTKALvsU9Bswhy80RbhABgJSWsak.	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:15.190651+02	2023-06-14 09:49:43.971031+02	0031o00001uxDe7AAE
e4c17f9e-0fa2-43f2-8238-0ad745a2e885	Adnan Temam	$2b$10$dK9RqZ0iwRBUkJvvFDIJd.uVV4QeLHNjK3flHYJZIyzuVmKdFiFTO	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:21.144581+02	2023-06-14 09:49:45.327165+02	00324000015BBNAAA4
b6bb69c7-8fee-47c3-8914-de24d5dfb65b	Tesfaye Milikias	$2b$10$ZPLLuCiyRJqHtqGTxFbUU.1KO25vPmqlrm7lUgKyLzWjsBRZdi1dC	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:25.040551+02	2023-06-14 09:49:45.822193+02	00324000015BBO3AAO
122ea99b-9a3f-4742-9125-321ebee222c6	Kidist Belayineh	$2b$10$eq61y9dtHmY3G25xQyto.u.oKVMSwbWW190xYYoRL9lKlwa7/x39K	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:37.931083+02	2023-06-14 09:49:48.661545+02	0037S000003NxdBQAS
57358d4d-c3ab-44c8-895d-43711ee13b12	Meskerem Demise	$2b$10$mw10Gv.YQ01g8fCfin3mWezZsf7n81eq8RhWxjk3PsgRxUcfD2SwK	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:41.319704+02	2023-06-14 09:49:49.056558+02	0037S000003OyrQQAS
a447d66c-d49b-43dc-a476-66e736f47bff	Aixaliz Jordan	$2b$10$XEhjT1jf/hxfEpJRMf1IoOko9ZCzNqS7.5mIF6EHGO8MjvXzOIbdC	\N	7873818347	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:12.712109+02	2023-06-14 09:49:43.408677+02	0031o00001uwX1HAAU
797aa84d-5267-4622-bc14-8ddfc451a531	Adisu Shume	$2b$10$uhR63/tEXxlW1xe1hmWoCeyENFPlUpbksWbMeHD/uO9XW6EHQWij2	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:39.185526+02	2023-06-14 09:49:48.806674+02	0037S000003OyLSQA0
7eec4800-0745-49bb-bb67-b4019e372f23	Mamush Tamirat	$2b$10$sTJoTA7AXaSwKqq856rBfOpoJ.r0nw.nGpnODjFTi0dKmO/DENAAW	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:39.58128+02	2023-06-14 09:49:48.853553+02	0037S000003Oyr5QAC
99dc6152-3d10-45c2-b668-2e6db65f59b1	Getahun Gemechu	$2b$10$CtRGxXnT.Qi180HFItXscuamUOn9TdgTTw76QOdIgj4S5lfRSXSVu	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:39.62944+02	2023-06-14 09:49:48.857171+02	0037S000003Oyr6QAC
4734462c-3790-460c-9b33-197efdd802b1	Yeshiwareg Shetera	$2b$10$uwGyfwVrLVJAZ3TN/2t9FeDfhRbO6a/BuZAZqLGbRprBfKT96UqgS	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:39.860132+02	2023-06-14 09:49:48.875609+02	0037S000003Oyr8QAC
31260ddc-c404-4a9b-b8c0-3a37e3b96392	Mihret Eriba	$2b$10$UxicbwPZFa8fIOlc83F7rOCy2ZfyTgOnNBL73xPl8dsTWali8otoa	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:41.871564+02	2023-06-14 09:49:49.123027+02	0037S000003OyrXQAS
48c5c204-c484-4d3a-8bf5-dc4661aaa6fe	Kebede Gedecho	$2b$10$vqnxatqpaw.nyRHT5naOZu0pIx0XXskTCvIzvfoWcqukoydpMF/A6	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:42.240595+02	2023-06-14 09:49:49.158807+02	0037S000003OyrbQAC
5d69836a-4645-4a67-80da-fe018498a539	Tekalign Hordiofa	$2b$10$BWw8RkKfqF/NT5kDCLLJ7Ok3x7kNGQH4rZ67W5IUY45GTtWnYX4Ui	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:43.338652+02	2023-06-14 09:49:49.225578+02	0037S000003OyrkQAC
4c07d668-e968-4e11-a805-9809c41bc0fb	Misirak Abera	$2b$10$3VNtqtlWxi9NXHhCna025eDqtMgcg7yIeF7HmXrvnEQ..RTrCUqim	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:43.389917+02	2023-06-14 09:49:49.238524+02	0037S000003OyrlQAC
6753ba18-2b87-4a5b-9f94-2f6e7f377215	Ashagire Ayele	$2b$10$w9pv6WlXqDLOh0jnuDeR5eXxeXKBbbunLZQUO1mTzLp8WRtwxpSga	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:43.499936+02	2023-06-14 09:49:49.242238+02	0037S000003OyrmQAC
d1428751-745d-4a4a-80e8-2cbad6793550	Adane Beyene	$2b$10$ZauMRQGYrORtKVBpbi4b..USncRM7wl.EVi1dbMKI1iVjfHeg2dVe	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:43.694601+02	2023-06-14 09:49:49.253223+02	0037S000003OyrnQAC
644d7c7b-764c-4fc6-a68f-6fb00dcb2535	Messay Yonase	$2b$10$vt54m5tP1eJF9dMu6eKF8OX/1E0eoeUyNZsCyDShIbzVESkzOKjo2	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:43.877678+02	2023-06-14 09:49:49.268215+02	0037S000003OyrpQAC
1e8a644c-4ffd-459e-ab42-5703a1032cfa	Gizachew Ali	$2b$10$rblbBrwUTGg.IY2UqX1HpeP3pa4taU38DP.iwlWHbJ0F6MPx9rwRy	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:44.048405+02	2023-06-14 09:49:49.272728+02	0037S000003OyrqQAC
d9226a15-d342-42f9-b041-f1c09f38fcf2	Zetseat Gumi	$2b$10$v0hfANhxqW61vyAER8tMjOO/VBLZfdlrAkR7uzBOhmP8QkX4OSLvC	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:44.134347+02	2023-06-14 09:49:49.281519+02	0037S000003OyrrQAC
5c40ed9c-0404-4c54-8d91-cbbb97a6284b	Husen Hasen	$2b$10$2kT0FyOCZoCbDjMRCeiaYeY5YLoNTCLjw6w2CmsCVo3lKfs7f9anu	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:44.67446+02	2023-06-14 09:49:49.313803+02	0037S000003OyrwQAC
65ad1661-bed8-4e0b-b092-309f424b98b2	Desalegn Tadesse	$2b$10$kFNbWn.qTpvCdzcsTdwor.H1cau5VcMZZYWBIWQpvGk1LFfRMOsWO	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:44.774557+02	2023-06-14 09:49:49.323835+02	0037S000003OyrxQAC
16d6921f-0563-446a-8456-909c3e8c4cf1	Yosef Tsegaye	$2b$10$tnm3Qv/m.Ona52ByFE.tOeGqzgHHj/wi1sDvsnYrjuWdAKCvr0ILi	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:44.943726+02	2023-06-14 09:49:49.33798+02	0037S000003OyryQAC
8e743c4a-5e77-465c-8f9c-a9825bffa069	Gezahegn Shiferew	$2b$10$sgTbs8mQrJwyqCur9W7C6uJX7JyvOdlrfxeZTAJjjwUlrHrH5kOui	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:45.100824+02	2023-06-14 09:49:49.371447+02	0037S000003Oys0QAC
2c820cf6-a60f-43f2-9356-6f7c328928f3	Zegeye Ageze	$2b$10$s6snqesqrT5/ePiqQmVjBe3UlmkaviUZ0IdjKyfTtpsviu8tmQp4.	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:45.265583+02	2023-06-14 09:49:49.381738+02	0037S000003Oys1QAC
6527052f-8ef1-4e9a-9743-449aa2f2f745	Markos Mokone	$2b$10$4aUzRYeg4i1v1CBaxaa2we84TwjR9H0fo2ZlR8Ik81kcxGW/ZQDzG	\N	966899810	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:45.350197+02	2023-06-14 09:49:49.396837+02	0037S000003PJ25QAG
509e3988-4636-4db5-ae49-bf4eec3aa60a	Daniel Mugereka	$2b$10$zy9qYbSPWC8hmZCg5Ix0NOJlYu2UyLQMz.A7KXsFcoAV8OiAsfIfS	\N	+256754573166	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:45.704493+02	2023-06-14 09:49:49.430548+02	0037S000004B6pQQAS
db0f463d-d8d2-4bd5-8f86-e9c13beca361	Dieudonne Fazili Nyenyezi	$2b$10$m/rtYSV0NjVCeVWn9DWwkeQqM3Fbic3IZaeXYl6.UWeLfKJPIyKCu	\N	994909712	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:46.176695+02	2023-06-14 09:49:49.457169+02	0039J000001jvOgQAI
f983f717-fe9e-4e40-a35a-08e0925d0b96	Yves Mugenga	$2b$10$kcvqxJbEyFcbVhWA3hHFGOKidja7eMv91HpPP0nksV4zoQAHfxtKK	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:48.990017+02	2023-06-14 09:49:49.705334+02	0039J000002CLV6QAO
4931bbef-8b0b-45bf-8551-a51a70a70ea0	Hamza Kalifa	$2b$10$ZJejQKutZ4tGTFVFKAFIT..a47QV6W1/Yl/500LL3.0NO6Lt3oJg2	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:15.708329+02	2023-06-14 09:49:50.117148+02	0039J000002UT2rQAG
b84e06e9-8274-48f4-ab93-2274ebed2081	Saidate Masheka Francine	$2b$10$b3jK6VShq0TlclfETbes9O7BrlFfHTmLJLpVQ.OCbeW1NpZAZL0iG	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:41.435076+02	2023-06-14 09:49:37.282617+02	00306000020tCJHAA2
cd47c21f-3405-4563-be4b-5d71e1d81f89	Timothy Murithi *inactive*	$2b$10$7IhmTLMMpCbe2sUj9wdfouhUkqWcEuX/Z2atD0vJHsx0easiCRXe6	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:38:48.572053+02	2023-06-14 09:49:38.483558+02	0031o00001VZd45AAD
ba9b4850-13c6-4efe-bd0f-44f1ac0e1034	Nabateregga Reginah Renah	$2b$10$EO.SAJHqjVU3FH9lGAvo.uSbOilq9y4cF8TBVpAoXZqs/3xj0s2/2	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:54.607561+02	2023-06-14 09:49:39.734085+02	0031o00001a0dVQAAY
1c7ead20-7b0d-40b3-94fe-34f67dc28a28	Amida Sheik Jibril	$2b$10$5OCtmAhRQMZmZzfFEIFAMe0u/kL/3R9MjD9puZMQJyyWkrV.sea2a	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:00.567894+02	2023-06-14 09:49:41.09133+02	0031o00001i7jl8AAA
bd3805b1-e970-4ff7-a27c-c5ce51e56434	Feidi Jemal	$2b$10$x70.dyEmDvfwlilvXKLb0ukYZE/4bBHoLu4hE4IbI/2ZPJZN3hOZG	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:00.951339+02	2023-06-14 09:49:41.124472+02	0031o00001i7jlDAAQ
52a9ae23-b4d5-40d8-b07d-242b9cf256f3	Meritzi Pagan	$2b$10$Ifymop/A8lDtnN2J1clse.iWmUlty6qmOf0V.rTvur8poaZP1lMBi	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:12.652833+02	2023-06-14 09:49:43.403958+02	0031o00001uwX0sAAE
be55c265-c5dc-4e63-9c3a-eecba3ad0fbf	Tenaye Waji	$2b$10$ZDPeSc7ad8an5jOWkGfBbOpe.Tq4PyVxDRSO6DUyFe0CC7Pw4EgUG	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:24.724338+02	2023-06-14 09:49:45.811561+02	00324000015BBO2AAO
09423048-d7f2-4085-a249-2201b6496810	Netsanet Bekele	$2b$10$fWWCnOEthK9v/C5DrhDLTOqD4CyuBmM1XfRrqrZFyNk9qEa8197pi	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:38.185021+02	2023-06-14 09:49:48.674531+02	0037S000003NxdDQAS
e093a0a3-adde-4342-a907-3e0b62968dd4	Bediru Negash	$2b$10$9hNzrdxEF5JQTs53htw81ubOuOanOGwVpVdfcjwWXaaKgPUQDaNey	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:38.874172+02	2023-06-14 09:49:48.772488+02	0037S000003OyLPQA0
079e30dc-f897-4d67-8b7f-6afbbbb7f32e	Endiryas Kefyalew	$2b$10$81iGLIRDW9ciMywglQGeJ.I1w.ZoCYKju3uzozACYgXu/RJwTQ81G	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:38.940945+02	2023-06-14 09:49:48.792146+02	0037S000003OyLRQA0
0abf6c36-170a-4164-a0e4-03cd052dc4ee	Zabiba Garama	$2b$10$N0xsW7ecu2xD8E9vbgqwOucG/pJdaaFl14h1tZsOr9EIJ9D4IVk6W	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:15.775626+02	2023-06-14 09:49:50.294068+02	0039J000002UT2wQAG
4d4ccdad-e086-4df6-a67b-0a7c68c784b0	Abdulbasix Kamal	$2b$10$oA/LF12V4MSIzU3sotoVSesFby4g/S7vPRMdXmTw1yXt9QvnPYlbm	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:15.790953+02	2023-06-14 09:49:50.362785+02	0039J000002UT2xQAG
d830340f-c12f-46c2-afd9-3f735253b105	Hayder Bedewi	$2b$10$ULGFmBgH2GmIafEskGhvJuCkzFRb4b6jxp2EGF6vf.G0qZvbKKBzq	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:15.827968+02	2023-06-14 09:49:50.542602+02	0039J000002UT31QAG
990e7957-1574-4674-aac6-b01ca3b05c08	Jebir Kemal	$2b$10$RG7vWyzXVYoQsmzRYfy9KuiP6WgROix9mVe03J9AKTLfJiGzIhYiy	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:15.839867+02	2023-06-14 09:49:50.579513+02	0039J000002UT32QAG
0a86ea72-4b86-44bd-83b0-355bb0b1265f	Samri Hawi	$2b$10$JTpI5mrYKknYeDsZ9bu7VukFo/h9FvyoyuIQ7KOJ8W5nhr8k.9kia	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:15.87925+02	2023-06-14 09:49:50.707935+02	0039J000002UT38QAG
6d15dc7f-3464-4d93-b5fc-6ddb54c6bfcd	Nabintu Sifa Gisele	$2b$10$Y1x7gFIUlbBpio.Y5ynFO.cFIOHQYCJvsVPwCROzlcuxLvLQRvse6	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:41.168282+02	2023-06-14 09:49:37.245249+02	00306000020tCJCAA2
d9994df1-85a2-4012-a17f-281b7304d01b	Dawit Wako	$2b$10$QLlSGF.j3Kf3zVBhDHISjec7lHmVBv.RzsrlsHG/2Io8hRPoOt8lC	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:41.821158+02	2023-06-14 09:49:49.118058+02	0037S000003OyrWQAS
4e0a3cc5-8ca1-406a-8aab-a1323d1ffb16	Adanech Aweke	$2b$10$wbiwoCChl.4s7uz3Pk..YuDWasRXc.CfWAqdHJwf0WmCSUInXXEhe	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:41.954498+02	2023-06-14 09:49:49.135353+02	0037S000003OyrYQAS
58d7da39-05a1-48f7-b507-8344941d0376	Alemayehu Zeleke	$2b$10$B8iwqzhi6iKII37WoMJj2uxM.1F46C8./TdYUadoV22F.q/ZGQsGy	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:42.160073+02	2023-06-14 09:49:49.141225+02	0037S000003OyrZQAS
e5d4451e-43ad-4253-b8d5-1750a6d60f21	Firenesh Wako	$2b$10$2tJJCMqqramZXp23nWIY0.7ecsmVNGaRF9klCSuLMEqXJ47B.0BxK	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:42.297728+02	2023-06-14 09:49:49.151666+02	0037S000003OyraQAC
ce4213c8-f0fd-4f9a-8c74-d84c4e7294e4	Meskelu Tsegaye	$2b$10$5NWz8NeJX6bj2Ir7TFG8POEu2ASeAL0ma7P9LHUG11g29N.lc4KKm	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:42.431133+02	2023-06-14 09:49:49.167937+02	0037S000003OyrcQAC
438e3125-c63d-4880-b9e7-c4980083effb	Tigilu Ashenafi	$2b$10$eignJkvYI3sdRgMR1AzvoO/73P/vYYhUlAu03kbXhM2zunoKzYGNy	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:42.515002+02	2023-06-14 09:49:49.173892+02	0037S000003OyrdQAC
f74c6d79-9fe5-4b73-bb25-29fc96fd5688	Haymanot Mekonen	$2b$10$Kcn6ODrn/VeX/GAIsm5NGOV0w9scvQX/r4wIlnxI308Gcq88r1cni	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:42.570895+02	2023-06-14 09:49:49.183133+02	0037S000003OyreQAC
170818dc-3200-48f2-acf0-bd47544aa9c3	Birtukane Demese	$2b$10$0SvxjZaks0ixWGKRGcJF5O7RCqcsvDzd96bPkcdMxT/n86nKRuu4m	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:42.702211+02	2023-06-14 09:49:49.187836+02	0037S000003OyrfQAC
0b40524c-9ab3-4fe4-866f-f130d8c21104	Tigist Rabo	$2b$10$wH5UeF80boy3AgW3xsc30uWsCafH/x/MEyUUNdyK166cYb1Lvdd0m	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:42.753844+02	2023-06-14 09:49:49.19732+02	0037S000003OyrgQAC
33f2758e-ff54-4b5d-a6f4-2f5139bbe0e3	Wongelawit Tefera	$2b$10$T9RdeQJivlW/aZTbH38XkOA2SFQroscl2ZNYO79wLDRc3.uHq6IRO	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:42.941553+02	2023-06-14 09:49:49.205086+02	0037S000003OyrhQAC
0f991744-9d3d-42b4-bd08-af0af60bd8f1	Getachew Jikiso	$2b$10$iis/oNHdnz2hyjtyUmu1t.eHrKg1n/iAgszYOUC8/cZz9/GM7wSaC	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:43.075941+02	2023-06-14 09:49:49.209536+02	0037S000003OyriQAC
0a598f64-499e-4b41-b892-359e501d11a1	Samuel Assefa	$2b$10$Zu5z1aXHRUobgqkc5e19fOrP4gldvybtPvWJT1oze1yW/5jypzfXa	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:43.271913+02	2023-06-14 09:49:49.221554+02	0037S000003OyrjQAC
d059064a-d9d1-4026-8ca6-23d0d5aea797	Samuel Tefere	$2b$10$QL1.VQW3X.6boxLxV8JWsOdfMs0AKrF8hAAycNgp2FOhJRt93GEqm	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:43.761088+02	2023-06-14 09:49:49.257516+02	0037S000003OyroQAC
aaa258a2-87a8-4bbe-927c-925fd99bccc0	Hirut Tsegaye	$2b$10$AypXm8V3.Hc15rKBGLT3h.UN6K3JeXy9NJtqiClNzN3RUHC2Wdpeq	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:44.22674+02	2023-06-14 09:49:49.287028+02	0037S000003OyrsQAC
6add0824-df98-4dbf-9ec0-89c75c7949c3	Maryam Sheka	$2b$10$Vea3Kms1Dl9RfD6fc1fDgOJcjaYoyIsXU88UD0W05rHFBPdp62v7m	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:44.323719+02	2023-06-14 09:49:49.291575+02	0037S000003OyrtQAC
99b1729c-9efd-457d-b930-e38a860857cb	Tariku Birre	$2b$10$SsMjJ1JVIkgLhasWUbW5KOopDaEstYtM86MUHm.qrtKB465hmVWdu	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:44.54481+02	2023-06-14 09:49:49.298934+02	0037S000003OyruQAC
8f32f481-a06f-4e45-803e-09aedd8aa9d6	Wongelawit Abrham	$2b$10$ByPedFrA.WXpMBt1/IbHRu.8Tam8nJBK/M0Y1F3uxDN1Hf6hyyELa	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:44.626151+02	2023-06-14 09:49:49.303103+02	0037S000003OyrvQAC
bba6a630-64a0-4a09-a62d-a072bec056b7	Esrael Tefera	$2b$10$NQVqeVaUMXHNFW/mLtwm0.gJ9.87pXVBA24YKYISH30RieVte/z8u	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:45.032997+02	2023-06-14 09:49:49.359071+02	0037S000003OyrzQAC
7824caad-6e1a-4f7b-a87d-7d8de8950d2e	Mengistu Hordofa	$2b$10$elm5zLVizypxaRzhjXnQB.LxyJxx6VoKaKLQ/mu5mGH4IRG1FGk3u	\N	938689754	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:45.420426+02	2023-06-14 09:49:49.405243+02	0037S000003PJ26QAG
c6ba0f5f-f4eb-4c93-8395-59e91a4b8a19	Fred Sonko	$2b$10$o.9wTv.xDsqBs3.1ecMrBO8wlqLNSSUc9K.Xu9G2amFolWmvjOwiy	\N	256754895867	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:45.619423+02	2023-06-14 09:49:49.420571+02	0037S000004B6oIQAS
73d62a11-dbd0-46eb-9b5e-899d2d659880	Jospin Mulomba Sanvura	$2b$10$ZsLbgrj3.1LcIPuYEG9N3.iqpcLEc.2b9jcVQguLSvb0f0Wo9BrNe	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:45.765963+02	2023-06-14 09:49:49.43638+02	0037S000007oS5KQAU
c5390b13-a5ee-4a29-9f79-bb0dc481f02e	Solange Kinja	$2b$10$y8jxXiIEeF6gZFvBXcwVvuddsrFTZxPi0O6apFR6fvAlp442vKSnu	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:45.895884+02	2023-06-14 09:49:49.445453+02	0039J000001jv7vQAA
f78979ad-08eb-4000-b0d1-0a2d8333af3d	Merlin Baraka Mbavu	$2b$10$uvn.nR/vNILANagETOO6HudRq/MpfJG.7lbhWQiWloExDSEhBMV4K	\N	971219335	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:46.083036+02	2023-06-14 09:49:49.452748+02	0039J000001jvOfQAI
2aa31577-a1c6-4a9c-a55f-7d529ccb84ff	Yselte Asifiwe	$2b$10$r21u9nFx6HBOZs0pPDhv2OFntEkhILRTETsRRZpAxIgMnsk3DoTz2	\N	976498387	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:46.321261+02	2023-06-14 09:49:49.46928+02	0039J000001jvOhQAI
afb4dd52-27b4-4f47-9fe1-c8485a1abdac	Lucien Bamporiki Manegabe	$2b$10$Z4VS07mG4jYTB2o9ELORcuwBw2VxYCq.OnW8k5XTpeXxE/a3bT/mW	\N	971840304	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:46.379924+02	2023-06-14 09:49:49.472869+02	0039J000001jvOiQAI
10b78c06-1820-41a5-b51a-6f623ac061e4	Glorienne Nsimire	$2b$10$Gl4doMGGdbzV6y7YS3ivW.idSXcTNh7v0QruTVtowEyrnh8nO2OKG	\N	975800990	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:46.511601+02	2023-06-14 09:49:49.484118+02	0039J000001jvOjQAI
18d9005b-6970-45e0-bd88-4caaf5116c7b	Espoir Tumaini Sanvura	$2b$10$thYneKqLhJI/V3wArOQiXeZ9opK84xHG27iNeisEEmN.e/.S7NrCC	\N	991189242	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:46.597693+02	2023-06-14 09:49:49.488121+02	0039J000001jvOkQAI
d5310419-3cb5-49e9-bb41-e4a229341da4	Rachel Malunga	$2b$10$S1.SVful0eKA6OhcG3kwfuNUY3w8EC3DKMHUa0ra0HdCact4/uVda	\N	978358211	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:46.659734+02	2023-06-14 09:49:49.499876+02	0039J000001k7qDQAQ
3902c1aa-0111-498d-93ac-ecacbe8b68b7	Guillaine Mastaki	$2b$10$1v0j4ocNnVvJL/WQCT2HS.IPitgil9N7RwQeGK5rAlHU10etwC5ae	\N	995918287	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:46.914267+02	2023-06-14 09:49:49.505297+02	0039J000001k7qEQAQ
bb2ddc11-a1e9-4684-a4d3-f243a464b078	Jolie Magadju	$2b$10$iKcyteoCYSW4wAZPcdvtfOovzzz/T6G3inMorpZ47H25veWiM6w2q	\N	9732662668	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:47.020598+02	2023-06-14 09:49:49.516202+02	0039J000001k7qFQAQ
aec14d74-61c9-4f74-b3de-db1a444f8d4e	Germain Bahati Macumu	$2b$10$vcUueNPhlLYytgVC9nljkOda/EQdnnCPFy6o8mzY054c/tnxq.FQe	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:47.19641+02	2023-06-14 09:49:49.522047+02	0039J000001lR8FQAU
a99fcc43-12b3-4ae4-bf86-9796bdd91776	John Bahati	$2b$10$QdKjh.0tuG1.f1U54roXkunnJ9pfsn75KNZfJ0GXCBLj2f/cVtKOi	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:47.333994+02	2023-06-14 09:49:49.533927+02	0039J000001lRFVQA2
8901a375-3103-487c-b81f-55af1a314783	Michel Mitima	$2b$10$bQQQ8E.5JBR8WENJhJJFlOL20RnrHBu6.rJH6NZqGchVfSwCFRjZa	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:47.496419+02	2023-06-14 09:49:49.538488+02	0039J000001lRFWQA2
b8e6f150-5dfd-4105-bbca-b500e2336348	Christophe Kacheche	$2b$10$rH45ps77SUNEBzqO4ehw.uQRDBv1kexkC/eWJ.exjiZMpqOrIBx1G	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:47.566687+02	2023-06-14 09:49:49.549109+02	0039J000001lRFXQA2
4533e6d2-843d-4a3b-aea6-8e5f8e0cb0bf	Aimé Bahati Rutale	$2b$10$8dxvAcq0PzSUTJcJCVgQQOPdNSRdctISuWynzD9ur1rAvLDanSE2O	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:47.628045+02	2023-06-14 09:49:49.553521+02	0039J000001lRFYQA2
097f1a1e-bad8-4056-b494-bf71d14d3d8e	Daniel Kamungu	$2b$10$/.TG7l.hIlKcEcQrlDaIL.BwgLwo4Y6Dxa1QvSwXPDB70goWP3HiS	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:47.771474+02	2023-06-14 09:49:49.5634+02	0039J000001lRFZQA2
65681f05-e17f-411b-9c19-1093599ff94c	Elysée Macumu Bunyungu	$2b$10$FKPi4vsy/Clu4NBc0gMdsuQCP2P2joTp7BbsDgmOKhF1Teo4CtFW2	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:47.9188+02	2023-06-14 09:49:49.571745+02	0039J000001lRFaQAM
441a8523-1e49-43ea-bf76-cc2f3eee950e	Tsion Chebeso	$2b$10$x1q.jGU30CarnYrJAM4tC.fHleF1CnnOWFtQkocwxdqMCYGFMuhzW	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:41.178767+02	2023-06-14 09:49:49.042325+02	0037S000003OyrOQAS
4bd0d9b2-5add-4bf7-a675-1b4a9ad1685a	Meseret Tilahun	$2b$10$IcihagnTp.j4WGvMvasSjedRWN1UnPySdbzbIrOlmcVu.Nke7ATYG	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:41.545019+02	2023-06-14 09:49:49.069236+02	0037S000003OyrRQAS
af9dcda1-51e3-4130-91dd-f713b0e3cec9	Awoke Abate	$2b$10$X3tdYy1gMgvQCdJCrM/GcuxgvCNs6ApKs62363gcdZUYvMrsucV1e	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:48.409707+02	2023-06-14 09:49:49.645813+02	0039J000001p8nNQAQ
397f79a0-db5a-43b3-a2a8-ca3fb5cc6b9e	Fayiza Aliyi	$2b$10$jCKRnI.GGLTNAsaKW3IpbOySWk/ximK6CVy7Bp8qjz5Mpl.UL90U6	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:15.69061+02	2023-06-14 09:49:50.103483+02	0039J000002UT2qQAG
14c9623e-cceb-44ba-b783-1ea6c05a9937	Nasru Kalil	$2b$10$EPUb6QmAbUe8Vq2K3/xjvud57gep4qOBrPx8IpaMH8ceA/vdFhDqi	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:15.762977+02	2023-06-14 09:49:50.148893+02	0039J000002UT2uQAG
50d9fdba-bb56-4f32-9307-3c3a12463f82	Fami Yasin	$2b$10$.dDl.A4ZA1MqfKH5oL4sBOX6hIGE/qgNEBPZJELIpa1keHc0vj1tu	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:15.814822+02	2023-06-14 09:49:50.491574+02	0039J000002UT30QAG
26ee539d-6818-419b-9551-dc9d7d30da85	Kamil Abajebel	$2b$10$/wQGdGB0TdzOwfgmkFr5Z.UXtsIgagJcYhWWbvvDdEpvZJTatfxWS	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:15.92306+02	2023-06-14 09:49:50.780735+02	0039J000002UT3BQAW
88b9353e-4692-43b5-b4ee-e016b9c7a720	Riyadu Digashu	$2b$10$8RmUYYiLMo188iUzH2H.F.UcI/5Tsbub3DBsxvSnNI68FvxKSoEEe	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:15.956525+02	2023-06-14 09:49:50.810261+02	0039J000002UT3FQAW
322f2774-1530-469e-9fac-018abb970f6d	Sali Jamal	$2b$10$/xkLb9cgl5MqpGwO7w/Lz.1XtE5ldhuPiPyOFuyUKDyi2xWp7J7AS	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:15.961427+02	2023-06-14 09:49:50.814292+02	0039J000002UT3GQAW
7d64500e-4eeb-4d60-bd52-70a7012fa259	Kabitamu Abireham	$2b$10$4gsV.jkBFde/GcOn6vOHgeAnA3e0ll1EMR7xnOAGgpwSjXIpK2uF.	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:16.019324+02	2023-06-14 09:49:50.838943+02	0039J000002UtYmQAK
ba134f28-f8e7-46b6-ac29-cf9c02affa7c	Andachew Samuel	$2b$10$vDmmPBSwMtaTyHNsxqeI/O.ERc8dW8WYUu/ojrWCZj6EoTUzcYahK	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:16.024679+02	2023-06-14 09:49:50.845812+02	0039J000002UtzLQAS
f09c44c9-b9e1-4d97-aa12-b9b74fc0e0a6	Wilfredo Torres	$2b$10$SoPvkU/rtGzdqfpI1sZxt.XrMOJ3gwS4jbik5qP/wzOEDLwjhTZ4y	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:12.597012+02	2023-06-14 09:49:43.391677+02	0031o00001ub1IWAAY
998e5204-0ec1-426e-a299-49dd2e4ba92b	Carole White	$2b$10$1fUOwdXNIWvUkNvF.YtImedPdEMiETS8C7prZA7luse26e7xSL.ee	info@salesforce.com	(415) 555-1212	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:20:46.814325+02	2023-06-14 09:49:44.499918+02	00324000002sAitAAE
6dd533b3-c9e2-4c2a-8239-2c7b778b8582	Jaleli Boko	$2b$10$OD9uOqWh1PGPilq5eb2jOOKSxxw/IZ1Rhn1HIZKCKoOqAW/.OKkAG	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:24.268532+02	2023-06-14 09:49:45.675105+02	00324000015BBNmAAO
095eb391-6816-4c1d-b7cb-694d452f57cb	Meseret Denbela	$2b$10$Y0.CKRwHMvFHsWmm3xjMZ.raPpIVVp040UvRrGXc0vL5rDd3zhbte	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:24.609172+02	2023-06-14 09:49:45.75775+02	00324000015BBNwAAO
38f67717-9adf-4c25-8484-7ab761102d44	Annette Nabatte	$2b$10$q1XjHWVl/dTNrzjlZb2H7OHMzYzmmsT8IVtdcmJSpYcs7yoG7ts.W	\N	+256708693219	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:45.487325+02	2023-06-14 09:49:49.41433+02	0037S000004B6njQAC
22f3aaf7-c979-49c1-8d85-0abcb65f3743	Christian Seti	$2b$10$BtX/ba/UsMe7usPO3SAWR.LJLECZgVal3PUBJCw5cw/tASL2xWmDO	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:48.030624+02	2023-06-14 09:49:49.584781+02	0039J000001lRFbQAM
6af49e02-ce91-4084-bdd7-153f8140ab16	Bernardine Furaha	$2b$10$I9NyRwBI2eeQdBii0wLHaekPVeZl5JnUY9/Am49aNz6AlBzVRg/i2	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:48.091639+02	2023-06-14 09:49:49.589596+02	0039J000001lRFcQAM
ac59c3c4-9662-4a1e-ba3e-083a2fd5d7dd	Guillaume Habamungu	$2b$10$zyI2j52LjdMbBFz.1vbfC.acybCFmjtmTIUNXxaZU46KYgUcK7EdO	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:48.180817+02	2023-06-14 09:49:49.61446+02	0039J000001lRFdQAM
1c45ee4e-8d49-4cce-9686-88130466d914	luc Mastaki	$2b$10$iVwMkF84Xq.R.yC.rfD.RetbVFdfcG9Y.q0EG/1Jnvd1H/JTnA/u6	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:48.323755+02	2023-06-14 09:49:49.633772+02	0039J000001lRFeQAM
a12bc87b-17a6-4ac8-8aad-61acc7527370	Banchalem Getinet	$2b$10$rjbqckNAftblrrFPqQdDuOk.ppGCnJuii/sxb.T58SHPih8WA0.4W	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:48.457053+02	2023-06-14 09:49:49.65533+02	0039J000001z85xQAA
8861f073-0fe1-42cc-b0d0-4128630dc6be	John Arenas	$2b$10$qb1DIr8RBN4HKhrhnI.I1OptjX3MVJI4L7xLQpjvKU16.r86JraSu	jarroyo@tns.org	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:48.534687+02	2023-06-14 09:49:49.66785+02	0039J0000026XJIQA2
ce2146ff-a188-4bf1-99d4-55fe71bfc004	Tatiana Tosado	$2b$10$0rzPF9Omcgcpf0NcOS.ZhOrrXtTsPM8rXvXLMLSdzDvq8z3HAuAYK	ttosado@tns.org	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:48.602739+02	2023-06-14 09:49:49.678532+02	0039J0000026YOuQAM
e736cedc-1003-4e38-ab7f-849930826b59	Yves Mugenga (Contact)	$2b$10$evtH0FaQkb0KyXI05zYW6eHe8gT6AGU1xME21WGOotpHKLIGCKPwm	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:48.81468+02	2023-06-14 09:49:49.698421+02	0039J000002A6I9QAK
784f6b6c-ac36-4d48-9ec0-003aa7bd2f29	Kerudin Awal	$2b$10$s4vmHz8YQ92RLl40QKWBOeGbvKe3ItveoDQwsml4gGHGdt18hpoNe	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:15.860786+02	2023-06-14 09:49:50.658452+02	0039J000002UT35QAG
0a639950-63ca-4c53-81d8-d6bba8d27893	Mamedo Raya	$2b$10$GG5rdP6Elm4ksKJ9rWytPe7q5BaWfRSgCKsSoHoQy0Vj2NaYlkHrK	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:15.874779+02	2023-06-14 09:49:50.668982+02	0039J000002UT36QAG
661cfb00-f09c-4b4d-a124-846af98b036a	Tesfanesh Hordofa	$2b$10$r0rONT7QN4P1GDggSh0qj.mS.oa9nAnlVFERvP51IooYdBcmziwwW	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:16.055421+02	2023-06-14 09:49:50.872271+02	0039J000002UtzOQAS
567a0545-6966-4d3e-bc95-df8fc6007a36	Asnake Mengistu	$2b$10$EvsjcgNtD.QFxSAvj1vRauW3hmRnOAMdZYDsymoszf7v7pS1cN15C	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:16.076519+02	2023-06-14 09:49:50.888571+02	0039J000002UtzQQAS
5cb549bb-3e3e-40b1-9b31-8f8302e35f13	Tadeo Ssetuba *inactive	$2b$10$P3NYXFzjYHFkkh20M7cFP.YKZ3ApdhHP0k5OHHuPatkDe7T4l0/Ci	\N	781518024	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:38:37.677797+02	2023-06-14 09:49:36.337812+02	00306000020fifgAAA
3c98686c-1844-4d7b-a5fc-48ad1cbe3748	Kakande Yunusu	$2b$10$P19QIYeW9S7LfekQlqnyBeeFXpKZo9w3B93BiRc1/xP6JMwGE.UWC	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:48.457937+02	2023-06-14 09:49:38.451834+02	0031o00001TKKn0AAH
21f0a8fa-afc5-4690-afa6-71632c171526	Mary Nyambura	$2b$10$xxG47MS9D8jz.jGPL9dGlunNK5fE0SZXHKkVJYAdqKPPYK0tipLLq	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:48.621061+02	2023-06-14 09:49:38.491035+02	0031o00001VZd46AAD
10b9556a-db73-4d2a-8758-65c81e44563d	Domy Thiery	$2b$10$zAZazho1rdGGssjIH9qsm.IcldNnfQCF75JKn2wrNVJ.wxtOqthJ2	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:04.664941+02	2023-06-14 09:49:41.715416+02	0031o00001lRdMNAA0
8c4b9e02-ad8d-48c4-9ecb-c95c9f668625	Abdulmalik Abayazid	$2b$10$D.7IEB.XvodNqKaaYI9iAeL.AUg0yxRkbEFFnJm58MNv/K0lRN/di	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:36.062656+02	2023-06-14 09:49:48.40278+02	0037S000003MlQcQAK
d937383e-7071-4a41-8f70-1298c09b71fa	Hayat Kemal	$2b$10$P9VwFhksduHEZQoDFV7y1OkRMhq0Q7e9ZonrK2mezH5lyEoP2xMe.	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:15.909417+02	2023-06-14 09:49:50.776355+02	0039J000002UT3AQAW
c75b4cca-6d6f-44f4-9a8b-676897074421	Werkineh Abebe	$2b$10$NdHmWfkecffi4OUklopk7Oz0mtHsYI2Rvb7kZbq7viLHFxhZLsGhm	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:16.311753+02	2023-06-14 09:49:51.1964+02	0039J000002UuVkQAK
8c00813a-70f2-4d1c-968a-d017a88e6525	Sintayehu Edima	$2b$10$ztole0Et5HapPAUjvySRm.b8E61zlDCYXKqzZ3Wf2wOxwfATlVZvi	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:16.357743+02	2023-06-14 09:49:51.493787+02	0039J000002UuVrQAK
8c6c9514-bcec-4c99-afce-e6a5c3fc3ed6	Eyerusalem Tilahu	$2b$10$9BKPlKd9kO8.BzWU4zAhq../RoKnA7866W/.yWWLyjVIztxRzW3WO	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:16.399522+02	2023-06-14 09:49:51.528158+02	0039J000002UuVuQAK
ec38c115-88a8-445b-b373-aaf40df9f226	Yishak Nigatu	$2b$10$LgH50J6NFeXBXOELC00EAO3Y3cHY3/7P.y8ocGwbvWP2QyUx9NVMa	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:16.432076+02	2023-06-14 09:49:51.56066+02	0039J000002UuVyQAK
59c9713a-0075-412f-9113-54f19ff2b11c	Mulualem Hailu	$2b$10$TlxrY1Z1vcLCqXjsCvzr/uAYP8jdlaBHfEe6EJbZfh7gkAW.QWsa2	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:16.486033+02	2023-06-14 09:49:51.610281+02	0039J000002UuW4QAK
1024dc0d-06df-4818-b933-5d8c9ef64994	Mihiretu Mijane	$2b$10$ynAFIWThXQsVxq2idmof8eDv2corfYfKI97lEiz8FhBNb5.iMvysS	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:16.713925+02	2023-06-14 09:49:51.649039+02	0039J000002UuW9QAK
13a5a7c9-76ed-4e39-a61f-0b569db4fb43	Senait Ayano	$2b$10$nYsDGdKZW4c8osgEPlFGoOlGxkz1MNmt2Mjty8RZBDVDb5gVI9Btq	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:17.167275+02	2023-06-14 09:49:51.72537+02	0039J000002UuWJQA0
6f57ea5f-7fc0-4fb4-a2fd-26e94d0045d7	Solomon Tefera	$2b$10$w474sYBuns2W/ltX5mO.L.6MbSR5Nu8zYJ./EhmUuEo9Ho4NYsr2K	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:17.213816+02	2023-06-14 09:49:51.765043+02	0039J000002UuWOQA0
1259323d-09de-411e-8153-7e88e555878b	Yasa Diramo	$2b$10$zonrMOv59SDkIgMRxVrul.LVxPGtiS/uvtlqElnNI.9sqfrNXCae6	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:17.348835+02	2023-06-14 09:49:51.785367+02	0039J000002UuWQQA0
30131332-9963-402f-80d2-2f6762ea47d6	John Doe	$2b$10$AFaOwei6CRJOFXb14fqdJ.tgMgP073fHQBF2.yNV2c.gtgRTMxxCq	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:17.412399+02	2023-06-14 09:49:51.891695+02	0039J000002VuqaQAC
01ce5a10-33e5-42af-aab4-dc44e1501914	Furdos Mohammed	$2b$10$MEjmVDqiwnU2i8wyY1x88.vGoZYXPXtGkX9KE7596I5EX5K665q76	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:17.478743+02	2023-06-14 09:49:51.93885+02	0039J000002VuxLQAS
b1291a97-52d2-4e08-bb1f-ef6ab54f9c2b	Tofik A/Jihad	$2b$10$oKmZzmiMf2o9gUEBddTvV.3oBHDBNhLH.2uGtPM5EWi9f4.OS6iq2	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:17.531538+02	2023-06-14 09:49:52.022037+02	0039J000002VuxUQAS
e339fada-19ed-4d7a-8d5d-4095e44792c5	Sawuda Jihad	$2b$10$FsYq2fIIJopHiXj1CBnP4OhY0rLeTQ/hQGqLUoNJx1n.xiZtoo0Mu	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:17.584336+02	2023-06-14 09:49:52.049259+02	0039J000002VuxYQAS
2e4d82da-2c5f-46b2-8d56-580f1e97ce3d	Nasir Siraj	$2b$10$I2cC9cW4bej/W3SMnR/P4ejQlwrWDktHRNKUhQ7aBkVIUOPxLAr7S	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:17.644307+02	2023-06-14 09:49:52.151869+02	0039J000002VuxfQAC
7ac7caf1-8ffc-4cec-909a-6a1d21caa523	Nebia Yesuf	$2b$10$rKsJfpD6sguXKci.TM2Q3.W.akWd.iJzrH8rofzvDOoKh6rBRTv5K	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:17.72166+02	2023-06-14 09:49:52.189906+02	0039J000002VuxjQAC
f9e51706-7a53-4412-9509-a48b9628ec95	Haider Jihad	$2b$10$T0VfQ6Ss7OcCtZXmhfqBgOWvMS6yEwPM2HJt9l1NurKQcQ56Zvtqy	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:17.799909+02	2023-06-14 09:49:52.246032+02	0039J000002VuxpQAC
1a6546f2-f8cf-4786-9110-c6ce92d51d37	Alima A/Dafis	$2b$10$NiIsnPZEdfTUF3SDyp35Xe9mYyoWOp56IlNpLpIP9HAxzrAnNFO8C	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:17.865097+02	2023-06-14 09:49:52.283124+02	0039J000002VuxuQAC
34f3eef8-974f-4b6a-ba4f-b0c20d362633	Munaja Husen	$2b$10$6/yEra3oIXaLaVZMP2w/1eoOBI1BcbKLFXDE7jzopj2ZhNFJz/iFS	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:17.943969+02	2023-06-14 09:49:52.318622+02	0039J000002VuxzQAC
73d80189-000a-4167-b60c-98b9fbca24e4	Abdulsemed Temam	$2b$10$dxxvlxE/JPZ9z0A6nIEoKOl4HflRsBu.dAuQw/wmi1OJYM210Iole	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:17.99539+02	2023-06-14 09:49:52.352343+02	0039J000002Vuy4QAC
ab4eb224-2ca6-4485-a9e3-34b8f1c08d6c	Husen Jebel	$2b$10$bfmvSlSt4fI.rAZ7CIZsN.H.QyA3T/q1YIbeM9/Ize11le5L8t4sO	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:18.042806+02	2023-06-14 09:49:52.402517+02	0039J000002Vuy9QAC
cec4e351-2834-44d8-86b9-d48cca7e97c2	Belay Defar	$2b$10$WrKKMk.z2EM9.ScbjFIMFOyGZ7SNCa7Sl4J78E0MJz3eOYJzgpTVe	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:18.097132+02	2023-06-14 09:49:52.448081+02	0039J000002VuyEQAS
222e88aa-c535-414f-b616-f7fe442040ff	Noela Namukenge	$2b$10$9A0y6CT8joFuvtDeDiigQedSfuZWDTaky6pPKUMuxnq8/.QR6UyKm	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:18.164592+02	2023-06-14 09:49:52.483948+02	0039J000002anRtQAI
3caa4b95-08f4-44a5-a287-73398ffda9b3	Eunice Ngari	$2b$10$FGSbnD0BQwVpd9pquqKw2ungbWdf1hjeZVdS6/syJ8//0ENmtLQ7S	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:18.204223+02	2023-06-14 09:49:52.532914+02	0039J000002bwz5QAA
252cab4e-3864-488d-b7c4-4db30bb6b6af	Dennis Kariuki	$2b$10$WyMp0KeXhi0fjrnj7qio9eelr/khwNBV9etfbtw/PwXVHmF52YKkK	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:18.257082+02	2023-06-14 09:49:52.653018+02	0039J000002bxEyQAI
be4749d7-ef4c-4171-93e5-97b4cf1b700d	Kennedy Munene	$2b$10$v7/v7iDK2DjboAXRorWVF.TVQWz5O1MFrjn/RO7sZCeLcH/tbNTFm	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:18.29265+02	2023-06-14 09:49:52.715476+02	0039J000002bxF3QAI
889d4dce-e689-4794-a2ed-75d09efdf2f5	Elias Ireri	$2b$10$KU8ucnYz27m4Jx.HPF5L8OAsxgzzCypOKBDtPLB.RSYq6odk4w/vO	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:18.329979+02	2023-06-14 09:49:52.79683+02	0039J000002bxF8QAI
9ab2f487-696c-47ea-8e78-d2a07261d932	Robert Kinyua	$2b$10$Satimazk8C7C5HUmQCB9bO/kUAH8c1ayE5wjdbaytEsY./UnzW0bW	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:18.392954+02	2023-06-14 09:49:52.8345+02	0039J000002bxFDQAY
214b95c4-6e2e-42ea-b753-269ea35952b1	Bonface Rugendo	$2b$10$UPY0glehA6wnxsa3i93tMe8cEtSBaRM4iikOdEjUJpL1Yt7yVDF96	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:18.441694+02	2023-06-14 09:49:52.88442+02	0039J000002bxFIQAY
e7baa2f6-74e8-405f-a93c-6a3a5b16325f	Brian Muriithi	$2b$10$JnR84rUAeRjgJhnl7po2MOvGLlSTgiUiigbdWFcO2kBFm85fg6bgm	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:18.536611+02	2023-06-14 09:49:52.927909+02	0039J000002bxFNQAY
523a52c1-bdfa-4d79-8d78-14e2389b0a3d	Rose Njeri	$2b$10$FtDRqKDxwhB.UAdJY8wOBukdPvHlkJ0BHMVK/7iv5LIKkp15qnYjS	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:18.611588+02	2023-06-14 09:49:53.015926+02	0039J000002bxFSQAY
0d6df213-2c00-41e4-bbc8-7f099b1b5e15	Tamrat Mengistu	$2b$10$eqJeIxXsDQ3IKkRxM8ma9OG.27TO43vTNW6YY8UjUuW1G2SHk50HS	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:16.17364+02	2023-06-14 09:49:51.011309+02	0039J000002UuVWQA0
49af684c-49d5-42ac-abc7-59db8f07e84e	Kefalech Gezahegn	$2b$10$v0MDKPuC4dtJ/oGgPryOFefZKMha6gtM96SJOHDXmBF8T/3xsqPa2	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:16.221336+02	2023-06-14 09:49:51.057274+02	0039J000002UuVaQAK
75579e9c-3b7c-4802-8afb-ef43dfbee810	Petros Beraso	$2b$10$WE05ZAKx/CRBULj1rDT27ec0nsUZ22igFD6SCN.pLkmXv89N0LiJ.	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:16.259182+02	2023-06-14 09:49:51.096886+02	0039J000002UuVfQAK
6ba2d06e-eace-4b41-a54e-be93b520813b	Abraham Bekele	$2b$10$403wTK0h1GWf6YRBQAtIuuIwCHcVk9m39wGa3tvhtmSZhCPOHHrGm	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:16.901303+02	2023-06-14 09:49:51.699145+02	0039J000002UuWEQA0
d4ca093d-906e-47fe-b416-6b8707a6dc95	Abrham Beyene	$2b$10$GSGhL4Mk37gl8e91xZWZF.CMyXhrbadu.dxWgD0L3FwttFotL0tuK	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:16.323799+02	2023-06-14 09:49:51.211333+02	0039J000002UuVlQAK
f4866682-7d6b-44aa-9435-ce931371640e	Melese Berako	$2b$10$fo8wDuM4zZuaFU.Xa.8Hn.kEr.zSr0iOdTLyqC9w.QoYHE8vJr8ce	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:16.365787+02	2023-06-14 09:49:51.435252+02	0039J000002UuVpQAK
211f814a-c9c0-4500-b772-c84ffb81c367	Getachew Jebo	$2b$10$a8xB6ngIrCW7LbdUfk/2qeeCe59SO4wEuqs9keMij/vEI9HmAgZ4K	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:16.405055+02	2023-06-14 09:49:51.538927+02	0039J000002UuVvQAK
dbcd20cd-24e8-43bb-807e-e19ba57546ab	Yosef Mariam	$2b$10$PkxpRE/InPu57W7Sahw/eOWENVT9InaSU3ALgB5TY//xLpBAzF/dy	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:16.539638+02	2023-06-14 09:49:51.621571+02	0039J000002UuW5QAK
70cefde6-1480-428c-8674-39830dc03882	Mulugeta Taye	$2b$10$DdjVjwUF3mBoeNLEtg90uOsxJneAlhvYHGe/j98ZNkSlo.1iFjZP.	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:16.772445+02	2023-06-14 09:49:51.657098+02	0039J000002UuWAQA0
d01f8c76-89c2-4ed5-83a5-d2122de4065b	Abraham Shiferaw	$2b$10$Ma/teJnAe0E8l/Xb77Alpu2ZROQ5FFzlNU/elum27j4S.CPO1AKwC	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:17.01848+02	2023-06-14 09:49:51.703872+02	0039J000002UuWFQA0
dbd33bcc-c6cc-4ad1-9a48-abce5800264d	Desalegn Tadese	$2b$10$jrrIQe2fCJDmUVuNzrT/Iu/3Zh3no98vYxCzwc5mRmT6528CE1MHe	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:17.194574+02	2023-06-14 09:49:51.731326+02	0039J000002UuWKQA0
15a04d94-d8a0-4110-8768-60d094c68b5d	Wendmagegn Niguse	$2b$10$vJXr0E6JpJh8/HPRU7uW9.SfoyiQ38h3Si4KaSpl.VoX2qSA/7Wl.	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:17.217605+02	2023-06-14 09:49:51.774315+02	0039J000002UuWPQA0
e7f2843b-6c5e-4904-b920-bfce3dfbe0bc	Niguse Bekele	$2b$10$GhvvXDIE6Sk0IHCFBPf2hOOuc8fK1dfjXPYhNC0LO6Ok1GS5GtOuO	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:17.366982+02	2023-06-14 09:49:51.832352+02	0039J000002VuqWQAS
7c84e0ff-e379-4579-b9af-44229a104adc	Aludin Jebel	$2b$10$rO1lBwQbMIHjT.dqWZKO9eRiixrBX.QAaMOB1/sy99I/hYtLDJ.7O	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:17.42689+02	2023-06-14 09:49:51.915314+02	0039J000002VuxJQAS
b50fff2c-0c29-4ac2-be11-b92efdaa90bf	Jafer A/Jobir	$2b$10$3oG1ZuNcVSjBVe1DECvIZur2Bsdfl3hG7zABDMZGFv7An2y9WIaRO	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:17.485424+02	2023-06-14 09:49:51.949816+02	0039J000002VuxMQAS
5c0f855e-210c-4af1-a531-563fbea8417f	Abreham Mekonin	$2b$10$UDEZiIXbx5qk4ceGcMTVDeWfEDT3hIi6Dv6y6VhcZBeyw5ZrPfVSG	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:17.54459+02	2023-06-14 09:49:52.029754+02	0039J000002VuxVQAS
06645dc3-3152-4b0d-b52f-8b21b24d6567	Janati Mume	$2b$10$ctA7ZBKzgqnCsHEtlE5kSOzYgglrJ9UjIJfAzLmIxcFbC2yrwEpV.	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:17.595008+02	2023-06-14 09:49:52.130752+02	0039J000002VuxbQAC
b4b3f78d-db21-4d16-9387-690779e43196	Derartu Nuru	$2b$10$7pPtz4s8F4KEJ7pWPI/f8uOH0bZiB9sAz3eHNL2YhBA9fxj4gDyom	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:17.652174+02	2023-06-14 09:49:52.163554+02	0039J000002VuxhQAC
74a14338-38f6-4ff3-a10c-4b6fbe3b125a	Zakir A/Oli	$2b$10$ExCjODIhkmnI.96id63w.OCmpyP7.3Yu/XG7hbh16kYij.MWblMUy	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:17.731831+02	2023-06-14 09:49:52.214626+02	0039J000002VuxlQAC
2131b86b-6f15-4429-8775-ec946db70aa4	Kamila A/Fita	$2b$10$Q3.eCnJKjQfboC465gP5y.zkS9nfQBz3AsJ.22Tmfn0khjdOdtQ1m	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:17.817522+02	2023-06-14 09:49:52.252492+02	0039J000002VuxqQAC
88742acb-6479-4df6-af97-fceacb113548	Behailu Deresse	$2b$10$v5SN5dFtawYhmC1t3RC9G.ILb8q2nzjw7rXMFFcc6WOtbx7EHsJBu	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:17.875134+02	2023-06-14 09:49:52.287838+02	0039J000002VuxvQAC
97f2238e-874f-4865-ba6d-5faf17acfe2f	Musbahu Abdo	$2b$10$kw72fO2X8jZRHX1BK3voZuY11k2tGvJfH0kP.4p1d2WY6/mNIsT82	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:17.949336+02	2023-06-14 09:49:52.322435+02	0039J000002Vuy0QAC
aac19cec-08af-445b-bdca-2c1d0c82c88a	Anes Mohammed	$2b$10$xWQntRbgIYjkID4Mk5w4veLI93t/P17s0.JQX2USyae38yKfw9Mt2	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:18.004742+02	2023-06-14 09:49:52.367467+02	0039J000002Vuy5QAC
7f319885-690c-43e3-8648-313ae6e6d508	Rama Nasir	$2b$10$T217oSK9CfDNzThHqnE5ruephllIXDyp47WL5YZyIzlHskhsNkQZe	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:18.055266+02	2023-06-14 09:49:52.413642+02	0039J000002VuyAQAS
3b55890b-8ddc-48ef-9c89-1f30755170ce	Mifta Tijani	$2b$10$Fez68hqS5/daF32nPZjjmecl7K.gk4mfS4ZjoLk2dzZtK6z4d.872	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:18.10545+02	2023-06-14 09:49:52.452236+02	0039J000002VuyFQAS
0670f54a-cfb6-47a8-a18b-aef5fa642666	Timothy Murithi	$2b$10$M4K.6t7c2/.dJgv.Gj14eObPico5yPei4Ji8m8wh4tBPDpHFuURYO	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:18.177648+02	2023-06-14 09:49:52.502068+02	0039J000002bwZJQAY
6a459572-464d-4bae-abbd-a0c7d94668d0	James Njoroge	$2b$10$2IFBgzrjOd4AEuZhWsv73uw4b71DuAhs9/LRAsuK8n4ENtnU89ay6	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:18.210774+02	2023-06-14 09:49:52.547813+02	0039J000002bwz6QAA
0f36586a-66ee-4fc8-bde3-0be9ac7ee0af	Edward Chomba Ngai	$2b$10$M7D6sQAECE0.lK1NTHZObuzFqr.FILwdZM006fiVCG1wVrsvqbIbq	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:18.263268+02	2023-06-14 09:49:52.669694+02	0039J000002bxEzQAI
d9acbd99-2c6f-4e33-9704-32dd9acadd7c	Rose Nasumba	$2b$10$bqGT/Pf49y.Dh9ZzRYtUS.XlKLhqyRGAPAhYkOflk/M7u7AZef8NK	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:18.300726+02	2023-06-14 09:49:52.733148+02	0039J000002bxF4QAI
d9582fa3-8f08-4dfc-a52c-5c8c13642c98	Elizabeth Wawira	$2b$10$8xkjLOBy8sLZvE2QhhUbL.YIkQJu6lV73XNZ7NjNpFbPHxNOXShIC	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:18.34573+02	2023-06-14 09:49:52.80138+02	0039J000002bxF9QAI
7748421f-492c-4a30-9199-f2b2ee180787	Ruth M. Njoki	$2b$10$FmOmOPSX.NlD2NFkV.uiBOoFLHu6umZFk2FsarsSBSg66zH/W0oPu	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:18.404081+02	2023-06-14 09:49:52.851897+02	0039J000002bxFEQAY
114e0187-83a0-4abb-a052-f0909a16f248	Carolyne Mwende	$2b$10$WyjSlO.Pa8Rp6igSvs4yo.SqF/S8WS0nC66g9DC9zRrDoGh3xxh/e	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:18.457694+02	2023-06-14 09:49:52.893762+02	0039J000002bxFJQAY
f38f05e4-6fd3-4d62-b2e9-b151870f88e2	Charles Baru	$2b$10$Db8DFBPXdcUM.y63.NNFieLd8GjqozSzomj.ZD3p.K16nDQvVE/Rq	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:18.545195+02	2023-06-14 09:49:52.932336+02	0039J000002bxFOQAY
fe8bc60a-f46a-4dfd-9150-c32b3d017539	Veronica Nyawira	$2b$10$EqLaLqxijMLe4U6AbjyAoOPyqivPyj5Z0HeKqgwLZFSmQ.Pbrrkdy	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:18.62297+02	2023-06-14 09:49:53.026761+02	0039J000002bxFTQAY
cc63e484-0666-4f0e-b259-e08e1fc70339	Kefalew Erba	$2b$10$UacdYcdmbvRUDCxp0IC2s.c.FyrGHlC4KdDiMJglHvWaBt5OD4uqO	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:16.187652+02	2023-06-14 09:49:50.997413+02	0039J000002UuVVQA0
c2590c8f-c67c-4bc7-97a3-417b6bd08ee4	Mirtinesh Tadese	$2b$10$s7BHTwblHa3nKJ7SvcIY3eSIhp/zqCxDHcDuG/u.ZyT13GfiKhXTy	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:16.226088+02	2023-06-14 09:49:51.06202+02	0039J000002UuVbQAK
34451c76-ad27-4175-a263-35abea16e2cd	Rahel Ayele	$2b$10$/z6UYg/6GulHbieHyE6FJOopilE1HiiLOIMyKQza2R6brIElBj1XG	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:16.269574+02	2023-06-14 09:49:51.118478+02	0039J000002UuVgQAK
a8af2f2b-f7ab-4904-8a7e-17a190440a7c	Bekele Abera	$2b$10$WAktHnt9Bfn31m35.3ztg.ZgwlhSz0SH4NgG9Tclgr5./w8i9HiZO	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:16.441196+02	2023-06-14 09:49:51.585942+02	0039J000002UuW0QAK
7fbc6241-28cb-4500-9e3f-6922d6fcf720	Senayit Ayele	$2b$10$QT8Tnzg8ZPaDexPJYbGaBepa0SG4Pxgqc3han4ZBZorNLn6PRj/D2	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:16.375185+02	2023-06-14 09:49:51.442267+02	0039J000002UuVqQAK
6ed4bf0d-bf06-4673-8b32-541d1ca27f83	Teshager Jiso	$2b$10$qRrsfqfTzkgVAoTa0tiHQOVhu.qWqpJkQD8MV3WZCTW33fl/L9ZLK	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:16.411906+02	2023-06-14 09:49:51.543261+02	0039J000002UuVwQAK
c9fbbc34-e7cf-493e-9138-7c9086d42753	Ekulinet Atara	$2b$10$HKGQCbNScSSA7UpHFDd98.0EXYTb7dv3eCtNrTVbT4FIus7r95N2u	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:16.447791+02	2023-06-14 09:49:51.590037+02	0039J000002UuW1QAK
15b0396b-0eaa-44d6-915c-53228db6e700	Aster Milisha	$2b$10$PqGkRkb8ssphYEzMG11EWuvyi29I7pWNBImjySRj2Eahr5BTAYE6O	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:16.601236+02	2023-06-14 09:49:51.626152+02	0039J000002UuW6QAK
01ac08be-8c9b-48f1-ab58-cee9dd12d4b1	Kefialew Tekile	$2b$10$LRr/kZ4qY6AyFz6TGw/gi.D1fHrRS9vqUb/bw5q/6a7iU0vGiOTay	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:17.06427+02	2023-06-14 09:49:51.707941+02	0039J000002UuWGQA0
c187a677-1ba8-4740-bb3e-fc8179bb2923	Esayas Zewde	$2b$10$.lsQJBuW1bUliizebM7YM.BBcRTIxdRRPe/A4ouezxsz.RCYpzbdi	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:17.19861+02	2023-06-14 09:49:51.741809+02	0039J000002UuWLQA0
15def1a1-ecc0-4caa-a13a-30618027a5c5	Addisu Akalu	$2b$10$ttc1LMq/cdPZCfjzoEdg7eGNDcGaf2EyXkAmT4Ya6e2STTGycY9RO	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:17.250458+02	2023-06-14 09:49:51.798403+02	0039J000002VuqSQAS
eceab69e-874b-4225-948b-9fef01917bf6	Seida Nezif	$2b$10$AfjV2g8.KsvftjStdYGS2eb/mYcmn5fUyrHbwyFTUcfObqyaO..s.	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:17.380654+02	2023-06-14 09:49:51.852574+02	0039J000002VuqXQAS
7ea495d6-a667-4e02-ab9c-6e41a12bf4ed	Serkalem Belay	$2b$10$5mWoBRn2fZmY9jHFg2DaBeI0WFHLeaOJAZih2AbBn1TtrptDUJlZ6	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:17.435686+02	2023-06-14 09:49:51.874558+02	0039J000002VuqYQAS
1391499c-95cc-4133-a02e-23cb9b04e231	Rebika Dafis	$2b$10$h.Vgtw7CyoW3yZAMjJjQguUnrtylK33.ANEBuBsA/9hzFCuLaNey6	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:17.494973+02	2023-06-14 09:49:51.956742+02	0039J000002VuxSQAS
c265b4a5-bcc0-4913-8001-13656eecbfd1	Mefuza Sh/Mohammednur	$2b$10$9F/ouenKCz.tyAn9g.sezOx5z5ulWKrSh2F/PIaw06b9gFgNJJISC	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:17.550529+02	2023-06-14 09:49:52.043535+02	0039J000002VuxXQAS
4ccb0800-430d-45eb-86fd-34e41aa0a0e7	Muna Teyib	$2b$10$u/OISHjoDg.b/gXYrZBX8uo9kEwyZ32kl8BAdjZ7Q2VCSIgjYDEGm	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:17.609752+02	2023-06-14 09:49:52.147761+02	0039J000002VuxeQAC
5ab6de3d-6c2b-4c81-9032-3a7f57f9ba4d	Ayisha Mahamad	$2b$10$OgJJZeaZAOVAb2Dqyf7f0OvGjx9c1f/SRmL31HbNR7IGZF8Yu4QUK	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:17.661636+02	2023-06-14 09:49:52.156075+02	0039J000002VuxgQAC
cd27a936-fd3e-41de-95a6-5903b3174608	Abdo A/Oli	$2b$10$RFogBh9jnf6OK9hNAH/Qmuqxt0uE03HRb4A7nyeUBDOAuwOUVEn/.	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:17.750835+02	2023-06-14 09:49:52.221186+02	0039J000002VuxmQAC
7b76099f-fa90-4e06-b656-6eb8c2310f6e	Nebil Mohammed	$2b$10$A84HLvD4saL5J8..6OJwmu7WHa5XC.p1.et.Z3fqqJScwKtEf9eNS	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:17.83237+02	2023-06-14 09:49:52.26247+02	0039J000002VuxrQAC
24cc6db3-655a-4d11-95eb-b9be1208107e	Semira Abdurkadir	$2b$10$Rs1SWlEFQiiTWBmE5P1XB.or7VFm1Lo7oTnXi0JnUO55VTSSdvX4q	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:17.898102+02	2023-06-14 09:49:52.296958+02	0039J000002VuxwQAC
4413ac6c-12e4-42cb-9fe6-ac55999e96ff	Muslima Temam	$2b$10$lZOSH55sRGqPMNzUtv2auuNEHD88poDg/B9YhB.jjUJ2mxA8Xw2fC	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:17.972564+02	2023-06-14 09:49:52.332661+02	0039J000002Vuy1QAC
c05bc138-15ce-45f2-bb64-41bbf3e3896d	Bikiltu Nasir	$2b$10$aKqG0pYhNz6.9nlR5TMnceeEHQJtGpl2pBEiQ0AluCtcSGCKxxxh6	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:18.013555+02	2023-06-14 09:49:52.371901+02	0039J000002Vuy6QAC
25baa3ec-f98f-4782-9973-8edd8f81412a	Abduleziz Jebel	$2b$10$Exgnjm2/nfeHSn2iyEKAPu03aHnrXIz4oQM3bxDJh5kueckOj1I1m	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:18.066591+02	2023-06-14 09:49:52.433199+02	0039J000002VuyCQAS
6a4e86ff-3a02-4988-aef5-db8b15c90ee2	Riyada Nebso	$2b$10$F7/ii6edmcN0UWbPTDKFJuY6AbaYEZor6gsvzfK1RHGHGXj.JaoXu	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:18.12204+02	2023-06-14 09:49:52.467921+02	0039J000002VuyHQAS
2acfabfb-2c65-4c8a-9ca2-946870fd93e7	Jonas Bahati	$2b$10$gHKbm7mntTHnoZQoHzazkegdY6UkNhZHuBx7cow38MzZA22/pB3HK	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:18.182036+02	2023-06-14 09:49:52.497793+02	0039J000002asQtQAI
93f109e3-0312-4bae-a5ec-beadaf52ae1f	Millicent Ngatia	$2b$10$no.vefhf.lYn39rwtcCa1O.4J1Gn.LmLPalMRyFjwLvk.wDiK3/YS	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:18.217994+02	2023-06-14 09:49:52.568723+02	0039J000002bwz7QAA
8e205eae-1bd6-4e1f-81ae-55f747bb6031	Ephantus Kinyua Muchira	$2b$10$8jlPON4ixxu7UPNzLz7DEuCXWy49PbcypMqQg4.ysEm3qYnuiAw2K	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:18.274637+02	2023-06-14 09:49:52.684387+02	0039J000002bxF0QAI
b49cd8b5-e4d6-419c-b244-4b122674fca5	Simon Macharia	$2b$10$3t0jaD3FngmBk9sy2ajYWu/lJjF38tI6tC8WKHHZCud7jX01G4j76	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:18.306083+02	2023-06-14 09:49:52.76245+02	0039J000002bxF5QAI
f859fde5-9c7d-4868-a3ca-37e8ed74c54f	James Kinyua	$2b$10$J/APczPvN93DfKx06QDtQeNG3/y9iRwPLL7PKXd9PybhhtobDAd7y	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:18.354588+02	2023-06-14 09:49:52.811958+02	0039J000002bxFBQAY
5012efb4-a4b9-42b3-af1b-704313a1d368	Winfred Nyaguthii	$2b$10$hLthqg9hDEWWZibiVTMTAucD78f1RtMqkKTv3nMF2fHxl/y7beeOO	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:18.413055+02	2023-06-14 09:49:52.866543+02	0039J000002bxFFQAY
2c78b599-fe14-458f-9ec6-546653bcd3a3	Grace Karegi	$2b$10$kwlSgvYTDaXUtorvLuqJKOa4nzUZy3AEHFNP0ZFUmuXsTnnXWl6xu	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:18.474418+02	2023-06-14 09:49:52.898937+02	0039J000002bxFKQAY
5fb7e50f-85ce-41fc-9c95-0683cd326911	Charles Murimi	$2b$10$O9t2K1TZW7Q3MtjegzDxjeIIMyqMJh3iJP26av3hM6z/vSGY9pbKW	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:18.573628+02	2023-06-14 09:49:52.946749+02	0039J000002bxFPQAY
70fe3488-08ba-4b0c-a2b7-58b8f68b391f	Adane Berane	$2b$10$3oZMuRSe0HPhrpGKPWQ.jOXIJXHW2sx2xf8JaKQRYnr8LAiWXgcdW	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:16.192832+02	2023-06-14 09:49:51.026005+02	0039J000002UuVXQA0
22b41e48-f975-48f9-affb-fa54619da439	Zekiyos Abebe	$2b$10$QVbtMFSKRRelBfQfsKnYFecM19CbC3zlmdV/I8nYGe04/i1uppkOm	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:16.237595+02	2023-06-14 09:49:51.086567+02	0039J000002UuVdQAK
77ce8afe-017a-424f-a966-2f9d452ea47d	Shitaye Alemu	$2b$10$dbJXclb07q968mkPXoqNuOdXGaeCFxS5dvtRYIoG8bBqsL9X4GGD6	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:16.277443+02	2023-06-14 09:49:51.141301+02	0039J000002UuVhQAK
5ff7bf1d-27b7-4e97-8019-602d0bcb1f7f	Getachew Hirbaye	$2b$10$HZdP4A2PsifTJ27hLRCwYeKf1xpoLEWvJAZDH2nj4Hw/hdYMzLq4W	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:16.334093+02	2023-06-14 09:49:51.321624+02	0039J000002UuVnQAK
37186eeb-d13b-4895-8f25-56fbee82299d	Tadelech Bantore	$2b$10$Ct6SSqK/sN3tIg5WL0qDheifSjAJL3PX46BTLkWfC/xqyQ6sdU0jG	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:16.798993+02	2023-06-14 09:49:51.666418+02	0039J000002UuWBQA0
7bcb2935-e2fb-4b6a-8afa-1e1c876e57c8	Bereket Werasa	$2b$10$2rdWzPGimOZXTr/IrLkRNOVmsCqP5w2xhBe7in8Dv.HYyDM8YX9oK	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:16.386642+02	2023-06-14 09:49:51.518767+02	0039J000002UuVsQAK
371c149f-d367-4f39-a3bc-a1cda550ec5b	Tsegaye Demise	$2b$10$E5KyjriL1.GyVSHfAT5fuOGGS5QYgH76HYdAkISQfH1VsRKGa3gne	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:16.418515+02	2023-06-14 09:49:51.557162+02	0039J000002UuVxQAK
10cbafc1-5f9b-4949-b4b3-367fb192966d	Eminet Kebede	$2b$10$F7olnhBNgnEP8jE8nfJlTu8JajUsAJUPhHFQHCHCTcJ5VNDGcocku	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:16.454581+02	2023-06-14 09:49:51.600435+02	0039J000002UuW2QAK
4ce5afe0-ab6a-47b4-af77-62db10211d3a	Mariam Miju	$2b$10$4rYQiG30WOzxjsV4ZfwMGeTYqtEAGcIgIGspaXaTpJnnK8CsG7gEG	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:16.633807+02	2023-06-14 09:49:51.635205+02	0039J000002UuW7QAK
cd034cbd-079a-4f4b-be04-61e56e4a7510	Mame Tekach	$2b$10$xJEfIjCyTCYJgGdUDNhKz.AMzM8Q6aIbMGASzOa8dzSnMx/a5hvVm	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:17.119805+02	2023-06-14 09:49:51.714989+02	0039J000002UuWHQA0
6dec46d6-fc8c-42f3-a835-e7161644ef40	Hizikel Safa	$2b$10$GWHJpu7XcE0UQ4U.Qr2XD.CmEz6WzGXA3UNPNIQWfKqi6Rqr5cOPS	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:17.203967+02	2023-06-14 09:49:51.753888+02	0039J000002UuWMQA0
d127d45d-2612-4f25-8362-ef7debe353b3	Amanual Samuel	$2b$10$WgH/vdec5tXvtcgEOnkcWukzNsGRHDpRgCj5O6/b2myAFiNNbc53G	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:17.301677+02	2023-06-14 09:49:51.790396+02	0039J000002V78BQAS
a376ac1d-58f9-4832-9a14-fb8c44797de7	Gazali Ahmed	$2b$10$qGb6n9qupOiRhWxhf0j4AeQQe/7azSkZE0ZwzBoZmZth186mbLqWG	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:17.386047+02	2023-06-14 09:49:51.807738+02	0039J000002VuqUQAS
b505a902-1423-4a53-8528-937e27a9c7cd	Tanashe Eyasu	$2b$10$KCFfoDdi0V9TIL5gzT.TXeBV0afFOhsYJvS2tMd7h/L1KbzDI/GNW	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:17.448521+02	2023-06-14 09:49:51.884761+02	0039J000002VuqZQAS
6caba874-f151-45f6-809e-67180e5c3d56	Sumeya Awel	$2b$10$SUdzgducPog1TaHud4l9GetWBavOoIVrqraA6uzaGiBRemX2SBQkW	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:17.51259+02	2023-06-14 09:49:52.004414+02	0039J000002VuxTQAS
00e700f7-5a64-4d5c-bcd3-5f923115a98f	Hawi A/Mecha	$2b$10$p8cerGdZGU40koy0sHpUyOjBYlfx94LdJyIr5Oq/Nf/5dkle6I.Ei	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:17.563237+02	2023-06-14 09:49:52.126899+02	0039J000002VuxaQAC
b354b305-42a3-4ae6-af3e-890433dac451	Kanna A/Milki	$2b$10$PWm35ZMtiZxH9hIYU.oSzuwTfuDbU8DR5gfw6fEIRenkxnK2QMiCO	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:17.618595+02	2023-06-14 09:49:52.134483+02	0039J000002VuxcQAC
692a4131-d735-4479-8019-2d80c150a9d8	Jewar Biyya	$2b$10$TV4R9LUe3HCUDCrcq8erze46PUAxsPoLLeOU4ljC75XR34tFWxhtC	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:17.676944+02	2023-06-14 09:49:52.172679+02	0039J000002VuxiQAC
cb8e762f-5e78-45e0-9b0b-a9b2719c26d3	Abdo Tijani	$2b$10$jm1mwRbs4bDxhPBqwHrV7.BkW25Ngc3mxS1Owoa7rVya6ZZ7CMZBG	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:17.765307+02	2023-06-14 09:49:52.230393+02	0039J000002VuxnQAC
72617a34-1cd6-4f3f-aa22-926b1b54327e	Reyad Teib	$2b$10$Lzt1T1vE.bBIZfNuj0BgOO1LK2lD144x0LqimSI.ARJDtUX3ELUja	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:17.8429+02	2023-06-14 09:49:52.267941+02	0039J000002VuxsQAC
b161b10b-bbac-4229-b838-97ecd9b7b7fc	Abdulselam Kadir	$2b$10$OnTBRmsh63ySIYVksaOtTetFTojR4VxSVrcklFEOnbYzRmNgtWiDy	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:17.91524+02	2023-06-14 09:49:52.303511+02	0039J000002VuxxQAC
8c08ff59-b18c-4684-8373-694c21ac0535	Taha Nezif	$2b$10$FHpWrSDFpxmrpB86SZnK2uraJ47xiCO1K4pBqnWL7./5kuubDCeL.	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:17.978867+02	2023-06-14 09:49:52.338656+02	0039J000002Vuy2QAC
f060b162-6d60-452b-8ed9-8717c464056f	Gidi Bediru	$2b$10$FhNYAzPuxKOQyUUw4Uj7gOgMlEc2JHlT15QOb3XnYokkEKrbABl2i	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:18.0229+02	2023-06-14 09:49:52.398357+02	0039J000002Vuy8QAC
3ed63a43-8ad5-4568-a9ef-451ecdd4aa86	Amirisa Nebso	$2b$10$PTjnQvtO5tvEdDpRpP2tQe6Sc33rP2Wg6IPI0NW3WXPDy7/7cZxU6	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:18.076796+02	2023-06-14 09:49:52.43795+02	0039J000002VuyDQAS
d5f5ad3f-3dbd-4e01-b6c3-50fa5fd32845	Nejat Abdulmejid	$2b$10$xuwoCp3JjhvHovvDTxccmOALYhTSxrT0y4IUaglMAuHXIBx9CZgqu	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:18.129585+02	2023-06-14 09:49:52.463701+02	0039J000002VuyGQAS
7887dfb0-fb14-4777-8b15-4a764b3320bb	Juma Kibisu	$2b$10$o9cwiKBe9GGRkUZvY6Orh.lOsQL9Akl2VHgpkaOju7i9/a17iqK2y	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:18.191483+02	2023-06-14 09:49:52.5144+02	0039J000002bwgkQAA
128b3cd1-f575-4ceb-acba-8dcb26b019e4	Caroline Wanjiru	$2b$10$p4X.IVISahwUWkDAM8OvtuvwMCCGzTvrYGkrwHpEsCtWEQnLf33Jq	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:18.230762+02	2023-06-14 09:49:52.602007+02	0039J000002bxExQAI
4e9277df-2261-42d8-b368-9726de56a54e	Grace Wanjiru	$2b$10$z0bfMjmypUFpCfqL45OilOZjEuK6t4RpMulunc3Qpc21Tt/zN2mEi	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:18.280865+02	2023-06-14 09:49:52.696747+02	0039J000002bxF1QAI
1d089321-8a12-499d-9d3f-3de646ef4c04	Bernard Githui (Mercy)	$2b$10$26Xw6GXNZhyutJSsX/00c.kdT9qTRTiBkfYq7ZCPakf4UqOLEBJXC	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:18.315269+02	2023-06-14 09:49:52.775909+02	0039J000002bxF6QAI
13dc122c-772b-4d65-81c5-4254e5a64540	Harrison Chomba	$2b$10$zg03rlu/cvN0WthRfP5X.e66.Caq9jVhdg9tcbKT1tTUGGHoiNMH6	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:18.360505+02	2023-06-14 09:49:52.808617+02	0039J000002bxFAQAY
34a0534c-b2f7-4eaa-a8fd-7fd3ede6e78a	Beatrice Wangui	$2b$10$DwT5UwvWmqBdr2jbLANnmuyRPXkQHjNREuakPTWIP22bomYtVGqdC	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:18.425238+02	2023-06-14 09:49:52.875616+02	0039J000002bxFGQAY
869fefd4-731d-4fa3-921f-995454334f29	Lucy Kagendo	$2b$10$/cEJO8pcgIBn4aMLt8aI3.zgLfNPLZD5JgK98hWcYvwkz4V2NrtXW	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:18.49003+02	2023-06-14 09:49:52.910553+02	0039J000002bxFLQAY
06474cd3-523a-4689-b61b-adbebadd0a88	Harliet Gicobi	$2b$10$wU/rgXbZj9EKxwL/dHtgOOt2oKT.hIyhtoivV2/01LhBBs7Cp30/y	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:18.588944+02	2023-06-14 09:49:52.992652+02	0039J000002bxFQQAY
b8d19cec-d618-425c-b797-823601751101	Etenesh Kasahun	$2b$10$VsAe8w6KrkM8OYIz/5CoZe6Hwbn387m8nUgN/SI/6XEqItIhbq3zm	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:16.205287+02	2023-06-14 09:49:51.039332+02	0039J000002UuVYQA0
81bc9487-89d6-448b-8b2d-b94d67b297e5	Tigineh Dincha	$2b$10$/sUCptIUOntoi.DZ9aaaO.pNPCz/tZpuq1G17Mi7A5fJXQXBwyPqe	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:16.242919+02	2023-06-14 09:49:51.074367+02	0039J000002UuVcQAK
4b9a46fb-a333-41e5-8c74-36f21550b18b	Tigst Ayele	$2b$10$ZJ6I/vDkmVMtemQupjMmF.MMz1ZILbhyVYdXgYyExgp/QxknTzcZm	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:16.290238+02	2023-06-14 09:49:51.193101+02	0039J000002UuVjQAK
e9c17269-48d5-412a-b2d3-3fe5b623445a	Betelihem Yohannis	$2b$10$AAh0.JQ1LcRHDBDB6ogpwe3fSy16OpQZrFhXwbyoiRpZM4Bv2pkFS	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:16.340819+02	2023-06-14 09:49:51.262456+02	0039J000002UuVmQAK
c9c39e7a-d917-4a9c-a79c-26dd9c80b5a6	Tariku Shiferaw	$2b$10$FLa4bVboZ0E0f.pNqk9oReSeoWg3AiP/DtKuBq5TRy3MFctHCaT7u	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:16.842997+02	2023-06-14 09:49:51.674607+02	0039J000002UuWCQA0
7f5ce078-74fe-4526-a223-e7892a8913b7	Ashenafi Terefe	$2b$10$4wKgsgDC9UzclrJvJ/RZgOCicqfDuMPwH637SlJ8DfrXBecEobs3S	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:16.253915+02	2023-06-14 09:49:51.091662+02	0039J000002UuVeQAK
bdfa4c02-7c57-4458-bf19-38399255fada	Tamrat Shoto	$2b$10$Bh5zJ1Z8F8S/EfFhM5bQSuh3WP.BDuVBPg1yDt4JA2awdgEJYJTJi	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:16.305135+02	2023-06-14 09:49:51.186801+02	0039J000002UuViQAK
31cf498c-01af-425e-a052-6ed68d99b88b	Hilina Tadese	$2b$10$HDAUs0PkBR/MyBLv12ZDpeWrr9FTo60KqcyDBX9IQDl.B5qj6059O	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:16.349819+02	2023-06-14 09:49:51.418278+02	0039J000002UuVoQAK
c21a364d-2e10-48cd-9f80-7f56c8da2b64	Bizuneh Shune	$2b$10$CSdvselD.iLGac1NL1sG0e7s.iWFBsVGgVcYWiG4kbYxChkafjuHm	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:16.392231+02	2023-06-14 09:49:51.523354+02	0039J000002UuVtQAK
16478819-aaa1-44cd-8e1f-fb6800c4f953	Amare G/Tsadik	$2b$10$yeobSoN2QtOM78bRz0XSG./34uv43sy0RXU6azGzAslr968z9QnXO	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:16.424499+02	2023-06-14 09:49:51.573061+02	0039J000002UuVzQAK
5cb63426-b7c5-4f15-8779-758ff901465d	Higena Tilahun	$2b$10$gyinfn0xxSOVnH/KuT6v1OdpdomiZ8eQaO2qkFulGo6PTD80WZpWW	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:16.473107+02	2023-06-14 09:49:51.605061+02	0039J000002UuW3QAK
9009d722-81c4-43d2-97ed-f01a190d2062	Mariam Tadese	$2b$10$t4FjJn7IVfUAcgFrQ37mQuXwi0w3I.NAGaOGXX0L/IxrRhdH1Jouq	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:16.681699+02	2023-06-14 09:49:51.63898+02	0039J000002UuW8QAK
dbb203fa-5a55-4d55-9b14-1e296f0a9c65	Abraham Ageze	$2b$10$mESZixoqf0v3BZH26QhdwenK8Dc59FdgkuR26x3I5CTocQtUkgYby	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:16.887847+02	2023-06-14 09:49:51.688811+02	0039J000002UuWDQA0
04a1a8f1-f6e5-487c-8dac-54f01c27aeb4	Misgana Daniel	$2b$10$UYuiMQLwuEVsmY/oK0yTGOug9KjRcsmw7IfSEJ7g2RA1L7XF4V3Qy	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:17.139438+02	2023-06-14 09:49:51.719756+02	0039J000002UuWIQA0
ca143ba9-ca4e-4d84-bdea-981c844daebd	Mulugeta Brhanu	$2b$10$F1z7dLFza0FxB1Yh/D1u5./OK3mLToE3Y76MZLsyxmJ4/P8wwbPKe	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:17.209686+02	2023-06-14 09:49:51.757574+02	0039J000002UuWNQA0
f52f07c1-3eab-47da-bcc7-19028fe45246	Buzayehu Ayele	$2b$10$Noh6uwaOScoqBblCuTAnPOvH0jktY2uDu/pLfv6Ne3Ss16dK3Wp7C	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:17.330778+02	2023-06-14 09:49:51.802171+02	0039J000002VuqTQAS
25b16035-f61d-4973-93d8-07bb4d0a71ce	Ismael Shafi	$2b$10$kTgeAZGMsjL4Iba0SS8ChOztF9set6ZoPEzaZudZ6r3WuMDm91kXq	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:17.398438+02	2023-06-14 09:49:51.815169+02	0039J000002VuqVQAS
94033d21-b1e1-4693-89c5-710ccc137375	Fekiriya Shemisu	$2b$10$G/DEZPrAXsKz3UVGMKpwPeu4dzXe8HK5oq1b7dSO.m63T2jE1b8.y	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:17.467625+02	2023-06-14 09:49:51.934137+02	0039J000002VuxKQAS
25d06a9a-d6d7-4800-a097-abf0cb246aa2	Kenzi A/Biya	$2b$10$KAekD9H9FMiRSoYq9REVQuHZF9BIk2Lw9zUgoo7ISZLVt4XuC3uCG	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:17.519647+02	2023-06-14 09:49:52.035561+02	0039J000002VuxWQAS
cbfd7d46-49e2-481d-b678-e777925b015b	Tofik A/Mecha	$2b$10$LzGWRl5Fk7c02FfY8HFk5eRsEloYZO5m/SxDrT7JaRm/KR4BQaZ26	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:17.57583+02	2023-06-14 09:49:52.120603+02	0039J000002VuxZQAS
310b6029-9436-4953-811b-e58c7593d1a7	Mahammad A/Oli	$2b$10$RsLKcBHXw.KAxDH5Xx45refRc0wC.rRb7unncOpCxwXN6DXEHygMG	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:17.635491+02	2023-06-14 09:49:52.138834+02	0039J000002VuxdQAC
c54a7372-9fc8-47de-a878-d18b95567e88	Rabiya Awol	$2b$10$lV4ZMNzAhOST719vRhROsOJJFCC6ybw1GY/8FaMdT81Bw6GBi.sc6	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:17.713388+02	2023-06-14 09:49:52.200995+02	0039J000002VuxkQAC
299da5ff-07e7-4b23-a069-d2cf36948a37	Amida Zenu	$2b$10$hOp6pWeArrpkqzQsAH.fW.wHXlofj8hKEvRdc2uhwvJQ.vcfupd7W	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:17.779728+02	2023-06-14 09:49:52.236381+02	0039J000002VuxoQAC
d3a3ad34-4e36-4ea5-863f-1e4a79d81709	Zebiba Reshad	$2b$10$/55dGYG9xNS4rI88gQoyoeAodCXmdwvI7VjRWqqCCkEeOKfmswfha	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:17.857973+02	2023-06-14 09:49:52.272748+02	0039J000002VuxtQAC
7a63a704-5f65-4ed0-a114-fe301fadc798	Amin A/Jihad	$2b$10$IC3txFkNxKsYvWU0FGMk5.XwafQ.v1m5XOYrRmiRgTjC.lziqwYny	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:17.928317+02	2023-06-14 09:49:52.313403+02	0039J000002VuxyQAC
90a2cab9-94af-4f5e-92f4-4303f88f3d14	Yohannis Gezahegn	$2b$10$29ngWWeX.UOQUJpaGBtzTOx1XI0gyZpDwki2tvEjy88yKSTGXe9q2	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:17.988866+02	2023-06-14 09:49:52.347329+02	0039J000002Vuy3QAC
cbcac6dd-d7ea-4e15-901e-64c941cf33d3	Furdose A/Mecha	$2b$10$XZppcyhfYEQehYCZAj9bc.PZ1YBx//P2I51aQII2YE9h6OvuBJSOK	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:18.035845+02	2023-06-14 09:49:52.383605+02	0039J000002Vuy7QAC
ef1bf82b-2b13-4362-8f64-5bf7037cbacd	Yesriba Sh/Mohammed	$2b$10$IIHZjkVs6dI6GBDwUgEjOuvMe6DyAuf2UffWRoWD.tQ5BKhFhi9fG	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:18.089313+02	2023-06-14 09:49:52.418591+02	0039J000002VuyBQAS
2288cde1-9e8e-459c-b113-a19f14c8dd5e	Samiya Negash	$2b$10$t3ldwv8niW22wPApLv1ATu6kOpXRFGiw2I1Q5Sx9LKONeyBfb9r26	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:18.142837+02	2023-06-14 09:49:52.479595+02	0039J000002VuyIQAS
a91014fc-ecf0-42fc-9453-83bc90e0ad1c	Charles Ng'ang'a	$2b$10$dOUxDU0VJZh1F1DxnbII1eug/cpZg/BxV3iMoNMxCo6TEUQKT088y	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:18.196764+02	2023-06-14 09:49:52.520075+02	0039J000002bwz4QAA
ab947c53-1c6b-43bb-b6c9-ab4e1e3ad0c5	Andrew Murimi	$2b$10$Wzb65WbApk6tLc.2Xhec4urYY1rJQgOdnYQY4HwlS7w3rlwNnZiCy	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:18.245941+02	2023-06-14 09:49:52.585043+02	0039J000002bxEwQAI
53d67d7c-1e0c-44a1-ae43-3e19245eb567	John Karoki	$2b$10$sqUbQGczqexFxa8/GM92JejCGT/aWTziqrG8Vu5kdS7hqpGUYJ3d.	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:18.287737+02	2023-06-14 09:49:52.703563+02	0039J000002bxF2QAI
7a335708-2d65-493b-997f-3f0da00e5935	Cyrus Karungu	$2b$10$mz2oQ3OopNtzP9hLDOZ9RutA83.qt/2orzpWS6r6Gm95jF7afrIOO	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:18.324497+02	2023-06-14 09:49:52.786213+02	0039J000002bxF7QAI
96f7a14e-f9b6-4ee8-8a77-59abd81ee4bb	Kevin Wambura	$2b$10$EsybRlwqrhJfuuzUsxXmJ.So8Rgn7V4wFN0dTtvAZ088XXJRUslHm	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:18.370345+02	2023-06-14 09:49:52.824662+02	0039J000002bxFCQAY
0d53ebfa-9e70-4d09-9721-7af353c3592a	Bedan Kithinji	$2b$10$kUxGbiElr9ey2K7rpqT.3ukBpN3VnKqjGl831D.42meZByQmqp5lC	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:18.429839+02	2023-06-14 09:49:52.87979+02	0039J000002bxFHQAY
baab2659-5176-4568-ba39-26f584bb2728	Martin Njagi	$2b$10$kMIPNJTNdiHlNiVv6veGWuY7jj5W8gOKLLjsxEwKBwC6YoHopvIIm	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:18.504061+02	2023-06-14 09:49:52.915428+02	0039J000002bxFMQAY
11a544c6-be7e-4b10-ae4f-ab02c03ff34a	Lewis Munene	$2b$10$4pDASoHLBpAoT3BfUbGRuexvtIh/ZSq18hpU5.YbZM.fp0wf.kFyO	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:18.604549+02	2023-06-14 09:49:53.001463+02	0039J000002bxFRQAY
ab068009-8bc0-47c1-99f9-bce7740bd99d	Miguel Gonzalez	$2b$10$Ata94IeuKbjiCMEp0B2sqOZmtux6l/quQxyohwAxIbr9USy9Z1t1K	\N	7873091962	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:36.856391+02	2023-06-14 09:49:36.270187+02	00306000020ejtrAAA
ab070a09-d8be-4e2e-8701-9f71431ccf0d	John Henry Wambi	$2b$10$q8WvhgtEBmbCrDm0cT6iauodcf29OocLQHQHygbJAGTdcSKDoQQKe	\N	754444061	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:39.154792+02	2023-06-14 09:49:36.915819+02	00306000020figDAAQ
21260192-7d02-4799-a8e3-a319e21bceb0	Hilum Njuki Mwangi	$2b$10$hKowVSMMZAhdNqY544rl6extZSrfg4tOIcyZ6wUHWjhYjrSzXZHLq	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:55.263323+02	2023-06-14 09:49:39.914846+02	0031o00001gDVAhAAO
a9567ef5-8038-4f5c-af83-47e44fc53149	Magdalena Sabore	$2b$10$9xecZgNcC6HWS.SBBtxb0.fXKpihmk/8GhdQt5JKuq1m6XTD8sh/G	msabore@tns.org	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:20:47.132389+02	2023-06-14 09:49:44.629743+02	0032400000kwF3LAAU
73837f29-1a30-477c-956a-e1e3c6135ef2	Ayinalem Mutage	$2b$10$fw.oztsNDOUxfnnNgL1DUeTYUBBPDX3lllxKsLM.HcLLGdeByeMZ6	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:37.896929+02	2023-06-14 09:49:48.656002+02	0037S000003NxdAQAS
2dc92c2c-961b-41cd-bfdb-ff0c39ac97ed	Keriya Nasir	$2b$10$CaovYyCfvTd0xJopzUCe7O4m2U5vu9FJLO5TKa6SGYfxCDN9Zll2y	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:15.855083+02	2023-06-14 09:49:50.648942+02	0039J000002UT34QAG
0bd7b6a9-ca36-42b5-a254-dfd863134957	Genet Biftu	$2b$10$CnO4L8gIMJRPL2LRxt1hFeStOWfTygF689ww0vVuRPfnMwDTs1sDC	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:42:16.210561+02	2023-06-14 09:49:51.044467+02	0039J000002UuVZQA0
0f35c36d-9c63-4891-a6f5-6928bd4e95e4	Batasema Chahekire Lucien	$2b$10$tn7BKFkH/ipq/il4q.gomuvdW3BwvjCroBmqOzpEtFmY4d/jmmKSq	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:38:40.464479+02	2023-06-14 09:49:37.138105+02	00306000020tCJ2AAM
0bcd91b1-d83a-4fb2-a70b-38dc4cf9cb23	Sabir Zakir	$2b$10$D76Sp8mqWx2e3rSSwuboeuxIf7KABB4w5rZr5dTIrp0OicmsMMoa.	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:34.511653+02	2023-06-14 09:49:48.289564+02	0037S000003MlQOQA0
74bc647f-e014-4653-b2f0-7f3cdd01d6a4	Abdurauf Nabso	$2b$10$6FBIOQDvZmZ./bMS7.56Q.Kzq/bPn1eeqrxFa9TYG.whrTkcgKeX6	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:34.578924+02	2023-06-14 09:49:48.294267+02	0037S000003MlQPQA0
627b8c06-d10e-433f-acb9-25ea484cefcd	Keriya A/Jebel	$2b$10$K62xlPgmuv5txdl05dNgheU4eQ4bTJhBqM1oilgDXEyrKaR2D8gQS	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	inactive	2023-06-14 09:39:34.703699+02	2023-06-14 09:49:48.321327+02	0037S000003MlQRQA0
ccdf8bac-cf53-4f61-adbb-4c365ea9c044	Yasriba Nasir	$2b$10$MOVuh8DJ0Bfsi7NtIU7HnenLFVk8fpvLOVyQMDG0FuPRp20XdkDV6	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:34.902868+02	2023-06-14 09:49:48.329746+02	0037S000003MlQSQA0
62b21d71-4f63-4f99-97b1-89084d6a2528	Riduwan Awol	$2b$10$Nw4fGFeCKu5pMIcd.xgdse.L5cc252IvvB1nc3qTGtZdvD7imjz6u	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:34.973554+02	2023-06-14 09:49:48.336881+02	0037S000003MlQTQA0
9ff3fe40-8485-4e37-826b-95688c4b0dd9	Gazzali Awol	$2b$10$czfDtPpXBhEQ8OpyCESJ2O6l8vJi0MsmxRAi13Be9aly0mSrgFLYW	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:35.058374+02	2023-06-14 09:49:48.34382+02	0037S000003MlQUQA0
61065bd3-7102-4180-9f94-87e2603bff04	Faxe Shafi	$2b$10$gfsqdaWxvGiqIkKpZzBr1uUM2gOse7mhDFh5E/WnjSi86Dzc7bwa.	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:35.421468+02	2023-06-14 09:49:48.356919+02	0037S000003MlQWQA0
401d00db-38fe-492b-9f40-b4e4fced72e0	Basixo Aba Bulgu	$2b$10$PIPV4Fcng5wcUmAkXV62kOVjSSuD9GaGgv3xE/wbq6TdZ7oskqOnq	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:35.503823+02	2023-06-14 09:49:48.363881+02	0037S000003MlQXQA0
3910db36-c727-428c-939d-774406a4da56	Abdulaziz Nasir	$2b$10$MqabQCZgQFhRdUDGu3NwzOUA3YsHM1iaDXmYY57TijwNmUnnHjfty	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:35.596603+02	2023-06-14 09:49:48.373059+02	0037S000003MlQYQA0
8dc51f0b-654c-4c5d-9690-4c949dea08b2	Asna Mukamil	$2b$10$n4LIL62j1sNvT7SUMBDg/eaXelZt3chvCwFPSax.moLM.5LyxlaT2	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:35.710089+02	2023-06-14 09:49:48.380764+02	0037S000003MlQZQA0
3aa24fae-20e9-435f-be0f-865e64395e42	Alamudin Aliyy	$2b$10$ZxvE4IMRcY/.68YzMW2.gOcw0/glkpMd2NNz83xHS8PYuZVg50.Wm	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:35.859994+02	2023-06-14 09:49:48.393391+02	0037S000003MlQbQAK
6bedd8eb-9ccf-4b25-afca-e402766ca05b	Zulfa Hussen	$2b$10$8ncT.iY4WnuDMr9ddzzg3OrUnKMmabrd8tJDwqsS0V8eRrqBHlCem	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:35.171938+02	2023-06-14 09:49:48.352029+02	0037S000003MlQVQA0
1db60458-8bbf-41f4-95b9-ed8565d18829	Nebila Miftahu	$2b$10$GxxH6.nCBN/71Qc69BR6OOAxcplOi0CAyctJPfBveaF9MyZ7FhOAm	\N	\N	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 09:39:35.907053+02	2023-06-14 09:49:48.387864+02	0037S000003MlQaQAK
b63d02a2-7366-4194-8b69-46f2aff88512	jules ntare	$2b$10$HtH3.mBU8x1hg5ap2aFYduEx9jWer6y0YKbcpO0FEhGpW9PVMLLX2	julesntare@gmail.com	0780674459	afd4cf48-4a81-41bb-939e-1faff919c04d	active	2023-06-14 10:06:44.507893+02	2023-06-14 10:06:44.507893+02	\N
\.


--
-- TOC entry 3405 (class 0 OID 74482)
-- Dependencies: 219
-- Data for Name: tbl_verifications; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tbl_verifications (verification_id, user_id, verification_code, expiry_time, is_verified, "createdAt", "updatedAt") FROM stdin;
\.


--
-- TOC entry 3238 (class 2606 OID 74433)
-- Name: SequelizeMeta SequelizeMeta_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."SequelizeMeta"
    ADD CONSTRAINT "SequelizeMeta_pkey" PRIMARY KEY (name);


--
-- TOC entry 3252 (class 2606 OID 74515)
-- Name: tbl_participants tbl_participants_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_participants
    ADD CONSTRAINT tbl_participants_pkey PRIMARY KEY (participant_id);


--
-- TOC entry 3240 (class 2606 OID 74441)
-- Name: tbl_permissions tbl_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_permissions
    ADD CONSTRAINT tbl_permissions_pkey PRIMARY KEY (perm_id);


--
-- TOC entry 3250 (class 2606 OID 74508)
-- Name: tbl_projects tbl_projects_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_projects
    ADD CONSTRAINT tbl_projects_pkey PRIMARY KEY (project_id);


--
-- TOC entry 3242 (class 2606 OID 74452)
-- Name: tbl_roles tbl_roles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_roles
    ADD CONSTRAINT tbl_roles_pkey PRIMARY KEY (role_id);


--
-- TOC entry 3246 (class 2606 OID 74476)
-- Name: tbl_user_sessions tbl_user_sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_user_sessions
    ADD CONSTRAINT tbl_user_sessions_pkey PRIMARY KEY (session_id);


--
-- TOC entry 3244 (class 2606 OID 74460)
-- Name: tbl_users tbl_users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_users
    ADD CONSTRAINT tbl_users_pkey PRIMARY KEY (user_id);


--
-- TOC entry 3248 (class 2606 OID 74489)
-- Name: tbl_verifications tbl_verifications_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_verifications
    ADD CONSTRAINT tbl_verifications_pkey PRIMARY KEY (verification_id);


--
-- TOC entry 3256 (class 2606 OID 74521)
-- Name: tbl_participants tbl_participants_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_participants
    ADD CONSTRAINT tbl_participants_project_id_fkey FOREIGN KEY (project_id) REFERENCES public.tbl_projects(project_id);


--
-- TOC entry 3257 (class 2606 OID 74516)
-- Name: tbl_participants tbl_participants_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_participants
    ADD CONSTRAINT tbl_participants_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.tbl_users(user_id);


--
-- TOC entry 3254 (class 2606 OID 74477)
-- Name: tbl_user_sessions tbl_user_sessions_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_user_sessions
    ADD CONSTRAINT tbl_user_sessions_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.tbl_users(user_id);


--
-- TOC entry 3253 (class 2606 OID 74461)
-- Name: tbl_users tbl_users_role_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_users
    ADD CONSTRAINT tbl_users_role_id_fkey FOREIGN KEY (role_id) REFERENCES public.tbl_roles(role_id);


--
-- TOC entry 3255 (class 2606 OID 74490)
-- Name: tbl_verifications tbl_verifications_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_verifications
    ADD CONSTRAINT tbl_verifications_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.tbl_users(user_id);


-- Completed on 2023-06-26 12:10:46

--
-- PostgreSQL database dump complete
--

