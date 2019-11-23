--This selects all the records that are coded in other portals (currently set to all portals except atlas wisconsin)

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

WHERE (breeding_bird_atlas_category = 'C2' OR breeding_bird_atlas_category = 'C3' OR breeding_bird_atlas_category = 'C4')

AND project_code != 'EBIRD_ATL_WI'


)

TO 'C:\Users\nicho\Desktop\testdatabase5\testcodesinwrongportalfrompost3.csv'

WITH (FORMAT CSV, HEADER, DELIMITER ',');
