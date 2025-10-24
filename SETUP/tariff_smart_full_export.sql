--
-- PostgreSQL database dump
--

-- Dumped from database version 16.8
-- Dumped by pg_dump version 16.5

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: countries; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.countries (
    id integer NOT NULL,
    name text NOT NULL,
    base_tariff numeric NOT NULL,
    reciprocal_tariff numeric NOT NULL,
    effective_date text,
    impact_level text
);


ALTER TABLE public.countries OWNER TO neondb_owner;

--
-- Name: countries_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.countries_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.countries_id_seq OWNER TO neondb_owner;

--
-- Name: countries_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.countries_id_seq OWNED BY public.countries.id;


--
-- Name: email_subscribers; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.email_subscribers (
    id integer NOT NULL,
    email text NOT NULL,
    status text DEFAULT 'active'::text NOT NULL,
    source text,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    gdpr_consent boolean DEFAULT true,
    consent_timestamp timestamp without time zone DEFAULT now(),
    ip_address text
);


ALTER TABLE public.email_subscribers OWNER TO neondb_owner;

--
-- Name: email_subscribers_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.email_subscribers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.email_subscribers_id_seq OWNER TO neondb_owner;

--
-- Name: email_subscribers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.email_subscribers_id_seq OWNED BY public.email_subscribers.id;


--
-- Name: feature_access; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.feature_access (
    id integer NOT NULL,
    feature_name text NOT NULL,
    user_role text NOT NULL,
    is_enabled boolean DEFAULT false
);


ALTER TABLE public.feature_access OWNER TO neondb_owner;

--
-- Name: feature_access_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.feature_access_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.feature_access_id_seq OWNER TO neondb_owner;

--
-- Name: feature_access_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.feature_access_id_seq OWNED BY public.feature_access.id;


--
-- Name: feature_flags; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.feature_flags (
    id integer NOT NULL,
    name text NOT NULL,
    is_enabled boolean DEFAULT false,
    description text
);


ALTER TABLE public.feature_flags OWNER TO neondb_owner;

--
-- Name: feature_flags_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.feature_flags_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.feature_flags_id_seq OWNER TO neondb_owner;

--
-- Name: feature_flags_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.feature_flags_id_seq OWNED BY public.feature_flags.id;


--
-- Name: product_categories; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.product_categories (
    id integer NOT NULL,
    name text NOT NULL,
    description text,
    primary_countries jsonb
);


ALTER TABLE public.product_categories OWNER TO neondb_owner;

--
-- Name: product_categories_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.product_categories_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.product_categories_id_seq OWNER TO neondb_owner;

--
-- Name: product_categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.product_categories_id_seq OWNED BY public.product_categories.id;


--
-- Name: products; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.products (
    id integer NOT NULL,
    name text NOT NULL,
    description text,
    category_id integer NOT NULL,
    origin_country text,
    current_price numeric,
    estimated_increase numeric,
    impact_level text
);


ALTER TABLE public.products OWNER TO neondb_owner;

--
-- Name: products_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.products_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.products_id_seq OWNER TO neondb_owner;

--
-- Name: products_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.products_id_seq OWNED BY public.products.id;


--
-- Name: subscriptions; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.subscriptions (
    id integer NOT NULL,
    user_id integer NOT NULL,
    plan text NOT NULL,
    status text NOT NULL,
    start_date timestamp without time zone NOT NULL,
    end_date timestamp without time zone,
    auto_renew boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.subscriptions OWNER TO neondb_owner;

--
-- Name: subscriptions_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.subscriptions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.subscriptions_id_seq OWNER TO neondb_owner;

--
-- Name: subscriptions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.subscriptions_id_seq OWNED BY public.subscriptions.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.users (
    id integer NOT NULL,
    username text NOT NULL,
    password text,
    email text,
    is_subscribed boolean DEFAULT false,
    role text DEFAULT 'user'::text NOT NULL,
    google_id text,
    display_name text,
    profile_picture text,
    subscription_tier text,
    subscription_expiration timestamp without time zone,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    last_login timestamp without time zone
);


ALTER TABLE public.users OWNER TO neondb_owner;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO neondb_owner;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: v2_dictionary_terms; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.v2_dictionary_terms (
    id integer NOT NULL,
    term text NOT NULL,
    slug text NOT NULL,
    definition text NOT NULL,
    category text NOT NULL,
    examples text[],
    related_terms text[],
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.v2_dictionary_terms OWNER TO neondb_owner;

--
-- Name: v2_dictionary_terms_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.v2_dictionary_terms_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.v2_dictionary_terms_id_seq OWNER TO neondb_owner;

--
-- Name: v2_dictionary_terms_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.v2_dictionary_terms_id_seq OWNED BY public.v2_dictionary_terms.id;


--
-- Name: v2_feature_flags; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.v2_feature_flags (
    id integer NOT NULL,
    name text NOT NULL,
    is_enabled boolean DEFAULT true NOT NULL,
    description text NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.v2_feature_flags OWNER TO neondb_owner;

--
-- Name: v2_feature_flags_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.v2_feature_flags_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.v2_feature_flags_id_seq OWNER TO neondb_owner;

--
-- Name: v2_feature_flags_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.v2_feature_flags_id_seq OWNED BY public.v2_feature_flags.id;


--
-- Name: v2_learning_modules; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.v2_learning_modules (
    id integer NOT NULL,
    title text NOT NULL,
    slug text NOT NULL,
    description text NOT NULL,
    content text NOT NULL,
    category text NOT NULL,
    difficulty text NOT NULL,
    estimated_minutes integer NOT NULL,
    featured boolean DEFAULT false NOT NULL,
    "order" integer NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.v2_learning_modules OWNER TO neondb_owner;

--
-- Name: v2_learning_modules_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.v2_learning_modules_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.v2_learning_modules_id_seq OWNER TO neondb_owner;

--
-- Name: v2_learning_modules_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.v2_learning_modules_id_seq OWNED BY public.v2_learning_modules.id;


--
-- Name: v2_quiz_answers; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.v2_quiz_answers (
    id integer NOT NULL,
    question_id integer NOT NULL,
    text text NOT NULL,
    is_correct boolean NOT NULL,
    explanation text,
    "order" integer NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.v2_quiz_answers OWNER TO neondb_owner;

--
-- Name: v2_quiz_answers_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.v2_quiz_answers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.v2_quiz_answers_id_seq OWNER TO neondb_owner;

--
-- Name: v2_quiz_answers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.v2_quiz_answers_id_seq OWNED BY public.v2_quiz_answers.id;


--
-- Name: v2_quiz_questions; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.v2_quiz_questions (
    id integer NOT NULL,
    quiz_id integer NOT NULL,
    question text NOT NULL,
    type text NOT NULL,
    "order" integer NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.v2_quiz_questions OWNER TO neondb_owner;

--
-- Name: v2_quiz_questions_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.v2_quiz_questions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.v2_quiz_questions_id_seq OWNER TO neondb_owner;

--
-- Name: v2_quiz_questions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.v2_quiz_questions_id_seq OWNED BY public.v2_quiz_questions.id;


--
-- Name: v2_quizzes; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.v2_quizzes (
    id integer NOT NULL,
    module_id integer NOT NULL,
    title text NOT NULL,
    description text NOT NULL,
    passing_score integer DEFAULT 70 NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.v2_quizzes OWNER TO neondb_owner;

--
-- Name: v2_quizzes_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.v2_quizzes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.v2_quizzes_id_seq OWNER TO neondb_owner;

--
-- Name: v2_quizzes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.v2_quizzes_id_seq OWNED BY public.v2_quizzes.id;


--
-- Name: v2_user_progress; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.v2_user_progress (
    id integer NOT NULL,
    user_id integer NOT NULL,
    module_id integer NOT NULL,
    completed boolean DEFAULT false NOT NULL,
    quiz_score integer,
    last_accessed timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.v2_user_progress OWNER TO neondb_owner;

--
-- Name: v2_user_progress_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.v2_user_progress_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.v2_user_progress_id_seq OWNER TO neondb_owner;

--
-- Name: v2_user_progress_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.v2_user_progress_id_seq OWNED BY public.v2_user_progress.id;


--
-- Name: v2_users; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.v2_users (
    id integer NOT NULL,
    username text NOT NULL,
    email text NOT NULL,
    password text,
    display_name text,
    profile_picture text,
    google_id text,
    role text DEFAULT 'basic'::text NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.v2_users OWNER TO neondb_owner;

--
-- Name: v2_users_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.v2_users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.v2_users_id_seq OWNER TO neondb_owner;

--
-- Name: v2_users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.v2_users_id_seq OWNED BY public.v2_users.id;


--
-- Name: countries id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.countries ALTER COLUMN id SET DEFAULT nextval('public.countries_id_seq'::regclass);


--
-- Name: email_subscribers id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.email_subscribers ALTER COLUMN id SET DEFAULT nextval('public.email_subscribers_id_seq'::regclass);


--
-- Name: feature_access id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.feature_access ALTER COLUMN id SET DEFAULT nextval('public.feature_access_id_seq'::regclass);


--
-- Name: feature_flags id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.feature_flags ALTER COLUMN id SET DEFAULT nextval('public.feature_flags_id_seq'::regclass);


--
-- Name: product_categories id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.product_categories ALTER COLUMN id SET DEFAULT nextval('public.product_categories_id_seq'::regclass);


--
-- Name: products id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.products ALTER COLUMN id SET DEFAULT nextval('public.products_id_seq'::regclass);


--
-- Name: subscriptions id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.subscriptions ALTER COLUMN id SET DEFAULT nextval('public.subscriptions_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: v2_dictionary_terms id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.v2_dictionary_terms ALTER COLUMN id SET DEFAULT nextval('public.v2_dictionary_terms_id_seq'::regclass);


--
-- Name: v2_feature_flags id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.v2_feature_flags ALTER COLUMN id SET DEFAULT nextval('public.v2_feature_flags_id_seq'::regclass);


--
-- Name: v2_learning_modules id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.v2_learning_modules ALTER COLUMN id SET DEFAULT nextval('public.v2_learning_modules_id_seq'::regclass);


--
-- Name: v2_quiz_answers id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.v2_quiz_answers ALTER COLUMN id SET DEFAULT nextval('public.v2_quiz_answers_id_seq'::regclass);


--
-- Name: v2_quiz_questions id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.v2_quiz_questions ALTER COLUMN id SET DEFAULT nextval('public.v2_quiz_questions_id_seq'::regclass);


--
-- Name: v2_quizzes id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.v2_quizzes ALTER COLUMN id SET DEFAULT nextval('public.v2_quizzes_id_seq'::regclass);


--
-- Name: v2_user_progress id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.v2_user_progress ALTER COLUMN id SET DEFAULT nextval('public.v2_user_progress_id_seq'::regclass);


--
-- Name: v2_users id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.v2_users ALTER COLUMN id SET DEFAULT nextval('public.v2_users_id_seq'::regclass);


--
-- Data for Name: countries; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.countries (id, name, base_tariff, reciprocal_tariff, effective_date, impact_level) FROM stdin;
8	China	20	125	April 9, 2025	High
9	Cote d'Ivoire	10	22	July 8, 2025	Low
10	European Union	10	20	July 8, 2025	Low
11	Falkland Islands	10	42	July 8, 2025	High
12	Fiji	10	32	July 8, 2025	Medium
13	Guyana	10	38	July 8, 2025	High
14	India	10	27	July 8, 2025	Medium
15	Indonesia	10	32	July 8, 2025	Medium
16	Iraq	10	39	July 8, 2025	High
17	Israel	10	17	July 8, 2025	Low
18	Japan	10	24	July 8, 2025	Low
19	Jordan	10	20	July 8, 2025	Low
20	Kazakhstan	10	27	July 8, 2025	Medium
21	Kenya	10	30	July 8, 2025	Medium
22	Lesotho	10	50	July 8, 2025	High
23	Libya	10	31	July 8, 2025	Medium
24	Liechtenstein	10	37	July 8, 2025	High
25	Loos	10	48	July 8, 2025	High
26	Madagascar	10	47	July 8, 2025	High
27	Malawi	10	18	July 8, 2025	Low
28	Malaysia	10	24	July 8, 2025	Low
29	Mauritius	10	40	July 8, 2025	High
30	Moldova	10	31	July 8, 2025	Medium
31	Myanmar (Burma)	10	45	July 8, 2025	High
32	Namibia	10	21	July 8, 2025	Low
33	Nicaragua	10	19	July 8, 2025	Low
34	Norfolk Island	10	28	July 8, 2025	Medium
1	Algeria	10	29	July 8, 2025	Medium
2	Angola	10	32	July 8, 2025	Medium
3	Bangladesh	10	37	July 8, 2025	High
4	Bosnia and Herzegovina	10	35	July 8, 2025	High
5	Botswana	10	38	July 8, 2025	High
6	Brunei	10	24	July 8, 2025	Low
7	Cambodia	10	49	July 8, 2025	High
35	North Macedonia	10	33	July 8, 2025	Medium
36	Pakistan	10	29	July 8, 2025	Medium
37	Philippines	10	17	July 8, 2025	Low
38	Reunion	10	37	July 8, 2025	High
39	Saint Pierre and Miquelon	10	50	July 8, 2025	High
40	Serbia	10	37	July 8, 2025	High
41	South Africa	10	30	July 8, 2025	Medium
42	South Korea	10	25	July 8, 2025	Medium
43	Sri Lanka	10	46	July 8, 2025	High
44	Switzerland	10	31	July 8, 2025	Medium
45	Syria	10	41	July 8, 2025	High
46	Taiwan	10	32	July 8, 2025	Medium
47	Thailand	10	36	July 8, 2025	High
48	Tunisia	10	28	July 8, 2025	Medium
49	Vanuatu	10	23	July 8, 2025	Low
50	Vietnam	10	46	July 8, 2025	High
51	Zambia	10	17	July 8, 2025	Low
52	Zimbabwe	10	18	July 8, 2025	Low
\.


--
-- Data for Name: email_subscribers; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.email_subscribers (id, email, status, source, created_at, gdpr_consent, consent_timestamp, ip_address) FROM stdin;
1	kapil9000@gmail.com	active	website_cta	2025-04-07 22:20:20.262	t	2025-04-07 22:20:20.262	70.23.21.69, 10.82.1.228
\.


--
-- Data for Name: feature_access; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.feature_access (id, feature_name, user_role, is_enabled) FROM stdin;
\.


--
-- Data for Name: feature_flags; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.feature_flags (id, name, is_enabled, description) FROM stdin;
1	productFiltering	t	Enables product filtering functionality
2	calculator	t	Enables the tariff calculator tool
4	emailAlerts	t	Enables email alert signup functionality
5	alternativeProducts	f	Enables alternative product recommendations
3	authentication	t	Enables user authentication features
6	showAds	f	Controls whether ads are displayed throughout the application
7	showSocialLinks	f	Controls whether social media links are displayed in the footer
\.


--
-- Data for Name: product_categories; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.product_categories (id, name, description, primary_countries) FROM stdin;
1	Electronics	Consumer electronics and gadgets	["China", "South Korea", "Japan"]
2	Clothing & Apparel	Clothing, footwear, and accessories	["Vietnam", "Bangladesh", "China"]
3	Toys & Games	Children's toys and games	["China", "Vietnam", "Mexico"]
4	Furniture & Home Goods	Home furniture and decorative items	["China", "Vietnam", "Mexico"]
5	Food & Beverages	Imported food products and beverages	["Mexico", "Canada", "EU"]
\.


--
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.products (id, name, description, category_id, origin_country, current_price, estimated_increase, impact_level) FROM stdin;
1	Smartphones	Mobile phones and accessories	1	China	899	40.5	High
2	Laptops	Portable computers	1	China	1200	54	High
3	TVs	Televisions and home entertainment	1	South Korea	750	22.5	Medium
4	T-Shirts	Casual cotton shirts	2	Bangladesh	15	1.5	Low
5	Jeans	Denim pants	2	Vietnam	45	6.75	Medium
6	Action Figures	Collectible toys	3	China	25	11.25	High
7	Board Games	Family board games	3	China	35	15.75	High
8	Sofas	Living room furniture	4	Vietnam	899	134.85	Medium
9	Coffee Tables	Living room tables	4	China	250	112.5	High
10	Imported Chocolates	Premium chocolate assortments	5	EU	12	1.8	Medium
11	Imported Cheese	Specialty cheeses	5	EU	15	2.25	Medium
12	Imported Wines	Premium wines	5	EU	35	5.25	Medium
\.


--
-- Data for Name: subscriptions; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.subscriptions (id, user_id, plan, status, start_date, end_date, auto_renew, created_at) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.users (id, username, password, email, is_subscribed, role, google_id, display_name, profile_picture, subscription_tier, subscription_expiration, created_at, last_login) FROM stdin;
\.


--
-- Data for Name: v2_dictionary_terms; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.v2_dictionary_terms (id, term, slug, definition, category, examples, related_terms, created_at, updated_at) FROM stdin;
1	Tariff	tariff	A tax imposed on goods when they are moved across a political boundary. Tariffs are typically charged by the importing country and paid by the importer.	Basics	{"The United States imposed a 25% tariff on steel imports from several countries.","Companies often factor in tariff costs when pricing their exported goods."}	{duty,import-tax,customs-duty}	2025-04-13 00:04:28.581501	2025-04-13 00:04:28.581501
2	Duty	duty	A tax levied by a government on the import, export, or consumption of goods. In international trade, it primarily refers to import duties charged on goods imported into a country.	Basics	{"The customs officer calculated the duty based on the declared value of the imported electronics.","Many developing countries rely heavily on import duties for government revenue."}	{tariff,import-tax,customs-duty}	2025-04-13 00:04:28.581501	2025-04-13 00:04:28.581501
3	Customs Duty	customs-duty	A specific type of tariff or tax imposed on goods when they are transported across international borders, typically collected by customs authorities of the importing country.	Basics	{"The wine importer paid customs duties at the port of entry.","Different customs duties apply to different categories of imported goods."}	{tariff,duty,import-tax}	2025-04-13 00:04:28.581501	2025-04-13 00:04:28.581501
4	Ad Valorem Tariff	ad-valorem-tariff	A tariff that is calculated as a percentage of the value of the imported goods. This is the most common type of tariff.	Types of Tariffs	{"The country applies a 5% ad valorem tariff on imported automobiles.","Ad valorem tariffs can lead to debates about the proper valuation of goods."}	{tariff,specific-tariff,compound-tariff}	2025-04-13 00:04:28.581501	2025-04-13 00:04:28.581501
5	Specific Tariff	specific-tariff	A tariff that is charged as a fixed fee based on the weight, volume, or quantity of the imported goods, regardless of their value.	Types of Tariffs	{"The government imposed a specific tariff of $2 per barrel of imported oil.","Specific tariffs are easier to administer as they do not require valuation of goods."}	{tariff,ad-valorem-tariff,compound-tariff}	2025-04-13 00:04:28.581501	2025-04-13 00:04:28.581501
6	Compound Tariff	compound-tariff	A tariff that combines both ad valorem and specific tariff elements, charging both a percentage of the value and a fixed amount per unit.	Types of Tariffs	{"The compound tariff on imported shoes included both 10% of the value and $1 per pair.","Compound tariffs provide multiple layers of protection for domestic industries."}	{tariff,ad-valorem-tariff,specific-tariff}	2025-04-13 00:04:28.581501	2025-04-13 00:04:28.581501
7	Most Favored Nation (MFN)	most-favored-nation	A principle in international trade where countries agree to provide the same trading benefits to all trading partners that are members of the World Trade Organization.	Trade Agreements	{"Under MFN rules, if a country grants a lower tariff rate to one WTO member, it must extend that same rate to all other members.","MFN status forms the foundation of the multilateral trading system."}	{wto,national-treatment,preferential-trade-agreement}	2025-04-13 00:04:28.581501	2025-04-13 00:04:28.581501
8	World Trade Organization (WTO)	wto	An international organization that regulates international trade between nations. It provides a framework for negotiating trade agreements and resolving disputes between members.	Organizations	{"The WTO was established in 1995 and currently has 164 member countries.","Countries can bring trade disputes to the WTO for resolution."}	{most-favored-nation,gatt,trade-dispute}	2025-04-13 00:04:28.581501	2025-04-13 00:04:28.581501
9	General Agreement on Tariffs and Trade (GATT)	gatt	A multilateral agreement that regulated international trade from 1948 until it was replaced by the World Trade Organization in 1995. Many GATT principles were incorporated into the WTO.	Trade Agreements	{"GATT helped reduce global tariff levels through multiple rounds of negotiations.","The Uruguay Round of GATT negotiations led to the creation of the WTO."}	{wto,trade-round,uruguay-round}	2025-04-13 00:04:28.581501	2025-04-13 00:04:28.581501
10	Harmonized System (HS)	harmonized-system	An internationally standardized system of names and numbers to classify traded products, developed and maintained by the World Customs Organization.	Classification	{"The HS code 1806.31 refers to filled chocolate bars.","Importers must determine the correct HS code for their products to calculate applicable tariffs."}	{hs-code,tariff-classification,world-customs-organization}	2025-04-13 00:04:28.581501	2025-04-13 00:04:28.581501
\.


--
-- Data for Name: v2_feature_flags; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.v2_feature_flags (id, name, is_enabled, description, created_at, updated_at) FROM stdin;
1	enableLearningModules	t	Controls whether learning modules are accessible	2025-04-12 23:59:53.05861	2025-04-12 23:59:53.05861
2	enableTradeAgreements	t	Controls whether trade agreements section is accessible	2025-04-12 23:59:53.05861	2025-04-12 23:59:53.05861
3	enableDailyChallenges	t	Controls whether daily challenges are available	2025-04-12 23:59:53.05861	2025-04-12 23:59:53.05861
4	enableCertificates	t	Controls whether certificates can be earned and displayed	2025-04-12 23:59:53.05861	2025-04-12 23:59:53.05861
5	enableSocialSharing	t	Controls whether social sharing options are available	2025-04-12 23:59:53.05861	2025-04-12 23:59:53.05861
6	enableFeedback	t	Controls whether user feedback mechanisms are enabled	2025-04-12 23:59:53.05861	2025-04-12 23:59:53.05861
7	enableAdvancedSearch	t	Controls whether advanced search features are available	2025-04-12 23:59:53.05861	2025-04-12 23:59:53.05861
\.


--
-- Data for Name: v2_learning_modules; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.v2_learning_modules (id, title, slug, description, content, category, difficulty, estimated_minutes, featured, "order", created_at, updated_at) FROM stdin;
1	Introduction to Tariffs	intro-to-tariffs	Learn about the basics of tariffs, their purpose, and how they impact global trade.	# Introduction to Tariffs\n\n## What is a Tariff?\n\nA tariff is a tax imposed by a government on goods and services imported from other countries. Tariffs serve several purposes:\n\n1. **Revenue Generation**: Historically, tariffs were a major source of government revenue before income taxes became widespread.\n2. **Protection of Domestic Industries**: By making imported goods more expensive, tariffs can shield domestic producers from foreign competition.\n3. **Trade Policy Tool**: Governments use tariffs as leverage in international trade negotiations.\n\n## Types of Tariffs\n\n### Ad Valorem Tariffs\nThese are calculated as a percentage of the value of the imported goods. For example, a 5% ad valorem tariff on a $100 product would result in a $5 tariff.\n\n### Specific Tariffs\nThese are fixed fees based on the quantity, weight, or volume of the imported goods, regardless of their value. For example, $2 per barrel of oil or $1 per kilogram of cheese.\n\n### Compound Tariffs\nThese combine both ad valorem and specific tariff components. For example, 5% of the value plus $1 per unit.\n\n## Economic Impact of Tariffs\n\nTariffs have complex economic effects that ripple through both importing and exporting countries:\n\n- **Higher Consumer Prices**: Imported goods become more expensive, and domestic producers often raise their prices too.\n- **Reduced Trade Volume**: Higher prices typically lead to reduced consumption of imported goods.\n- **Domestic Industry Protection**: Local producers face less pressure from international competition.\n- **Potential Retaliation**: Trading partners may impose their own tariffs in response.\n- **Deadweight Loss**: Overall economic efficiency can decrease due to distorted market signals.\n\n## Historical Perspective\n\nTariffs have played a significant role in economic history:\n\n- The **Smoot-Hawley Tariff Act** of 1930 raised U.S. tariffs to historically high levels and is widely believed to have worsened the Great Depression.\n- After World War II, the **General Agreement on Tariffs and Trade (GATT)** and later the **World Trade Organization (WTO)** worked to reduce tariff barriers globally.\n- Despite this trend toward liberalization, tariffs remain an important and sometimes controversial policy tool.\n\n## Modern Tariff Policies\n\nIn today's globalized economy, tariffs are typically lower than in the past, but they continue to be used for:\n\n- **Infant Industry Protection**: Temporary protection for developing industries until they become internationally competitive.\n- **National Security**: Protection of industries deemed vital to national security.\n- **Trade Disputes**: Countermeasures against unfair trade practices like dumping or subsidies.\n- **Bargaining Leverage**: Pressure in trade negotiations.\n\n## Conclusion\n\nUnderstanding tariffs is essential for grasping how international trade works and how government policies shape global commerce. While economists generally favor free trade, tariffs remain an important policy instrument that countries use to achieve various economic and political objectives.	Basics	beginner	30	t	1	2025-04-13 00:05:24.150066	2025-04-13 00:05:24.150066
2	Trade Agreements Fundamentals	trade-agreements-fundamentals	Understand the structure and purpose of international trade agreements and their role in global commerce.	# Trade Agreements Fundamentals\n\n## What are Trade Agreements?\n\nTrade agreements are contracts between two or more countries that define the terms of commerce between them. These agreements typically aim to reduce barriers to trade such as tariffs, quotas, and regulatory obstacles, while establishing rules for international business.\n\n## Types of Trade Agreements\n\n### Bilateral Trade Agreements\nAgreements between two countries. Examples include:\n- United States-Mexico-Canada Agreement (USMCA)\n- Japan-EU Economic Partnership Agreement\n\n### Regional Trade Agreements\nAgreements among countries in a specific geographic region. Examples include:\n- Association of Southeast Asian Nations (ASEAN) Free Trade Area\n- European Union Single Market\n\n### Multilateral Trade Agreements\nAgreements involving many countries across the globe. Examples include:\n- World Trade Organization (WTO) agreements\n- The General Agreement on Tariffs and Trade (GATT)\n\n## Key Components of Trade Agreements\n\nMost trade agreements address these fundamental areas:\n\n### Tariff Reduction or Elimination\n- Schedules for gradually reducing or eliminating duties on goods\n- Rules about which products qualify for preferential treatment\n\n### Rules of Origin\n- Criteria to determine the national source of a product\n- Important for determining which tariff rates apply\n\n### Services Trade\n- Market access for service providers like banking, insurance, and telecommunications\n- Professional qualification recognition\n\n### Intellectual Property Protection\n- Patents, trademarks, copyrights, and trade secrets\n- Enforcement mechanisms\n\n### Dispute Resolution\n- Procedures for settling disagreements between countries\n- Arbitration panels and compliance mechanisms\n\n### Special Provisions\n- Environmental and labor standards\n- Government procurement rules\n- Competition policy\n- Investment protection\n\n## Benefits of Trade Agreements\n\n### Economic Growth\n- Expanded market access and increased exports\n- Greater competition leading to innovation and efficiency\n- Lower prices for consumers\n- Job creation in competitive sectors\n\n### Political Stability\n- Strengthened diplomatic relations\n- Reduced potential for conflict\n- Predictable business environment\n\n### Standards Harmonization\n- Simplified regulatory compliance\n- Common safety and quality standards\n\n## Criticisms and Challenges\n\n### Potential Job Displacement\n- Industries facing new competition may shed workers\n- Transition costs for affected workers and communities\n\n### Sovereignty Concerns\n- Perceived limitations on domestic policy choices\n- Controversy over investor-state dispute settlement\n\n### Environmental and Labor Standards\n- Concerns about regulatory "race to the bottom"\n- Enforcement challenges\n\n### Uneven Benefits\n- Gains may be concentrated among certain industries or income groups\n- Developing countries may face implementation challenges\n\n## Major Global Trade Frameworks\n\n### World Trade Organization (WTO)\n- Founded in 1995 as successor to GATT\n- 164 member countries (as of 2023)\n- Most-favored-nation principle\n- National treatment principle\n- Binding dispute settlement\n\n### Regional Integration Blocks\n- European Union (EU)\n- North American Free Trade Agreement/USMCA\n- Comprehensive and Progressive Agreement for Trans-Pacific Partnership (CPTPP)\n- African Continental Free Trade Area (AfCFTA)\n\n## Conclusion\n\nTrade agreements represent a crucial mechanism for managing international economic relationships. While they can deliver substantial benefits through increased trade and investment, their design and implementation require careful attention to ensure broadly shared prosperity and respect for important social values.\n\nUnderstanding these agreements is essential for businesses operating internationally, policymakers, and citizens interested in how global economic integration affects their lives and livelihoods.	Trade Policy	beginner	45	t	2	2025-04-13 00:05:24.150066	2025-04-13 00:05:24.150066
3	Advanced Tariff Classification	advanced-tariff-classification	Master the complexities of the Harmonized System and learn how to properly classify goods for customs purposes.	# Advanced Tariff Classification\n\n## The Harmonized System Framework\n\nThe Harmonized Commodity Description and Coding System, commonly known as the Harmonized System (HS), is the international nomenclature developed by the World Customs Organization (WCO) for the classification of goods. This standardized numerical method categorizes products for customs purposes across 212 countries and economies.\n\n### Structure of HS Codes\n\nThe HS comprises approximately 5,000 commodity groups organized in a hierarchical structure:\n\n1. **Sections (I-XXI)**: Broad categories (e.g., Section XI: Textiles and Textile Articles)\n2. **Chapters (2-digit, 01-97)**: Product categories (e.g., Chapter 61: Apparel and Clothing Accessories, Knitted or Crocheted)\n3. **Headings (4-digit)**: More specific product groups (e.g., 6104: Women's or girls' suits, ensembles, etc.)\n4. **Subheadings (6-digit)**: Detailed product specifications (e.g., 6104.43: Women's dresses of synthetic fibers)\n\nCountries may add additional digits (typically 8-10 total) for further classification at the national level.\n\n## Classification Principles\n\n### General Rules of Interpretation (GRIs)\nThe GRIs provide the framework for classification under the HS:\n\n1. **GRI 1**: Classification is determined according to the terms of the headings and relevant section or chapter notes.\n2. **GRI 2**: Covers incomplete or unfinished articles and mixtures or combinations of materials.\n3. **GRI 3**: Provides rules when goods could be classified under multiple headings.\n4. **GRI 4**: Goods that cannot be classified under GRIs 1-3 are classified under the heading appropriate to the goods to which they are most similar.\n5. **GRI 5**: Covers special cases like containers and packaging.\n6. **GRI 6**: Applies the above rules for classification at the subheading level.\n\n### Legal Notes\nEach section and chapter contains legal notes that define terms, establish inclusions and exclusions, and clarify classification boundaries. These notes have binding legal force and must be consulted before classification.\n\n## Advanced Classification Challenges\n\n### Multi-function Products\nModern products often perform multiple functions, making classification complex. The "principal function" or "essential character" must be determined.\n\n**Example**: A smartwatch that tells time, monitors health metrics, and receives calls might be classified as:\n- 9101/9102: Wristwatch\n- 8517: Telephone\n- 9029: Revolution counter (for step counting)\n\nThe correct classification depends on the essential character of the device.\n\n### Technological Advancements\nNew technologies often create classification challenges:\n\n**Example**: 3D printers didn't exist when the HS was created. They might be classified under:\n- 8477: Machinery for working rubber or plastics\n- 8479: Machines having individual functions not specified elsewhere\n- 8443: Printing machinery\n\nMost authorities now classify them under 8479.\n\n### Valuation Considerations\nClassification and valuation interact in complex ways:\n\n- Software-enabled devices (is the software value included?)\n- Products with significant intellectual property components\n- Goods sold at different levels of trade\n\n## Binding Rulings and Dispute Resolution\n\n### Advance Rulings\nMany customs authorities provide binding pre-importation rulings:\n- U.S. Customs and Border Protection issues "Customs Rulings"\n- EU member states issue "Binding Tariff Information" (BTI)\n\nThese provide certainty about classification before goods are shipped.\n\n### Dispute Processes\nWhen disagreements arise:\n1. **Administrative review** within customs authorities\n2. **Judicial review** in courts or specialized tribunals\n3. **WCO intervention** (advisory, non-binding)\n\n## Strategic Classification Approaches\n\n### Building a Classification Program\nCompanies with substantial international trade should:\n1. Maintain a product classification database\n2. Implement verification processes\n3. Monitor regulatory changes\n4. Train staff on classification principles\n5. Consider automation tools\n\n### Risk Management\nMisclassification risks include:\n- Penalties and fines\n- Delayed clearance\n- Post-entry audits\n- Reputational damage\n\n### Classification Software\nModern classification software can:\n- Suggest appropriate HS codes\n- Maintain classification histories\n- Track regulatory changes\n- Generate required documentation\n\n## Conclusion\n\nAdvanced tariff classification requires understanding complex rules, staying current with regulatory changes, and developing systematic approaches to classification challenges. Proper classification is essential for:\n- Determining applicable duty rates\n- Qualifying for preferential treatment under trade agreements\n- Complying with non-tariff requirements like quotas and licenses\n- Accurate trade statistics\n\nCompanies that invest in classification expertise can minimize compliance risks while potentially reducing duty liability through proper classification strategies.	Compliance	advanced	60	t	3	2025-04-13 00:05:24.150066	2025-04-13 00:05:24.150066
\.


--
-- Data for Name: v2_quiz_answers; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.v2_quiz_answers (id, question_id, text, is_correct, explanation, "order", created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: v2_quiz_questions; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.v2_quiz_questions (id, quiz_id, question, type, "order", created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: v2_quizzes; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.v2_quizzes (id, module_id, title, description, passing_score, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: v2_user_progress; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.v2_user_progress (id, user_id, module_id, completed, quiz_score, last_accessed, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: v2_users; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.v2_users (id, username, email, password, display_name, profile_picture, google_id, role, created_at, updated_at) FROM stdin;
1	admin	admin@tariffsmart.com	\N	Admin User	\N	\N	admin	2025-04-13 00:00:05.527691	2025-04-13 00:00:05.527691
\.


--
-- Name: countries_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.countries_id_seq', 12, true);


--
-- Name: email_subscribers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.email_subscribers_id_seq', 1, true);


--
-- Name: feature_access_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.feature_access_id_seq', 1, false);


--
-- Name: feature_flags_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.feature_flags_id_seq', 7, true);


--
-- Name: product_categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.product_categories_id_seq', 5, true);


--
-- Name: products_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.products_id_seq', 12, true);


--
-- Name: subscriptions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.subscriptions_id_seq', 1, false);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.users_id_seq', 1, false);


--
-- Name: v2_dictionary_terms_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.v2_dictionary_terms_id_seq', 10, true);


--
-- Name: v2_feature_flags_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.v2_feature_flags_id_seq', 7, true);


--
-- Name: v2_learning_modules_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.v2_learning_modules_id_seq', 3, true);


--
-- Name: v2_quiz_answers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.v2_quiz_answers_id_seq', 1, false);


--
-- Name: v2_quiz_questions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.v2_quiz_questions_id_seq', 1, false);


--
-- Name: v2_quizzes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.v2_quizzes_id_seq', 1, false);


--
-- Name: v2_user_progress_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.v2_user_progress_id_seq', 1, false);


--
-- Name: v2_users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.v2_users_id_seq', 1, true);


--
-- Name: countries countries_name_unique; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.countries
    ADD CONSTRAINT countries_name_unique UNIQUE (name);


--
-- Name: countries countries_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.countries
    ADD CONSTRAINT countries_pkey PRIMARY KEY (id);


--
-- Name: email_subscribers email_subscribers_email_unique; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.email_subscribers
    ADD CONSTRAINT email_subscribers_email_unique UNIQUE (email);


--
-- Name: email_subscribers email_subscribers_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.email_subscribers
    ADD CONSTRAINT email_subscribers_pkey PRIMARY KEY (id);


--
-- Name: feature_access feature_access_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.feature_access
    ADD CONSTRAINT feature_access_pkey PRIMARY KEY (id);


--
-- Name: feature_flags feature_flags_name_unique; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.feature_flags
    ADD CONSTRAINT feature_flags_name_unique UNIQUE (name);


--
-- Name: feature_flags feature_flags_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.feature_flags
    ADD CONSTRAINT feature_flags_pkey PRIMARY KEY (id);


--
-- Name: product_categories product_categories_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.product_categories
    ADD CONSTRAINT product_categories_pkey PRIMARY KEY (id);


--
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);


--
-- Name: subscriptions subscriptions_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.subscriptions
    ADD CONSTRAINT subscriptions_pkey PRIMARY KEY (id);


--
-- Name: users users_google_id_unique; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_google_id_unique UNIQUE (google_id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: users users_username_unique; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_unique UNIQUE (username);


--
-- Name: v2_dictionary_terms v2_dictionary_terms_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.v2_dictionary_terms
    ADD CONSTRAINT v2_dictionary_terms_pkey PRIMARY KEY (id);


--
-- Name: v2_dictionary_terms v2_dictionary_terms_slug_key; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.v2_dictionary_terms
    ADD CONSTRAINT v2_dictionary_terms_slug_key UNIQUE (slug);


--
-- Name: v2_feature_flags v2_feature_flags_name_key; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.v2_feature_flags
    ADD CONSTRAINT v2_feature_flags_name_key UNIQUE (name);


--
-- Name: v2_feature_flags v2_feature_flags_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.v2_feature_flags
    ADD CONSTRAINT v2_feature_flags_pkey PRIMARY KEY (id);


--
-- Name: v2_learning_modules v2_learning_modules_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.v2_learning_modules
    ADD CONSTRAINT v2_learning_modules_pkey PRIMARY KEY (id);


--
-- Name: v2_learning_modules v2_learning_modules_slug_key; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.v2_learning_modules
    ADD CONSTRAINT v2_learning_modules_slug_key UNIQUE (slug);


--
-- Name: v2_quiz_answers v2_quiz_answers_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.v2_quiz_answers
    ADD CONSTRAINT v2_quiz_answers_pkey PRIMARY KEY (id);


--
-- Name: v2_quiz_questions v2_quiz_questions_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.v2_quiz_questions
    ADD CONSTRAINT v2_quiz_questions_pkey PRIMARY KEY (id);


--
-- Name: v2_quizzes v2_quizzes_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.v2_quizzes
    ADD CONSTRAINT v2_quizzes_pkey PRIMARY KEY (id);


--
-- Name: v2_user_progress v2_user_progress_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.v2_user_progress
    ADD CONSTRAINT v2_user_progress_pkey PRIMARY KEY (id);


--
-- Name: v2_users v2_users_email_key; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.v2_users
    ADD CONSTRAINT v2_users_email_key UNIQUE (email);


--
-- Name: v2_users v2_users_google_id_key; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.v2_users
    ADD CONSTRAINT v2_users_google_id_key UNIQUE (google_id);


--
-- Name: v2_users v2_users_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.v2_users
    ADD CONSTRAINT v2_users_pkey PRIMARY KEY (id);


--
-- Name: v2_users v2_users_username_key; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.v2_users
    ADD CONSTRAINT v2_users_username_key UNIQUE (username);


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: public; Owner: cloud_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE cloud_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO neon_superuser WITH GRANT OPTION;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: public; Owner: cloud_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE cloud_admin IN SCHEMA public GRANT ALL ON TABLES TO neon_superuser WITH GRANT OPTION;


--
-- PostgreSQL database dump complete
--

