
--This script exports out checklists with no code within the atlas portal.
--I don't have script written to produce the codedstatus table, so for now for this function I'm using something under small R scripts.

--BEFORE CHECKING FOR CHECKLISTS WITH NO CODES, NEED TO MERGE IN SENSITIVE SPECIES, AND UN 0s.

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
	obs.species_comments,
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

--this indicates you want records where the checklist has no codes, in the atlas portal (here wi), and not night checklists (where entering time but with no codes can be valid)

WHERE (status = 'UNCODED') and (project_code = 'EBIRD_ATL_WI') and (is_noc IS NULL)

)

TO 'C:\Users\nicho\Desktop\portalout\portalouttest5.csv'

WITH (FORMAT CSV, HEADER, DELIMITER ',');





