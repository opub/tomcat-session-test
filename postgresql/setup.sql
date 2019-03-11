set search_path to public;

DROP TABLE IF EXISTS tomcat_sessions CASCADE;

CREATE TABLE tomcat_sessions
(
  session_id character varying(100) NOT NULL PRIMARY KEY,
  valid_session character(1) NOT NULL,
  max_inactive integer NOT NULL,
  last_access bigint NOT NULL,
  app_name character varying(255),
  session_data bytea
)
WITH (
  OIDS=FALSE
);

ALTER TABLE tomcat_sessions
  OWNER TO postgres;
