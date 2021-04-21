

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

INSERT INTO public.posts (id, title, body, created_at) VALUES ('3e76f707-11af-49af-a7ca-89353c40081b', 'Cine foro', 'This is an event for watching "Los del camino" film from Colombia.', '2021-04-21 15:16:24.862211-04');
INSERT INTO public.posts (id, title, body, created_at) VALUES ('6c26933f-47f8-4a07-8ffc-5d8709a9d8cf', 'Hello', 'World', '2021-04-21 15:16:24.863153-04');
INSERT INTO public.posts (id, title, body, created_at) VALUES ('b7784c72-e2fb-4f30-8938-bb3aa8cfb8d6', 'Diclo', '## Get diclo
this is **body** *text*. 
', '2021-04-21 15:23:21.527879-04');
INSERT INTO public.posts (id, title, body, created_at) VALUES ('73170821-d03f-4d3f-8dca-a9bcf81bf8f6', 'tt', 'fff ~fff~', '2021-04-21 16:31:41.872294-04');


ALTER TABLE public.posts ENABLE TRIGGER ALL;


