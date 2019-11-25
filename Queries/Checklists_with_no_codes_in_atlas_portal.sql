
--This script exports out checklists with no code within the atlas portal.
--I don't have script written to produce the codedstatus table, so for now for this function I'm using something under small R scripts.

CREATE DATABASE portalouttest;

--this command connects to the database called test5

\c portalouttest

/*  
These are the structures of the table: column name, then data type, and constraints. Use the R code to split the eBird download into 4 csv files that will get loaded into these tables after they are created. 
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

--USER TABLE, user info not available in download, request from ebird central

CREATE TABLE usr (
email VARCHAR(50),
last_name VARCHAR(50),
first_name VARCHAR(50), 
observer_id VARCHAR(15) NOT NULL PRIMARY KEY);

--NOCTURNAL TAGS ON CHECKLIST, request from ebird central

CREATE TABLE noc (
sampling_event_identifier VARCHAR(15) NOT NULL PRIMARY KEY,
is_noc VARCHAR(9));

--this is a new table for this script. The column status has 2 values: UNCODED means the entire checklist has no code, and CODED means there is a code (above F) on the checklist
CREATE TABLE codedstatus (
global_unique_identifier VARCHAR(50) NOT NULL PRIMARY KEY,
status VARCHAR(7));
                                
-- this fixes some character encoding issues
SET CLIENT_ENCODING TO 'utf8';

/* 
This populates the tables with data. Change path to the proper files. In order for the program to be allowed access, you need to find file or folder, then go to: properties, security, Edit, Add "Everyone" as a user, then allow all permissions to Everyone. Second word below is the name of the table we are copying into. These csv files are  created from the eBird download with the R code, except for user which is prepared separately.
 */

--obs is the largest table so this next line can take quite a while to load if the file is large               
COPY OBS FROM 'C:\Users\nicho\Desktop\portalout\obs.csv' DELIMITER ',' CSV HEADER NULL AS 'NA';

COPY LOC FROM 'C:\Users\nicho\Desktop\portalout\loc.csv' DELIMITER ',' CSV HEADER NULL AS 'NA';

COPY SUB FROM 'C:\Users\nicho\Desktop\portalout\sub.csv' DELIMITER ',' CSV HEADER NULL AS 'NA';

COPY BRD FROM 'C:\Users\nicho\Desktop\portalout\brd.csv' DELIMITER ',' CSV HEADER NULL AS 'NA';

COPY USR FROM 'C:\Users\nicho\Desktop\portalout\usr.csv' DELIMITER ',' CSV HEADER NULL AS 'NA';

COPY NOC FROM 'C:\Users\nicho\Desktop\portalout\noc.csv' DELIMITER ',' CSV HEADER NULL AS 'NA';

--this is a new table for this query, see above
COPY CODEDSTATUS FROM 'C:\Users\nicho\Desktop\portalout\codedstatus.csv' DELIMITER ',' CSV HEADER NULL AS 'NA';


--------------------------------------------------------------------------------------------------------------------

--This selects all the records that are uncoded but in the atlas portal

SET CLIENT_ENCODING TO 'utf8';

COPY (

SELECT  

	obs.global_unique_identifier,

	obs.last_edited_date,

	brd.taxonomic_order,

	brd.category,

	obs.common_name,

	brd.scientific_name,

	brd.subspecies_common_name,

	brd.subpsecies_scientific_name,

	obs.observation_count,

	obs.breeding_bird_atlas_code,

	obs.breeding_bird_atlas_category,

	obs.age_sex,

	loc.country,

	loc.country_code,

	loc.state,

	loc.state_code,

	loc.county,

	loc.county_code,

	loc.iba_code,

	loc.bcr_code,

	loc.usfws_code,

	loc.atlas_block,

	loc.locality,

        obs.locality_id,

	loc.locality_type,

	loc.latitude,

	loc.longitude,

	sub.observation_date,

	sub.time_observations_started,

	obs.observer_id,

	obs.sampling_event_identifier,

	sub.protocol_type,

	sub.protocol_code,

	sub.project_code,

	sub.duration_minutes,

	sub.effort_distance_km,
	
	sub.effort_area_ha,
	
	sub.number_observers,
	
	sub.all_species_reported,
	
	sub.group_identifier,
	
	obs.has_media,
	
	obs.approved,
	
	obs.reviewed,
	
	obs.reason,
	
	usr.email,
	
	usr.last_name,
	
	usr.first_name,
	
	sub.trip_comments,
	
	obs.species_comments,
	
	noc.is_noc

FROM     obs LEFT JOIN loc

            ON obs.locality_id = loc.locality_id

LEFT JOIN usr

            ON obs.observer_id = usr.observer_id          

LEFT JOIN sub

            ON obs.sampling_event_identifier = sub.sampling_event_identifier    

LEFT JOIN brd

            ON obs.common_name = brd.common_name 

LEFT JOIN noc   

	    ON obs.sampling_event_identifier = noc.sampling_event_identifier 

LEFT JOIN codedstatus   

	    ON obs.global_unique_identifier = codedstatus.global_unique_identifier          

--this indicates you want records where the checklist has no codes, in the atlas portal (here wi), and not night checklists (where entering time but with no codes can be valid)

WHERE (status = 'UNCODED') and (project_code = 'EBIRD_ATL_WI') and (is_noc IS NULL)

)

TO 'C:\Users\nicho\Desktop\portalout\portalouttest5.csv'

WITH (FORMAT CSV, HEADER, DELIMITER ',');





