--
-- PostgreSQL database dump
--

-- Dumped from database version 12.22 (Ubuntu 12.22-0ubuntu0.20.04.4)
-- Dumped by pg_dump version 12.22 (Ubuntu 12.22-0ubuntu0.20.04.4)

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

DROP DATABASE universe;
--
-- Name: universe; Type: DATABASE; Schema: -; Owner: freecodecamp
--

CREATE DATABASE universe WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE universe OWNER TO freecodecamp;

\connect universe

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
-- Name: asteroid; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.asteroid (
    asteroid_id integer NOT NULL,
    name character varying(100) NOT NULL,
    galaxy_id integer,
    star_id integer,
    size_km integer NOT NULL,
    velocity_kms integer NOT NULL,
    is_hazardous boolean NOT NULL
);


ALTER TABLE public.asteroid OWNER TO freecodecamp;

--
-- Name: asteroid_asteroid_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.asteroid_asteroid_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.asteroid_asteroid_id_seq OWNER TO freecodecamp;

--
-- Name: asteroid_asteroid_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.asteroid_asteroid_id_seq OWNED BY public.asteroid.asteroid_id;


--
-- Name: galaxy; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.galaxy (
    galaxy_id integer NOT NULL,
    name character varying(100) NOT NULL,
    type text NOT NULL,
    mass double precision NOT NULL,
    age double precision NOT NULL,
    redshift double precision NOT NULL,
    has_black_hole boolean NOT NULL,
    arms_count smallint,
    CONSTRAINT arms_spiral_check CHECK (((type <> 'spiral'::text) OR (arms_count IS NOT NULL)))
);


ALTER TABLE public.galaxy OWNER TO freecodecamp;

--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.galaxy_galaxy_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.galaxy_galaxy_id_seq OWNER TO freecodecamp;

--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.galaxy_galaxy_id_seq OWNED BY public.galaxy.galaxy_id;


--
-- Name: moon; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.moon (
    moon_id integer NOT NULL,
    planet_id integer NOT NULL,
    name character varying(100) NOT NULL,
    type text NOT NULL,
    radius double precision,
    mass double precision,
    orbital_period_days double precision,
    is_geologically_active boolean,
    has_subsurface_ocean boolean
);


ALTER TABLE public.moon OWNER TO freecodecamp;

--
-- Name: moon_moon_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.moon_moon_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.moon_moon_id_seq OWNER TO freecodecamp;

--
-- Name: moon_moon_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.moon_moon_id_seq OWNED BY public.moon.moon_id;


--
-- Name: planet; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.planet (
    planet_id integer NOT NULL,
    star_id integer NOT NULL,
    name character varying(100) NOT NULL,
    type text,
    mass double precision NOT NULL,
    radius double precision,
    age double precision NOT NULL,
    orbital_distance_au double precision,
    temperature_k double precision,
    habitable_probability numeric NOT NULL,
    has_life boolean
);


ALTER TABLE public.planet OWNER TO freecodecamp;

--
-- Name: planet_planet_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.planet_planet_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.planet_planet_id_seq OWNER TO freecodecamp;

--
-- Name: planet_planet_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.planet_planet_id_seq OWNED BY public.planet.planet_id;


--
-- Name: star; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.star (
    star_id integer NOT NULL,
    galaxy_id integer NOT NULL,
    name character varying(100) NOT NULL,
    type text NOT NULL,
    mass double precision NOT NULL,
    age double precision NOT NULL,
    temperature_k double precision NOT NULL,
    luminosity double precision NOT NULL,
    radius double precision NOT NULL
);


ALTER TABLE public.star OWNER TO freecodecamp;

--
-- Name: star_star_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.star_star_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.star_star_id_seq OWNER TO freecodecamp;

--
-- Name: star_star_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.star_star_id_seq OWNED BY public.star.star_id;


--
-- Name: asteroid asteroid_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.asteroid ALTER COLUMN asteroid_id SET DEFAULT nextval('public.asteroid_asteroid_id_seq'::regclass);


--
-- Name: galaxy galaxy_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy ALTER COLUMN galaxy_id SET DEFAULT nextval('public.galaxy_galaxy_id_seq'::regclass);


--
-- Name: moon moon_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon ALTER COLUMN moon_id SET DEFAULT nextval('public.moon_moon_id_seq'::regclass);


--
-- Name: planet planet_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet ALTER COLUMN planet_id SET DEFAULT nextval('public.planet_planet_id_seq'::regclass);


--
-- Name: star star_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star ALTER COLUMN star_id SET DEFAULT nextval('public.star_star_id_seq'::regclass);


--
-- Data for Name: asteroid; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.asteroid VALUES (1, 'Apophis-like', 1, 1, 340, 30, true);
INSERT INTO public.asteroid VALUES (2, 'Ceres Fragment', 1, 1, 950, 18, false);
INSERT INTO public.asteroid VALUES (3, 'Orion Belt Rock', 2, 2, 120, 42, true);
INSERT INTO public.asteroid VALUES (4, 'Deep Space Wanderer', NULL, NULL, 60, 55, false);
INSERT INTO public.asteroid VALUES (5, 'Centauri Bullet', 3, 3, 210, 70, true);


--
-- Data for Name: galaxy; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.galaxy VALUES (1, 'Milky Way', 'spiral', 1500000000000, 13.6, 0, true, 4);
INSERT INTO public.galaxy VALUES (2, 'Andromeda', 'spiral', 1200000000000, 10, 0.001, true, 2);
INSERT INTO public.galaxy VALUES (3, 'Triangulum', 'spiral', 50000000000, 12, 0.002, true, 3);
INSERT INTO public.galaxy VALUES (4, 'Sombrero Galaxy', 'spiral', 800000000000, 13, 0.0034, true, 0);
INSERT INTO public.galaxy VALUES (5, 'Large Magellanic Cloud', 'irregular', 15000000000, 13.5, 0.0009, false, NULL);
INSERT INTO public.galaxy VALUES (6, 'Messier 87', 'elliptical', 2700000000000, 13.2, 0.0043, true, NULL);


--
-- Data for Name: moon; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.moon VALUES (1, 1, 'Moon', 'regular', 1737, 0.0123, 27.3, false, false);
INSERT INTO public.moon VALUES (2, 4, 'Phobos', 'captured', 11.1, 1e-05, 0.32, false, false);
INSERT INTO public.moon VALUES (3, 4, 'Deimos', 'captured', 6.2, 1e-06, 1.26, false, false);
INSERT INTO public.moon VALUES (4, 5, 'Io', 'geologically_active', 1821, 0.015, 1.77, true, false);
INSERT INTO public.moon VALUES (5, 5, 'Europa', 'regular', 1560, 0.008, 3.55, true, true);
INSERT INTO public.moon VALUES (6, 5, 'Ganymede', 'regular', 2634, 0.025, 7.15, false, true);
INSERT INTO public.moon VALUES (7, 5, 'Callisto', 'regular', 2410, 0.018, 16.7, false, false);
INSERT INTO public.moon VALUES (8, 6, 'Titan', 'regular', 2574, 0.0225, 15.9, false, true);
INSERT INTO public.moon VALUES (9, 6, 'Enceladus', 'regular', 252, 0.00018, 1.37, true, true);
INSERT INTO public.moon VALUES (10, 6, 'Mimas', 'regular', 198, 4e-05, 0.94, false, false);
INSERT INTO public.moon VALUES (11, 7, 'Proxima I-A', 'captured', 900, 0.005, 5.2, false, false);
INSERT INTO public.moon VALUES (12, 7, 'Proxima I-B', 'regular', 1200, 0.007, 12.4, true, true);
INSERT INTO public.moon VALUES (13, 8, 'Frozen Rocklet', 'irregular', 80, 1e-05, 30, false, false);
INSERT INTO public.moon VALUES (14, 9, 'Alpha I', 'regular', 1500, 0.009, 2.2, true, false);
INSERT INTO public.moon VALUES (15, 9, 'Alpha II', 'captured', 400, 0.0005, 18, false, false);
INSERT INTO public.moon VALUES (16, 10, 'Beta Ringmoon', 'regular', 600, 0.002, 1.1, false, false);
INSERT INTO public.moon VALUES (17, 10, 'Beta Ice Fragment', 'irregular', 200, 0.0002, 3.8, false, false);
INSERT INTO public.moon VALUES (18, 11, 'Centauri Moon A', 'regular', 1700, 0.01, 4.6, true, true);
INSERT INTO public.moon VALUES (19, 12, 'Vega I', 'captured', 950, 0.006, 9.3, false, false);
INSERT INTO public.moon VALUES (20, 12, 'Vega II', 'regular', 1100, 0.008, 6.8, false, false);


--
-- Data for Name: planet; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.planet VALUES (1, 1, 'Mercury-like', 'terrestrial', 0.055, 0.383, 4.5, 0.39, 440, 0.01, false);
INSERT INTO public.planet VALUES (2, 1, 'Venus-like', 'terrestrial', 0.815, 0.949, 4.5, 0.72, 737, 0.05, false);
INSERT INTO public.planet VALUES (3, 1, 'Earth-like', 'terrestrial', 1, 1, 4.5, 1, 288, 0.95, true);
INSERT INTO public.planet VALUES (4, 1, 'Mars-like', 'terrestrial', 0.107, 0.532, 4.5, 1.52, 210, 0.30, false);
INSERT INTO public.planet VALUES (5, 2, 'Hot Jupiter', 'gas giant', 1.2, 1.1, 0.2, 0.05, 1800, 0.02, false);
INSERT INTO public.planet VALUES (6, 2, 'Ice Giant X', 'ice giant', 0.8, 0.9, 1, 5.2, 70, 0.10, false);
INSERT INTO public.planet VALUES (7, 3, 'Proxima b', 'terrestrial', 1.3, 1.1, 4.8, 0.048, 234, 0.70, false);
INSERT INTO public.planet VALUES (8, 3, 'Frozen Rock', 'dwarf planet', 0.02, 0.2, 4.8, 12, 30, 0.01, false);
INSERT INTO public.planet VALUES (9, 4, 'Alpha Hot Rock', 'terrestrial', 2, 1.5, 0.3, 0.2, 900, 0.05, false);
INSERT INTO public.planet VALUES (10, 4, 'Alpha Gas Giant', 'gas giant', 5, 1.2, 0.3, 2, 600, 0.01, false);
INSERT INTO public.planet VALUES (11, 5, 'Centauri I', 'terrestrial', 0.9, 0.95, 4.8, 0.05, 280, 0.85, true);
INSERT INTO public.planet VALUES (12, 6, 'Vega Major', 'gas giant', 3.5, 1.4, 0.4, 1.2, 1500, 0.03, false);


--
-- Data for Name: star; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.star VALUES (1, 1, 'Sun', 'main sequence', 1, 4.6, 5778, 1, 1);
INSERT INTO public.star VALUES (2, 1, 'Sirius A', 'main sequence', 2.02, 0.24, 9940, 25.4, 1.71);
INSERT INTO public.star VALUES (3, 2, 'Betelgeuse', 'red supergiant', 11.6, 8, 3500, 126000, 764);
INSERT INTO public.star VALUES (4, 2, 'Rigel', 'blue supergiant', 21, 8, 12100, 120000, 78.9);
INSERT INTO public.star VALUES (5, 3, 'Proxima Centauri', 'red dwarf', 0.122, 4.85, 3042, 0.0017, 0.1542);
INSERT INTO public.star VALUES (6, 4, 'Vega', 'main sequence', 2.1, 0.45, 9602, 40.12, 2.36);


--
-- Name: asteroid_asteroid_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.asteroid_asteroid_id_seq', 5, true);


--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.galaxy_galaxy_id_seq', 6, true);


--
-- Name: moon_moon_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.moon_moon_id_seq', 20, true);


--
-- Name: planet_planet_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.planet_planet_id_seq', 12, true);


--
-- Name: star_star_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.star_star_id_seq', 6, true);


--
-- Name: asteroid asteroid_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.asteroid
    ADD CONSTRAINT asteroid_name_key UNIQUE (name);


--
-- Name: asteroid asteroid_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.asteroid
    ADD CONSTRAINT asteroid_pkey PRIMARY KEY (asteroid_id);


--
-- Name: galaxy galaxy_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_name_key UNIQUE (name);


--
-- Name: galaxy galaxy_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_pkey PRIMARY KEY (galaxy_id);


--
-- Name: moon moon_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_name_key UNIQUE (name);


--
-- Name: moon moon_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_pkey PRIMARY KEY (moon_id);


--
-- Name: planet planet_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_name_key UNIQUE (name);


--
-- Name: planet planet_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_pkey PRIMARY KEY (planet_id);


--
-- Name: star star_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_name_key UNIQUE (name);


--
-- Name: star star_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_pkey PRIMARY KEY (star_id);


--
-- Name: asteroid fk_asteroid_galaxy; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.asteroid
    ADD CONSTRAINT fk_asteroid_galaxy FOREIGN KEY (galaxy_id) REFERENCES public.galaxy(galaxy_id);


--
-- Name: asteroid fk_asteroid_star; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.asteroid
    ADD CONSTRAINT fk_asteroid_star FOREIGN KEY (star_id) REFERENCES public.star(star_id);


--
-- Name: moon fk_moon_planet; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT fk_moon_planet FOREIGN KEY (planet_id) REFERENCES public.planet(planet_id);


--
-- Name: planet fk_planet_star; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT fk_planet_star FOREIGN KEY (star_id) REFERENCES public.star(star_id);


--
-- Name: star fk_star_galaxy; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT fk_star_galaxy FOREIGN KEY (galaxy_id) REFERENCES public.galaxy(galaxy_id);


--
-- PostgreSQL database dump complete
--

