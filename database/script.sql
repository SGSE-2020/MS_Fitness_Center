--
-- PostgreSQL database dump
--

-- Dumped from database version 12.3 (Debian 12.3-1.pgdg100+1)
-- Dumped by pg_dump version 12.3 (Ubuntu 12.3-1.pgdg18.04+1)

-- Started on 2020-06-15 10:22:29 CEST

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
-- TOC entry 209 (class 1259 OID 91361)
-- Name: abo; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.abo (
    id integer NOT NULL,
    name text NOT NULL,
    description text NOT NULL,
    costs double precision NOT NULL,
    terms integer NOT NULL
);


--
-- TOC entry 208 (class 1259 OID 91359)
-- Name: abo_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.abo_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3071 (class 0 OID 0)
-- Dependencies: 208
-- Name: abo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.abo_id_seq OWNED BY public.abo.id;


--
-- TOC entry 207 (class 1259 OID 91350)
-- Name: course; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.course (
    id integer NOT NULL,
    name text NOT NULL,
    description text NOT NULL
);


--
-- TOC entry 206 (class 1259 OID 91348)
-- Name: course_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.course_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3072 (class 0 OID 0)
-- Dependencies: 206
-- Name: course_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.course_id_seq OWNED BY public.course.id;


--
-- TOC entry 216 (class 1259 OID 91412)
-- Name: date; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.date (
    id integer NOT NULL,
    week_day integer NOT NULL,
    hour integer NOT NULL,
    min integer NOT NULL,
    duration integer NOT NULL,
    course_id integer NOT NULL
);


--
-- TOC entry 215 (class 1259 OID 91410)
-- Name: date_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.date_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3073 (class 0 OID 0)
-- Dependencies: 215
-- Name: date_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.date_id_seq OWNED BY public.date.id;


--
-- TOC entry 224 (class 1259 OID 91486)
-- Name: date_location; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.date_location (
    date_id integer NOT NULL,
    location_id integer NOT NULL
);


--
-- TOC entry 205 (class 1259 OID 91339)
-- Name: device; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.device (
    id integer NOT NULL,
    name text NOT NULL,
    description text NOT NULL
);


--
-- TOC entry 204 (class 1259 OID 91337)
-- Name: device_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.device_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3074 (class 0 OID 0)
-- Dependencies: 204
-- Name: device_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.device_id_seq OWNED BY public.device.id;


--
-- TOC entry 226 (class 1259 OID 91516)
-- Name: device_muscle; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.device_muscle (
    device_id integer NOT NULL,
    muscle_id integer NOT NULL
);


--
-- TOC entry 223 (class 1259 OID 91471)
-- Name: exercise; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.exercise (
    trainingplan_id integer NOT NULL,
    device_id integer NOT NULL,
    sets integer NOT NULL,
    repetitions integer,
    duration integer
);


--
-- TOC entry 203 (class 1259 OID 91328)
-- Name: location; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.location (
    id integer NOT NULL,
    name text NOT NULL,
    description text NOT NULL,
    street text NOT NULL,
    place text NOT NULL
);


--
-- TOC entry 225 (class 1259 OID 91501)
-- Name: location_device; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.location_device (
    location_id integer NOT NULL,
    device_id integer NOT NULL
);


--
-- TOC entry 202 (class 1259 OID 91326)
-- Name: location_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.location_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3075 (class 0 OID 0)
-- Dependencies: 202
-- Name: location_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.location_id_seq OWNED BY public.location.id;


--
-- TOC entry 212 (class 1259 OID 91381)
-- Name: member; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.member (
    id text NOT NULL,
    role integer NOT NULL,
    height integer,
    weight integer,
    performance_level integer,
    other_activitys text,
    diseases text,
    goal text,
    time_aviability integer,
    abo_start date,
    abo_id integer
);


--
-- TOC entry 211 (class 1259 OID 91372)
-- Name: muscle; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.muscle (
    id integer NOT NULL,
    name text NOT NULL,
    description text
);


--
-- TOC entry 210 (class 1259 OID 91370)
-- Name: muscle_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.muscle_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3076 (class 0 OID 0)
-- Dependencies: 210
-- Name: muscle_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.muscle_id_seq OWNED BY public.muscle.id;


--
-- TOC entry 222 (class 1259 OID 91457)
-- Name: trainingplan; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.trainingplan (
    id integer NOT NULL,
    name text NOT NULL,
    note text NOT NULL,
    member_id text NOT NULL
);


--
-- TOC entry 221 (class 1259 OID 91455)
-- Name: trainingplan_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.trainingplan_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3077 (class 0 OID 0)
-- Dependencies: 221
-- Name: trainingplan_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.trainingplan_id_seq OWNED BY public.trainingplan.id;


--
-- TOC entry 220 (class 1259 OID 91441)
-- Name: trainingplanrequest; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.trainingplanrequest (
    id integer NOT NULL,
    request_date date NOT NULL,
    member_id text NOT NULL
);


--
-- TOC entry 219 (class 1259 OID 91439)
-- Name: trainingplanrequest_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.trainingplanrequest_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3078 (class 0 OID 0)
-- Dependencies: 219
-- Name: trainingplanrequest_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.trainingplanrequest_id_seq OWNED BY public.trainingplanrequest.id;


--
-- TOC entry 214 (class 1259 OID 91396)
-- Name: treatmentnote; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.treatmentnote (
    id integer NOT NULL,
    day date NOT NULL,
    note text NOT NULL,
    member_id text
);


--
-- TOC entry 213 (class 1259 OID 91394)
-- Name: treatmentnote_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.treatmentnote_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3079 (class 0 OID 0)
-- Dependencies: 213
-- Name: treatmentnote_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.treatmentnote_id_seq OWNED BY public.treatmentnote.id;


--
-- TOC entry 218 (class 1259 OID 91425)
-- Name: treatmentrequest; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.treatmentrequest (
    id integer NOT NULL,
    request_date date NOT NULL,
    note text,
    member_id text NOT NULL
);


--
-- TOC entry 217 (class 1259 OID 91423)
-- Name: treatmentrequest_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.treatmentrequest_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3080 (class 0 OID 0)
-- Dependencies: 217
-- Name: treatmentrequest_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.treatmentrequest_id_seq OWNED BY public.treatmentrequest.id;


--
-- TOC entry 2864 (class 2604 OID 91364)
-- Name: abo id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.abo ALTER COLUMN id SET DEFAULT nextval('public.abo_id_seq'::regclass);


--
-- TOC entry 2863 (class 2604 OID 91353)
-- Name: course id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.course ALTER COLUMN id SET DEFAULT nextval('public.course_id_seq'::regclass);


--
-- TOC entry 2867 (class 2604 OID 91415)
-- Name: date id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.date ALTER COLUMN id SET DEFAULT nextval('public.date_id_seq'::regclass);


--
-- TOC entry 2862 (class 2604 OID 91342)
-- Name: device id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.device ALTER COLUMN id SET DEFAULT nextval('public.device_id_seq'::regclass);


--
-- TOC entry 2861 (class 2604 OID 91331)
-- Name: location id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.location ALTER COLUMN id SET DEFAULT nextval('public.location_id_seq'::regclass);


--
-- TOC entry 2865 (class 2604 OID 91375)
-- Name: muscle id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.muscle ALTER COLUMN id SET DEFAULT nextval('public.muscle_id_seq'::regclass);


--
-- TOC entry 2870 (class 2604 OID 91460)
-- Name: trainingplan id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.trainingplan ALTER COLUMN id SET DEFAULT nextval('public.trainingplan_id_seq'::regclass);


--
-- TOC entry 2869 (class 2604 OID 91444)
-- Name: trainingplanrequest id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.trainingplanrequest ALTER COLUMN id SET DEFAULT nextval('public.trainingplanrequest_id_seq'::regclass);


--
-- TOC entry 2866 (class 2604 OID 91399)
-- Name: treatmentnote id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.treatmentnote ALTER COLUMN id SET DEFAULT nextval('public.treatmentnote_id_seq'::regclass);


--
-- TOC entry 2868 (class 2604 OID 91428)
-- Name: treatmentrequest id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.treatmentrequest ALTER COLUMN id SET DEFAULT nextval('public.treatmentrequest_id_seq'::regclass);


--
-- TOC entry 3048 (class 0 OID 91361)
-- Dependencies: 209
-- Data for Name: abo; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.abo (id, name, description, costs, terms) FROM stdin;
1	Flex	Die Vertragslaufzeit der Mitgliedsverträge mit einer Mindestvertragslaufzeit unter 12 Monate verlängern sich jeweils um die online ausgewählte Laufzeit, wenn der „Mitgliedsvertrag“ nicht vom Mitglied oder von EASYFITNESS unter Einhaltung einer Kündigungsfrist von mindestens 1 Monat vor dem jeweiligen Vertragsende gekündigt wird. 	39.9	1
2	Service 12	Die Vertragslaufzeit der Mitgliedsverträge mit einer Mindestvertragslaufzeit unter 12 Monate verlängern sich jeweils um die online ausgewählte Laufzeit, wenn der „Mitgliedsvertrag“ nicht vom Mitglied oder von EASYFITNESS unter Einhaltung einer Kündigungsfrist von mindestens 1 Monat vor dem jeweiligen Vertragsende gekündigt wird. 	29.9	12
3	Service 24	Die Vertragslaufzeit der Mitgliedsverträge mit einer Mindestvertragslaufzeit unter 12 Monate verlängern sich jeweils um die online ausgewählte Laufzeit, wenn der „Mitgliedsvertrag“ nicht vom Mitglied oder von EASYFITNESS unter Einhaltung einer Kündigungsfrist von mindestens 1 Monat vor dem jeweiligen Vertragsende gekündigt wird. 	25.9	24
\.


--
-- TOC entry 3046 (class 0 OID 91350)
-- Dependencies: 207
-- Data for Name: course; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.course (id, name, description) FROM stdin;
1	Spinning	Im Gegensatz zum Heimfahrrad oder Ergometer ist das Spinning-Bike ein Standrad mit Starrlauf, mit dem man das tatsächliche Radtraining sinnvoll simulieren bzw. um spezielle Technik-Drills ergänzen kann. Mentale Hilfen, zum Beispiel Visualisierung, und spezielle Atemtechniken kommen ebenfalls zum Einsatz. 
2	Bodyatack	BODYATTACK ist eine hochintensive Fitness-Class mit Bewegungsabläufen, die sowohl für absolute Anfänger als auch für Fitness-Freaks geeignet sind. Dieses Workout kombiniert athletische Bewegung wie Laufen, Ausfallschritte oder Springen mit Kraftübungen wie Push-Ups und Squats. Ein Instruktor führt dich mit energiegeladener Musik durchs Workout und motiviert dich dazu, an deine Grenzen zu gehen. Dabei verbrennst du bis zu 730 Kalorien^ und fühlst dich danach einfach großartig.
\.


--
-- TOC entry 3055 (class 0 OID 91412)
-- Dependencies: 216
-- Data for Name: date; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.date (id, week_day, hour, min, duration, course_id) FROM stdin;
1	0	18	30	60	1
2	3	19	0	40	1
3	1	18	0	45	2
4	5	14	0	55	2
\.


--
-- TOC entry 3063 (class 0 OID 91486)
-- Dependencies: 224
-- Data for Name: date_location; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.date_location (date_id, location_id) FROM stdin;
1	1
1	2
2	1
2	2
3	1
3	2
4	2
\.


--
-- TOC entry 3044 (class 0 OID 91339)
-- Dependencies: 205
-- Data for Name: device; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.device (id, name, description) FROM stdin;
1	Butterfly	Mit der Butterfly-Maschine trainierst Du primär Deine Brustmuskulatur. Die Brustmuskeln (musculus pectoralis major et minor) sind für das Zusammenführen der Arme vor dem Körper zuständig. Bei der eGym Butterfly-Maschine wird die Brustmuskulatur im Gegensatz zu anderen Brust Übungen wie Liegestützen über den vollen Bewegungsumfang trainiert. Hier müssen Deine Brustmuskeln auch im Endpunkt maximal arbeiten. Insbesondere die inneren Bereiche der Brust werden so stärker trainiert. Eine gut ausgebildete Brustmuskulatur ist für die Stabilisierung und somit für die Gesundheit des Schultergelenks unerlässlich.
2	Beinstrecker	Mit dem Beinstrecker trainierst Du Deine vorderen Oberschenkelmuskeln, d. h. den vierköpfigen Oberschenkelmuskel (Musculus quadriceps femoris). Der Quadrizeps ist der Muskel mit der größten Muskelmasse im Körper und besteht aus vier Köpfen oder Teilen, dem geraden Oberschenkelmuskel (Musculus rectus femoris), dem inneren Oberschenkelmuskel (Musculus vastus medialis), dem mittleren Oberschenkelmuskel (Musculus vastus intermedius) und dem äußeren Oberschenkelmuskel (Musculus vastus lateralis). Die Hauptfunktion Deiner vorderen Oberschenkelmuskulatur ist die Kniestreckung, wie z. B. beim Laufen und Springen.
\.


--
-- TOC entry 3065 (class 0 OID 91516)
-- Dependencies: 226
-- Data for Name: device_muscle; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.device_muscle (device_id, muscle_id) FROM stdin;
1	1
1	2
2	3
\.


--
-- TOC entry 3062 (class 0 OID 91471)
-- Dependencies: 223
-- Data for Name: exercise; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.exercise (trainingplan_id, device_id, sets, repetitions, duration) FROM stdin;
1	1	3	10	\N
1	2	3	10	\N
\.


--
-- TOC entry 3042 (class 0 OID 91328)
-- Dependencies: 203
-- Data for Name: location; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.location (id, name, description, street, place) FROM stdin;
1	Smart City - Straße 7	Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.	Straße 7	4242 Smart City
2	Smart City - Straße 73	Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.	Straße 73	4242 Smart City
\.


--
-- TOC entry 3064 (class 0 OID 91501)
-- Dependencies: 225
-- Data for Name: location_device; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.location_device (location_id, device_id) FROM stdin;
1	1
2	1
1	2
\.


--
-- TOC entry 3051 (class 0 OID 91381)
-- Dependencies: 212
-- Data for Name: member; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.member (id, role, height, weight, performance_level, other_activitys, diseases, goal, time_aviability, abo_start, abo_id) FROM stdin;
1	0	190	75	4	Fußball		Gewichtszunahme	2	2020-01-01	2
2	1	190	75	4	Fußball		Gewichtszunahme	2	\N	\N
3	2	190	75	4	Fußball		Gewichtszunahme	2	\N	\N
\.


--
-- TOC entry 3050 (class 0 OID 91372)
-- Dependencies: 211
-- Data for Name: muscle; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.muscle (id, name, description) FROM stdin;
1	Brustmuskel	
2	Vorderer Armmuskel	
3	Vorderer Oberschenkelmuskel	
\.


--
-- TOC entry 3061 (class 0 OID 91457)
-- Dependencies: 222
-- Data for Name: trainingplan; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.trainingplan (id, name, note, member_id) FROM stdin;
1	Fit mit 2 Übungen	Siehe Titel	1
\.


--
-- TOC entry 3059 (class 0 OID 91441)
-- Dependencies: 220
-- Data for Name: trainingplanrequest; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.trainingplanrequest (id, request_date, member_id) FROM stdin;
1	2020-05-23	1
\.


--
-- TOC entry 3053 (class 0 OID 91396)
-- Dependencies: 214
-- Data for Name: treatmentnote; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.treatmentnote (id, day, note, member_id) FROM stdin;
1	2020-02-17	Er stellt sich ziemlich an...	1
\.


--
-- TOC entry 3057 (class 0 OID 91425)
-- Dependencies: 218
-- Data for Name: treatmentrequest; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.treatmentrequest (id, request_date, note, member_id) FROM stdin;
1	2020-05-23	Verletzung am Fuß	1
\.


--
-- TOC entry 3081 (class 0 OID 0)
-- Dependencies: 208
-- Name: abo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.abo_id_seq', 3, true);


--
-- TOC entry 3082 (class 0 OID 0)
-- Dependencies: 206
-- Name: course_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.course_id_seq', 2, true);


--
-- TOC entry 3083 (class 0 OID 0)
-- Dependencies: 215
-- Name: date_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.date_id_seq', 4, true);


--
-- TOC entry 3084 (class 0 OID 0)
-- Dependencies: 204
-- Name: device_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.device_id_seq', 2, true);


--
-- TOC entry 3085 (class 0 OID 0)
-- Dependencies: 202
-- Name: location_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.location_id_seq', 2, true);


--
-- TOC entry 3086 (class 0 OID 0)
-- Dependencies: 210
-- Name: muscle_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.muscle_id_seq', 3, true);


--
-- TOC entry 3087 (class 0 OID 0)
-- Dependencies: 221
-- Name: trainingplan_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.trainingplan_id_seq', 1, true);


--
-- TOC entry 3088 (class 0 OID 0)
-- Dependencies: 219
-- Name: trainingplanrequest_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.trainingplanrequest_id_seq', 1, true);


--
-- TOC entry 3089 (class 0 OID 0)
-- Dependencies: 213
-- Name: treatmentnote_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.treatmentnote_id_seq', 1, true);


--
-- TOC entry 3090 (class 0 OID 0)
-- Dependencies: 217
-- Name: treatmentrequest_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.treatmentrequest_id_seq', 1, true);


--
-- TOC entry 2878 (class 2606 OID 91369)
-- Name: abo abo_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.abo
    ADD CONSTRAINT abo_pkey PRIMARY KEY (id);


--
-- TOC entry 2876 (class 2606 OID 91358)
-- Name: course course_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.course
    ADD CONSTRAINT course_pkey PRIMARY KEY (id);


--
-- TOC entry 2896 (class 2606 OID 91490)
-- Name: date_location date_location_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.date_location
    ADD CONSTRAINT date_location_pkey PRIMARY KEY (date_id, location_id);


--
-- TOC entry 2886 (class 2606 OID 91417)
-- Name: date date_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.date
    ADD CONSTRAINT date_pkey PRIMARY KEY (id);


--
-- TOC entry 2900 (class 2606 OID 91520)
-- Name: device_muscle device_muscle_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.device_muscle
    ADD CONSTRAINT device_muscle_pkey PRIMARY KEY (device_id, muscle_id);


--
-- TOC entry 2874 (class 2606 OID 91347)
-- Name: device device_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.device
    ADD CONSTRAINT device_pkey PRIMARY KEY (id);


--
-- TOC entry 2894 (class 2606 OID 91475)
-- Name: exercise exercise_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.exercise
    ADD CONSTRAINT exercise_pkey PRIMARY KEY (trainingplan_id, device_id);


--
-- TOC entry 2898 (class 2606 OID 91505)
-- Name: location_device location_device_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.location_device
    ADD CONSTRAINT location_device_pkey PRIMARY KEY (location_id, device_id);


--
-- TOC entry 2872 (class 2606 OID 91336)
-- Name: location location_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.location
    ADD CONSTRAINT location_pkey PRIMARY KEY (id);


--
-- TOC entry 2882 (class 2606 OID 91388)
-- Name: member member_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.member
    ADD CONSTRAINT member_pkey PRIMARY KEY (id);


--
-- TOC entry 2880 (class 2606 OID 91380)
-- Name: muscle muscle_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.muscle
    ADD CONSTRAINT muscle_pkey PRIMARY KEY (id);


--
-- TOC entry 2892 (class 2606 OID 91465)
-- Name: trainingplan trainingplan_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.trainingplan
    ADD CONSTRAINT trainingplan_pkey PRIMARY KEY (id);


--
-- TOC entry 2890 (class 2606 OID 91449)
-- Name: trainingplanrequest trainingplanrequest_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.trainingplanrequest
    ADD CONSTRAINT trainingplanrequest_pkey PRIMARY KEY (id);


--
-- TOC entry 2884 (class 2606 OID 91404)
-- Name: treatmentnote treatmentnote_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.treatmentnote
    ADD CONSTRAINT treatmentnote_pkey PRIMARY KEY (id);


--
-- TOC entry 2888 (class 2606 OID 91433)
-- Name: treatmentrequest treatmentrequest_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.treatmentrequest
    ADD CONSTRAINT treatmentrequest_pkey PRIMARY KEY (id);


--
-- TOC entry 2903 (class 2606 OID 91418)
-- Name: date date_course_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.date
    ADD CONSTRAINT date_course_id_fkey FOREIGN KEY (course_id) REFERENCES public.course(id);


--
-- TOC entry 2909 (class 2606 OID 91491)
-- Name: date_location date_location_date_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.date_location
    ADD CONSTRAINT date_location_date_id_fkey FOREIGN KEY (date_id) REFERENCES public.date(id);


--
-- TOC entry 2910 (class 2606 OID 91496)
-- Name: date_location date_location_location_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.date_location
    ADD CONSTRAINT date_location_location_id_fkey FOREIGN KEY (location_id) REFERENCES public.location(id);


--
-- TOC entry 2913 (class 2606 OID 91521)
-- Name: device_muscle device_muscle_device_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.device_muscle
    ADD CONSTRAINT device_muscle_device_id_fkey FOREIGN KEY (device_id) REFERENCES public.device(id);


--
-- TOC entry 2914 (class 2606 OID 91526)
-- Name: device_muscle device_muscle_muscle_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.device_muscle
    ADD CONSTRAINT device_muscle_muscle_id_fkey FOREIGN KEY (muscle_id) REFERENCES public.muscle(id);


--
-- TOC entry 2908 (class 2606 OID 91481)
-- Name: exercise exercise_device_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.exercise
    ADD CONSTRAINT exercise_device_id_fkey FOREIGN KEY (device_id) REFERENCES public.device(id);


--
-- TOC entry 2907 (class 2606 OID 91476)
-- Name: exercise exercise_trainingplan_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.exercise
    ADD CONSTRAINT exercise_trainingplan_id_fkey FOREIGN KEY (trainingplan_id) REFERENCES public.trainingplan(id);


--
-- TOC entry 2912 (class 2606 OID 91511)
-- Name: location_device location_device_device_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.location_device
    ADD CONSTRAINT location_device_device_id_fkey FOREIGN KEY (device_id) REFERENCES public.device(id);


--
-- TOC entry 2911 (class 2606 OID 91506)
-- Name: location_device location_device_location_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.location_device
    ADD CONSTRAINT location_device_location_id_fkey FOREIGN KEY (location_id) REFERENCES public.location(id);


--
-- TOC entry 2901 (class 2606 OID 91389)
-- Name: member member_abo_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.member
    ADD CONSTRAINT member_abo_id_fkey FOREIGN KEY (abo_id) REFERENCES public.abo(id);


--
-- TOC entry 2906 (class 2606 OID 91466)
-- Name: trainingplan trainingplan_member_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.trainingplan
    ADD CONSTRAINT trainingplan_member_id_fkey FOREIGN KEY (member_id) REFERENCES public.member(id);


--
-- TOC entry 2905 (class 2606 OID 91450)
-- Name: trainingplanrequest trainingplanrequest_member_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.trainingplanrequest
    ADD CONSTRAINT trainingplanrequest_member_id_fkey FOREIGN KEY (member_id) REFERENCES public.member(id);


--
-- TOC entry 2902 (class 2606 OID 91405)
-- Name: treatmentnote treatmentnote_member_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.treatmentnote
    ADD CONSTRAINT treatmentnote_member_id_fkey FOREIGN KEY (member_id) REFERENCES public.member(id);


--
-- TOC entry 2904 (class 2606 OID 91434)
-- Name: treatmentrequest treatmentrequest_member_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.treatmentrequest
    ADD CONSTRAINT treatmentrequest_member_id_fkey FOREIGN KEY (member_id) REFERENCES public.member(id);


-- Completed on 2020-06-15 10:22:30 CEST

--
-- PostgreSQL database dump complete
--
