-- Database generated with pgModeler (PostgreSQL Database Modeler).
-- pgModeler version: 1.1.0
-- PostgreSQL version: 16.0
-- Project Site: pgmodeler.io
-- Model Author: ---

-- Database creation must be performed outside a multi lined SQL file. 
-- These commands were put in this file only as a convenience.
-- 
-- object: gamesite | type: DATABASE --
-- DROP DATABASE IF EXISTS gamesite;
--CREATE DATABASE gamesite
--	OWNER = postgres;
-- ddl-end --


-- object: gamesite | type: SCHEMA --
-- DROP SCHEMA IF EXISTS gamesite CASCADE;
CREATE SCHEMA IF NOT EXISTS gamesite;
-- ddl-end --
ALTER SCHEMA gamesite OWNER TO postgres;
-- ddl-end --

SET search_path TO pg_catalog,public,gamesite;
-- ddl-end --

-- object: public.users_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS public.users_id_seq CASCADE;
CREATE SEQUENCE IF NOT EXISTS public.users_id_seq
	INCREMENT BY 1
	MINVALUE -2147483648
	MAXVALUE 2147483647
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --

-- object: public.activationkeys_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS public.activationkeys_id_seq CASCADE;
CREATE SEQUENCE IF NOT EXISTS public.activationkeys_id_seq
	INCREMENT BY 1
	MINVALUE -2147483648
	MAXVALUE 2147483647
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --

-- object: public.suspensions_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS public.suspensions_id_seq CASCADE;
CREATE SEQUENCE IF NOT EXISTS public.suspensions_id_seq
	INCREMENT BY 1
	MINVALUE -2147483648
	MAXVALUE 2147483647
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --

-- object: public.queuetesters_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS public.queuetesters_id_seq CASCADE;
CREATE SEQUENCE IF NOT EXISTS public.queuetesters_id_seq
	INCREMENT BY 1
	MINVALUE -2147483648
	MAXVALUE 2147483647
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --

-- object: public.activetesters_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS public.activetesters_id_seq CASCADE;
CREATE SEQUENCE IF NOT EXISTS public.activetesters_id_seq
	INCREMENT BY 1
	MINVALUE -2147483648
	MAXVALUE 2147483647
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --

-- object: public.downloadlinks_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS public.downloadlinks_id_seq CASCADE;
CREATE SEQUENCE IF NOT EXISTS public.downloadlinks_id_seq
	INCREMENT BY 1
	MINVALUE -2147483648
	MAXVALUE 2147483647
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --

-- object: public.profiles_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS public.profiles_id_seq CASCADE;
CREATE SEQUENCE IF NOT EXISTS public.profiles_id_seq
	INCREMENT BY 1
	MINVALUE -2147483648
	MAXVALUE 2147483647
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --

-- object: public.activetesters | type: TABLE --
-- DROP TABLE IF EXISTS public.activetesters CASCADE;
CREATE TABLE IF NOT EXISTS public.activetesters (
	id integer NOT NULL DEFAULT nextval('public.activetesters_id_seq'::regclass),
	user_id serial,
	CONSTRAINT activetesters_pk PRIMARY KEY (id),
	CONSTRAINT unique_activetesters_user_id UNIQUE (user_id)
);
-- ddl-end --
ALTER TABLE public.activetesters OWNER TO postgres;
-- ddl-end --

-- object: public.users | type: TABLE --
-- DROP TABLE IF EXISTS public.users CASCADE;
CREATE TABLE IF NOT EXISTS public.users (
	id integer NOT NULL DEFAULT nextval('public.users_id_seq'::regclass),
	username text,
	password text NOT NULL,
	last_password_change bigint,
	admin bool NOT NULL,
	activated bool NOT NULL,
	activation_deadline bigint NOT NULL,
	CONSTRAINT users_pk PRIMARY KEY (id),
	CONSTRAINT unique_users_username UNIQUE (username)
);
-- ddl-end --
ALTER TABLE public.users OWNER TO postgres;
-- ddl-end --

-- object: public.profiles | type: TABLE --
-- DROP TABLE IF EXISTS public.profiles CASCADE;
CREATE TABLE IF NOT EXISTS public.profiles (
	id integer NOT NULL DEFAULT nextval('public.profiles_id_seq'::regclass),
	user_id serial NOT NULL,
	first_name text,
	last_name text,
	resume text,
	CONSTRAINT profiles_pk PRIMARY KEY (id),
	CONSTRAINT unique_profiles_user_id UNIQUE (user_id)
);
-- ddl-end --
ALTER TABLE public.profiles OWNER TO postgres;
-- ddl-end --

-- object: public.queuetesters | type: TABLE --
-- DROP TABLE IF EXISTS public.queuetesters CASCADE;
CREATE TABLE IF NOT EXISTS public.queuetesters (
	id integer NOT NULL DEFAULT nextval('public.queuetesters_id_seq'::regclass),
	user_id serial,
	"from" bigint NOT NULL,
	rejected bool NOT NULL,
	rejected_until bigint NOT NULL,
	rejected_message text,
	CONSTRAINT queuetesters_pk PRIMARY KEY (id),
	CONSTRAINT unique_queuetesters_user_id UNIQUE (user_id)
);
-- ddl-end --
ALTER TABLE public.queuetesters OWNER TO postgres;
-- ddl-end --

-- object: public.downloadlinks | type: TABLE --
-- DROP TABLE IF EXISTS public.downloadlinks CASCADE;
CREATE TABLE IF NOT EXISTS public.downloadlinks (
	id integer NOT NULL DEFAULT nextval('public.downloadlinks_id_seq'::regclass),
	activetester_id serial NOT NULL,
	link text NOT NULL,
	expire_time bigint NOT NULL,
	generations integer NOT NULL,
	uses smallint NOT NULL,
	CONSTRAINT downloadlinks_pk PRIMARY KEY (id),
	CONSTRAINT unique_activetesters_activetester_id UNIQUE (activetester_id)
);
-- ddl-end --
ALTER TABLE public.downloadlinks OWNER TO postgres;
-- ddl-end --

-- object: public.activationkeys | type: TABLE --
-- DROP TABLE IF EXISTS public.activationkeys CASCADE;
CREATE TABLE IF NOT EXISTS public.activationkeys (
	id integer NOT NULL DEFAULT nextval('public.activationkeys_id_seq'::regclass),
	user_id serial NOT NULL,
	key text NOT NULL,
	force_password_change bool NOT NULL,
	date bigint NOT NULL,
	CONSTRAINT activationkeys_pk PRIMARY KEY (id),
	CONSTRAINT unique_activationkeys_key UNIQUE (key),
	CONSTRAINT unique_activationkeys_user_id UNIQUE (user_id)
);
-- ddl-end --
ALTER TABLE public.activationkeys OWNER TO postgres;
-- ddl-end --

-- object: public.suspensions | type: TABLE --
-- DROP TABLE IF EXISTS public.suspensions CASCADE;
CREATE TABLE IF NOT EXISTS public.suspensions (
	id integer NOT NULL DEFAULT nextval('public.suspensions_id_seq'::regclass),
	user_id serial,
	by_user_id serial NOT NULL,
	"from" bigint NOT NULL,
	until bigint NOT NULL,
	message text,
	CONSTRAINT suspensions_pk PRIMARY KEY (id),
	CONSTRAINT unique_suspensions_user_id UNIQUE (user_id)
);
-- ddl-end --
ALTER TABLE public.suspensions OWNER TO postgres;
-- ddl-end --

-- -- object: fk_activetesters_user_id_users | type: CONSTRAINT --
-- -- ALTER TABLE public.activetesters DROP CONSTRAINT IF EXISTS fk_activetesters_user_id_users CASCADE;
-- ALTER TABLE public.activetesters ADD CONSTRAINT fk_activetesters_user_id_users FOREIGN KEY (user_id)
-- REFERENCES public.users (id) MATCH SIMPLE
-- ON DELETE NO ACTION ON UPDATE NO ACTION;
-- -- ddl-end --
--
-- -- object: fk_profiles_user_id_users | type: CONSTRAINT --
-- -- ALTER TABLE public.profiles DROP CONSTRAINT IF EXISTS fk_profiles_user_id_users CASCADE;
-- ALTER TABLE public.profiles ADD CONSTRAINT fk_profiles_user_id_users FOREIGN KEY (user_id)
-- REFERENCES public.users (id) MATCH SIMPLE
-- ON DELETE NO ACTION ON UPDATE NO ACTION;
-- -- ddl-end --
--
-- -- object: fk_queuetesters_user_id_users | type: CONSTRAINT --
-- -- ALTER TABLE public.queuetesters DROP CONSTRAINT IF EXISTS fk_queuetesters_user_id_users CASCADE;
-- ALTER TABLE public.queuetesters ADD CONSTRAINT fk_queuetesters_user_id_users FOREIGN KEY (user_id)
-- REFERENCES public.users (id) MATCH SIMPLE
-- ON DELETE NO ACTION ON UPDATE NO ACTION;
-- -- ddl-end --
--
-- -- object: fk_downloadlinks_activetester_id_activetesters | type: CONSTRAINT --
-- -- ALTER TABLE public.downloadlinks DROP CONSTRAINT IF EXISTS fk_downloadlinks_activetester_id_activetesters CASCADE;
-- ALTER TABLE public.downloadlinks ADD CONSTRAINT fk_downloadlinks_activetester_id_activetesters FOREIGN KEY (activetester_id)
-- REFERENCES public.activetesters (user_id) MATCH SIMPLE
-- ON DELETE NO ACTION ON UPDATE NO ACTION;
-- -- ddl-end --
--
-- -- object: fk_activationkeys_user_id_users | type: CONSTRAINT --
-- -- ALTER TABLE public.activationkeys DROP CONSTRAINT IF EXISTS fk_activationkeys_user_id_users CASCADE;
-- ALTER TABLE public.activationkeys ADD CONSTRAINT fk_activationkeys_user_id_users FOREIGN KEY (user_id)
-- REFERENCES public.users (id) MATCH SIMPLE
-- ON DELETE NO ACTION ON UPDATE NO ACTION;
-- -- ddl-end --
--
-- -- object: fk_suspensions_user_id_users | type: CONSTRAINT --
-- -- ALTER TABLE public.suspensions DROP CONSTRAINT IF EXISTS fk_suspensions_user_id_users CASCADE;
-- ALTER TABLE public.suspensions ADD CONSTRAINT fk_suspensions_user_id_users FOREIGN KEY (user_id)
-- REFERENCES public.users (id) MATCH SIMPLE
-- ON DELETE NO ACTION ON UPDATE NO ACTION;
-- -- ddl-end --
--
-- -- object: fk_suspensions_by_user_id_users | type: CONSTRAINT --
-- -- ALTER TABLE public.suspensions DROP CONSTRAINT IF EXISTS fk_suspensions_by_user_id_users CASCADE;
-- ALTER TABLE public.suspensions ADD CONSTRAINT fk_suspensions_by_user_id_users FOREIGN KEY (by_user_id)
-- REFERENCES public.users (id) MATCH SIMPLE
-- ON DELETE NO ACTION ON UPDATE NO ACTION;
-- -- ddl-end --


