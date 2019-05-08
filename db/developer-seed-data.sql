--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = public, pg_catalog;

DROP INDEX public.index_user_auths_on_uid;
DROP INDEX public.index_service_alerts_on_display_and_created_at;
DROP INDEX public.index_canvas_site_mailing_lists_on_canvas_site_id;
DROP INDEX public.mailing_list_membership_index;
ALTER TABLE ONLY public.user_roles DROP CONSTRAINT user_roles_pkey;
ALTER TABLE ONLY public.user_auths DROP CONSTRAINT user_auths_pkey;
ALTER TABLE ONLY public.service_alerts DROP CONSTRAINT service_alerts_pkey;
DROP INDEX public.index_oec_course_codes_on_dept_name_and_catalog_id;
DROP INDEX public.index_oec_course_codes_on_dept_code;
ALTER TABLE ONLY public.oec_course_codes DROP CONSTRAINT oec_course_codes_pkey;
ALTER TABLE ONLY public.links DROP CONSTRAINT links_pkey;
ALTER TABLE ONLY public.link_sections DROP CONSTRAINT link_sections_pkey;
ALTER TABLE ONLY public.link_categories DROP CONSTRAINT link_categories_pkey;
ALTER TABLE ONLY public.canvas_site_mailing_lists DROP CONSTRAINT canvas_site_mailing_lists_pkey;
ALTER TABLE ONLY public.canvas_site_mailing_list_members DROP CONSTRAINT canvas_site_mailing_list_members_pkey;
ALTER TABLE public.user_roles ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.user_auths ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.service_alerts ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.oec_course_codes ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.links ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.link_sections ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.link_categories ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.canvas_site_mailing_lists ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.canvas_site_mailing_list_members ALTER COLUMN id DROP DEFAULT;
DROP SEQUENCE public.user_roles_id_seq;
DROP TABLE public.user_roles;
DROP SEQUENCE public.user_auths_id_seq;
DROP TABLE public.user_auths;
DROP SEQUENCE public.service_alerts_id_seq;
DROP TABLE public.service_alerts;
DROP SEQUENCE public.oec_course_codes_id_seq;
DROP TABLE public.oec_course_codes;
DROP TABLE public.links_user_roles;
DROP SEQUENCE public.links_id_seq;
DROP TABLE public.links;
DROP TABLE public.link_sections_links;
DROP SEQUENCE public.link_sections_id_seq;
DROP TABLE public.link_sections;
DROP TABLE public.link_categories_link_sections;
DROP SEQUENCE public.link_categories_id_seq;
DROP TABLE public.link_categories;
DROP SEQUENCE public.canvas_site_mailing_lists_id_seq;
DROP TABLE public.canvas_site_mailing_lists;
DROP SEQUENCE public.canvas_site_mailing_list_members_id_seq;
DROP TABLE public.canvas_site_mailing_list_members;
SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: canvas_site_mailing_list_members; Type: TABLE; Schema: public; Owner: -; Tablespace:
--

CREATE TABLE canvas_site_mailing_list_members (
  id integer NOT NULL,
  mailing_list_id integer NOT NULL,
  first_name character varying(255),
  last_name character varying(255),
  email_address character varying(255) NOT NULL,
  can_send boolean DEFAULT false NOT NULL,
  created_at timestamp without time zone,
  updated_at timestamp without time zone
);

--
-- Name: canvas_site_mailing_list_members_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE canvas_site_mailing_list_members_id_seq
START WITH 1
INCREMENT BY 1
NO MINVALUE
NO MAXVALUE
CACHE 1;


--
-- Name: canvas_site_mailing_list_members_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE canvas_site_mailing_list_members_id_seq OWNED BY canvas_site_mailing_list_members.id;

--
-- Name: canvas_site_mailing_lists; Type: TABLE; Schema: public; Owner: -; Tablespace:
--

CREATE TABLE canvas_site_mailing_lists (
  id integer NOT NULL,
  canvas_site_id character varying(255),
  canvas_site_name character varying(255),
  list_name character varying(255),
  state character varying(255),
  populated_at timestamp without time zone,
  created_at timestamp without time zone,
  updated_at timestamp without time zone,
  members_count integer,
  populate_add_errors integer,
  populate_remove_errors integer,
  type character varying(255)
);

--
-- Name: canvas_site_mailing_lists_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE canvas_site_mailing_lists_id_seq
START WITH 1
INCREMENT BY 1
NO MINVALUE
NO MAXVALUE
CACHE 1;

--
-- Name: canvas_site_mailing_lists_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE canvas_site_mailing_lists_id_seq OWNED BY canvas_site_mailing_lists.id;


--
-- Name: link_categories; Type: TABLE; Schema: public; Owner: -; Tablespace:
--

CREATE TABLE link_categories (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    slug character varying(255) NOT NULL,
    root_level boolean DEFAULT false,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: link_categories_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE link_categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: link_categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE link_categories_id_seq OWNED BY link_categories.id;


--
-- Name: link_categories_link_sections; Type: TABLE; Schema: public; Owner: -; Tablespace:
--

CREATE TABLE link_categories_link_sections (
    link_category_id integer,
    link_section_id integer
);


--
-- Name: link_sections; Type: TABLE; Schema: public; Owner: -; Tablespace:
--

CREATE TABLE link_sections (
    id integer NOT NULL,
    link_root_cat_id integer,
    link_top_cat_id integer,
    link_sub_cat_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: link_sections_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE link_sections_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: link_sections_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE link_sections_id_seq OWNED BY link_sections.id;


--
-- Name: link_sections_links; Type: TABLE; Schema: public; Owner: -; Tablespace:
--

CREATE TABLE link_sections_links (
    link_section_id integer,
    link_id integer
);


--
-- Name: links; Type: TABLE; Schema: public; Owner: -; Tablespace:
--

CREATE TABLE links (
    id integer NOT NULL,
    name character varying(255),
    url character varying(255),
    description character varying(255),
    published boolean DEFAULT true,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: links_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE links_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: links_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE links_id_seq OWNED BY links.id;


--
-- Name: links_user_roles; Type: TABLE; Schema: public; Owner: -; Tablespace:
--

CREATE TABLE links_user_roles (
    link_id integer,
    user_role_id integer
);


--
-- Name: oec_course_codes; Type: TABLE; Schema: public; Owner: -; Tablespace:
--

CREATE TABLE oec_course_codes (
    id integer NOT NULL,
    dept_name character varying(255) NOT NULL,
    catalog_id character varying(255) NOT NULL,
    dept_code character varying(255) NOT NULL,
    include_in_oec boolean NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: oec_course_codes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE oec_course_codes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: oec_course_codes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE oec_course_codes_id_seq OWNED BY oec_course_codes.id;


--
-- Name: service_alerts; Type: TABLE; Schema: public; Owner: -; Tablespace:
--

CREATE TABLE service_alerts (
  id integer NOT NULL,
  title character varying(255) NOT NULL,
  snippet text,
  body text NOT NULL,
  publication_date timestamp without time zone NOT NULL,
  display boolean DEFAULT false NOT NULL,
  splash boolean DEFAULT false NOT NULL,
  created_at timestamp without time zone,
  updated_at timestamp without time zone
);


ALTER TABLE service_alerts OWNER TO calcentral_development;

--
-- Name: service_alerts_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE service_alerts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE service_alerts_id_seq OWNER TO calcentral_development;

--
-- Name: service_alerts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE service_alerts_id_seq OWNED BY service_alerts.id;


--
-- Name: user_auths; Type: TABLE; Schema: public; Owner: -; Tablespace:
--

CREATE TABLE user_auths (
    id integer NOT NULL,
    uid character varying(255) NOT NULL,
    is_superuser boolean DEFAULT false NOT NULL,
    active boolean DEFAULT false NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    is_author boolean DEFAULT false NOT NULL,
    is_viewer boolean DEFAULT false NOT NULL
);


--
-- Name: user_auths_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE user_auths_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: user_auths_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE user_auths_id_seq OWNED BY user_auths.id;


--
-- Name: user_roles; Type: TABLE; Schema: public; Owner: -; Tablespace:
--

CREATE TABLE user_roles (
    id integer NOT NULL,
    name character varying(255),
    slug character varying(255)
);


--
-- Name: user_roles_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE user_roles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: user_roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE user_roles_id_seq OWNED BY user_roles.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY canvas_site_mailing_list_members ALTER COLUMN id SET DEFAULT nextval('canvas_site_mailing_list_members_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY canvas_site_mailing_lists ALTER COLUMN id SET DEFAULT nextval('canvas_site_mailing_lists_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY link_categories ALTER COLUMN id SET DEFAULT nextval('link_categories_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY link_sections ALTER COLUMN id SET DEFAULT nextval('link_sections_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY links ALTER COLUMN id SET DEFAULT nextval('links_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY oec_course_codes ALTER COLUMN id SET DEFAULT nextval('oec_course_codes_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: calcentral_development
--

ALTER TABLE ONLY service_alerts ALTER COLUMN id SET DEFAULT nextval('service_alerts_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_auths ALTER COLUMN id SET DEFAULT nextval('user_auths_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_roles ALTER COLUMN id SET DEFAULT nextval('user_roles_id_seq'::regclass);


--
-- Data for Name: link_categories; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO link_categories VALUES (839, 'Academic', 'academic', true, '2015-08-21 00:19:34.291', '2015-08-21 00:19:34.291');
INSERT INTO link_categories VALUES (840, 'Academic Departments', 'academicdepartments', false, '2015-08-21 00:19:34.303', '2015-08-21 00:19:34.303');
INSERT INTO link_categories VALUES (841, 'Academic Planning', 'academicplanning', false, '2015-08-21 00:19:34.31', '2015-08-21 00:19:34.31');
INSERT INTO link_categories VALUES (842, 'Classes', 'classes', false, '2015-08-21 00:19:34.317', '2015-08-21 00:19:34.317');
INSERT INTO link_categories VALUES (843, 'Faculty', 'faculty', false, '2015-08-21 00:19:34.324', '2015-08-21 00:19:34.324');
INSERT INTO link_categories VALUES (844, 'Staff Learning', 'stafflearning', false, '2015-08-21 00:19:34.332', '2015-08-21 00:19:34.332');
INSERT INTO link_categories VALUES (845, 'Administrative', 'administrative', true, '2015-08-21 00:19:34.339', '2015-08-21 00:19:34.339');
INSERT INTO link_categories VALUES (846, 'Campus Departments', 'campusdepartments', false, '2015-08-21 00:19:34.346', '2015-08-21 00:19:34.346');
INSERT INTO link_categories VALUES (847, 'Communication & Collaboration', 'communicationcollaboration', false, '2015-08-21 00:19:34.354', '2015-08-21 00:19:34.354');
INSERT INTO link_categories VALUES (848, 'Policies & Procedures', 'policiesproceedures', false, '2015-08-21 00:19:34.361', '2015-08-21 00:19:34.361');
INSERT INTO link_categories VALUES (849, 'Shared Service Center', 'sharedservices', false, '2015-08-21 00:19:34.368', '2015-08-21 00:19:34.368');
INSERT INTO link_categories VALUES (850, 'Tools & Resources', 'toolsresources', false, '2015-08-21 00:19:34.376', '2015-08-21 00:19:34.376');
INSERT INTO link_categories VALUES (851, 'Campus Life', 'campus life', true, '2015-08-21 00:19:34.383', '2015-08-21 00:19:34.383');
INSERT INTO link_categories VALUES (852, 'Community', 'community', false, '2015-08-21 00:19:34.39', '2015-08-21 00:19:34.39');
INSERT INTO link_categories VALUES (853, 'Getting Around', 'gettingaround', false, '2015-08-21 00:19:34.398', '2015-08-21 00:19:34.398');
INSERT INTO link_categories VALUES (854, 'Recreation & Entertainment', 'recreationentertainment', false, '2015-08-21 00:19:34.405', '2015-08-21 00:19:34.405');
INSERT INTO link_categories VALUES (855, 'Safety & Emergency Information', 'safetyemergencyinfo', false, '2015-08-21 00:19:34.412', '2015-08-21 00:19:34.412');
INSERT INTO link_categories VALUES (856, 'Student Engagement', 'studentgroups', false, '2015-08-21 00:19:34.419', '2015-08-21 00:19:34.419');
INSERT INTO link_categories VALUES (857, 'Support Services', 'supportservices', false, '2015-08-21 00:19:34.426', '2015-08-21 00:19:34.426');
INSERT INTO link_categories VALUES (858, 'Personal', 'personal', true, '2015-08-21 00:19:34.433', '2015-08-21 00:19:34.433');
INSERT INTO link_categories VALUES (859, 'Career', 'career', false, '2015-08-21 00:19:34.44', '2015-08-21 00:19:34.44');
INSERT INTO link_categories VALUES (860, 'Finances', 'finances', false, '2015-08-21 00:19:34.447', '2015-08-21 00:19:34.447');
INSERT INTO link_categories VALUES (861, 'Food & Housing', 'foodandhousing', false, '2015-08-21 00:19:34.454', '2015-08-21 00:19:34.454');
INSERT INTO link_categories VALUES (862, 'HR & Benefits', 'hrbenefits', false, '2015-08-21 00:19:34.461', '2015-08-21 00:19:34.461');
INSERT INTO link_categories VALUES (863, 'Wellness', 'wellness', false, '2015-08-21 00:19:34.468', '2015-08-21 00:19:34.468');
INSERT INTO link_categories VALUES (864, 'Parking & Transportation', 'parking & transportation', false, '2015-08-21 00:19:34.479', '2015-08-21 00:19:34.479');
INSERT INTO link_categories VALUES (865, 'Calendar', 'calendar', false, '2015-08-21 00:19:34.631', '2015-08-21 00:19:34.631');
INSERT INTO link_categories VALUES (866, 'Policies', 'policies', false, '2015-08-21 00:19:34.802', '2015-08-21 00:19:34.802');
INSERT INTO link_categories VALUES (867, 'Resources', 'resources', false, '2015-08-21 00:19:34.857', '2015-08-21 00:19:34.857');
INSERT INTO link_categories VALUES (868, 'Administrative and Other', 'administrative and other', false, '2015-08-21 00:19:34.903', '2015-08-21 00:19:34.903');
INSERT INTO link_categories VALUES (869, 'Security & Access', 'security & access', false, '2015-08-21 00:19:34.961', '2015-08-21 00:19:34.961');
INSERT INTO link_categories VALUES (870, 'Student Government', 'student government', false, '2015-08-21 00:19:35.017', '2015-08-21 00:19:35.017');
INSERT INTO link_categories VALUES (871, 'Benefits', 'benefits', false, '2015-08-21 00:19:35.061', '2015-08-21 00:19:35.061');
INSERT INTO link_categories VALUES (872, 'Students', 'students', false, '2015-08-21 00:19:35.11', '2015-08-21 00:19:35.11');
INSERT INTO link_categories VALUES (873, 'Financial', 'financial', false, '2015-08-21 00:19:35.156', '2015-08-21 00:19:35.156');
INSERT INTO link_categories VALUES (874, 'bConnected Tools', 'bconnected tools', false, '2015-08-21 00:19:35.205', '2015-08-21 00:19:35.205');
INSERT INTO link_categories VALUES (875, 'Academic Record', 'academic record', false, '2015-08-21 00:19:35.375', '2015-08-21 00:19:35.375');
INSERT INTO link_categories VALUES (876, 'Purchasing', 'purchasing', false, '2015-08-21 00:19:35.427', '2015-08-21 00:19:35.427');
INSERT INTO link_categories VALUES (877, 'Night Safety', 'night safety', false, '2015-08-21 00:19:35.478', '2015-08-21 00:19:35.478');
INSERT INTO link_categories VALUES (878, 'Planning', 'planning', false, '2015-08-21 00:19:35.53', '2015-08-21 00:19:35.53');
INSERT INTO link_categories VALUES (879, 'Jobs', 'jobs', false, '2015-08-21 00:19:35.581', '2015-08-21 00:19:35.581');
INSERT INTO link_categories VALUES (880, 'Research', 'research', false, '2015-08-21 00:19:35.629', '2015-08-21 00:19:35.629');
INSERT INTO link_categories VALUES (881, 'Points of Interest', 'points of interest', false, '2015-08-21 00:19:35.703', '2015-08-21 00:19:35.703');
INSERT INTO link_categories VALUES (882, 'Housing', 'housing', false, '2015-08-21 00:19:35.791', '2015-08-21 00:19:35.791');
INSERT INTO link_categories VALUES (883, 'Asset Management', 'asset management', false, '2015-08-21 00:19:35.833', '2015-08-21 00:19:35.833');
INSERT INTO link_categories VALUES (884, 'Billing & Payments', 'billing & payments', false, '2015-08-21 00:19:35.907', '2015-08-21 00:19:35.907');
INSERT INTO link_categories VALUES (885, 'Staff Portal', 'staff portal', false, '2015-08-21 00:19:35.95', '2015-08-21 00:19:35.95');
INSERT INTO link_categories VALUES (886, 'Learning Resources', 'learning resources', false, '2015-08-21 00:19:36.063', '2015-08-21 00:19:36.063');
INSERT INTO link_categories VALUES (887, 'Collaboration Tools', 'collaboration tools', false, '2015-08-21 00:19:36.11', '2015-08-21 00:19:36.11');
INSERT INTO link_categories VALUES (888, 'Tools', 'tools', false, '2015-08-21 00:19:36.231', '2015-08-21 00:19:36.231');
INSERT INTO link_categories VALUES (889, 'Campus Dining', 'campus dining', false, '2015-08-21 00:19:36.3', '2015-08-21 00:19:36.3');
INSERT INTO link_categories VALUES (890, 'Analysis & Reporting', 'analysis & reporting', false, '2015-08-21 00:19:36.363', '2015-08-21 00:19:36.363');
INSERT INTO link_categories VALUES (891, 'Activities', 'activities', false, '2015-08-21 00:19:36.408', '2015-08-21 00:19:36.408');
INSERT INTO link_categories VALUES (892, 'Student Advising', 'student advising', false, '2015-08-21 00:19:36.635', '2015-08-21 00:19:36.635');
INSERT INTO link_categories VALUES (893, 'Your Questions Answered Here', 'your questions answered here', false, '2015-08-21 00:19:36.654', '2015-08-21 00:19:36.654');
INSERT INTO link_categories VALUES (894, 'Athletics', 'athletics', false, '2015-08-21 00:19:36.739', '2015-08-21 00:19:36.739');
INSERT INTO link_categories VALUES (895, 'Student Organizations', 'student organizations', false, '2015-08-21 00:19:36.828', '2015-08-21 00:19:36.828');
INSERT INTO link_categories VALUES (896, 'Campus Messaging', 'campus messaging', false, '2015-08-21 00:19:36.965', '2015-08-21 00:19:36.965');
INSERT INTO link_categories VALUES (897, 'Budget', 'budget', false, '2015-08-21 00:19:37.043', '2015-08-21 00:19:37.043');
INSERT INTO link_categories VALUES (898, 'Payroll', 'payroll', false, '2015-08-21 00:19:37.118', '2015-08-21 00:19:37.118');
INSERT INTO link_categories VALUES (899, 'Philanthropy & Public Service', 'philanthropy & public service', false, '2015-08-21 00:19:37.165', '2015-08-21 00:19:37.165');
INSERT INTO link_categories VALUES (900, 'Directory', 'directory', false, '2015-08-21 00:19:37.273', '2015-08-21 00:19:37.273');
INSERT INTO link_categories VALUES (901, 'Map', 'map', false, '2015-08-21 00:19:37.375', '2015-08-21 00:19:37.375');
INSERT INTO link_categories VALUES (902, 'Overview', 'overview', false, '2015-08-21 00:19:37.426', '2015-08-21 00:19:37.426');
INSERT INTO link_categories VALUES (903, 'Campus Health Center', 'campus health center', false, '2015-08-21 00:19:37.507', '2015-08-21 00:19:37.507');
INSERT INTO link_categories VALUES (904, 'Family', 'family', false, '2015-08-21 00:19:37.695', '2015-08-21 00:19:37.695');
INSERT INTO link_categories VALUES (905, 'Staff Support Services', 'staff support services', false, '2015-08-21 00:19:37.725', '2015-08-21 00:19:37.725');
INSERT INTO link_categories VALUES (906, 'Classroom Technology', 'classroom technology', false, '2015-08-21 00:19:37.847', '2015-08-21 00:19:37.847');
INSERT INTO link_categories VALUES (907, 'Computing', 'computing', false, '2015-08-21 00:19:38.195', '2015-08-21 00:19:38.195');
INSERT INTO link_categories VALUES (908, 'Emergency Preparedness', 'emergency preparedness', false, '2015-08-21 00:19:38.346', '2015-08-21 00:19:38.346');
INSERT INTO link_categories VALUES (909, 'Health & Safety', 'health & safety', false, '2015-08-21 00:19:38.432', '2015-08-21 00:19:38.432');
INSERT INTO link_categories VALUES (910, 'Employer & Employee', 'employer & employee', false, '2015-08-21 00:19:38.509', '2015-08-21 00:19:38.509');
INSERT INTO link_categories VALUES (911, 'News & Events', 'news & events', false, '2015-08-21 00:19:38.556', '2015-08-21 00:19:38.556');
INSERT INTO link_categories VALUES (912, 'Financial Assistance', 'financial assistance', false, '2015-08-21 00:19:38.703', '2015-08-21 00:19:38.703');
INSERT INTO link_categories VALUES (913, 'Graduate', 'graduate', false, '2015-08-21 00:19:38.909', '2015-08-21 00:19:38.909');
INSERT INTO link_categories VALUES (914, 'Student Employees', 'student employees', false, '2015-08-21 00:19:39.004', '2015-08-21 00:19:39.004');
INSERT INTO link_categories VALUES (915, 'Leaving Cal?', 'leaving cal?', false, '2015-08-21 00:19:39.046', '2015-08-21 00:19:39.046');
INSERT INTO link_categories VALUES (916, 'Human Resources', 'human resources', false, '2015-08-21 00:19:39.128', '2015-08-21 00:19:39.128');
INSERT INTO link_categories VALUES (917, 'Library', 'library', false, '2015-08-21 00:19:39.515', '2015-08-21 00:19:39.515');
INSERT INTO link_categories VALUES (918, 'Campus Mail', 'campus mail', false, '2015-08-21 00:19:39.605', '2015-08-21 00:19:39.605');
INSERT INTO link_categories VALUES (919, 'Professional Development', 'professional development', false, '2015-08-21 00:19:39.941', '2015-08-21 00:19:39.941');
INSERT INTO link_categories VALUES (920, 'My Information', 'my information', false, '2015-08-21 00:19:40.076', '2015-08-21 00:19:40.076');
INSERT INTO link_categories VALUES (921, 'Sports & Recreation', 'sports & recreation', false, '2015-08-21 00:19:40.185', '2015-08-21 00:19:40.185');
INSERT INTO link_categories VALUES (922, 'Police', 'police', false, '2015-08-21 00:19:40.228', '2015-08-21 00:19:40.228');
INSERT INTO link_categories VALUES (923, 'Network & Computing', 'network & computing', false, '2015-08-21 00:19:40.539', '2015-08-21 00:19:40.539');
INSERT INTO link_categories VALUES (924, 'Retirement', 'retirement', false, '2015-08-21 00:19:40.619', '2015-08-21 00:19:40.619');
INSERT INTO link_categories VALUES (925, 'Summer Programs', 'summer programs', false, '2015-08-21 00:19:40.779', '2015-08-21 00:19:40.779');
INSERT INTO link_categories VALUES (926, 'Conflict Resolution', 'conflict resolution', false, '2015-08-21 00:19:40.981', '2015-08-21 00:19:40.981');
INSERT INTO link_categories VALUES (927, 'Service Requests', 'service requests', false, '2015-08-21 00:19:41.202', '2015-08-21 00:19:41.202');
INSERT INTO link_categories VALUES (928, 'Student Services', 'student services', false, '2015-08-21 00:19:41.433', '2015-08-21 00:19:41.433');
INSERT INTO link_categories VALUES (929, 'Travel & Entertainment', 'travel & entertainment', false, '2015-08-21 00:19:41.545', '2015-08-21 00:19:41.545');
INSERT INTO link_categories VALUES (930, 'Social Media', 'social media', false, '2015-08-21 00:19:41.593', '2015-08-21 00:19:41.593');
INSERT INTO link_categories VALUES (931, 'News & Information', 'news & information', false, '2015-08-21 00:19:41.72', '2015-08-21 00:19:41.72');


--
-- Name: link_categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('link_categories_id_seq', 931, true);


--
-- Data for Name: link_sections; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO link_sections VALUES (681, 851, 853, 864, '2015-08-21 00:19:34.527', '2015-08-21 00:19:34.527');
INSERT INTO link_sections VALUES (682, 839, 841, 865, '2015-08-21 00:19:34.644', '2015-08-21 00:19:34.644');
INSERT INTO link_sections VALUES (683, 839, 840, 839, '2015-08-21 00:19:34.758', '2015-08-21 00:19:34.758');
INSERT INTO link_sections VALUES (684, 845, 848, 866, '2015-08-21 00:19:34.814', '2015-08-21 00:19:34.814');
INSERT INTO link_sections VALUES (685, 839, 843, 867, '2015-08-21 00:19:34.869', '2015-08-21 00:19:34.869');
INSERT INTO link_sections VALUES (686, 845, 846, 868, '2015-08-21 00:19:34.915', '2015-08-21 00:19:34.915');
INSERT INTO link_sections VALUES (687, 845, 850, 869, '2015-08-21 00:19:34.974', '2015-08-21 00:19:34.974');
INSERT INTO link_sections VALUES (688, 851, 856, 870, '2015-08-21 00:19:35.028', '2015-08-21 00:19:35.028');
INSERT INTO link_sections VALUES (689, 858, 862, 871, '2015-08-21 00:19:35.072', '2015-08-21 00:19:35.072');
INSERT INTO link_sections VALUES (690, 851, 857, 872, '2015-08-21 00:19:35.123', '2015-08-21 00:19:35.123');
INSERT INTO link_sections VALUES (691, 845, 850, 873, '2015-08-21 00:19:35.168', '2015-08-21 00:19:35.168');
INSERT INTO link_sections VALUES (692, 845, 847, 874, '2015-08-21 00:19:35.216', '2015-08-21 00:19:35.216');
INSERT INTO link_sections VALUES (693, 839, 842, 842, '2015-08-21 00:19:35.3', '2015-08-21 00:19:35.3');
INSERT INTO link_sections VALUES (694, 839, 841, 875, '2015-08-21 00:19:35.386', '2015-08-21 00:19:35.386');
INSERT INTO link_sections VALUES (695, 845, 850, 876, '2015-08-21 00:19:35.438', '2015-08-21 00:19:35.438');
INSERT INTO link_sections VALUES (696, 851, 855, 877, '2015-08-21 00:19:35.489', '2015-08-21 00:19:35.489');
INSERT INTO link_sections VALUES (697, 839, 841, 878, '2015-08-21 00:19:35.541', '2015-08-21 00:19:35.541');
INSERT INTO link_sections VALUES (698, 858, 859, 879, '2015-08-21 00:19:35.592', '2015-08-21 00:19:35.592');
INSERT INTO link_sections VALUES (699, 839, 840, 880, '2015-08-21 00:19:35.639', '2015-08-21 00:19:35.639');
INSERT INTO link_sections VALUES (700, 851, 853, 881, '2015-08-21 00:19:35.714', '2015-08-21 00:19:35.714');
INSERT INTO link_sections VALUES (701, 858, 861, 882, '2015-08-21 00:19:35.801', '2015-08-21 00:19:35.801');
INSERT INTO link_sections VALUES (702, 845, 850, 883, '2015-08-21 00:19:35.844', '2015-08-21 00:19:35.844');
INSERT INTO link_sections VALUES (703, 858, 860, 884, '2015-08-21 00:19:35.918', '2015-08-21 00:19:35.918');
INSERT INTO link_sections VALUES (704, 845, 850, 885, '2015-08-21 00:19:35.961', '2015-08-21 00:19:35.961');
INSERT INTO link_sections VALUES (705, 839, 842, 886, '2015-08-21 00:19:36.075', '2015-08-21 00:19:36.075');
INSERT INTO link_sections VALUES (706, 845, 847, 887, '2015-08-21 00:19:36.121', '2015-08-21 00:19:36.121');
INSERT INTO link_sections VALUES (707, 839, 841, 842, '2015-08-21 00:19:36.166', '2015-08-21 00:19:36.166');
INSERT INTO link_sections VALUES (708, 839, 843, 888, '2015-08-21 00:19:36.241', '2015-08-21 00:19:36.241');
INSERT INTO link_sections VALUES (709, 858, 861, 889, '2015-08-21 00:19:36.31', '2015-08-21 00:19:36.31');
INSERT INTO link_sections VALUES (710, 845, 850, 890, '2015-08-21 00:19:36.374', '2015-08-21 00:19:36.374');
INSERT INTO link_sections VALUES (711, 851, 854, 891, '2015-08-21 00:19:36.419', '2015-08-21 00:19:36.419');
INSERT INTO link_sections VALUES (712, 851, 854, 881, '2015-08-21 00:19:36.463', '2015-08-21 00:19:36.463');
INSERT INTO link_sections VALUES (713, 851, 856, 891, '2015-08-21 00:19:36.603', '2015-08-21 00:19:36.603');
INSERT INTO link_sections VALUES (714, 839, 841, 892, '2015-08-21 00:19:36.645', '2015-08-21 00:19:36.645');
INSERT INTO link_sections VALUES (715, 858, 860, 893, '2015-08-21 00:19:36.664', '2015-08-21 00:19:36.664');
INSERT INTO link_sections VALUES (716, 851, 854, 894, '2015-08-21 00:19:36.75', '2015-08-21 00:19:36.75');
INSERT INTO link_sections VALUES (717, 851, 856, 895, '2015-08-21 00:19:36.838', '2015-08-21 00:19:36.838');
INSERT INTO link_sections VALUES (718, 845, 847, 896, '2015-08-21 00:19:36.976', '2015-08-21 00:19:36.976');
INSERT INTO link_sections VALUES (719, 845, 850, 897, '2015-08-21 00:19:37.053', '2015-08-21 00:19:37.053');
INSERT INTO link_sections VALUES (720, 845, 850, 898, '2015-08-21 00:19:37.13', '2015-08-21 00:19:37.13');
INSERT INTO link_sections VALUES (721, 851, 852, 899, '2015-08-21 00:19:37.175', '2015-08-21 00:19:37.175');
INSERT INTO link_sections VALUES (722, 851, 852, 900, '2015-08-21 00:19:37.284', '2015-08-21 00:19:37.284');
INSERT INTO link_sections VALUES (723, 851, 853, 901, '2015-08-21 00:19:37.386', '2015-08-21 00:19:37.386');
INSERT INTO link_sections VALUES (724, 845, 849, 902, '2015-08-21 00:19:37.437', '2015-08-21 00:19:37.437');
INSERT INTO link_sections VALUES (725, 858, 863, 903, '2015-08-21 00:19:37.518', '2015-08-21 00:19:37.518');
INSERT INTO link_sections VALUES (726, 858, 861, 904, '2015-08-21 00:19:37.706', '2015-08-21 00:19:37.706');
INSERT INTO link_sections VALUES (727, 858, 862, 904, '2015-08-21 00:19:37.718', '2015-08-21 00:19:37.718');
INSERT INTO link_sections VALUES (728, 858, 863, 905, '2015-08-21 00:19:37.736', '2015-08-21 00:19:37.736');
INSERT INTO link_sections VALUES (729, 839, 843, 906, '2015-08-21 00:19:37.86', '2015-08-21 00:19:37.86');
INSERT INTO link_sections VALUES (730, 845, 850, 907, '2015-08-21 00:19:38.206', '2015-08-21 00:19:38.206');
INSERT INTO link_sections VALUES (731, 851, 855, 908, '2015-08-21 00:19:38.357', '2015-08-21 00:19:38.357');
INSERT INTO link_sections VALUES (732, 839, 844, 909, '2015-08-21 00:19:38.443', '2015-08-21 00:19:38.443');
INSERT INTO link_sections VALUES (733, 845, 848, 910, '2015-08-21 00:19:38.52', '2015-08-21 00:19:38.52');
INSERT INTO link_sections VALUES (734, 851, 852, 911, '2015-08-21 00:19:38.567', '2015-08-21 00:19:38.567');
INSERT INTO link_sections VALUES (735, 858, 860, 912, '2015-08-21 00:19:38.714', '2015-08-21 00:19:38.714');
INSERT INTO link_sections VALUES (736, 839, 840, 913, '2015-08-21 00:19:38.92', '2015-08-21 00:19:38.92');
INSERT INTO link_sections VALUES (737, 858, 859, 914, '2015-08-21 00:19:39.014', '2015-08-21 00:19:39.014');
INSERT INTO link_sections VALUES (738, 858, 860, 915, '2015-08-21 00:19:39.057', '2015-08-21 00:19:39.057');
INSERT INTO link_sections VALUES (739, 845, 850, 916, '2015-08-21 00:19:39.139', '2015-08-21 00:19:39.139');
INSERT INTO link_sections VALUES (740, 839, 844, 902, '2015-08-21 00:19:39.479', '2015-08-21 00:19:39.479');
INSERT INTO link_sections VALUES (741, 839, 840, 917, '2015-08-21 00:19:39.527', '2015-08-21 00:19:39.527');
INSERT INTO link_sections VALUES (742, 845, 850, 918, '2015-08-21 00:19:39.618', '2015-08-21 00:19:39.618');
INSERT INTO link_sections VALUES (743, 839, 844, 919, '2015-08-21 00:19:39.951', '2015-08-21 00:19:39.951');
INSERT INTO link_sections VALUES (744, 858, 862, 920, '2015-08-21 00:19:40.087', '2015-08-21 00:19:40.087');
INSERT INTO link_sections VALUES (745, 851, 854, 921, '2015-08-21 00:19:40.196', '2015-08-21 00:19:40.196');
INSERT INTO link_sections VALUES (746, 851, 855, 922, '2015-08-21 00:19:40.239', '2015-08-21 00:19:40.239');
INSERT INTO link_sections VALUES (747, 858, 861, 923, '2015-08-21 00:19:40.549', '2015-08-21 00:19:40.549');
INSERT INTO link_sections VALUES (748, 858, 862, 924, '2015-08-21 00:19:40.63', '2015-08-21 00:19:40.63');
INSERT INTO link_sections VALUES (749, 858, 860, 925, '2015-08-21 00:19:40.789', '2015-08-21 00:19:40.789');
INSERT INTO link_sections VALUES (750, 858, 862, 926, '2015-08-21 00:19:40.992', '2015-08-21 00:19:40.992');
INSERT INTO link_sections VALUES (751, 845, 849, 927, '2015-08-21 00:19:41.213', '2015-08-21 00:19:41.213');
INSERT INTO link_sections VALUES (752, 845, 846, 928, '2015-08-21 00:19:41.444', '2015-08-21 00:19:41.444');
INSERT INTO link_sections VALUES (753, 845, 850, 929, '2015-08-21 00:19:41.557', '2015-08-21 00:19:41.557');
INSERT INTO link_sections VALUES (754, 851, 852, 930, '2015-08-21 00:19:41.614', '2015-08-21 00:19:41.614');
INSERT INTO link_sections VALUES (755, 858, 863, 931, '2015-08-21 00:19:41.731', '2015-08-21 00:19:41.731');


--
-- Name: link_sections_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('link_sections_id_seq', 755, true);


--
-- Data for Name: link_sections_links; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO link_sections_links VALUES (681, 1634);
INSERT INTO link_sections_links VALUES (682, 1635);
INSERT INTO link_sections_links VALUES (682, 1636);
INSERT INTO link_sections_links VALUES (683, 1637);
INSERT INTO link_sections_links VALUES (684, 1638);
INSERT INTO link_sections_links VALUES (685, 1639);
INSERT INTO link_sections_links VALUES (686, 1640);
INSERT INTO link_sections_links VALUES (687, 1641);
INSERT INTO link_sections_links VALUES (688, 1642);
INSERT INTO link_sections_links VALUES (689, 1643);
INSERT INTO link_sections_links VALUES (690, 1644);
INSERT INTO link_sections_links VALUES (691, 1645);
INSERT INTO link_sections_links VALUES (692, 1646);
INSERT INTO link_sections_links VALUES (692, 1647);
INSERT INTO link_sections_links VALUES (693, 1648);
INSERT INTO link_sections_links VALUES (692, 1649);
INSERT INTO link_sections_links VALUES (694, 1650);
INSERT INTO link_sections_links VALUES (695, 1651);
INSERT INTO link_sections_links VALUES (696, 1652);
INSERT INTO link_sections_links VALUES (697, 1653);
INSERT INTO link_sections_links VALUES (698, 1654);
INSERT INTO link_sections_links VALUES (699, 1655);
INSERT INTO link_sections_links VALUES (700, 1656);
INSERT INTO link_sections_links VALUES (686, 1657);
INSERT INTO link_sections_links VALUES (701, 1658);
INSERT INTO link_sections_links VALUES (702, 1659);
INSERT INTO link_sections_links VALUES (691, 1660);
INSERT INTO link_sections_links VALUES (703, 1661);
INSERT INTO link_sections_links VALUES (704, 1662);
INSERT INTO link_sections_links VALUES (695, 1663);
INSERT INTO link_sections_links VALUES (692, 1664);
INSERT INTO link_sections_links VALUES (705, 1665);
INSERT INTO link_sections_links VALUES (706, 1666);
INSERT INTO link_sections_links VALUES (707, 1667);
INSERT INTO link_sections_links VALUES (693, 1667);
INSERT INTO link_sections_links VALUES (706, 1667);
INSERT INTO link_sections_links VALUES (708, 1668);
INSERT INTO link_sections_links VALUES (685, 1669);
INSERT INTO link_sections_links VALUES (709, 1670);
INSERT INTO link_sections_links VALUES (687, 1670);
INSERT INTO link_sections_links VALUES (710, 1671);
INSERT INTO link_sections_links VALUES (711, 1672);
INSERT INTO link_sections_links VALUES (712, 1673);
INSERT INTO link_sections_links VALUES (712, 1674);
INSERT INTO link_sections_links VALUES (701, 1675);
INSERT INTO link_sections_links VALUES (713, 1676);
INSERT INTO link_sections_links VALUES (714, 1677);
INSERT INTO link_sections_links VALUES (715, 1677);
INSERT INTO link_sections_links VALUES (712, 1678);
INSERT INTO link_sections_links VALUES (716, 1679);
INSERT INTO link_sections_links VALUES (709, 1680);
INSERT INTO link_sections_links VALUES (701, 1681);
INSERT INTO link_sections_links VALUES (717, 1681);
INSERT INTO link_sections_links VALUES (717, 1682);
INSERT INTO link_sections_links VALUES (698, 1683);
INSERT INTO link_sections_links VALUES (692, 1684);
INSERT INTO link_sections_links VALUES (718, 1685);
INSERT INTO link_sections_links VALUES (687, 1686);
INSERT INTO link_sections_links VALUES (719, 1687);
INSERT INTO link_sections_links VALUES (706, 1688);
INSERT INTO link_sections_links VALUES (720, 1689);
INSERT INTO link_sections_links VALUES (721, 1690);
INSERT INTO link_sections_links VALUES (705, 1691);
INSERT INTO link_sections_links VALUES (691, 1692);
INSERT INTO link_sections_links VALUES (722, 1693);
INSERT INTO link_sections_links VALUES (686, 1694);
INSERT INTO link_sections_links VALUES (723, 1695);
INSERT INTO link_sections_links VALUES (724, 1696);
INSERT INTO link_sections_links VALUES (681, 1697);
INSERT INTO link_sections_links VALUES (725, 1698);
INSERT INTO link_sections_links VALUES (698, 1699);
INSERT INTO link_sections_links VALUES (698, 1700);
INSERT INTO link_sections_links VALUES (698, 1701);
INSERT INTO link_sections_links VALUES (698, 1702);
INSERT INTO link_sections_links VALUES (698, 1703);
INSERT INTO link_sections_links VALUES (726, 1704);
INSERT INTO link_sections_links VALUES (727, 1704);
INSERT INTO link_sections_links VALUES (728, 1704);
INSERT INTO link_sections_links VALUES (697, 1705);
INSERT INTO link_sections_links VALUES (681, 1706);
INSERT INTO link_sections_links VALUES (729, 1707);
INSERT INTO link_sections_links VALUES (683, 1708);
INSERT INTO link_sections_links VALUES (684, 1709);
INSERT INTO link_sections_links VALUES (690, 1710);
INSERT INTO link_sections_links VALUES (725, 1710);
INSERT INTO link_sections_links VALUES (685, 1711);
INSERT INTO link_sections_links VALUES (697, 1712);
INSERT INTO link_sections_links VALUES (697, 1713);
INSERT INTO link_sections_links VALUES (707, 1714);
INSERT INTO link_sections_links VALUES (693, 1714);
INSERT INTO link_sections_links VALUES (690, 1715);
INSERT INTO link_sections_links VALUES (730, 1716);
INSERT INTO link_sections_links VALUES (703, 1717);
INSERT INTO link_sections_links VALUES (714, 1718);
INSERT INTO link_sections_links VALUES (707, 1719);
INSERT INTO link_sections_links VALUES (693, 1719);
INSERT INTO link_sections_links VALUES (731, 1720);
INSERT INTO link_sections_links VALUES (731, 1721);
INSERT INTO link_sections_links VALUES (732, 1722);
INSERT INTO link_sections_links VALUES (686, 1723);
INSERT INTO link_sections_links VALUES (733, 1724);
INSERT INTO link_sections_links VALUES (734, 1725);
INSERT INTO link_sections_links VALUES (683, 1726);
INSERT INTO link_sections_links VALUES (686, 1727);
INSERT INTO link_sections_links VALUES (685, 1728);
INSERT INTO link_sections_links VALUES (735, 1729);
INSERT INTO link_sections_links VALUES (735, 1730);
INSERT INTO link_sections_links VALUES (697, 1731);
INSERT INTO link_sections_links VALUES (690, 1732);
INSERT INTO link_sections_links VALUES (728, 1732);
INSERT INTO link_sections_links VALUES (721, 1733);
INSERT INTO link_sections_links VALUES (688, 1734);
INSERT INTO link_sections_links VALUES (736, 1735);
INSERT INTO link_sections_links VALUES (735, 1736);
INSERT INTO link_sections_links VALUES (737, 1737);
INSERT INTO link_sections_links VALUES (738, 1738);
INSERT INTO link_sections_links VALUES (703, 1739);
INSERT INTO link_sections_links VALUES (725, 1739);
INSERT INTO link_sections_links VALUES (739, 1740);
INSERT INTO link_sections_links VALUES (739, 1741);
INSERT INTO link_sections_links VALUES (730, 1742);
INSERT INTO link_sections_links VALUES (701, 1743);
INSERT INTO link_sections_links VALUES (730, 1744);
INSERT INTO link_sections_links VALUES (730, 1745);
INSERT INTO link_sections_links VALUES (705, 1746);
INSERT INTO link_sections_links VALUES (734, 1747);
INSERT INTO link_sections_links VALUES (712, 1747);
INSERT INTO link_sections_links VALUES (732, 1748);
INSERT INTO link_sections_links VALUES (713, 1749);
INSERT INTO link_sections_links VALUES (740, 1750);
INSERT INTO link_sections_links VALUES (741, 1751);
INSERT INTO link_sections_links VALUES (705, 1751);
INSERT INTO link_sections_links VALUES (701, 1752);
INSERT INTO link_sections_links VALUES (742, 1753);
INSERT INTO link_sections_links VALUES (690, 1754);
INSERT INTO link_sections_links VALUES (735, 1755);
INSERT INTO link_sections_links VALUES (685, 1756);
INSERT INTO link_sections_links VALUES (690, 1757);
INSERT INTO link_sections_links VALUES (734, 1758);
INSERT INTO link_sections_links VALUES (686, 1759);
INSERT INTO link_sections_links VALUES (694, 1760);
INSERT INTO link_sections_links VALUES (714, 1761);
INSERT INTO link_sections_links VALUES (730, 1762);
INSERT INTO link_sections_links VALUES (743, 1763);
INSERT INTO link_sections_links VALUES (681, 1764);
INSERT INTO link_sections_links VALUES (703, 1765);
INSERT INTO link_sections_links VALUES (720, 1766);
INSERT INTO link_sections_links VALUES (744, 1767);
INSERT INTO link_sections_links VALUES (744, 1768);
INSERT INTO link_sections_links VALUES (733, 1769);
INSERT INTO link_sections_links VALUES (745, 1770);
INSERT INTO link_sections_links VALUES (746, 1771);
INSERT INTO link_sections_links VALUES (684, 1772);
INSERT INTO link_sections_links VALUES (721, 1773);
INSERT INTO link_sections_links VALUES (695, 1774);
INSERT INTO link_sections_links VALUES (745, 1775);
INSERT INTO link_sections_links VALUES (703, 1776);
INSERT INTO link_sections_links VALUES (699, 1777);
INSERT INTO link_sections_links VALUES (705, 1778);
INSERT INTO link_sections_links VALUES (701, 1779);
INSERT INTO link_sections_links VALUES (747, 1780);
INSERT INTO link_sections_links VALUES (730, 1780);
INSERT INTO link_sections_links VALUES (690, 1781);
INSERT INTO link_sections_links VALUES (748, 1782);
INSERT INTO link_sections_links VALUES (748, 1783);
INSERT INTO link_sections_links VALUES (731, 1784);
INSERT INTO link_sections_links VALUES (687, 1785);
INSERT INTO link_sections_links VALUES (749, 1786);
INSERT INTO link_sections_links VALUES (697, 1787);
INSERT INTO link_sections_links VALUES (697, 1788);
INSERT INTO link_sections_links VALUES (693, 1788);
INSERT INTO link_sections_links VALUES (697, 1789);
INSERT INTO link_sections_links VALUES (693, 1789);
INSERT INTO link_sections_links VALUES (730, 1790);
INSERT INTO link_sections_links VALUES (750, 1791);
INSERT INTO link_sections_links VALUES (684, 1792);
INSERT INTO link_sections_links VALUES (686, 1793);
INSERT INTO link_sections_links VALUES (735, 1794);
INSERT INTO link_sections_links VALUES (714, 1795);
INSERT INTO link_sections_links VALUES (690, 1796);
INSERT INTO link_sections_links VALUES (717, 1797);
INSERT INTO link_sections_links VALUES (751, 1798);
INSERT INTO link_sections_links VALUES (749, 1799);
INSERT INTO link_sections_links VALUES (697, 1800);
INSERT INTO link_sections_links VALUES (693, 1800);
INSERT INTO link_sections_links VALUES (703, 1801);
INSERT INTO link_sections_links VALUES (685, 1802);
INSERT INTO link_sections_links VALUES (697, 1803);
INSERT INTO link_sections_links VALUES (734, 1804);
INSERT INTO link_sections_links VALUES (752, 1805);
INSERT INTO link_sections_links VALUES (734, 1806);
INSERT INTO link_sections_links VALUES (690, 1807);
INSERT INTO link_sections_links VALUES (753, 1808);
INSERT INTO link_sections_links VALUES (754, 1809);
INSERT INTO link_sections_links VALUES (754, 1810);
INSERT INTO link_sections_links VALUES (712, 1811);
INSERT INTO link_sections_links VALUES (755, 1812);
INSERT INTO link_sections_links VALUES (707, 1813);
INSERT INTO link_sections_links VALUES (693, 1813);
INSERT INTO link_sections_links VALUES (743, 1813);
INSERT INTO link_sections_links VALUES (743, 1814);
INSERT INTO link_sections_links VALUES (725, 1815);
INSERT INTO link_sections_links VALUES (725, 1816);
INSERT INTO link_sections_links VALUES (682, 1817);
INSERT INTO link_sections_links VALUES (690, 1818);
INSERT INTO link_sections_links VALUES (686, 1819);
INSERT INTO link_sections_links VALUES (743, 1820);
INSERT INTO link_sections_links VALUES (738, 1821);
INSERT INTO link_sections_links VALUES (737, 1822);
INSERT INTO link_sections_links VALUES (735, 1822);
INSERT INTO link_sections_links VALUES (705, 1823);


--
-- Data for Name: links; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO links VALUES (1634, '511.org (Bay Area Transportation Planner)', 'http://www.511.org/', 'Calculates transportation options for traveling', true, '2015-08-21 00:19:34.6', '2015-08-21 00:19:34.6');
INSERT INTO links VALUES (1635, 'Academic Calendar', 'http://registrar.berkeley.edu/CalendarDisp.aspx?terms=current', 'Academic Calendars Future Campus Calendars', true, '2015-08-21 00:19:34.666', '2015-08-21 00:19:34.666');
INSERT INTO links VALUES (1636, 'Academic Calendar - Berkeley Law', 'https://www.law.berkeley.edu/php-programs/courses/academic_calendars.php', 'Academic calendar including academic and administrative holidays', true, '2015-08-21 00:19:34.73', '2015-08-21 00:19:34.73');
INSERT INTO links VALUES (1637, 'Academic Departments & Programs', 'http://www.berkeley.edu/academics/dept/a.shtml', 'UC Berkeley''s variety of degree programs', true, '2015-08-21 00:19:34.779', '2015-08-21 00:19:34.779');
INSERT INTO links VALUES (1638, 'Academic Policies', 'http://bulletin.berkeley.edu/academic-policies/', 'Policies set by the university specific for Berkeley students', true, '2015-08-21 00:19:34.835', '2015-08-21 00:19:34.835');
INSERT INTO links VALUES (1639, 'Academic Senate', 'http://academic-senate.berkeley.edu/', 'Governance held by faculty member to make decisions campus-wide', true, '2015-08-21 00:19:34.888', '2015-08-21 00:19:34.888');
INSERT INTO links VALUES (1640, 'Administration & Finance', 'http://vcaf.berkeley.edu/who-we-are/divisions', 'Administration officials ', true, '2015-08-21 00:19:34.939', '2015-08-21 00:19:34.939');
INSERT INTO links VALUES (1641, 'AirBears', 'http://ist.berkeley.edu/airbears/', 'Berkeley''s free internet wifi for Berkeley affiliates with a calnet and passphrase', true, '2015-08-21 00:19:34.993', '2015-08-21 00:19:34.993');
INSERT INTO links VALUES (1642, 'ASUC', 'http://asuc.org/', 'Student government', true, '2015-08-21 00:19:35.045', '2015-08-21 00:19:35.045');
INSERT INTO links VALUES (1643, 'At Your Service', 'https://atyourserviceonline.ucop.edu', 'Benefits, Earnings, Taxes & Retirement', true, '2015-08-21 00:19:35.091', '2015-08-21 00:19:35.091');
INSERT INTO links VALUES (1644, 'Athletic Study Center', 'https://asc.berkeley.edu/', 'Advising and tutoring for student athletes', true, '2015-08-21 00:19:35.14', '2015-08-21 00:19:35.14');
INSERT INTO links VALUES (1645, 'BAIRS', 'http://www.bai.berkeley.edu/BAIRS/index.htm', 'Berkeley Administrative Initiative Reporting System', true, '2015-08-21 00:19:35.186', '2015-08-21 00:19:35.186');
INSERT INTO links VALUES (1646, 'bCal', 'http://bcal.berkeley.edu', 'Your campus calendar', true, '2015-08-21 00:19:35.236', '2015-08-21 00:19:35.236');
INSERT INTO links VALUES (1647, 'bConnected Support', 'http://ist.berkeley.edu/bconnected', 'Information and resources site for Berkeley''s email, calendar and shared drive solutions, powered by Google Apps for Education', true, '2015-08-21 00:19:35.272', '2015-08-21 00:19:35.272');
INSERT INTO links VALUES (1648, 'bCourses', 'http://bcourses.berkeley.edu', 'Campus Learning Management System (LMS) powered by Canvas', true, '2015-08-21 00:19:35.318', '2015-08-21 00:19:35.318');
INSERT INTO links VALUES (1649, 'bDrive', 'http://bdrive.berkeley.edu', 'An area to store files that can be shared and collaborated', true, '2015-08-21 00:19:35.353', '2015-08-21 00:19:35.353');
INSERT INTO links VALUES (1650, 'Bear Facts', 'https://bearfacts.berkeley.edu', 'Academic record, grades & transcript, bill, degree audit, loans, SLR & personal info', true, '2015-08-21 00:19:35.405', '2015-08-21 00:19:35.405');
INSERT INTO links VALUES (1651, 'BearBuy', 'http://supplychain.berkeley.edu/bearbuy/', 'Campus procurement system with online catalog shopping and electronically-enabled workflows', true, '2015-08-21 00:19:35.459', '2015-08-21 00:19:35.459');
INSERT INTO links VALUES (1652, 'BearWALK Night safety services', 'http://police.berkeley.edu/programsandservices/campus_safety/index.html', 'Free safety night walks to and from a desired location with a Community Service Officer', true, '2015-08-21 00:19:35.508', '2015-08-21 00:19:35.508');
INSERT INTO links VALUES (1653, 'Berkeley Academic Guide', 'http://guide.berkeley.edu/', 'Degree programs, academic policies, and course catalog', true, '2015-08-21 00:19:35.56', '2015-08-21 00:19:35.56');
INSERT INTO links VALUES (1654, 'Berkeley Jobs', 'http://jobs.berkeley.edu/', 'Start here to learn about job openings on campus, student, staff and academic positions', true, '2015-08-21 00:19:35.61', '2015-08-21 00:19:35.61');
INSERT INTO links VALUES (1655, 'Berkeley Research', 'http://vcresearch.berkeley.edu/', 'Research information and opportunities', true, '2015-08-21 00:19:35.681', '2015-08-21 00:19:35.681');
INSERT INTO links VALUES (1656, 'Berkeley Self-Guided Tours', 'http://visitors.berkeley.edu/tour/self.shtml', 'Mobile, podcast, cell phone, and other tours of the Berkeley campus', true, '2015-08-21 00:19:35.734', '2015-08-21 00:19:35.734');
INSERT INTO links VALUES (1657, 'Berkeley Sites (A-Z)', 'http://www.berkeley.edu/a-z/a.shtml', 'Navigating UC Berkeley', true, '2015-08-21 00:19:35.77', '2015-08-21 00:19:35.77');
INSERT INTO links VALUES (1658, 'Berkeley Student Cooperative', 'http://www.bsc.coop/', 'Berkeley''s co-operative student housing option, and an alternative to living in student dorms', true, '2015-08-21 00:19:35.818', '2015-08-21 00:19:35.818');
INSERT INTO links VALUES (1659, 'BETS - equipment tracking', 'http://bets.berkeley.edu/BETS/home/BetsHome.cfm', 'Equipment Tracking System of inventorial and non-inventorial equipment', true, '2015-08-21 00:19:35.861', '2015-08-21 00:19:35.861');
INSERT INTO links VALUES (1660, 'BFS', 'http://www.bai.berkeley.edu/BFS/index.htm', 'Berkeley Financial System', true, '2015-08-21 00:19:35.889', '2015-08-21 00:19:35.889');
INSERT INTO links VALUES (1661, 'Billing Services', 'http://studentbilling.berkeley.edu/', 'Billing and payment options for students and parents', true, '2015-08-21 00:19:35.935', '2015-08-21 00:19:35.935');
INSERT INTO links VALUES (1662, 'Blu', 'http://blu.berkeley.edu', 'Berkeley''s employee portal: work-related tools and information', true, '2015-08-21 00:19:35.979', '2015-08-21 00:19:35.979');
INSERT INTO links VALUES (1663, 'Blu Card', 'http://supplychain.berkeley.edu/programs/card-program-services/blucard', 'A procurement card, issued to select employees, and used for purchasing work-related items and services', true, '2015-08-21 00:19:36.01', '2015-08-21 00:19:36.01');
INSERT INTO links VALUES (1664, 'bMail', 'http://bmail.berkeley.edu', 'Your campus email account', true, '2015-08-21 00:19:36.042', '2015-08-21 00:19:36.042');
INSERT INTO links VALUES (1665, 'Bookstore - Berkeley Law', 'http://www.law.berkeley.edu/15687.htm', 'Textbooks and other learning resources for Berkeley Law students', true, '2015-08-21 00:19:36.092', '2015-08-21 00:19:36.092');
INSERT INTO links VALUES (1666, 'Box.net', 'https://berkeley.box.com/', 'Cloud-hosted platform allowing users to store and share documents and other materials for collaborations', true, '2015-08-21 00:19:36.14', '2015-08-21 00:19:36.14');
INSERT INTO links VALUES (1667, 'bSpace', 'http://bspace.berkeley.edu', 'Homework assignments, lecture slides, syllabi and class resources', true, '2015-08-21 00:19:36.203', '2015-08-21 00:19:36.203');
INSERT INTO links VALUES (1668, 'bSpace Grade book', 'http://gsi.berkeley.edu/teachingguide/tech/bspace-gradebook.html', 'A tool to enter, upload, and calculate student grades on bSpace', true, '2015-08-21 00:19:36.258', '2015-08-21 00:19:36.258');
INSERT INTO links VALUES (1669, 'bSpace Support', 'http://ets.berkeley.edu/bspace', 'A communication and collaboration program that supports teaching and learning', true, '2015-08-21 00:19:36.285', '2015-08-21 00:19:36.285');
INSERT INTO links VALUES (1670, 'Cal 1 Card', 'http://services.housing.berkeley.edu/c1c/static/index.htm', 'The campus identification, and optional, debit and meal points card.', true, '2015-08-21 00:19:36.339', '2015-08-21 00:19:36.339');
INSERT INTO links VALUES (1671, 'Cal Answers', 'http://calanswers.berkeley.edu/', 'Provides reliable and consistent answers to critical campus questions', true, '2015-08-21 00:19:36.391', '2015-08-21 00:19:36.391');
INSERT INTO links VALUES (1672, 'Cal Band', 'http://calband.berkeley.edu/', 'UC Berkeley''s marching band', true, '2015-08-21 00:19:36.437', '2015-08-21 00:19:36.437');
INSERT INTO links VALUES (1673, 'Cal Marketplace', 'http://calmarketplace.berkeley.edu/', 'Everything at Cal you may want to buy, discover or visit', true, '2015-08-21 00:19:36.504', '2015-08-21 00:19:36.504');
INSERT INTO links VALUES (1674, 'Cal Performances', 'http://www.calperformances.org/', 'Information and tickets for Cal music, dance, and theater performances', true, '2015-08-21 00:19:36.539', '2015-08-21 00:19:36.539');
INSERT INTO links VALUES (1675, 'Cal Rentals', 'http://calrentals.housing.berkeley.edu/', 'Listings of housing opportunities for the Berkeley community', true, '2015-08-21 00:19:36.574', '2015-08-21 00:19:36.574');
INSERT INTO links VALUES (1676, 'Cal Spirit Groups', 'http://calspirit.berkeley.edu/', 'Cheerleading and Dance Group ', true, '2015-08-21 00:19:36.62', '2015-08-21 00:19:36.62');
INSERT INTO links VALUES (1677, 'Cal Student Central', 'http://studentcentral.berkeley.edu/', 'A resourceful website with answers to the most frequently asked questions by students', true, '2015-08-21 00:19:36.686', '2015-08-21 00:19:36.686');
INSERT INTO links VALUES (1678, 'Cal Student Store', 'https://calstudentstore.berkeley.edu/', 'Apparel, school supplies, and more ', true, '2015-08-21 00:19:36.718', '2015-08-21 00:19:36.718');
INSERT INTO links VALUES (1679, 'CalBears Intercollegiate Athletics', 'http://www.calbears.com/', 'Berkeley''s official sport teams', true, '2015-08-21 00:19:36.768', '2015-08-21 00:19:36.768');
INSERT INTO links VALUES (1680, 'CalDining', 'http://caldining.berkeley.edu/', 'Campus dining facilities', true, '2015-08-21 00:19:36.803', '2015-08-21 00:19:36.803');
INSERT INTO links VALUES (1681, 'CalGreeks', 'http://www.calgreeks.com/', 'Fraternities, Sororities, and professional fraternities among the Greek Family', true, '2015-08-21 00:19:36.861', '2015-08-21 00:19:36.861');
INSERT INTO links VALUES (1682, 'CalLink (Campus Activities Link)', 'http://callink.berkeley.edu/', 'Official campus student groups', true, '2015-08-21 00:19:36.89', '2015-08-21 00:19:36.89');
INSERT INTO links VALUES (1683, 'Callisto & CalJobs', 'https://career.berkeley.edu/CareerApps/Callisto/CallistoLogin.aspx', 'Official Berkeley website for all things job-related', true, '2015-08-21 00:19:36.916', '2015-08-21 00:19:36.916');
INSERT INTO links VALUES (1684, 'CalMail', 'http://calmail.berkeley.edu', 'Campus email management', true, '2015-08-21 00:19:36.945', '2015-08-21 00:19:36.945');
INSERT INTO links VALUES (1685, 'CalMessages', 'https://calmessages.berkeley.edu/', 'Berkeley''s official messaging system used to send broadcast email notifications to all staff, all students, etc.', true, '2015-08-21 00:19:36.993', '2015-08-21 00:19:36.993');
INSERT INTO links VALUES (1686, 'CalNet', 'https://calnet.berkeley.edu/', 'An online identity username that all Berkeley affiliates have to log into Berkeley websites', true, '2015-08-21 00:19:37.022', '2015-08-21 00:19:37.022');
INSERT INTO links VALUES (1687, 'CalPlanning', 'http://budget.berkeley.edu/systems/calplanning', 'UC Berkeley''s financial planning and analysis tool', true, '2015-08-21 00:19:37.071', '2015-08-21 00:19:37.071');
INSERT INTO links VALUES (1688, 'CalShare', 'https://calshare.berkeley.edu/', 'Tool for creating and managing web sites for collaboration purposes', true, '2015-08-21 00:19:37.099', '2015-08-21 00:19:37.099');
INSERT INTO links VALUES (1689, 'CalTime', 'http://caltime.berkeley.edu', 'Tracking and reporting work and time leave-timekeeping', true, '2015-08-21 00:19:37.147', '2015-08-21 00:19:37.147');
INSERT INTO links VALUES (1690, 'Campaign for Berkeley', 'http://campaign.berkeley.edu/', 'The campaign to raise money to help Berkeley''s programs and affiliates', true, '2015-08-21 00:19:37.194', '2015-08-21 00:19:37.194');
INSERT INTO links VALUES (1691, 'Campus Bookstore', 'https://calstudentstore.berkeley.edu/textbook', 'Text books and more', true, '2015-08-21 00:19:37.229', '2015-08-21 00:19:37.229');
INSERT INTO links VALUES (1692, 'Campus Deposit System (CDS)', 'https://cdsonline.berkeley.edu', 'Financial system used by departments to make cash deposits to their accounts', true, '2015-08-21 00:19:37.259', '2015-08-21 00:19:37.259');
INSERT INTO links VALUES (1693, 'Campus Directory - People Finder', 'http://directory.berkeley.edu', 'Campus directory of faculty, staff and students', true, '2015-08-21 00:19:37.32', '2015-08-21 00:19:37.32');
INSERT INTO links VALUES (1694, 'Campus IT Offices', 'http://www.berkeley.edu/admin/compute.shtml#offices', 'Contact information for information technology services', true, '2015-08-21 00:19:37.355', '2015-08-21 00:19:37.355');
INSERT INTO links VALUES (1695, 'Campus Map', 'http://www.berkeley.edu/map/3dmap/3dmap.shtml', 'Locate campus buildings', true, '2015-08-21 00:19:37.405', '2015-08-21 00:19:37.405');
INSERT INTO links VALUES (1696, 'Campus Shared Services', 'http://sharedservices.berkeley.edu/', 'Answers to questions and the ability to submit help requests', true, '2015-08-21 00:19:37.454', '2015-08-21 00:19:37.454');
INSERT INTO links VALUES (1697, 'Campus Shuttles', 'http://pt.berkeley.edu/around/transit/routes/', 'Bus routes around the Berkeley campus (most are free)', true, '2015-08-21 00:19:37.486', '2015-08-21 00:19:37.486');
INSERT INTO links VALUES (1698, 'CARE Services', 'http://uhs.berkeley.edu/facstaff/care/', 'free, confidential problem assessment and referral for UC Berkeley faculty and staff', true, '2015-08-21 00:19:37.535', '2015-08-21 00:19:37.535');
INSERT INTO links VALUES (1699, 'Career Center', 'http://career.berkeley.edu/', 'Cal jobs, internships & career counseling', true, '2015-08-21 00:19:37.567', '2015-08-21 00:19:37.567');
INSERT INTO links VALUES (1700, 'Career Center: Internships', 'https://career.berkeley.edu/Internships/Internships.stm', 'Resources and Information for Internships', true, '2015-08-21 00:19:37.6', '2015-08-21 00:19:37.6');
INSERT INTO links VALUES (1701, 'Career Center: Job Search Tools', 'https://career.berkeley.edu/Tools/Tools.stm', 'Resources on how to find a good job or internship ', true, '2015-08-21 00:19:37.626', '2015-08-21 00:19:37.626');
INSERT INTO links VALUES (1702, 'Career Center: Part-time Employment', 'https://career.berkeley.edu/Parttime/Parttime.stm', 'Links to part-time websites', true, '2015-08-21 00:19:37.653', '2015-08-21 00:19:37.653');
INSERT INTO links VALUES (1703, 'Career Development Office - Berkeley Law', 'http://www.law.berkeley.edu/careers.htm', 'Berkeley Law career development office', true, '2015-08-21 00:19:37.68', '2015-08-21 00:19:37.68');
INSERT INTO links VALUES (1704, 'Child Care', 'http://www.housing.berkeley.edu/child/', 'Campus child care services', true, '2015-08-21 00:19:37.766', '2015-08-21 00:19:37.766');
INSERT INTO links VALUES (1705, 'Class Enrollment Rules and Guides', 'http://registrar.berkeley.edu/StudentSystems/tbinfo.html', 'Registrar guide to Tele-BEARS, enrollment periods, add-drop deadlines, and other tips', true, '2015-08-21 00:19:37.805', '2015-08-21 00:19:37.805');
INSERT INTO links VALUES (1706, 'Class pass', 'http://pt.berkeley.edu/pay/transit/classpass/', 'AC Transit Pass to bus for free', true, '2015-08-21 00:19:37.832', '2015-08-21 00:19:37.832');
INSERT INTO links VALUES (1707, 'Classroom Technology', 'https://www.ets.berkeley.edu/discover-services/classroom-technology-support', 'Provide reliable resources and technical support to the UCB campus', true, '2015-08-21 00:19:37.877', '2015-08-21 00:19:37.877');
INSERT INTO links VALUES (1708, 'Colleges & Schools', 'http://www.berkeley.edu/academics/school.shtml', 'Different departments (colleges) that majors fall under', true, '2015-08-21 00:19:37.905', '2015-08-21 00:19:37.905');
INSERT INTO links VALUES (1709, 'Computer Use Policy', 'https://security.berkeley.edu/policy/usepolicy.html', 'Rules, rights, and policies regarding computer facilities', true, '2015-08-21 00:19:37.94', '2015-08-21 00:19:37.94');
INSERT INTO links VALUES (1710, 'Counseling & Psychological Services', 'http://uhs.berkeley.edu/students/counseling/cps.shtml', 'Individual, group, & self-help from Tang Center', true, '2015-08-21 00:19:37.985', '2015-08-21 00:19:37.985');
INSERT INTO links VALUES (1711, 'Course Capture Support', 'https://www.ets.berkeley.edu/discover-services/course-capture', 'Help with recordings of class lectures and discussions', true, '2015-08-21 00:19:38.021', '2015-08-21 00:19:38.021');
INSERT INTO links VALUES (1712, 'Course Catalog', 'http://guide.berkeley.edu/courses/', 'Detailed course descriptions', true, '2015-08-21 00:19:38.052', '2015-08-21 00:19:38.052');
INSERT INTO links VALUES (1713, 'DARS', 'https://marin.berkeley.edu/darsweb/servlet/ListAuditsServlet ', 'Degree requirements and track progress', true, '2015-08-21 00:19:38.086', '2015-08-21 00:19:38.086');
INSERT INTO links VALUES (1714, 'DeCal Courses', 'http://www.decal.org/ ', 'Catalog of student-led courses', true, '2015-08-21 00:19:38.142', '2015-08-21 00:19:38.142');
INSERT INTO links VALUES (1715, 'Disabled Students Program', 'http://dsp.berkeley.edu/', 'Resources specific to disabled students', true, '2015-08-21 00:19:38.179', '2015-08-21 00:19:38.179');
INSERT INTO links VALUES (1716, 'Drop-in Computer Facilities', 'https://www.ets.berkeley.edu/discover-services/drop-computer-facilities', 'Convenient and secure on-campus computing facilities for all individuals with a CalNet ID', true, '2015-08-21 00:19:38.224', '2015-08-21 00:19:38.224');
INSERT INTO links VALUES (1717, 'e-bills', 'https://bearfacts.berkeley.edu/bearfacts/student/CARS/ebill.do?bfaction=accessEBill ', 'Pay your CARS bill online with either Electronic Billing (e-Bill) or Electronic Payment (e-Check)', true, '2015-08-21 00:19:38.258', '2015-08-21 00:19:38.258');
INSERT INTO links VALUES (1718, 'Educational Opportunity Program', 'http://eop.berkeley.edu', 'Guidance and resources for first generation and low-income college students.', true, '2015-08-21 00:19:38.284', '2015-08-21 00:19:38.284');
INSERT INTO links VALUES (1719, 'Edx Classes at Berkeley', 'https://www.edx.org/university_profile/BerkeleyX', 'Resources that advise, coordinate, and facilitate the University’s online education initiatives', true, '2015-08-21 00:19:38.321', '2015-08-21 00:19:38.321');
INSERT INTO links VALUES (1720, 'Emergency information', 'http://emergency.berkeley.edu/', 'Go-to site for emergency response information', true, '2015-08-21 00:19:38.376', '2015-08-21 00:19:38.376');
INSERT INTO links VALUES (1721, 'Emergency Preparedness', 'http://oep.berkeley.edu/', 'How to be prepared and ready for emergencies', true, '2015-08-21 00:19:38.411', '2015-08-21 00:19:38.411');
INSERT INTO links VALUES (1722, 'Environmental Health & Safety', 'http://www.ehs.berkeley.edu/', 'Services to the campus community that promote health, safety, and environmental stewardship', true, '2015-08-21 00:19:38.46', '2015-08-21 00:19:38.46');
INSERT INTO links VALUES (1723, 'Equity, Inclusion & Diversity', 'http://diversity.berkeley.edu/', 'Creating a fair and inclusive society for all individuals', true, '2015-08-21 00:19:38.489', '2015-08-21 00:19:38.489');
INSERT INTO links VALUES (1724, 'Ethics & Compliance, Administrative guide', 'http://ethicscompliance.berkeley.edu/index.shtml', 'Contact information to report anything suspicious', true, '2015-08-21 00:19:38.538', '2015-08-21 00:19:38.538');
INSERT INTO links VALUES (1725, 'Events.Berkeley', 'http://events.berkeley.edu', 'Campus events calendar', true, '2015-08-21 00:19:38.586', '2015-08-21 00:19:38.586');
INSERT INTO links VALUES (1726, 'Executive Vice Chancellor & Provost', 'http://evcp.chance.berkeley.edu/', 'Meet Executive Vice Chancellor and Provost, Claude M. Steele', true, '2015-08-21 00:19:38.621', '2015-08-21 00:19:38.621');
INSERT INTO links VALUES (1727, 'Facilities Services', 'http://www.cp.berkeley.edu/', 'Cleaning, landscaping and other services to maintain exceptional physical appearance', true, '2015-08-21 00:19:38.655', '2015-08-21 00:19:38.655');
INSERT INTO links VALUES (1728, 'Faculty gateway', 'http://berkeley.edu/faculty/', 'Useful resources for faculty members ', true, '2015-08-21 00:19:38.688', '2015-08-21 00:19:38.688');
INSERT INTO links VALUES (1729, 'FAFSA', 'https://fafsa.ed.gov/', 'Free Application for Federal Student Aid (FAFSA),annual form submission required to receive financial aid', true, '2015-08-21 00:19:38.731', '2015-08-21 00:19:38.731');
INSERT INTO links VALUES (1730, 'Financial Aid & Scholarships Office', 'http://financialaid.berkeley.edu', 'Start here to learn about Financial Aid and for step-by-step guidance about financial aid and select scholarships at UC Berkeley', true, '2015-08-21 00:19:38.757', '2015-08-21 00:19:38.757');
INSERT INTO links VALUES (1731, 'Finding Your Way (L&S)', 'http://ls-yourway.berkeley.edu/', 'Academic advising for students in the Residence Halls under the college of Letters and Science', true, '2015-08-21 00:19:38.784', '2015-08-21 00:19:38.784');
INSERT INTO links VALUES (1732, 'Gender Equity Resource Center', 'http://geneq.berkeley.edu/', 'Community center for students, faculty, staff, & alumni', true, '2015-08-21 00:19:38.822', '2015-08-21 00:19:38.822');
INSERT INTO links VALUES (1733, 'Give to Berkeley', 'http://givetocal.berkeley.edu/', 'Help donate to further student''s education', true, '2015-08-21 00:19:38.861', '2015-08-21 00:19:38.861');
INSERT INTO links VALUES (1734, 'Graduate Assembly', 'https://ga.berkeley.edu/', 'Graduate student government', true, '2015-08-21 00:19:38.894', '2015-08-21 00:19:38.894');
INSERT INTO links VALUES (1735, 'Graduate Division', 'http://www.grad.berkeley.edu/', 'Information and resources for prospective and graduate students', true, '2015-08-21 00:19:38.938', '2015-08-21 00:19:38.938');
INSERT INTO links VALUES (1736, 'Graduate Financial Support', 'http://www.grad.berkeley.edu/financial/', 'Resources to provide financial support for graduate students', true, '2015-08-21 00:19:38.989', '2015-08-21 00:19:38.989');
INSERT INTO links VALUES (1737, 'GSI, Reader, Tutor, and GSR Positions', 'http://grad.berkeley.edu/professional-development/appointments/', 'Graduate Student Instructor (GSI), Researcher (GSR), Reader, and Tutor appointments at Berkeley', true, '2015-08-21 00:19:39.031', '2015-08-21 00:19:39.031');
INSERT INTO links VALUES (1738, 'Have a loan?', 'http://studentbilling.berkeley.edu/exitDirect.htm', 'Getting ready to graduate? Learn about your responsibilities for paying back your loans through the Exit Loan Counseling requirement', true, '2015-08-21 00:19:39.075', '2015-08-21 00:19:39.075');
INSERT INTO links VALUES (1739, 'How does my SHIP Waiver affect my billing?', 'http://studentcentral.berkeley.edu/faqshipwaiver', 'Frequently Asked Questions about how opt-ing out of the Student Health Insurance Plan effects your bill. ', true, '2015-08-21 00:19:39.11', '2015-08-21 00:19:39.11');
INSERT INTO links VALUES (1740, 'HR System', 'http://hrweb.berkeley.edu/hcm', 'Recording personal information and action for the Berkeley community', true, '2015-08-21 00:19:39.157', '2015-08-21 00:19:39.157');
INSERT INTO links VALUES (1741, 'HR Web', 'http://hrweb.berkeley.edu/', 'Human Resources at Berkeley', true, '2015-08-21 00:19:39.188', '2015-08-21 00:19:39.188');
INSERT INTO links VALUES (1742, 'Imagine Services', 'http://ist.berkeley.edu/imagine', 'Custom electronic document workflows', true, '2015-08-21 00:19:39.217', '2015-08-21 00:19:39.217');
INSERT INTO links VALUES (1743, 'International House', 'http://ihouse.berkeley.edu/', 'On-campus dormitory with a dining common for international students', true, '2015-08-21 00:19:39.244', '2015-08-21 00:19:39.244');
INSERT INTO links VALUES (1744, 'IST Knowledge Base', 'http://ist.berkeley.edu/support/kb', 'Contains answers to Berkeley computing and IT questions', true, '2015-08-21 00:19:39.272', '2015-08-21 00:19:39.272');
INSERT INTO links VALUES (1745, 'IST Support', 'http://ist.berkeley.edu/support/', 'Information Technology support for services and systems', true, '2015-08-21 00:19:39.307', '2015-08-21 00:19:39.307');
INSERT INTO links VALUES (1747, 'KALX', 'http://kalx.berkeley.edu/', '90.7 MHz. Berkeley''s campus radio station', true, '2015-08-21 00:19:39.387', '2015-08-21 00:19:39.387');
INSERT INTO links VALUES (1748, 'Lab Safety', 'http://rac.berkeley.edu/compliancebook/labsafety.html', 'Lab Safety & Hazardous Materials Management', true, '2015-08-21 00:19:39.426', '2015-08-21 00:19:39.426');
INSERT INTO links VALUES (1749, 'LEAD Center', 'http://lead.berkeley.edu/', 'Student leadership programs and workshops', true, '2015-08-21 00:19:39.46', '2015-08-21 00:19:39.46');
INSERT INTO links VALUES (1750, 'Learning Resources', 'http://hrweb.berkeley.edu/learning', 'Supports the development of the workforce with learning and development programs', true, '2015-08-21 00:19:39.498', '2015-08-21 00:19:39.498');
INSERT INTO links VALUES (1751, 'Library', 'http://library.berkeley.edu', 'Search the UC Library system', true, '2015-08-21 00:19:39.554', '2015-08-21 00:19:39.554');
INSERT INTO links VALUES (1752, 'Living At Cal', 'http://www.housing.berkeley.edu/livingatcal/', 'UC Berkeley housing options', true, '2015-08-21 00:19:39.59', '2015-08-21 00:19:39.59');
INSERT INTO links VALUES (1753, 'Mail Services', 'http://mailservices.berkeley.edu/', 'United States Postal Service-incoming and outgoing mail', true, '2015-08-21 00:19:39.636', '2015-08-21 00:19:39.636');
INSERT INTO links VALUES (1754, 'My Years at Cal', 'http://myyears.berkeley.edu/', 'Undergraduate advice site with useful resources and on how to stay on track for graduation ', true, '2015-08-21 00:19:39.665', '2015-08-21 00:19:39.665');
INSERT INTO links VALUES (1755, 'MyFinAid', 'https://myfinaid.berkeley.edu/', 'Manage your Financial Aid Awards-grants, scholarships, work-study, loans, etc.', true, '2015-08-21 00:19:39.691', '2015-08-21 00:19:39.691');
INSERT INTO links VALUES (1756, 'New Faculty resources', 'http://teaching.berkeley.edu/new-faculty-resources', 'Hints, resources, and guidelines on productive teaching', true, '2015-08-21 00:19:39.718', '2015-08-21 00:19:39.718');
INSERT INTO links VALUES (1757, 'New Student Services (includes CalSO)', 'http://nss.berkeley.edu/', 'Helping new undergrads get the most out of Cal', true, '2015-08-21 00:19:39.744', '2015-08-21 00:19:39.744');
INSERT INTO links VALUES (1758, 'Newscenter', 'http://newscenter.berkeley.edu', 'News affiliated with UC Berkeley', true, '2015-08-21 00:19:39.773', '2015-08-21 00:19:39.773');
INSERT INTO links VALUES (1759, 'Office of the Chancellor', 'http://chancellor.berkeley.edu/', 'Meet Chancellor Nicholas B. Dirks', true, '2015-08-21 00:19:39.808', '2015-08-21 00:19:39.808');
INSERT INTO links VALUES (1760, 'Office of the Registrar', 'http://registrar.berkeley.edu/', 'Administrative office with helpful links and resources regarding Berkeley', true, '2015-08-21 00:19:39.857', '2015-08-21 00:19:39.857');
INSERT INTO links VALUES (1761, 'Office of Undergraduate Advising', 'http://ls-advise.berkeley.edu/', 'Advising provided for students under the college of Letters and Science', true, '2015-08-21 00:19:39.89', '2015-08-21 00:19:39.89');
INSERT INTO links VALUES (1762, 'Open Computing Facility', 'http://www.ocf.berkeley.edu/', 'Free computing such as printing for Berkeley affiliates', true, '2015-08-21 00:19:39.919', '2015-08-21 00:19:39.919');
INSERT INTO links VALUES (1763, 'Organizational & Workforce Effectiveness', 'http://hrweb.berkeley.edu/learning/corwe', 'Organization supporting managers wanting to make organizational improvements', true, '2015-08-21 00:19:39.968', '2015-08-21 00:19:39.968');
INSERT INTO links VALUES (1764, 'Parking & Transportation', 'http://pt.berkeley.edu/', 'Parking lots, transportation, car sharing, etc.', true, '2015-08-21 00:19:39.997', '2015-08-21 00:19:39.997');
INSERT INTO links VALUES (1765, 'Payment Options', 'http://studentbilling.berkeley.edu/carsPaymentOptions.htm', 'Learn more about the options for making payment either electronically or by check to your CARS account', true, '2015-08-21 00:19:40.029', '2015-08-21 00:19:40.029');
INSERT INTO links VALUES (1766, 'Payroll', 'http://controller.berkeley.edu/payroll/', 'Providing accurate paychecks to Berkeley employees', true, '2015-08-21 00:19:40.057', '2015-08-21 00:19:40.057');
INSERT INTO links VALUES (1767, 'Personal Info - Campus Directory', 'https://calnet.berkeley.edu/directory/update/', 'Public contact information of Berkeley affiliates such as email addresses, UIDs, etc.', true, '2015-08-21 00:19:40.105', '2015-08-21 00:19:40.105');
INSERT INTO links VALUES (1768, 'Personal Info - HR record', 'https://auth.berkeley.edu/cas/login?service=https://hrw-vip-prod.is.berkeley.edu/cgi-bin/cas-hrsprod.pl', 'HR personal data, requires log-in.', true, '2015-08-21 00:19:40.135', '2015-08-21 00:19:40.135');
INSERT INTO links VALUES (1769, 'Personnel Policies', 'http://hrweb.berkeley.edu/er/policies', 'Employee relations - personnel policies', true, '2015-08-21 00:19:40.167', '2015-08-21 00:19:40.167');
INSERT INTO links VALUES (1770, 'Physical Education Program', 'http://pe.berkeley.edu/', 'Physical education instructional courses for units', true, '2015-08-21 00:19:40.213', '2015-08-21 00:19:40.213');
INSERT INTO links VALUES (1771, 'Police & Safety', 'http://police.berkeley.edu', 'Campus police and safety', true, '2015-08-21 00:19:40.258', '2015-08-21 00:19:40.258');
INSERT INTO links VALUES (1772, 'Policies & procedures A-Z', 'http://campuspol.chance.berkeley.edu/Home/AtoZPolicies.cfm?long_page=yes', 'A-Z of campuswide policies and procedures', true, '2015-08-21 00:19:40.295', '2015-08-21 00:19:40.295');
INSERT INTO links VALUES (1773, 'Public Service Center', 'http://publicservice.berkeley.edu', 'On and off campus community service engagement', true, '2015-08-21 00:19:40.332', '2015-08-21 00:19:40.332');
INSERT INTO links VALUES (1774, 'Purchasing', 'http://businessservices.berkeley.edu/procurement/services', 'Services that can be purchased by individuals with a CalNet ID and passphrase', true, '2015-08-21 00:19:40.366', '2015-08-21 00:19:40.366');
INSERT INTO links VALUES (1775, 'Recreational Sports Facility', 'http://recsports.berkeley.edu/ ', 'Sports and fitness programs', true, '2015-08-21 00:19:40.398', '2015-08-21 00:19:40.398');
INSERT INTO links VALUES (1776, 'Registration Fees', 'http://registrar.berkeley.edu/Registration/feesched.html', 'Required Berkeley fees to be a Registered Student', true, '2015-08-21 00:19:40.43', '2015-08-21 00:19:40.43');
INSERT INTO links VALUES (1777, 'Research', 'http://berkeley.edu/research/', 'Directory of UC Berkeley research programs', true, '2015-08-21 00:19:40.459', '2015-08-21 00:19:40.459');
INSERT INTO links VALUES (1778, 'Reserve a Study Room', 'http://berkeley.libcal.com/booking/gardner', 'Reservations for library group study rooms', true, '2015-08-21 00:19:40.494', '2015-08-21 00:19:40.494');
INSERT INTO links VALUES (1779, 'Residential & Student Service Programs', 'http://www.housing.berkeley.edu/', 'UC Berkeley housing options', true, '2015-08-21 00:19:40.524', '2015-08-21 00:19:40.524');
INSERT INTO links VALUES (1780, 'Residential Computing (ResComp)', 'http://www.rescomp.berkeley.edu/', 'Computer and network services for students living in campus housing', true, '2015-08-21 00:19:40.575', '2015-08-21 00:19:40.575');
INSERT INTO links VALUES (1781, 'Resource Guide for Students', 'http://resource.berkeley.edu/', 'Comprehensive campus guide for students', true, '2015-08-21 00:19:40.605', '2015-08-21 00:19:40.605');
INSERT INTO links VALUES (1782, 'Retirement Benefits - At Your Service', 'https://atyourserviceonline.ucop.edu', 'Benefits, Earnings, Taxes & Retirement', true, '2015-08-21 00:19:40.648', '2015-08-21 00:19:40.648');
INSERT INTO links VALUES (1783, 'Retirement Resources', 'http://thecenter.berkeley.edu/index.shtml', 'Programs and services that contribute to the well being of retired faculty', true, '2015-08-21 00:19:40.678', '2015-08-21 00:19:40.678');
INSERT INTO links VALUES (1784, 'Safety', 'http://police.berkeley.edu/index.html', 'Safety information and programs', true, '2015-08-21 00:19:40.724', '2015-08-21 00:19:40.724');
INSERT INTO links VALUES (1785, 'SARA - request system access', 'http://www.bai.berkeley.edu/BFS/systems/systemAccess.htm', 'Form that grants access to different systems for employees', true, '2015-08-21 00:19:40.758', '2015-08-21 00:19:40.758');
INSERT INTO links VALUES (1786, 'Schedule & Deadlines', 'http://summer.berkeley.edu/registration/schedule', 'Key dates and deadlines for summer sessions', true, '2015-08-21 00:19:40.806', '2015-08-21 00:19:40.806');
INSERT INTO links VALUES (1787, 'Schedule Builder', 'https://schedulebuilder.berkeley.edu/', 'Plan your classes', true, '2015-08-21 00:19:40.835', '2015-08-21 00:19:40.835');
INSERT INTO links VALUES (1788, 'Schedule of Classes', 'http://schedule.berkeley.edu/', 'Classes offerings by semester', true, '2015-08-21 00:19:40.878', '2015-08-21 00:19:40.878');
INSERT INTO links VALUES (1789, 'Schedule of Classes - Berkeley Law', 'https://www.law.berkeley.edu/php-programs/courses/courseSearch.php', 'Law School classes offerings by semester', true, '2015-08-21 00:19:40.925', '2015-08-21 00:19:40.925');
INSERT INTO links VALUES (1790, 'Software Central', 'http://ist.berkeley.edu/software-central/', 'Free software for Berkeley affiliates (ex. Adobe, Word, etc.)', true, '2015-08-21 00:19:40.96', '2015-08-21 00:19:40.96');
INSERT INTO links VALUES (1791, 'Staff Ombuds Office', 'http://staffombuds.berkeley.edu/ ', 'An independent department that provides staff with strictly confidential and informal conflict resolution and problem-solving services', true, '2015-08-21 00:19:41.009', '2015-08-21 00:19:41.009');
INSERT INTO links VALUES (1792, 'Student & Student Organization Policies', 'http://sa.berkeley.edu/conduct/policies', 'Rules and policies enforced on students and student organizations', true, '2015-08-21 00:19:41.042', '2015-08-21 00:19:41.042');
INSERT INTO links VALUES (1793, 'Student Affairs', 'http://sa.berkeley.edu/', 'Berkeley''s division responsible for many student life services including the Registrar, Admissions, Financial Aid, Housing & Dining, Conduct, Public Service Center, LEAD center, and ASUC auxiliary', true, '2015-08-21 00:19:41.077', '2015-08-21 00:19:41.077');
INSERT INTO links VALUES (1794, 'Student Budgets', 'http://financialaid.berkeley.edu/cost-attendance', 'Estimated living expense amounts for students', true, '2015-08-21 00:19:41.109', '2015-08-21 00:19:41.109');
INSERT INTO links VALUES (1795, 'Student Learning Center', 'http://slc.berkeley.edu', 'Tutoring, workshops, support services, and 24-hour study access', true, '2015-08-21 00:19:41.135', '2015-08-21 00:19:41.135');
INSERT INTO links VALUES (1796, 'Student Ombuds', 'http://sa.berkeley.edu/ombuds', 'Confidential help with campus issues, conflict situations, and more', true, '2015-08-21 00:19:41.162', '2015-08-21 00:19:41.162');
INSERT INTO links VALUES (1797, 'Student Organizations Search', 'http://students.berkeley.edu/osl/studentgroups/public/index.asp', 'Cal''s clubs and organizations on campus', true, '2015-08-21 00:19:41.188', '2015-08-21 00:19:41.188');
INSERT INTO links VALUES (1798, 'Submit a Service Request', 'https://shared-services-help.berkeley.edu/', 'Help requests for various services such as research', true, '2015-08-21 00:19:41.23', '2015-08-21 00:19:41.23');
INSERT INTO links VALUES (1799, 'Summer Session', 'http://summer.berkeley.edu/', 'Various programs and courses offered during summer for Berkeley students', true, '2015-08-21 00:19:41.26', '2015-08-21 00:19:41.26');
INSERT INTO links VALUES (1800, 'Summer Sessions', 'http://summer.berkeley.edu/', 'Various programs and courses offered during summer for Berkeley students', true, '2015-08-21 00:19:41.297', '2015-08-21 00:19:41.297');
INSERT INTO links VALUES (1801, 'Tax 1098-T Form', 'http://studentbilling.berkeley.edu/taxpayer.htm', 'Start here to access your 1098-T form', true, '2015-08-21 00:19:41.333', '2015-08-21 00:19:41.333');
INSERT INTO links VALUES (1802, 'Teaching resources', 'http://teaching.berkeley.edu/teaching.html', 'Resources that promotes teaching and learning including consultation and program facilitation', true, '2015-08-21 00:19:41.359', '2015-08-21 00:19:41.359');
INSERT INTO links VALUES (1803, 'Tele-BEARS', 'https://telebears.berkeley.edu', 'Register for classes', true, '2015-08-21 00:19:41.385', '2015-08-21 00:19:41.385');
INSERT INTO links VALUES (1804, 'The Berkeley Blog', 'http://blogs.berkeley.edu', 'Issues that are being discussed by members of Berkeley''s academic community ', true, '2015-08-21 00:19:41.413', '2015-08-21 00:19:41.413');
INSERT INTO links VALUES (1805, 'The Center for Student Conduct', 'http://sa.berkeley.edu/conduct', 'Administers and promotes our Code of Student Conduct', true, '2015-08-21 00:19:41.463', '2015-08-21 00:19:41.463');
INSERT INTO links VALUES (1806, 'The Daily Californian (The DailyCal)', 'http://www.dailycal.org/', 'Independent student newspaper', true, '2015-08-21 00:19:41.497', '2015-08-21 00:19:41.497');
INSERT INTO links VALUES (1807, 'Transfer, Re-entry and Student Parent Center', 'http://trsp.berkeley.edu/', 'Resources specific to transfer, re-entering, and parent students', true, '2015-08-21 00:19:41.529', '2015-08-21 00:19:41.529');
INSERT INTO links VALUES (1808, 'Travel & Entertainment', 'http://controller.berkeley.edu/travel/', 'Travel services including airfare and Berkeley''s Direct Bill ID system', true, '2015-08-21 00:19:41.575', '2015-08-21 00:19:41.575');
INSERT INTO links VALUES (1809, 'Twitter', 'https://twitter.com/UCBerkeley', 'UC Berkeley''s primary Stay updated on campus news through Berkeley''s primary Twitter address', true, '2015-08-21 00:19:41.635', '2015-08-21 00:19:41.635');
INSERT INTO links VALUES (1810, 'UC Berkeley Facebook page', 'http://www.facebook.com/UCBerkeley', 'Keep updated with Berkeley news through social media', true, '2015-08-21 00:19:41.668', '2015-08-21 00:19:41.668');
INSERT INTO links VALUES (1811, 'UC Berkeley museums', 'http://bnhm.berkeley.edu/', 'Berkeley''s national history museums ', true, '2015-08-21 00:19:41.698', '2015-08-21 00:19:41.698');
INSERT INTO links VALUES (1812, 'UC Berkeley Wellness Letter', 'http://www.wellnessletter.com/ucberkeley/', 'Tips and information on how to stay healthy', true, '2015-08-21 00:19:41.747', '2015-08-21 00:19:41.747');
INSERT INTO links VALUES (1813, 'UC Extension Classes', 'http://extension.berkeley.edu/', 'Professional development', true, '2015-08-21 00:19:41.793', '2015-08-21 00:19:41.793');
INSERT INTO links VALUES (1814, 'UC Learning Center', 'https://uc.sumtotal.host/Core/dash/home?domain=4', 'Various services that help students and instructors succeed', true, '2015-08-21 00:19:41.831', '2015-08-21 00:19:41.831');
INSERT INTO links VALUES (1815, 'UC SHIP (Student Health Insurance Plan)', 'http://www.uhs.berkeley.edu/students/insurance/', 'UC Student Health Insurance Plan', true, '2015-08-21 00:19:41.863', '2015-08-21 00:19:41.863');
INSERT INTO links VALUES (1816, 'UHS - Tang Center', 'http://uhs.berkeley.edu/', 'Berkeley''s healthcare center', true, '2015-08-21 00:19:41.899', '2015-08-21 00:19:41.899');
INSERT INTO links VALUES (1817, 'Undergraduate Student Calendar & Deadlines', 'http://registrar.berkeley.edu/current_students/registration_enrollment/stucal.html', 'Student''s academic calendar ', true, '2015-08-21 00:19:41.935', '2015-08-21 00:19:41.935');
INSERT INTO links VALUES (1818, 'Undocumented Students Program', 'http://undocu.berkeley.edu/', 'Personalized services for undocumented undergraduates', true, '2015-08-21 00:19:41.97', '2015-08-21 00:19:41.97');
INSERT INTO links VALUES (1819, 'University Relations', 'http://www.urel.berkeley.edu/', 'Berkeley''s Public Affairs and fundraising Development division', true, '2015-08-21 00:19:42', '2015-08-21 00:19:42');
INSERT INTO links VALUES (1820, 'Wisdom Café', 'http://wisdomcafe.berkeley.edu/', 'Where Berkeley staff learn & share', true, '2015-08-21 00:19:42.033', '2015-08-21 00:19:42.033');
INSERT INTO links VALUES (1821, 'Withdrawing or Canceling?', 'http://registrar.berkeley.edu/canwd.html ', 'Learn more about what you need to do if you are planning to cancel, withdraw and readmit to UC Berkeley', true, '2015-08-21 00:19:42.065', '2015-08-21 00:19:42.065');
INSERT INTO links VALUES (1822, 'Work-Study', 'http://financialaid.berkeley.edu/work-study', 'A program that can help you lower your federal loan debt amount through work-study eligible jobs on campus', true, '2015-08-21 00:19:42.101', '2015-08-21 00:19:42.101');
INSERT INTO links VALUES (1823, 'YouTube - UC Berkeley', 'http://www.youtube.com/user/UCBerkeley', 'Videos relating to UC Berkeley on an external website', true, '2015-08-21 00:19:42.131', '2015-08-21 00:19:42.131');


--
-- Name: links_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('links_id_seq', 1823, true);


--
-- Data for Name: links_user_roles; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO links_user_roles VALUES (1634, 1);
INSERT INTO links_user_roles VALUES (1634, 3);
INSERT INTO links_user_roles VALUES (1634, 2);
INSERT INTO links_user_roles VALUES (1635, 1);
INSERT INTO links_user_roles VALUES (1635, 3);
INSERT INTO links_user_roles VALUES (1635, 2);
INSERT INTO links_user_roles VALUES (1636, 1);
INSERT INTO links_user_roles VALUES (1636, 3);
INSERT INTO links_user_roles VALUES (1636, 2);
INSERT INTO links_user_roles VALUES (1637, 1);
INSERT INTO links_user_roles VALUES (1637, 3);
INSERT INTO links_user_roles VALUES (1637, 2);
INSERT INTO links_user_roles VALUES (1638, 1);
INSERT INTO links_user_roles VALUES (1638, 3);
INSERT INTO links_user_roles VALUES (1638, 2);
INSERT INTO links_user_roles VALUES (1639, 3);
INSERT INTO links_user_roles VALUES (1640, 1);
INSERT INTO links_user_roles VALUES (1640, 3);
INSERT INTO links_user_roles VALUES (1640, 2);
INSERT INTO links_user_roles VALUES (1641, 1);
INSERT INTO links_user_roles VALUES (1641, 3);
INSERT INTO links_user_roles VALUES (1641, 2);
INSERT INTO links_user_roles VALUES (1642, 1);
INSERT INTO links_user_roles VALUES (1643, 3);
INSERT INTO links_user_roles VALUES (1643, 2);
INSERT INTO links_user_roles VALUES (1644, 1);
INSERT INTO links_user_roles VALUES (1645, 3);
INSERT INTO links_user_roles VALUES (1645, 2);
INSERT INTO links_user_roles VALUES (1646, 1);
INSERT INTO links_user_roles VALUES (1646, 3);
INSERT INTO links_user_roles VALUES (1646, 2);
INSERT INTO links_user_roles VALUES (1647, 1);
INSERT INTO links_user_roles VALUES (1647, 3);
INSERT INTO links_user_roles VALUES (1647, 2);
INSERT INTO links_user_roles VALUES (1648, 1);
INSERT INTO links_user_roles VALUES (1648, 3);
INSERT INTO links_user_roles VALUES (1648, 2);
INSERT INTO links_user_roles VALUES (1649, 1);
INSERT INTO links_user_roles VALUES (1649, 3);
INSERT INTO links_user_roles VALUES (1649, 2);
INSERT INTO links_user_roles VALUES (1650, 1);
INSERT INTO links_user_roles VALUES (1650, 3);
INSERT INTO links_user_roles VALUES (1650, 2);
INSERT INTO links_user_roles VALUES (1651, 3);
INSERT INTO links_user_roles VALUES (1651, 2);
INSERT INTO links_user_roles VALUES (1652, 1);
INSERT INTO links_user_roles VALUES (1652, 3);
INSERT INTO links_user_roles VALUES (1652, 2);
INSERT INTO links_user_roles VALUES (1653, 1);
INSERT INTO links_user_roles VALUES (1653, 3);
INSERT INTO links_user_roles VALUES (1653, 2);
INSERT INTO links_user_roles VALUES (1654, 3);
INSERT INTO links_user_roles VALUES (1654, 2);
INSERT INTO links_user_roles VALUES (1655, 1);
INSERT INTO links_user_roles VALUES (1655, 3);
INSERT INTO links_user_roles VALUES (1655, 2);
INSERT INTO links_user_roles VALUES (1656, 1);
INSERT INTO links_user_roles VALUES (1656, 3);
INSERT INTO links_user_roles VALUES (1656, 2);
INSERT INTO links_user_roles VALUES (1657, 1);
INSERT INTO links_user_roles VALUES (1657, 3);
INSERT INTO links_user_roles VALUES (1657, 2);
INSERT INTO links_user_roles VALUES (1658, 1);
INSERT INTO links_user_roles VALUES (1659, 2);
INSERT INTO links_user_roles VALUES (1660, 3);
INSERT INTO links_user_roles VALUES (1660, 2);
INSERT INTO links_user_roles VALUES (1661, 1);
INSERT INTO links_user_roles VALUES (1662, 3);
INSERT INTO links_user_roles VALUES (1662, 2);
INSERT INTO links_user_roles VALUES (1663, 3);
INSERT INTO links_user_roles VALUES (1663, 2);
INSERT INTO links_user_roles VALUES (1664, 1);
INSERT INTO links_user_roles VALUES (1664, 3);
INSERT INTO links_user_roles VALUES (1664, 2);
INSERT INTO links_user_roles VALUES (1665, 1);
INSERT INTO links_user_roles VALUES (1665, 3);
INSERT INTO links_user_roles VALUES (1666, 1);
INSERT INTO links_user_roles VALUES (1666, 3);
INSERT INTO links_user_roles VALUES (1666, 2);
INSERT INTO links_user_roles VALUES (1667, 1);
INSERT INTO links_user_roles VALUES (1667, 3);
INSERT INTO links_user_roles VALUES (1667, 2);
INSERT INTO links_user_roles VALUES (1668, 3);
INSERT INTO links_user_roles VALUES (1669, 3);
INSERT INTO links_user_roles VALUES (1670, 1);
INSERT INTO links_user_roles VALUES (1670, 3);
INSERT INTO links_user_roles VALUES (1670, 2);
INSERT INTO links_user_roles VALUES (1671, 3);
INSERT INTO links_user_roles VALUES (1671, 2);
INSERT INTO links_user_roles VALUES (1672, 1);
INSERT INTO links_user_roles VALUES (1672, 3);
INSERT INTO links_user_roles VALUES (1672, 2);
INSERT INTO links_user_roles VALUES (1673, 1);
INSERT INTO links_user_roles VALUES (1673, 3);
INSERT INTO links_user_roles VALUES (1673, 2);
INSERT INTO links_user_roles VALUES (1674, 1);
INSERT INTO links_user_roles VALUES (1674, 3);
INSERT INTO links_user_roles VALUES (1674, 2);
INSERT INTO links_user_roles VALUES (1675, 1);
INSERT INTO links_user_roles VALUES (1675, 3);
INSERT INTO links_user_roles VALUES (1675, 2);
INSERT INTO links_user_roles VALUES (1676, 1);
INSERT INTO links_user_roles VALUES (1677, 1);
INSERT INTO links_user_roles VALUES (1678, 1);
INSERT INTO links_user_roles VALUES (1678, 3);
INSERT INTO links_user_roles VALUES (1678, 2);
INSERT INTO links_user_roles VALUES (1679, 1);
INSERT INTO links_user_roles VALUES (1679, 3);
INSERT INTO links_user_roles VALUES (1679, 2);
INSERT INTO links_user_roles VALUES (1680, 1);
INSERT INTO links_user_roles VALUES (1680, 3);
INSERT INTO links_user_roles VALUES (1680, 2);
INSERT INTO links_user_roles VALUES (1681, 1);
INSERT INTO links_user_roles VALUES (1682, 1);
INSERT INTO links_user_roles VALUES (1683, 1);
INSERT INTO links_user_roles VALUES (1684, 1);
INSERT INTO links_user_roles VALUES (1684, 3);
INSERT INTO links_user_roles VALUES (1684, 2);
INSERT INTO links_user_roles VALUES (1685, 2);
INSERT INTO links_user_roles VALUES (1686, 1);
INSERT INTO links_user_roles VALUES (1686, 3);
INSERT INTO links_user_roles VALUES (1686, 2);
INSERT INTO links_user_roles VALUES (1687, 2);
INSERT INTO links_user_roles VALUES (1688, 3);
INSERT INTO links_user_roles VALUES (1688, 2);
INSERT INTO links_user_roles VALUES (1689, 3);
INSERT INTO links_user_roles VALUES (1689, 2);
INSERT INTO links_user_roles VALUES (1690, 1);
INSERT INTO links_user_roles VALUES (1690, 3);
INSERT INTO links_user_roles VALUES (1690, 2);
INSERT INTO links_user_roles VALUES (1691, 1);
INSERT INTO links_user_roles VALUES (1691, 3);
INSERT INTO links_user_roles VALUES (1692, 2);
INSERT INTO links_user_roles VALUES (1693, 1);
INSERT INTO links_user_roles VALUES (1693, 3);
INSERT INTO links_user_roles VALUES (1693, 2);
INSERT INTO links_user_roles VALUES (1694, 1);
INSERT INTO links_user_roles VALUES (1694, 3);
INSERT INTO links_user_roles VALUES (1694, 2);
INSERT INTO links_user_roles VALUES (1695, 1);
INSERT INTO links_user_roles VALUES (1695, 3);
INSERT INTO links_user_roles VALUES (1695, 2);
INSERT INTO links_user_roles VALUES (1696, 3);
INSERT INTO links_user_roles VALUES (1696, 2);
INSERT INTO links_user_roles VALUES (1697, 1);
INSERT INTO links_user_roles VALUES (1697, 3);
INSERT INTO links_user_roles VALUES (1697, 2);
INSERT INTO links_user_roles VALUES (1698, 3);
INSERT INTO links_user_roles VALUES (1698, 2);
INSERT INTO links_user_roles VALUES (1699, 1);
INSERT INTO links_user_roles VALUES (1699, 3);
INSERT INTO links_user_roles VALUES (1699, 2);
INSERT INTO links_user_roles VALUES (1700, 1);
INSERT INTO links_user_roles VALUES (1701, 1);
INSERT INTO links_user_roles VALUES (1702, 1);
INSERT INTO links_user_roles VALUES (1703, 1);
INSERT INTO links_user_roles VALUES (1704, 1);
INSERT INTO links_user_roles VALUES (1704, 3);
INSERT INTO links_user_roles VALUES (1704, 2);
INSERT INTO links_user_roles VALUES (1705, 1);
INSERT INTO links_user_roles VALUES (1706, 1);
INSERT INTO links_user_roles VALUES (1707, 3);
INSERT INTO links_user_roles VALUES (1708, 1);
INSERT INTO links_user_roles VALUES (1708, 3);
INSERT INTO links_user_roles VALUES (1708, 2);
INSERT INTO links_user_roles VALUES (1709, 1);
INSERT INTO links_user_roles VALUES (1709, 3);
INSERT INTO links_user_roles VALUES (1709, 2);
INSERT INTO links_user_roles VALUES (1710, 1);
INSERT INTO links_user_roles VALUES (1710, 3);
INSERT INTO links_user_roles VALUES (1710, 2);
INSERT INTO links_user_roles VALUES (1711, 3);
INSERT INTO links_user_roles VALUES (1712, 1);
INSERT INTO links_user_roles VALUES (1712, 3);
INSERT INTO links_user_roles VALUES (1712, 2);
INSERT INTO links_user_roles VALUES (1713, 1);
INSERT INTO links_user_roles VALUES (1714, 1);
INSERT INTO links_user_roles VALUES (1714, 3);
INSERT INTO links_user_roles VALUES (1714, 2);
INSERT INTO links_user_roles VALUES (1715, 1);
INSERT INTO links_user_roles VALUES (1716, 1);
INSERT INTO links_user_roles VALUES (1716, 3);
INSERT INTO links_user_roles VALUES (1716, 2);
INSERT INTO links_user_roles VALUES (1717, 1);
INSERT INTO links_user_roles VALUES (1718, 1);
INSERT INTO links_user_roles VALUES (1719, 1);
INSERT INTO links_user_roles VALUES (1719, 3);
INSERT INTO links_user_roles VALUES (1719, 2);
INSERT INTO links_user_roles VALUES (1720, 1);
INSERT INTO links_user_roles VALUES (1720, 3);
INSERT INTO links_user_roles VALUES (1720, 2);
INSERT INTO links_user_roles VALUES (1721, 1);
INSERT INTO links_user_roles VALUES (1721, 3);
INSERT INTO links_user_roles VALUES (1721, 2);
INSERT INTO links_user_roles VALUES (1722, 1);
INSERT INTO links_user_roles VALUES (1723, 1);
INSERT INTO links_user_roles VALUES (1723, 3);
INSERT INTO links_user_roles VALUES (1723, 2);
INSERT INTO links_user_roles VALUES (1724, 3);
INSERT INTO links_user_roles VALUES (1724, 2);
INSERT INTO links_user_roles VALUES (1725, 1);
INSERT INTO links_user_roles VALUES (1725, 3);
INSERT INTO links_user_roles VALUES (1725, 2);
INSERT INTO links_user_roles VALUES (1726, 1);
INSERT INTO links_user_roles VALUES (1726, 3);
INSERT INTO links_user_roles VALUES (1726, 2);
INSERT INTO links_user_roles VALUES (1727, 1);
INSERT INTO links_user_roles VALUES (1727, 3);
INSERT INTO links_user_roles VALUES (1727, 2);
INSERT INTO links_user_roles VALUES (1728, 3);
INSERT INTO links_user_roles VALUES (1729, 1);
INSERT INTO links_user_roles VALUES (1730, 1);
INSERT INTO links_user_roles VALUES (1731, 1);
INSERT INTO links_user_roles VALUES (1732, 1);
INSERT INTO links_user_roles VALUES (1732, 3);
INSERT INTO links_user_roles VALUES (1732, 2);
INSERT INTO links_user_roles VALUES (1733, 1);
INSERT INTO links_user_roles VALUES (1733, 3);
INSERT INTO links_user_roles VALUES (1733, 2);
INSERT INTO links_user_roles VALUES (1734, 1);
INSERT INTO links_user_roles VALUES (1735, 1);
INSERT INTO links_user_roles VALUES (1735, 3);
INSERT INTO links_user_roles VALUES (1735, 2);
INSERT INTO links_user_roles VALUES (1736, 1);
INSERT INTO links_user_roles VALUES (1737, 1);
INSERT INTO links_user_roles VALUES (1738, 1);
INSERT INTO links_user_roles VALUES (1739, 1);
INSERT INTO links_user_roles VALUES (1740, 3);
INSERT INTO links_user_roles VALUES (1740, 2);
INSERT INTO links_user_roles VALUES (1741, 3);
INSERT INTO links_user_roles VALUES (1741, 2);
INSERT INTO links_user_roles VALUES (1742, 2);
INSERT INTO links_user_roles VALUES (1743, 1);
INSERT INTO links_user_roles VALUES (1744, 1);
INSERT INTO links_user_roles VALUES (1744, 3);
INSERT INTO links_user_roles VALUES (1744, 2);
INSERT INTO links_user_roles VALUES (1745, 1);
INSERT INTO links_user_roles VALUES (1745, 3);
INSERT INTO links_user_roles VALUES (1745, 2);
INSERT INTO links_user_roles VALUES (1746, 1);
INSERT INTO links_user_roles VALUES (1746, 3);
INSERT INTO links_user_roles VALUES (1746, 2);
INSERT INTO links_user_roles VALUES (1747, 1);
INSERT INTO links_user_roles VALUES (1747, 3);
INSERT INTO links_user_roles VALUES (1747, 2);
INSERT INTO links_user_roles VALUES (1748, 1);
INSERT INTO links_user_roles VALUES (1748, 3);
INSERT INTO links_user_roles VALUES (1748, 2);
INSERT INTO links_user_roles VALUES (1749, 1);
INSERT INTO links_user_roles VALUES (1750, 3);
INSERT INTO links_user_roles VALUES (1750, 2);
INSERT INTO links_user_roles VALUES (1751, 1);
INSERT INTO links_user_roles VALUES (1751, 3);
INSERT INTO links_user_roles VALUES (1751, 2);
INSERT INTO links_user_roles VALUES (1752, 1);
INSERT INTO links_user_roles VALUES (1753, 3);
INSERT INTO links_user_roles VALUES (1753, 2);
INSERT INTO links_user_roles VALUES (1754, 1);
INSERT INTO links_user_roles VALUES (1755, 1);
INSERT INTO links_user_roles VALUES (1756, 3);
INSERT INTO links_user_roles VALUES (1757, 1);
INSERT INTO links_user_roles VALUES (1758, 1);
INSERT INTO links_user_roles VALUES (1758, 3);
INSERT INTO links_user_roles VALUES (1758, 2);
INSERT INTO links_user_roles VALUES (1759, 1);
INSERT INTO links_user_roles VALUES (1759, 3);
INSERT INTO links_user_roles VALUES (1759, 2);
INSERT INTO links_user_roles VALUES (1760, 1);
INSERT INTO links_user_roles VALUES (1760, 3);
INSERT INTO links_user_roles VALUES (1760, 2);
INSERT INTO links_user_roles VALUES (1761, 1);
INSERT INTO links_user_roles VALUES (1762, 1);
INSERT INTO links_user_roles VALUES (1762, 3);
INSERT INTO links_user_roles VALUES (1762, 2);
INSERT INTO links_user_roles VALUES (1763, 2);
INSERT INTO links_user_roles VALUES (1764, 1);
INSERT INTO links_user_roles VALUES (1764, 3);
INSERT INTO links_user_roles VALUES (1764, 2);
INSERT INTO links_user_roles VALUES (1765, 1);
INSERT INTO links_user_roles VALUES (1766, 3);
INSERT INTO links_user_roles VALUES (1766, 2);
INSERT INTO links_user_roles VALUES (1767, 3);
INSERT INTO links_user_roles VALUES (1767, 2);
INSERT INTO links_user_roles VALUES (1768, 3);
INSERT INTO links_user_roles VALUES (1768, 2);
INSERT INTO links_user_roles VALUES (1769, 3);
INSERT INTO links_user_roles VALUES (1769, 2);
INSERT INTO links_user_roles VALUES (1770, 1);
INSERT INTO links_user_roles VALUES (1771, 1);
INSERT INTO links_user_roles VALUES (1771, 3);
INSERT INTO links_user_roles VALUES (1771, 2);
INSERT INTO links_user_roles VALUES (1772, 1);
INSERT INTO links_user_roles VALUES (1772, 3);
INSERT INTO links_user_roles VALUES (1772, 2);
INSERT INTO links_user_roles VALUES (1773, 1);
INSERT INTO links_user_roles VALUES (1773, 3);
INSERT INTO links_user_roles VALUES (1773, 2);
INSERT INTO links_user_roles VALUES (1774, 3);
INSERT INTO links_user_roles VALUES (1774, 2);
INSERT INTO links_user_roles VALUES (1775, 1);
INSERT INTO links_user_roles VALUES (1775, 3);
INSERT INTO links_user_roles VALUES (1775, 2);
INSERT INTO links_user_roles VALUES (1776, 1);
INSERT INTO links_user_roles VALUES (1777, 1);
INSERT INTO links_user_roles VALUES (1777, 3);
INSERT INTO links_user_roles VALUES (1777, 2);
INSERT INTO links_user_roles VALUES (1778, 1);
INSERT INTO links_user_roles VALUES (1778, 3);
INSERT INTO links_user_roles VALUES (1779, 1);
INSERT INTO links_user_roles VALUES (1780, 1);
INSERT INTO links_user_roles VALUES (1781, 1);
INSERT INTO links_user_roles VALUES (1782, 3);
INSERT INTO links_user_roles VALUES (1782, 2);
INSERT INTO links_user_roles VALUES (1783, 3);
INSERT INTO links_user_roles VALUES (1783, 2);
INSERT INTO links_user_roles VALUES (1784, 1);
INSERT INTO links_user_roles VALUES (1784, 3);
INSERT INTO links_user_roles VALUES (1784, 2);
INSERT INTO links_user_roles VALUES (1785, 3);
INSERT INTO links_user_roles VALUES (1785, 2);
INSERT INTO links_user_roles VALUES (1786, 1);
INSERT INTO links_user_roles VALUES (1787, 1);
INSERT INTO links_user_roles VALUES (1787, 3);
INSERT INTO links_user_roles VALUES (1787, 2);
INSERT INTO links_user_roles VALUES (1788, 1);
INSERT INTO links_user_roles VALUES (1788, 3);
INSERT INTO links_user_roles VALUES (1788, 2);
INSERT INTO links_user_roles VALUES (1789, 1);
INSERT INTO links_user_roles VALUES (1789, 3);
INSERT INTO links_user_roles VALUES (1789, 2);
INSERT INTO links_user_roles VALUES (1790, 3);
INSERT INTO links_user_roles VALUES (1790, 2);
INSERT INTO links_user_roles VALUES (1791, 3);
INSERT INTO links_user_roles VALUES (1791, 2);
INSERT INTO links_user_roles VALUES (1792, 1);
INSERT INTO links_user_roles VALUES (1792, 3);
INSERT INTO links_user_roles VALUES (1792, 2);
INSERT INTO links_user_roles VALUES (1793, 1);
INSERT INTO links_user_roles VALUES (1793, 3);
INSERT INTO links_user_roles VALUES (1793, 2);
INSERT INTO links_user_roles VALUES (1794, 1);
INSERT INTO links_user_roles VALUES (1795, 1);
INSERT INTO links_user_roles VALUES (1796, 1);
INSERT INTO links_user_roles VALUES (1797, 1);
INSERT INTO links_user_roles VALUES (1798, 3);
INSERT INTO links_user_roles VALUES (1798, 2);
INSERT INTO links_user_roles VALUES (1799, 1);
INSERT INTO links_user_roles VALUES (1800, 1);
INSERT INTO links_user_roles VALUES (1800, 3);
INSERT INTO links_user_roles VALUES (1800, 2);
INSERT INTO links_user_roles VALUES (1801, 1);
INSERT INTO links_user_roles VALUES (1802, 3);
INSERT INTO links_user_roles VALUES (1803, 1);
INSERT INTO links_user_roles VALUES (1804, 1);
INSERT INTO links_user_roles VALUES (1804, 3);
INSERT INTO links_user_roles VALUES (1804, 2);
INSERT INTO links_user_roles VALUES (1805, 1);
INSERT INTO links_user_roles VALUES (1805, 3);
INSERT INTO links_user_roles VALUES (1805, 2);
INSERT INTO links_user_roles VALUES (1806, 1);
INSERT INTO links_user_roles VALUES (1806, 3);
INSERT INTO links_user_roles VALUES (1806, 2);
INSERT INTO links_user_roles VALUES (1807, 1);
INSERT INTO links_user_roles VALUES (1808, 3);
INSERT INTO links_user_roles VALUES (1808, 2);
INSERT INTO links_user_roles VALUES (1809, 1);
INSERT INTO links_user_roles VALUES (1809, 3);
INSERT INTO links_user_roles VALUES (1809, 2);
INSERT INTO links_user_roles VALUES (1810, 1);
INSERT INTO links_user_roles VALUES (1811, 1);
INSERT INTO links_user_roles VALUES (1811, 3);
INSERT INTO links_user_roles VALUES (1811, 2);
INSERT INTO links_user_roles VALUES (1812, 1);
INSERT INTO links_user_roles VALUES (1813, 1);
INSERT INTO links_user_roles VALUES (1813, 3);
INSERT INTO links_user_roles VALUES (1813, 2);
INSERT INTO links_user_roles VALUES (1814, 3);
INSERT INTO links_user_roles VALUES (1814, 2);
INSERT INTO links_user_roles VALUES (1815, 1);
INSERT INTO links_user_roles VALUES (1816, 1);
INSERT INTO links_user_roles VALUES (1816, 3);
INSERT INTO links_user_roles VALUES (1816, 2);
INSERT INTO links_user_roles VALUES (1817, 1);
INSERT INTO links_user_roles VALUES (1817, 3);
INSERT INTO links_user_roles VALUES (1817, 2);
INSERT INTO links_user_roles VALUES (1818, 1);
INSERT INTO links_user_roles VALUES (1819, 1);
INSERT INTO links_user_roles VALUES (1819, 3);
INSERT INTO links_user_roles VALUES (1819, 2);
INSERT INTO links_user_roles VALUES (1820, 3);
INSERT INTO links_user_roles VALUES (1820, 2);
INSERT INTO links_user_roles VALUES (1821, 1);
INSERT INTO links_user_roles VALUES (1822, 1);
INSERT INTO links_user_roles VALUES (1823, 1);

--
-- Data for Name: oec_course_codes; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO oec_course_codes VALUES (1, 'A,RESEC', '', 'MBARC', true, '2015-08-13 23:26:35.356', '2015-08-13 23:26:35.356');
INSERT INTO oec_course_codes VALUES (2, 'AEROSPC', '', 'QLROT', true, '2015-08-13 23:26:35.38', '2015-08-13 23:26:35.38');
INSERT INTO oec_course_codes VALUES (3, 'AFRICAM', '', 'SAAMS', true, '2015-08-13 23:26:35.388', '2015-08-13 23:26:35.388');
INSERT INTO oec_course_codes VALUES (4, 'AFRKANS', '', 'HZGER', true, '2015-08-13 23:26:35.399', '2015-08-13 23:26:35.399');
INSERT INTO oec_course_codes VALUES (5, 'AGR CHM', '', 'MEPMB', true, '2015-08-13 23:26:35.408', '2015-08-13 23:26:35.408');
INSERT INTO oec_course_codes VALUES (6, 'AHMA', '', 'HTAHN', false, '2015-08-13 23:26:35.417', '2015-08-13 23:26:35.417');
INSERT INTO oec_course_codes VALUES (7, 'ALTAIC', '', 'HGEAL', true, '2015-08-13 23:26:35.426', '2015-08-13 23:26:35.426');
INSERT INTO oec_course_codes VALUES (8, 'AMERSTD', '', 'QHUIS', true, '2015-08-13 23:26:35.433', '2015-08-13 23:26:35.433');
INSERT INTO oec_course_codes VALUES (9, 'ANTHRO', '', 'SZANT', true, '2015-08-13 23:26:35.444', '2015-08-13 23:26:35.444');
INSERT INTO oec_course_codes VALUES (10, 'ARABIC', '', 'HNNES', false, '2015-08-13 23:26:35.452', '2015-08-13 23:26:35.452');
INSERT INTO oec_course_codes VALUES (11, 'ARCH', '', 'DBARC', false, '2015-08-13 23:26:35.461', '2015-08-13 23:26:35.461');
INSERT INTO oec_course_codes VALUES (12, 'ART', '', 'LQAPR', false, '2015-08-13 23:26:35.471', '2015-08-13 23:26:35.471');
INSERT INTO oec_course_codes VALUES (13, 'ARMENI', '', 'LTSLL', true, '2015-08-13 23:26:35.482', '2015-08-13 23:26:35.482');
INSERT INTO oec_course_codes VALUES (14, 'ASAMST', '', 'SBETH', true, '2015-08-13 23:26:35.49', '2015-08-13 23:26:35.49');
INSERT INTO oec_course_codes VALUES (15, 'ASIANST', '', 'QIIAS', true, '2015-08-13 23:26:35.498', '2015-08-13 23:26:35.498');
INSERT INTO oec_course_codes VALUES (16, 'AST', '', 'EDDNO', true, '2015-08-13 23:26:35.506', '2015-08-13 23:26:35.506');
INSERT INTO oec_course_codes VALUES (17, 'ASTRON', '', 'PAAST', true, '2015-08-13 23:26:35.513', '2015-08-13 23:26:35.513');
INSERT INTO oec_course_codes VALUES (18, 'BANGLA', '', 'HVSSA', false, '2015-08-13 23:26:35.52', '2015-08-13 23:26:35.52');
INSERT INTO oec_course_codes VALUES (19, 'BIO ENG', '', 'EFBIO', true, '2015-08-13 23:26:35.528', '2015-08-13 23:26:35.528');
INSERT INTO oec_course_codes VALUES (20, 'BIOLOGY', '1A', 'IMMCB', true, '2015-08-13 23:26:35.534', '2015-08-13 23:26:35.534');
INSERT INTO oec_course_codes VALUES (21, 'BIOLOGY', '1AL', 'IMMCB', true, '2015-08-13 23:26:35.542', '2015-08-13 23:26:35.542');
INSERT INTO oec_course_codes VALUES (22, 'BIOLOGY', '1B', 'IBIBI', true, '2015-08-13 23:26:35.55', '2015-08-13 23:26:35.55');
INSERT INTO oec_course_codes VALUES (23, 'BIOLOGY', '1BL', 'IBIBI', true, '2015-08-13 23:26:35.558', '2015-08-13 23:26:35.558');
INSERT INTO oec_course_codes VALUES (24, 'BIOPHY', '', 'IQBBB', false, '2015-08-13 23:26:35.565', '2015-08-13 23:26:35.565');
INSERT INTO oec_course_codes VALUES (25, 'BOSCRSR', '', 'LTSLL', true, '2015-08-13 23:26:35.573', '2015-08-13 23:26:35.573');
INSERT INTO oec_course_codes VALUES (26, 'BUDDSTD', '', 'HGEAL', true, '2015-08-13 23:26:35.596', '2015-08-13 23:26:35.596');
INSERT INTO oec_course_codes VALUES (27, 'BULGARI', '', 'LTSLL', true, '2015-08-13 23:26:35.608', '2015-08-13 23:26:35.608');
INSERT INTO oec_course_codes VALUES (28, 'BUS ADM', '', 'BAHSB', false, '2015-08-13 23:26:35.619', '2015-08-13 23:26:35.619');
INSERT INTO oec_course_codes VALUES (29, 'CATALAN', '', 'LPSPP', true, '2015-08-13 23:26:35.629', '2015-08-13 23:26:35.629');
INSERT INTO oec_course_codes VALUES (30, 'CELTIC', '', 'CELTIC', true, '2015-08-13 23:26:35.64', '2015-08-13 23:26:35.64');
INSERT INTO oec_course_codes VALUES (31, 'CHEM', '', 'CCHEM', true, '2015-08-13 23:26:35.648', '2015-08-13 23:26:35.648');
INSERT INTO oec_course_codes VALUES (32, 'CHICANO', '', 'SBETH', true, '2015-08-13 23:26:35.655', '2015-08-13 23:26:35.655');
INSERT INTO oec_course_codes VALUES (33, 'CHINESE', '', 'HGEAL', true, '2015-08-13 23:26:35.664', '2015-08-13 23:26:35.664');
INSERT INTO oec_course_codes VALUES (34, 'CHM ENG', '', 'CEEEG', false, '2015-08-13 23:26:35.671', '2015-08-13 23:26:35.671');
INSERT INTO oec_course_codes VALUES (35, 'CIV ENG', '', 'EGCEE', true, '2015-08-13 23:26:35.684', '2015-08-13 23:26:35.684');
INSERT INTO oec_course_codes VALUES (36, 'CLASSIC', '', 'LSCLA', false, '2015-08-13 23:26:35.695', '2015-08-13 23:26:35.695');
INSERT INTO oec_course_codes VALUES (37, 'CMPBIO', '', 'BMCCB', true, '2015-08-13 23:26:35.704', '2015-08-13 23:26:35.704');
INSERT INTO oec_course_codes VALUES (38, 'COG SCI', '', 'QIIAS', true, '2015-08-13 23:26:35.711', '2015-08-13 23:26:35.711');
INSERT INTO oec_course_codes VALUES (39, 'COLWRIT', '', 'QKCWP', true, '2015-08-13 23:26:35.719', '2015-08-13 23:26:35.719');
INSERT INTO oec_course_codes VALUES (40, 'COM LIT', '', 'HLCOM', true, '2015-08-13 23:26:35.726', '2015-08-13 23:26:35.726');
INSERT INTO oec_course_codes VALUES (41, 'COMPBIO', '', 'OLGDD', true, '2015-08-13 23:26:35.733', '2015-08-13 23:26:35.733');
INSERT INTO oec_course_codes VALUES (42, 'COMPSCI', '', 'EHEEC', true, '2015-08-13 23:26:35.74', '2015-08-13 23:26:35.74');
INSERT INTO oec_course_codes VALUES (43, 'CRIT TH', '', 'CRTHE', false, '2015-08-13 23:26:35.749', '2015-08-13 23:26:35.749');
INSERT INTO oec_course_codes VALUES (44, 'CRWRIT', '', 'HENGL', true, '2015-08-13 23:26:35.756', '2015-08-13 23:26:35.756');
INSERT INTO oec_course_codes VALUES (45, 'CUNEIF', '', 'HNNES', false, '2015-08-13 23:26:35.766', '2015-08-13 23:26:35.766');
INSERT INTO oec_course_codes VALUES (46, 'CY PLAN', '', 'DCCRP', false, '2015-08-13 23:26:35.773', '2015-08-13 23:26:35.773');
INSERT INTO oec_course_codes VALUES (47, 'CZECH', '', 'LTSLL', true, '2015-08-13 23:26:35.781', '2015-08-13 23:26:35.781');
INSERT INTO oec_course_codes VALUES (48, 'DANISH', '', 'HSCAN', true, '2015-08-13 23:26:35.797', '2015-08-13 23:26:35.797');
INSERT INTO oec_course_codes VALUES (49, 'DATASCI', '', 'MMIMS', true, '2015-08-13 23:26:35.805', '2015-08-13 23:26:35.805');
INSERT INTO oec_course_codes VALUES (50, 'DEMOG', '', 'SDDEM', false, '2015-08-13 23:26:35.811', '2015-08-13 23:26:35.811');
INSERT INTO oec_course_codes VALUES (51, 'DES INV', '', 'EDDNO', true, '2015-08-13 23:26:35.817', '2015-08-13 23:26:35.817');
INSERT INTO oec_course_codes VALUES (52, 'DEV ENG', '', 'EGCEE', true, '2015-08-13 23:26:35.825', '2015-08-13 23:26:35.825');
INSERT INTO oec_course_codes VALUES (53, 'DEV STD', '', 'QIIAS', true, '2015-08-13 23:26:35.833', '2015-08-13 23:26:35.833');
INSERT INTO oec_course_codes VALUES (54, 'DEVP', '', 'MANRD', true, '2015-08-13 23:26:35.841', '2015-08-13 23:26:35.841');
INSERT INTO oec_course_codes VALUES (55, 'DUTCH', '', 'HZGER', true, '2015-08-13 23:26:35.847', '2015-08-13 23:26:35.847');
INSERT INTO oec_course_codes VALUES (56, 'EA LANG', '', 'HGEAL', true, '2015-08-13 23:26:35.855', '2015-08-13 23:26:35.855');
INSERT INTO oec_course_codes VALUES (57, 'EAEURST', '', 'LTSLL', true, '2015-08-13 23:26:35.863', '2015-08-13 23:26:35.863');
INSERT INTO oec_course_codes VALUES (58, 'ECON', '', 'SECON', true, '2015-08-13 23:26:35.878', '2015-08-13 23:26:35.878');
INSERT INTO oec_course_codes VALUES (59, 'EDUC', '', 'EAEDU', false, '2015-08-13 23:26:35.887', '2015-08-13 23:26:35.887');
INSERT INTO oec_course_codes VALUES (60, 'EECS', '', 'EHEEC', true, '2015-08-13 23:26:35.894', '2015-08-13 23:26:35.894');
INSERT INTO oec_course_codes VALUES (61, 'EGYPT', '', 'HNNES', false, '2015-08-13 23:26:35.903', '2015-08-13 23:26:35.903');
INSERT INTO oec_course_codes VALUES (62, 'EL ENG', '', 'EHEEC', true, '2015-08-13 23:26:35.916', '2015-08-13 23:26:35.916');
INSERT INTO oec_course_codes VALUES (63, 'ENE,RES', '', 'MGERG', true, '2015-08-13 23:26:35.934', '2015-08-13 23:26:35.934');
INSERT INTO oec_course_codes VALUES (64, 'ENGIN', '', 'EDDNO', true, '2015-08-13 23:26:35.944', '2015-08-13 23:26:35.944');
INSERT INTO oec_course_codes VALUES (65, 'ENGLISH', '', 'HENGL', false, '2015-08-13 23:26:35.949', '2015-08-13 23:26:35.949');
INSERT INTO oec_course_codes VALUES (66, 'ENV DES', '', 'DACED', false, '2015-08-13 23:26:35.954', '2015-08-13 23:26:35.954');
INSERT INTO oec_course_codes VALUES (67, 'ENV SCI', '', 'MCESP', true, '2015-08-13 23:26:35.96', '2015-08-13 23:26:35.96');
INSERT INTO oec_course_codes VALUES (68, 'ENVECON', '', 'MBARC', true, '2015-08-13 23:26:35.965', '2015-08-13 23:26:35.965');
INSERT INTO oec_course_codes VALUES (69, 'EPS', '', 'PGEGE', true, '2015-08-13 23:26:35.97', '2015-08-13 23:26:35.97');
INSERT INTO oec_course_codes VALUES (70, 'ESPM', '', 'MCESP', true, '2015-08-13 23:26:35.974', '2015-08-13 23:26:35.974');
INSERT INTO oec_course_codes VALUES (71, 'ETH GRP', '', 'SBETH', true, '2015-08-13 23:26:35.98', '2015-08-13 23:26:35.98');
INSERT INTO oec_course_codes VALUES (72, 'ETH STD', '', 'SBETH', true, '2015-08-13 23:26:35.985', '2015-08-13 23:26:35.985');
INSERT INTO oec_course_codes VALUES (73, 'EURA ST', '', 'LTSLL', true, '2015-08-13 23:26:35.99', '2015-08-13 23:26:35.99');
INSERT INTO oec_course_codes VALUES (74, 'EUST', '', 'LTSLL', true, '2015-08-13 23:26:35.994', '2015-08-13 23:26:35.994');
INSERT INTO oec_course_codes VALUES (75, 'EWMBA', '', 'BAHSB', false, '2015-08-13 23:26:36', '2015-08-13 23:26:36');
INSERT INTO oec_course_codes VALUES (76, 'FILIPN', '', 'HVSSA', false, '2015-08-13 23:26:36.005', '2015-08-13 23:26:36.005');
INSERT INTO oec_course_codes VALUES (77, 'FILM', '', 'HUFLM', false, '2015-08-13 23:26:36.01', '2015-08-13 23:26:36.01');
INSERT INTO oec_course_codes VALUES (78, 'FINNISH', '', 'HSCAN', true, '2015-08-13 23:26:36.015', '2015-08-13 23:26:36.015');
INSERT INTO oec_course_codes VALUES (79, 'FOLKLOR', '', 'SZANT', false, '2015-08-13 23:26:36.02', '2015-08-13 23:26:36.02');
INSERT INTO oec_course_codes VALUES (80, 'FRENCH', '', 'HFREN', true, '2015-08-13 23:26:36.025', '2015-08-13 23:26:36.025');
INSERT INTO oec_course_codes VALUES (81, 'GEOG', '', 'SGEOG', true, '2015-08-13 23:26:36.03', '2015-08-13 23:26:36.03');
INSERT INTO oec_course_codes VALUES (82, 'GERMAN', '', 'HZGER', true, '2015-08-13 23:26:36.036', '2015-08-13 23:26:36.036');
INSERT INTO oec_course_codes VALUES (83, 'GMS', '', 'BUGMS', false, '2015-08-13 23:26:36.04', '2015-08-13 23:26:36.04');
INSERT INTO oec_course_codes VALUES (84, 'GPP', '', 'QIIAS', true, '2015-08-13 23:26:36.045', '2015-08-13 23:26:36.045');
INSERT INTO oec_course_codes VALUES (85, 'GREEK', '', 'LSCLA', false, '2015-08-13 23:26:36.051', '2015-08-13 23:26:36.051');
INSERT INTO oec_course_codes VALUES (86, 'GSPDP', '', 'OLGDD', true, '2015-08-13 23:26:36.055', '2015-08-13 23:26:36.055');
INSERT INTO oec_course_codes VALUES (87, 'GWS', '', 'SWOME', true, '2015-08-13 23:26:36.06', '2015-08-13 23:26:36.06');
INSERT INTO oec_course_codes VALUES (88, 'HEBREW', '', 'HNNES', false, '2015-08-13 23:26:36.065', '2015-08-13 23:26:36.065');
INSERT INTO oec_course_codes VALUES (89, 'HIN-URD', '', 'HVSSA', false, '2015-08-13 23:26:36.07', '2015-08-13 23:26:36.07');
INSERT INTO oec_course_codes VALUES (90, 'HISTART', '', 'HARTH', false, '2015-08-13 23:26:36.075', '2015-08-13 23:26:36.075');
INSERT INTO oec_course_codes VALUES (91, 'HISTORY', '', 'SHIST', true, '2015-08-13 23:26:36.079', '2015-08-13 23:26:36.079');
INSERT INTO oec_course_codes VALUES (92, 'HMEDSCI', '', 'CPACA', true, '2015-08-13 23:26:36.084', '2015-08-13 23:26:36.084');
INSERT INTO oec_course_codes VALUES (93, 'HUNGARI', '', 'LTSLL', true, '2015-08-13 23:26:36.089', '2015-08-13 23:26:36.089');
INSERT INTO oec_course_codes VALUES (94, 'IAS', '', 'QIIAS', true, '2015-08-13 23:26:36.094', '2015-08-13 23:26:36.094');
INSERT INTO oec_course_codes VALUES (95, 'ICELAND', '', 'HSCAN', true, '2015-08-13 23:26:36.099', '2015-08-13 23:26:36.099');
INSERT INTO oec_course_codes VALUES (96, 'ILA', '', 'LPSPP', true, '2015-08-13 23:26:36.103', '2015-08-13 23:26:36.103');
INSERT INTO oec_course_codes VALUES (97, 'IND ENG', '', 'EIIEO', true, '2015-08-13 23:26:36.108', '2015-08-13 23:26:36.108');
INSERT INTO oec_course_codes VALUES (98, 'INFO', '', 'MMIMS', true, '2015-08-13 23:26:36.113', '2015-08-13 23:26:36.113');
INSERT INTO oec_course_codes VALUES (99, 'INTEGBI', '', 'IBIBI', true, '2015-08-13 23:26:36.118', '2015-08-13 23:26:36.118');
INSERT INTO oec_course_codes VALUES (100, 'IRANIAN', '', 'HNNES', false, '2015-08-13 23:26:36.123', '2015-08-13 23:26:36.123');
INSERT INTO oec_course_codes VALUES (101, 'ISF', '', 'ISF', true, '2015-08-13 23:26:36.127', '2015-08-13 23:26:36.127');
INSERT INTO oec_course_codes VALUES (102, 'ITALIAN', '', 'HITAL', true, '2015-08-13 23:26:36.132', '2015-08-13 23:26:36.132');
INSERT INTO oec_course_codes VALUES (103, 'JAPAN', '', 'HGEAL', true, '2015-08-13 23:26:36.139', '2015-08-13 23:26:36.139');
INSERT INTO oec_course_codes VALUES (104, 'JEWISH', '', 'KDCJS', false, '2015-08-13 23:26:36.143', '2015-08-13 23:26:36.143');
INSERT INTO oec_course_codes VALUES (105, 'JOURN', '', 'DJOUR', true, '2015-08-13 23:26:36.148', '2015-08-13 23:26:36.148');
INSERT INTO oec_course_codes VALUES (106, 'KHMER', '', 'HVSSA', false, '2015-08-13 23:26:36.152', '2015-08-13 23:26:36.152');
INSERT INTO oec_course_codes VALUES (107, 'KOREAN', '', 'HGEAL', true, '2015-08-13 23:26:36.157', '2015-08-13 23:26:36.157');
INSERT INTO oec_course_codes VALUES (108, 'L & S', '', 'QHUIS', true, '2015-08-13 23:26:36.16', '2015-08-13 23:26:36.16');
INSERT INTO oec_course_codes VALUES (109, 'LAN PRO', '', 'OLGDD', true, '2015-08-13 23:26:36.164', '2015-08-13 23:26:36.164');
INSERT INTO oec_course_codes VALUES (110, 'LATAMST', '', 'QIIAS', true, '2015-08-13 23:26:36.169', '2015-08-13 23:26:36.169');
INSERT INTO oec_course_codes VALUES (111, 'LATIN', '', 'LSCLA', false, '2015-08-13 23:26:36.174', '2015-08-13 23:26:36.174');
INSERT INTO oec_course_codes VALUES (112, 'LAW', '', 'CLLAW', false, '2015-08-13 23:26:36.178', '2015-08-13 23:26:36.178');
INSERT INTO oec_course_codes VALUES (113, 'LD ARCH', '', 'DFLAE', false, '2015-08-13 23:26:36.183', '2015-08-13 23:26:36.183');
INSERT INTO oec_course_codes VALUES (114, 'LEGALST', '', 'CLLAW', false, '2015-08-13 23:26:36.187', '2015-08-13 23:26:36.187');
INSERT INTO oec_course_codes VALUES (115, 'LGBT', '', 'SWOME', true, '2015-08-13 23:26:36.192', '2015-08-13 23:26:36.192');
INSERT INTO oec_course_codes VALUES (116, 'LINGUIS', '', 'SLING', true, '2015-08-13 23:26:36.199', '2015-08-13 23:26:36.199');
INSERT INTO oec_course_codes VALUES (117, 'M E STU', '', 'QIIAS', true, '2015-08-13 23:26:36.203', '2015-08-13 23:26:36.203');
INSERT INTO oec_course_codes VALUES (118, 'MALAY/I', '', 'HVSSA', false, '2015-08-13 23:26:36.207', '2015-08-13 23:26:36.207');
INSERT INTO oec_course_codes VALUES (119, 'MAT SCI', '', 'EJMSM', true, '2015-08-13 23:26:36.211', '2015-08-13 23:26:36.211');
INSERT INTO oec_course_codes VALUES (120, 'MATH', '', 'PMATH', true, '2015-08-13 23:26:36.215', '2015-08-13 23:26:36.215');
INSERT INTO oec_course_codes VALUES (121, 'MBA', '', 'BAHSB', false, '2015-08-13 23:26:36.22', '2015-08-13 23:26:36.22');
INSERT INTO oec_course_codes VALUES (122, 'MCELLBI', '', 'IMMCB', true, '2015-08-13 23:26:36.224', '2015-08-13 23:26:36.224');
INSERT INTO oec_course_codes VALUES (123, 'MEC ENG', '', 'EKMEG', true, '2015-08-13 23:26:36.228', '2015-08-13 23:26:36.228');
INSERT INTO oec_course_codes VALUES (124, 'MED ST', '', 'HPMED', false, '2015-08-13 23:26:36.235', '2015-08-13 23:26:36.235');
INSERT INTO oec_course_codes VALUES (125, 'MEDIAST', '', 'MEDIAST', true, '2015-08-13 23:26:36.239', '2015-08-13 23:26:36.239');
INSERT INTO oec_course_codes VALUES (126, 'MFE', '', 'BAHSB', false, '2015-08-13 23:26:36.243', '2015-08-13 23:26:36.243');
INSERT INTO oec_course_codes VALUES (127, 'MIL AFF', '', 'QLROT', true, '2015-08-13 23:26:36.247', '2015-08-13 23:26:36.247');
INSERT INTO oec_course_codes VALUES (128, 'MIL SCI', '', 'QLROT', true, '2015-08-13 23:26:36.251', '2015-08-13 23:26:36.251');
INSERT INTO oec_course_codes VALUES (129, 'MONGOLN', '', 'HGEAL', true, '2015-08-13 23:26:36.256', '2015-08-13 23:26:36.256');
INSERT INTO oec_course_codes VALUES (130, 'MUSIC', '', 'HMUSC', true, '2015-08-13 23:26:36.261', '2015-08-13 23:26:36.261');
INSERT INTO oec_course_codes VALUES (131, 'NAT RES', '', 'MANRD', true, '2015-08-13 23:26:36.265', '2015-08-13 23:26:36.265');
INSERT INTO oec_course_codes VALUES (132, 'NATAMST', '', 'SBETH', true, '2015-08-13 23:26:36.269', '2015-08-13 23:26:36.269');
INSERT INTO oec_course_codes VALUES (133, 'NAV SCI', '', 'QLROT', true, '2015-08-13 23:26:36.273', '2015-08-13 23:26:36.273');
INSERT INTO oec_course_codes VALUES (134, 'NE STUD', '', 'HNNES', false, '2015-08-13 23:26:36.278', '2015-08-13 23:26:36.278');
INSERT INTO oec_course_codes VALUES (135, 'NEUROSC', '', 'EUNEU', true, '2015-08-13 23:26:36.282', '2015-08-13 23:26:36.282');
INSERT INTO oec_course_codes VALUES (136, 'NORWEGN', '', 'HSCAN', true, '2015-08-13 23:26:36.286', '2015-08-13 23:26:36.286');
INSERT INTO oec_course_codes VALUES (137, 'NSE', '', 'EDDNO', true, '2015-08-13 23:26:36.29', '2015-08-13 23:26:36.29');
INSERT INTO oec_course_codes VALUES (138, 'NUC ENG', '', 'ELNUC', true, '2015-08-13 23:26:36.294', '2015-08-13 23:26:36.294');
INSERT INTO oec_course_codes VALUES (139, 'NUSCTX', '', 'MDNST', true, '2015-08-13 23:26:36.297', '2015-08-13 23:26:36.297');
INSERT INTO oec_course_codes VALUES (140, 'NWMEDIA', '', 'BTCNM', true, '2015-08-13 23:26:36.302', '2015-08-13 23:26:36.302');
INSERT INTO oec_course_codes VALUES (141, 'OPTOM', '', 'BOOPT', false, '2015-08-13 23:26:36.307', '2015-08-13 23:26:36.307');
INSERT INTO oec_course_codes VALUES (142, 'PACS', '', 'QIIAS', true, '2015-08-13 23:26:36.311', '2015-08-13 23:26:36.311');
INSERT INTO oec_course_codes VALUES (143, 'PB HLTH', '', 'CPACA', true, '2015-08-13 23:26:36.315', '2015-08-13 23:26:36.315');
INSERT INTO oec_course_codes VALUES (144, 'PERSIAN', '', 'HNNES', false, '2015-08-13 23:26:36.319', '2015-08-13 23:26:36.319');
INSERT INTO oec_course_codes VALUES (145, 'PHDBA', '', 'BAHSB', false, '2015-08-13 23:26:36.323', '2015-08-13 23:26:36.323');
INSERT INTO oec_course_codes VALUES (146, 'PHILOS', '', 'HCPHI', false, '2015-08-13 23:26:36.327', '2015-08-13 23:26:36.327');
INSERT INTO oec_course_codes VALUES (147, 'PHYS ED', '', 'IPPEP', true, '2015-08-13 23:26:36.331', '2015-08-13 23:26:36.331');
INSERT INTO oec_course_codes VALUES (148, 'PHYSICS', '', 'PHYSI', true, '2015-08-13 23:26:36.335', '2015-08-13 23:26:36.335');
INSERT INTO oec_course_codes VALUES (149, 'PLANTBI', '', 'MEPMB', true, '2015-08-13 23:26:36.339', '2015-08-13 23:26:36.339');
INSERT INTO oec_course_codes VALUES (150, 'POL SCI', '', 'SPOLS', true, '2015-08-13 23:26:36.344', '2015-08-13 23:26:36.344');
INSERT INTO oec_course_codes VALUES (151, 'POLECON', '', 'QIIAS', true, '2015-08-13 23:26:36.35', '2015-08-13 23:26:36.35');
INSERT INTO oec_course_codes VALUES (152, 'POLISH', '', 'LTSLL', true, '2015-08-13 23:26:36.355', '2015-08-13 23:26:36.355');
INSERT INTO oec_course_codes VALUES (153, 'PORTUG', '', 'LPSPP', true, '2015-08-13 23:26:36.359', '2015-08-13 23:26:36.359');
INSERT INTO oec_course_codes VALUES (154, 'PSYCH', '', 'SYPSY', true, '2015-08-13 23:26:36.363', '2015-08-13 23:26:36.363');
INSERT INTO oec_course_codes VALUES (155, 'PUB POL', '', 'CFPPR', false, '2015-08-13 23:26:36.367', '2015-08-13 23:26:36.367');
INSERT INTO oec_course_codes VALUES (156, 'PUNJABI', '', 'HVSSA', false, '2015-08-13 23:26:36.371', '2015-08-13 23:26:36.371');
INSERT INTO oec_course_codes VALUES (157, 'RELIGST', '', 'QHUIS', true, '2015-08-13 23:26:36.375', '2015-08-13 23:26:36.375');
INSERT INTO oec_course_codes VALUES (158, 'RHETOR', '', 'HRHET', false, '2015-08-13 23:26:36.379', '2015-08-13 23:26:36.379');
INSERT INTO oec_course_codes VALUES (159, 'ROMANI', '', 'LTSLL', true, '2015-08-13 23:26:36.383', '2015-08-13 23:26:36.383');
INSERT INTO oec_course_codes VALUES (160, 'RUSSIAN', '', 'LTSLL', true, '2015-08-13 23:26:36.387', '2015-08-13 23:26:36.387');
INSERT INTO oec_course_codes VALUES (161, 'S ASIAN', '', 'HVSSA', false, '2015-08-13 23:26:36.392', '2015-08-13 23:26:36.392');
INSERT INTO oec_course_codes VALUES (162, 'S,SEASN', '', 'HVSSA', false, '2015-08-13 23:26:36.396', '2015-08-13 23:26:36.396');
INSERT INTO oec_course_codes VALUES (163, 'SANSKR', '', 'HVSSA', false, '2015-08-13 23:26:36.401', '2015-08-13 23:26:36.401');
INSERT INTO oec_course_codes VALUES (164, 'SCANDIN', '', 'HSCAN', true, '2015-08-13 23:26:36.405', '2015-08-13 23:26:36.405');
INSERT INTO oec_course_codes VALUES (165, 'SCMATHE', '', 'EAEDU', false, '2015-08-13 23:26:36.409', '2015-08-13 23:26:36.409');
INSERT INTO oec_course_codes VALUES (166, 'SEASIAN', '', 'HVSSA', false, '2015-08-13 23:26:36.413', '2015-08-13 23:26:36.413');
INSERT INTO oec_course_codes VALUES (167, 'SEMITIC', '', 'HNNES', false, '2015-08-13 23:26:36.417', '2015-08-13 23:26:36.417');
INSERT INTO oec_course_codes VALUES (168, 'SLAVIC', '', 'LTSLL', true, '2015-08-13 23:26:36.421', '2015-08-13 23:26:36.421');
INSERT INTO oec_course_codes VALUES (169, 'SOC WEL', '', 'CSDEP', true, '2015-08-13 23:26:36.425', '2015-08-13 23:26:36.425');
INSERT INTO oec_course_codes VALUES (170, 'SOCIOL', '', 'SISOC', false, '2015-08-13 23:26:36.429', '2015-08-13 23:26:36.429');
INSERT INTO oec_course_codes VALUES (171, 'SPANISH', '', 'LPSPP', true, '2015-08-13 23:26:36.433', '2015-08-13 23:26:36.433');
INSERT INTO oec_course_codes VALUES (172, 'STAT', '', 'PSTAT', true, '2015-08-13 23:26:36.437', '2015-08-13 23:26:36.437');
INSERT INTO oec_course_codes VALUES (173, 'STS', '', 'JYHST', false, '2015-08-13 23:26:36.441', '2015-08-13 23:26:36.441');
INSERT INTO oec_course_codes VALUES (174, 'SWEDISH', '', 'HSCAN', true, '2015-08-13 23:26:36.446', '2015-08-13 23:26:36.446');
INSERT INTO oec_course_codes VALUES (175, 'TAGALG', '', 'HVSSA', false, '2015-08-13 23:26:36.45', '2015-08-13 23:26:36.45');
INSERT INTO oec_course_codes VALUES (176, 'TAMIL', '', 'HVSSA', false, '2015-08-13 23:26:36.454', '2015-08-13 23:26:36.454');
INSERT INTO oec_course_codes VALUES (177, 'TELUGU', '', 'HVSSA', false, '2015-08-13 23:26:36.458', '2015-08-13 23:26:36.458');
INSERT INTO oec_course_codes VALUES (178, 'THAI', '', 'HVSSA', false, '2015-08-13 23:26:36.462', '2015-08-13 23:26:36.462');
INSERT INTO oec_course_codes VALUES (179, 'THEATER', '', 'HDRAM', true, '2015-08-13 23:26:36.465', '2015-08-13 23:26:36.465');
INSERT INTO oec_course_codes VALUES (180, 'TIBETAN', '', 'HGEAL', true, '2015-08-13 23:26:36.469', '2015-08-13 23:26:36.469');
INSERT INTO oec_course_codes VALUES (181, 'TURKISH', '', 'HNNES', false, '2015-08-13 23:26:36.473', '2015-08-13 23:26:36.473');
INSERT INTO oec_course_codes VALUES (182, 'UGBA', '', 'BAHSB', false, '2015-08-13 23:26:36.477', '2015-08-13 23:26:36.477');
INSERT INTO oec_course_codes VALUES (183, 'UGIS', '', 'QHUIS', true, '2015-08-13 23:26:36.482', '2015-08-13 23:26:36.482');
INSERT INTO oec_course_codes VALUES (184, 'VIETNMS', '', 'HVSSA', false, '2015-08-13 23:26:36.486', '2015-08-13 23:26:36.486');
INSERT INTO oec_course_codes VALUES (185, 'VIS SCI', '', 'BOOPT', false, '2015-08-13 23:26:36.49', '2015-08-13 23:26:36.49');
INSERT INTO oec_course_codes VALUES (186, 'VIS STD', '', 'DBARC', false, '2015-08-13 23:26:36.494', '2015-08-13 23:26:36.494');
INSERT INTO oec_course_codes VALUES (187, 'XMBA', '', 'BAHSB', false, '2015-08-13 23:26:36.498', '2015-08-13 23:26:36.498');
INSERT INTO oec_course_codes VALUES (188, 'YIDDISH', '', 'HZGER', true, '2015-08-13 23:26:36.502', '2015-08-13 23:26:36.502');
INSERT INTO oec_course_codes VALUES (189, 'FSSEM', '', 'FSSEM', true, '2017-05-19 17:40:36.502', '2017-05-19 17:40:36.502');
INSERT INTO oec_course_codes VALUES (190, 'GLOBAL', '', 'QIIAS', true, '2017-08-10 17:40:36.502', '2017-08-10 17:40:36.502');
INSERT INTO oec_course_codes VALUES (191, 'BIC', '', 'QHUIS', true, '2017-09-27 23:26:36.16', '2017-09-27 23:26:36.16');
INSERT INTO oec_course_codes VALUES (192, 'EDUC', '130', 'CALTEACH', true, '2018-04-03 23:26:36.16', '2018-04-03 23:26:36.16');
INSERT INTO oec_course_codes VALUES (193, 'EDUC', '131AC', 'CALTEACH', true, '2018-04-03 23:26:36.16', '2018-04-03 23:26:36.16');
INSERT INTO oec_course_codes VALUES (194, 'HISTORY', '138T', 'CALTEACH', true, '2018-04-03 23:26:36.16', '2018-04-03 23:26:36.16');
INSERT INTO oec_course_codes VALUES (195, 'HISTORY', '180T', 'CALTEACH', true, '2018-04-03 23:26:36.16', '2018-04-03 23:26:36.16');
INSERT INTO oec_course_codes VALUES (196, 'HISTORY', '182AT', 'CALTEACH', true, '2018-04-03 23:26:36.16', '2018-04-03 23:26:36.16');
INSERT INTO oec_course_codes VALUES (197, 'UGIS', '187', 'CALTEACH', true, '2018-04-03 23:26:36.16', '2018-04-03 23:26:36.16');
INSERT INTO oec_course_codes VALUES (198, 'UGIS', '188', 'CALTEACH', true, '2018-04-03 23:26:36.16', '2018-04-03 23:26:36.16');
INSERT INTO oec_course_codes VALUES (199, 'UGIS', '303', 'CALTEACH', true, '2018-04-03 23:26:36.16', '2018-04-03 23:26:36.16');
INSERT INTO oec_course_codes VALUES (200, 'UGIS', '82', 'CALTEACH', true, '2018-04-03 23:26:36.16', '2018-04-03 23:26:36.16');
INSERT INTO oec_course_codes VALUES (201, 'CALTEACH', '', 'CALTEACH', true, '2018-04-03 23:26:36.16', '2018-04-03 23:26:36.16');
INSERT INTO oec_course_codes VALUES (202, 'CYBER', '', 'MMIMS', true, '2018-09-24 23:26:36.16', '2018-09-24 23:26:36.16');

--
-- Name: oec_course_codes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('oec_course_codes_id_seq', 238, true);

--
-- Data for Name: user_auths; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO user_auths VALUES (2, '53791', true, true, '2017-03-02 17:06:18.281', '2017-03-02 17:06:18.281', false, false);
INSERT INTO user_auths VALUES (3, '95509', true, true, '2017-03-02 17:06:18.296', '2013-03-04 17:06:18.296', false, false);
INSERT INTO user_auths VALUES (4, '177473', true, true, '2017-03-02 17:06:18.328', '2013-03-04 17:06:18.328', false, false);

--
-- Name: user_auths_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('user_auths_id_seq', 4, true);


--
-- Data for Name: user_roles; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO user_roles VALUES (1, 'Student', 'student');
INSERT INTO user_roles VALUES (2, 'Staff', 'staff');
INSERT INTO user_roles VALUES (3, 'Faculty', 'faculty');


--
-- Name: user_roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('user_roles_id_seq', 3, true);


--
-- Name: canvas_site_mailing_list_members_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace:
--

ALTER TABLE ONLY canvas_site_mailing_list_members
  ADD CONSTRAINT canvas_site_mailing_list_members_pkey PRIMARY KEY (id);


--
-- Name: canvas_site_mailing_lists_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace:
--

ALTER TABLE ONLY canvas_site_mailing_lists
  ADD CONSTRAINT canvas_site_mailing_lists_pkey PRIMARY KEY (id);

--
-- Name: link_categories_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace:
--

ALTER TABLE ONLY link_categories
    ADD CONSTRAINT link_categories_pkey PRIMARY KEY (id);


--
-- Name: link_sections_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace:
--

ALTER TABLE ONLY link_sections
    ADD CONSTRAINT link_sections_pkey PRIMARY KEY (id);


--
-- Name: links_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace:
--

ALTER TABLE ONLY links
    ADD CONSTRAINT links_pkey PRIMARY KEY (id);


--
-- Name: oec_course_codes_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace:
--

ALTER TABLE ONLY oec_course_codes
    ADD CONSTRAINT oec_course_codes_pkey PRIMARY KEY (id);


--
-- Name: service_alerts_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace:
--

ALTER TABLE ONLY service_alerts
    ADD CONSTRAINT service_alerts_pkey PRIMARY KEY (id);

--
-- Name: user_auths_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace:
--

ALTER TABLE ONLY user_auths
    ADD CONSTRAINT user_auths_pkey PRIMARY KEY (id);


--
-- Name: user_roles_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace:
--

ALTER TABLE ONLY user_roles
    ADD CONSTRAINT user_roles_pkey PRIMARY KEY (id);


--
-- Name: index_canvas_site_mailing_lists_on_canvas_site_id; Type: INDEX; Schema: public; Owner: -; Tablespace:
--

CREATE UNIQUE INDEX index_canvas_site_mailing_lists_on_canvas_site_id ON canvas_site_mailing_lists USING btree (canvas_site_id);


--
-- Name: index_oec_course_codes_on_dept_code; Type: INDEX; Schema: public; Owner: -; Tablespace:
--

CREATE INDEX index_oec_course_codes_on_dept_code ON oec_course_codes USING btree (dept_code);


--
-- Name: index_oec_course_codes_on_dept_name_and_catalog_id; Type: INDEX; Schema: public; Owner: -; Tablespace:
--

CREATE UNIQUE INDEX index_oec_course_codes_on_dept_name_and_catalog_id ON oec_course_codes USING btree (dept_name, catalog_id);


--
-- Name: index_service_alerts_on_display_and_created_at; Type: INDEX; Schema: public; Owner: -; Tablespace:
--

CREATE INDEX index_service_alerts_on_display_and_created_at ON service_alerts USING btree (display, created_at);


--
-- Name: index_user_auths_on_uid; Type: INDEX; Schema: public; Owner: -; Tablespace:
--

CREATE UNIQUE INDEX index_user_auths_on_uid ON user_auths USING btree (uid);


--
-- Name: mailing_list_membership_index; Type: INDEX; Schema: public; Owner: -; Tablespace:
--

CREATE UNIQUE INDEX mailing_list_membership_index ON canvas_site_mailing_list_members USING btree (mailing_list_id, email_address);


--
-- PostgreSQL database dump complete
--

