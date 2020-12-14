--this makes a database called dec6test
CREATE DATABASE dec6test;

--this command connects to the database called dec6test
\c dec6test;

/*  
These are the structures of the table: column name, then data type, and constraints.  * Use the R code to split the eBird download into 4 csv files that will get loaded into  * these tables after they are created. 
 */

-- this fixes some character encoding issues
SET CLIENT_ENCODING TO 'utf8';

CREATE TABLE brd (
taxonomic_order INT,
category VARCHAR(25),
common_name VARCHAR(75) NOT NULL PRIMARY KEY,
scientific_name VARCHAR(75),
subspecies_common_name VARCHAR(100),
subpsecies_scientific_name VARCHAR(100));

-- OPTIONAL USER TABLE, user info not available in download, request from ebird central
CREATE TABLE usr (
email VARCHAR(50),
last_name VARCHAR(80),
first_name VARCHAR(80), 
observer_id VARCHAR(15) UNIQUE NOT NULL PRIMARY KEY);

CREATE TABLE loc (
country VARCHAR(50),
country_code VARCHAR(10),
state VARCHAR(70),
state_code VARCHAR(5),
county VARCHAR(70),
county_code VARCHAR(10),
iba_code VARCHAR(15),
bcr_code VARCHAR(15),
usfws_code VARCHAR(15),
atlas_block VARCHAR(10),
locality VARCHAR,
locality_id VARCHAR(10) NOT NULL PRIMARY KEY,
locality_type VARCHAR(10),
latitude DECIMAL(8,5), 
longitude DECIMAL(8,5));

CREATE TABLE sub (
locality_id VARCHAR(10) REFERENCES loc(locality_id),
observation_date DATE,
time_observations_started TIME,
observer_id VARCHAR(15) REFERENCES usr (observer_id),
sampling_event_identifier VARCHAR(15) UNIQUE NOT NULL PRIMARY KEY,
protocol_type VARCHAR(50),
protocol_code CHAR (3),
project_code VARCHAR(25),
duration_minutes SMALLINT,
effort_distance_km DECIMAL(8,3),
effort_area_ha DECIMAL(8,3),
number_observers SMALLINT,
all_species_reported BOOLEAN,
group_identifier VARCHAR(15),
trip_comments VARCHAR);

CREATE TABLE obs (
global_unique_identifier VARCHAR(50) UNIQUE NOT NULL PRIMARY KEY,
last_edited_date TIMESTAMP,
common_name VARCHAR(70) REFERENCES brd (common_name),
observation_count VARCHAR(10),
breeding_bird_atlas_code VARCHAR(2),
breeding_bird_atlas_category CHAR(2),
age_sex VARCHAR,
sampling_event_identifier VARCHAR(15) REFERENCES sub (sampling_event_identifier),
has_media BOOLEAN,
approved BOOLEAN,
reviewed BOOLEAN,
reason VARCHAR(50),
species_comments VARCHAR);

-- OPTIONAL NOCTURNAL TAGS ON CHECKLIST, request from ebird central
--CREATE TABLE noc (
--sampling_event_identifier VARCHAR(15) UNIQUE NOT NULL PRIMARY KEY,
--is_noc VARCHAR(9));

-- add hiddenrecords, request from ebird central
                                   
-- add taxonomy (optional, brings in sort by taxon option or use of 6-letter code as better key for birds)

/* 
This populates the tables with data. Change path to the proper files. In order for the program to be allowed access, you need to find file or folder, then go to: properties, security, Edit, Add "Everyone" as a user, then allow all permissions to Everyone. Second word below is the name of the table we are copying into. These csv files are  created from the eBird download with the R code, except for user which is prepared separately.
 */

COPY BRD FROM 'C:\Users\nicho\Desktop\database\dec6test\brd.csv' DELIMITER ',' CSV HEADER NULL AS 'NA';

--make sure userIDs say obsr123 not user123 (they are listed as obsr in the EBD but user on any back-end exports)
COPY USR FROM 'C:\Users\nicho\Desktop\database\dec6test\usr.csv' DELIMITER ',' CSV HEADER NULL AS 'NA';

COPY LOC FROM 'C:\Users\nicho\Desktop\database\dec6test\loc.csv' DELIMITER ',' CSV HEADER NULL AS 'NA';

COPY SUB FROM 'C:\Users\nicho\Desktop\database\dec6test\sub.csv' DELIMITER ',' CSV HEADER NULL AS 'NA';

--obs is the largest table so this next line can take quite a while to load if the file is large               
COPY OBS FROM 'C:\Users\nicho\Desktop\database\dec6test\obs.csv' DELIMITER ',' CSV HEADER NULL AS 'NA';

--COPY NOC FROM 'C:\Users\nicho\Desktop\database\dec5test\noc.csv' DELIMITER ',' CSV HEADER NULL AS 'NA';
