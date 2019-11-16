 --this makes a database called test3

CREATE DATABASE test3;

--this command connects to the database called test3

\c test3

/*  
 * These are the structures of the table: column name, then data type, and constraints. Use the R code to split the eBird download into 4 csv files that will get loaded into these tables after they are created. Note: Codes that should techically be a different type but I moved to varchar for now because nulls were messing it up include bcrcode, reason, durationminutes, numberobservers, effortdistkm, effortareaha.
 */

CREATE TABLE obs (
global_unique_identifier VARCHAR(50) NOT NULL PRIMARY KEY,
last_edited_date VARCHAR(50),
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
global_unique_identifier VARCHAR(50) NOT NULL,
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
global_unique_identifier  VARCHAR(50) NOT NULL,
observation_date VARCHAR(20),
time_observations_started VARCHAR(20),
observer_id VARCHAR(15),
sampling_event_identifier VARCHAR(15) NOT NULL PRIMARY KEY,
protocol_type VARCHAR(50),
protocol_code CHAR (3),
project_code VARCHAR(25),
duration_minutes VARCHAR(25),
effort_distance_km VARCHAR(25),
effort_area_ha VARCHAR(25),
number_observers VARCHAR(25),
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

--user info not available in download, request from ebird central

CREATE TABLE usr (
email VARCHAR(50),
last_name VARCHAR(50),
first_name VARCHAR(50), 
observer_id VARCHAR(15) NOT NULL PRIMARY KEY);

--nocturnal table, request from ebird central

--hiddenrecords, request from ebird central

-- this fixes some character encoding issues
SET CLIENT_ENCODING TO 'utf8';

/* 
 * This populates the tables with data. Change path to the proper files. In order for the program to be allowed access, you need to find file or folder, then go to: properties, security, Edit, Add "Everyone" as a user, then allow all permissions to Everyone. Second word below is the name of the table we are copying into. These csv files are created from the eBird download with the R code, except for user which is prepared separately.
 */
 
COPY OBS FROM 'C:\Users\nicho\Desktop\testdatabase3\obs.csv' DELIMITER ',' CSV HEADER;

COPY LOC FROM 'C:\Users\nicho\Desktop\testdatabase3\loc.csv' DELIMITER ',' CSV HEADER;

COPY SUB FROM 'C:\Users\nicho\Desktop\testdatabase3\sub.csv' DELIMITER ',' CSV HEADER;

COPY BRD FROM 'C:\Users\nicho\Desktop\testdatabase3\brd.csv' DELIMITER ',' CSV HEADER;

COPY USR FROM 'C:\Users\nicho\Desktop\testdatabase3\usr.csv' DELIMITER ',' CSV HEADER;
