--As written this selects all checklists OUTSIDE the Atlas Wisconsin portal, but see below where it can be easily modified

/* 
The SELECT code identifies columns in the table (you can delete columns not needed - this is a master list that essentially recreates the EBD.)
The FROM and JOIN statements join the other tables in with their matching columns.
The COPY part outside parentheses exports to csv.
The WHERE part is your specific query of the data
 */

SET CLIENT_ENCODING TO 'utf8';

-- remove usr. and noc. files if you don't have those tables

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
        sub.locality_id,
	loc.locality_type,
	loc.latitude,
	loc.longitude,
	sub.observation_date,
	sub.time_observations_started,
	usr.observer_id,
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
	obs.species_comments
	noc.is_noc

FROM      obs LEFT JOIN brd
            ON obs.common_name = brd.common_name  
              LEFT JOIN sub
            ON obs.sampling_event_identifier = sub.sampling_event_identifier          
              LEFT JOIN loc
            ON sub.locality_id = loc.locality_id
   	     LEFT JOIN usr
            ON sub.observer_id = usr.observer_id    
	    LEFT JOIN noc   
	    ON obs.sampling_event_identifier = noc.sampling_event_identifier

-- Here this specifies project code does not equal atlas wisconsin You could easily adjust this to say = EBIRD_ATL_VA or whatever
WHERE (project_code != 'EBIRD_ATL_WI') 

)        

TO 'C:\Users\nicho\Desktop\testdatabase5\NONPORTALFROMPOST.csv'

WITH (FORMAT CSV, HEADER, DELIMITER ',');
