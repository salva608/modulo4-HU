--
-- PostgreSQL database dump
--

\restrict 8brjw6vasdPI44Jy9iXXPStKlaPkz0YhHZxHqg0vYi9Yc709ki50bguh9ZnW9BJ

-- Dumped from database version 18.2
-- Dumped by pg_dump version 18.2

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
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
-- Name: cursos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cursos (
    id_curso integer NOT NULL,
    nombre character varying(100) NOT NULL,
    codigo character varying(20) NOT NULL,
    creditos integer NOT NULL,
    semestre integer NOT NULL,
    id_docente integer,
    CONSTRAINT cursos_creditos_check CHECK ((creditos > 0)),
    CONSTRAINT cursos_semestre_check CHECK ((semestre >= 1))
);


ALTER TABLE public.cursos OWNER TO postgres;

--
-- Name: cursos_id_curso_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cursos_id_curso_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.cursos_id_curso_seq OWNER TO postgres;

--
-- Name: cursos_id_curso_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cursos_id_curso_seq OWNED BY public.cursos.id_curso;


--
-- Name: docentes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.docentes (
    id_docente integer NOT NULL,
    nombre_completo character varying(100) NOT NULL,
    correo_institucional character varying(100) NOT NULL,
    departamento_academico character varying(100) NOT NULL,
    anios_experiencia integer NOT NULL,
    CONSTRAINT docentes_anios_experiencia_check CHECK ((anios_experiencia >= 0))
);


ALTER TABLE public.docentes OWNER TO postgres;

--
-- Name: docentes_id_docente_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.docentes_id_docente_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.docentes_id_docente_seq OWNER TO postgres;

--
-- Name: docentes_id_docente_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.docentes_id_docente_seq OWNED BY public.docentes.id_docente;


--
-- Name: estudiantes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.estudiantes (
    id_estudiante integer NOT NULL,
    nombre_completo character varying(100) NOT NULL,
    correo_electronico character varying(100) NOT NULL,
    genero character varying(20),
    identificacion character varying(20) NOT NULL,
    carrera character varying(100) NOT NULL,
    fecha_nacimiento date NOT NULL,
    fecha_ingreso date NOT NULL,
    estado_academico character varying(20) DEFAULT 'Activo'::character varying,
    telefono character varying(20),
    CONSTRAINT estudiantes_genero_check CHECK (((genero)::text = ANY ((ARRAY['Masculino'::character varying, 'Femenino'::character varying, 'Otro'::character varying])::text[])))
);


ALTER TABLE public.estudiantes OWNER TO postgres;

--
-- Name: estudiantes_id_estudiante_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.estudiantes_id_estudiante_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.estudiantes_id_estudiante_seq OWNER TO postgres;

--
-- Name: estudiantes_id_estudiante_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.estudiantes_id_estudiante_seq OWNED BY public.estudiantes.id_estudiante;


--
-- Name: inscripciones; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.inscripciones (
    id_inscripcion integer NOT NULL,
    id_estudiante integer NOT NULL,
    id_curso integer NOT NULL,
    fecha_inscripcion date NOT NULL,
    calificacion_final numeric(4,2),
    CONSTRAINT inscripciones_calificacion_final_check CHECK (((calificacion_final >= (0)::numeric) AND (calificacion_final <= (5)::numeric)))
);


ALTER TABLE public.inscripciones OWNER TO postgres;

--
-- Name: inscripciones_id_inscripcion_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.inscripciones_id_inscripcion_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.inscripciones_id_inscripcion_seq OWNER TO postgres;

--
-- Name: inscripciones_id_inscripcion_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.inscripciones_id_inscripcion_seq OWNED BY public.inscripciones.id_inscripcion;


--
-- Name: vista_historial_academico; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.vista_historial_academico AS
 SELECT e.nombre_completo AS estudiante,
    c.nombre AS curso,
    d.nombre_completo AS docente,
    c.semestre,
    i.calificacion_final
   FROM (((public.inscripciones i
     JOIN public.estudiantes e ON ((i.id_estudiante = e.id_estudiante)))
     JOIN public.cursos c ON ((i.id_curso = c.id_curso)))
     LEFT JOIN public.docentes d ON ((c.id_docente = d.id_docente)));


ALTER VIEW public.vista_historial_academico OWNER TO postgres;

--
-- Name: cursos id_curso; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cursos ALTER COLUMN id_curso SET DEFAULT nextval('public.cursos_id_curso_seq'::regclass);


--
-- Name: docentes id_docente; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.docentes ALTER COLUMN id_docente SET DEFAULT nextval('public.docentes_id_docente_seq'::regclass);


--
-- Name: estudiantes id_estudiante; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estudiantes ALTER COLUMN id_estudiante SET DEFAULT nextval('public.estudiantes_id_estudiante_seq'::regclass);


--
-- Name: inscripciones id_inscripcion; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inscripciones ALTER COLUMN id_inscripcion SET DEFAULT nextval('public.inscripciones_id_inscripcion_seq'::regclass);


--
-- Data for Name: cursos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cursos (id_curso, nombre, codigo, creditos, semestre, id_docente) FROM stdin;
1	Bases de Datos	BD101	3	2	1
2	Derecho Civil	DC201	4	1	2
3	Anatom¡a	AN301	5	3	3
4	Programaci¢n	PR102	3	2	1
\.


--
-- Data for Name: docentes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.docentes (id_docente, nombre_completo, correo_institucional, departamento_academico, anios_experiencia) FROM stdin;
1	Dr. Ram¡rez	ramirez@uni.edu	Ingenier¡a	10
2	Dra. L¢pez	lopez@uni.edu	Derecho	4
3	Dr. S nchez	sanchez@uni.edu	Medicina	8
\.


--
-- Data for Name: estudiantes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.estudiantes (id_estudiante, nombre_completo, correo_electronico, genero, identificacion, carrera, fecha_nacimiento, fecha_ingreso, estado_academico, telefono) FROM stdin;
1	Juan P‚rez	juan@mail.com	Masculino	1001	Ingenier¡a	2002-05-10	2022-01-15	Activo	\N
2	Laura G¢mez	laura@mail.com	Femenino	1002	Derecho	2001-03-20	2021-01-15	Activo	\N
3	Carlos Ruiz	carlos@mail.com	Masculino	1003	Ingenier¡a	2000-11-02	2020-01-15	Activo	\N
4	Ana Torres	ana@mail.com	Femenino	1004	Medicina	2003-07-18	2022-01-15	Activo	\N
5	Mateo D¡az	mateo@mail.com	Masculino	1005	Arquitectura	2002-09-09	2021-01-15	Activo	\N
\.


--
-- Data for Name: inscripciones; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.inscripciones (id_inscripcion, id_estudiante, id_curso, fecha_inscripcion, calificacion_final) FROM stdin;
2	1	4	2024-02-01	4.00
3	2	2	2024-02-01	3.80
4	3	1	2024-02-01	4.70
5	3	4	2024-02-01	4.20
6	4	3	2024-02-01	3.50
7	5	1	2024-02-01	3.90
8	5	4	2024-02-01	4.10
1	1	1	2024-02-01	4.90
\.


--
-- Name: cursos_id_curso_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cursos_id_curso_seq', 4, true);


--
-- Name: docentes_id_docente_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.docentes_id_docente_seq', 3, true);


--
-- Name: estudiantes_id_estudiante_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.estudiantes_id_estudiante_seq', 5, true);


--
-- Name: inscripciones_id_inscripcion_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.inscripciones_id_inscripcion_seq', 8, true);


--
-- Name: cursos cursos_codigo_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cursos
    ADD CONSTRAINT cursos_codigo_key UNIQUE (codigo);


--
-- Name: cursos cursos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cursos
    ADD CONSTRAINT cursos_pkey PRIMARY KEY (id_curso);


--
-- Name: docentes docentes_correo_institucional_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.docentes
    ADD CONSTRAINT docentes_correo_institucional_key UNIQUE (correo_institucional);


--
-- Name: docentes docentes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.docentes
    ADD CONSTRAINT docentes_pkey PRIMARY KEY (id_docente);


--
-- Name: estudiantes estudiantes_correo_electronico_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estudiantes
    ADD CONSTRAINT estudiantes_correo_electronico_key UNIQUE (correo_electronico);


--
-- Name: estudiantes estudiantes_identificacion_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estudiantes
    ADD CONSTRAINT estudiantes_identificacion_key UNIQUE (identificacion);


--
-- Name: estudiantes estudiantes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estudiantes
    ADD CONSTRAINT estudiantes_pkey PRIMARY KEY (id_estudiante);


--
-- Name: inscripciones inscripciones_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inscripciones
    ADD CONSTRAINT inscripciones_pkey PRIMARY KEY (id_inscripcion);


--
-- Name: inscripciones fk_curso; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inscripciones
    ADD CONSTRAINT fk_curso FOREIGN KEY (id_curso) REFERENCES public.cursos(id_curso) ON DELETE CASCADE;


--
-- Name: cursos fk_docente; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cursos
    ADD CONSTRAINT fk_docente FOREIGN KEY (id_docente) REFERENCES public.docentes(id_docente) ON DELETE SET NULL;


--
-- Name: inscripciones fk_estudiante; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inscripciones
    ADD CONSTRAINT fk_estudiante FOREIGN KEY (id_estudiante) REFERENCES public.estudiantes(id_estudiante) ON DELETE CASCADE;


--
-- Name: TABLE vista_historial_academico; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.vista_historial_academico TO revisor_academico;


--
-- PostgreSQL database dump complete
--

\unrestrict 8brjw6vasdPI44Jy9iXXPStKlaPkz0YhHZxHqg0vYi9Yc709ki50bguh9ZnW9BJ

