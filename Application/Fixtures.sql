

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


SET SESSION AUTHORIZATION DEFAULT;

ALTER TABLE public.posts DISABLE TRIGGER ALL;

INSERT INTO public.posts (id, title, body) VALUES ('3e76f707-11af-49af-a7ca-89353c40081b', 'Cine foro', 'This is an event for watching "Los del camino" film from Colombia.');
INSERT INTO public.posts (id, title, body) VALUES ('6c26933f-47f8-4a07-8ffc-5d8709a9d8cf', 'Hello', 'World');


ALTER TABLE public.posts ENABLE TRIGGER ALL;


