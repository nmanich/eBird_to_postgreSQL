--this makes a database called test5

CREATE DATABASE test5;

--this command connects to the database called test5

\c test5

/*  
 * These are the structures of the table: column name, then data type, and constraints.  * Use the R code to split the eBird download into 4 csv files that will get loaded into  * these tables after they are created. 
 */

CREATE TABLE obs (
global_unique_identifier VARCHAR(50) NOT NULL PRIMARY KEY,
last_edited_date TIMESTAMP,
common_name VARCHAR(70) NOT NULL,
observation_count VARCHAR(10),
breeding_bird_atlas_code VARCHAR(2),
breeding_bird_atlas_category CHAR(2),
age_sex VARCHAR,
locality_id VARCHAR(10) NOT NULL,
observer_id VARCHAR(15) NOT NULL,
sampling_event_identifier VARCHAR(15) NOT NULL,
has_media BOOLEAN,
approved BOOLEAN,
reviewed BOOLEAN,
reason VARCHAR(50),
species_comments VARCHAR);

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
observation_date DATE,
time_observations_started TIME,
observer_id VARCHAR(15),
sampling_event_identifier VARCHAR(15) NOT NULL PRIMARY KEY,
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
last_name VARCHAR(60),
first_name VARCHAR(60), 
observer_id VARCHAR(15) NOT NULL PRIMARY KEY);

-- OPTIONAL NOCTURNAL TAGS ON CHECKLIST, request from ebird central

CREATE TABLE noc (
sampling_event_identifier VARCHAR(15) NOT NULL PRIMARY KEY,
is_noc VARCHAR(9));

-- add hiddenrecords, request from ebird central
                                   
-- add taxonomy (optional, brings in sort by taxon option or use of 6-letter code as better key for birds)

-- this fixes some character encoding issues
SET CLIENT_ENCODING TO 'utf8';

/* 
This populates the tables with data. Change path to the proper files. In order for the program to be allowed access, you need to find file or folder, then go to: properties, security, Edit, Add "Everyone" as a user, then allow all permissions to Everyone. Second word below is the name of the table we are copying into. These csv files are  created from the eBird download with the R code, except for user which is prepared separately.
 */

--obs is the largest table so this next line can take quite a while to load if the file is large               
COPY OBS FROM 'C:\Users\nicho\Desktop\testdatabase5\obs.csv' DELIMITER ',' CSV HEADER NULL AS 'NA';

COPY LOC FROM 'C:\Users\nicho\Desktop\testdatabase5\loc.csv' DELIMITER ',' CSV HEADER NULL AS 'NA';

COPY SUB FROM 'C:\Users\nicho\Desktop\testdatabase5\sub.csv' DELIMITER ',' CSV HEADER NULL AS 'NA';

COPY BRD FROM 'C:\Users\nicho\Desktop\testdatabase5\brd.csv' DELIMITER ',' CSV HEADER NULL AS 'NA';

COPY USR FROM 'C:\Users\nicho\Desktop\testdatabase5\usr.csv' DELIMITER ',' CSV HEADER NULL AS 'NA';

COPY NOC FROM 'C:\Users\nicho\Desktop\testdatabase5\noc.csv' DELIMITER ',' CSV HEADER NULL AS 'NA';
