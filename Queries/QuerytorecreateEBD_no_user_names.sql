/* 
As written this essentially rebuids the EBD (eBird Database) original download file. I am using this like a master query
because it joins the major tables. You should be able to delete columns from this that you do not need. This version does not have a usr table with usernames.
*/

/* 
The SELECT code identifies columns in the table (you can delete columns not needed - this is a master list that essentially recreates the EBD.)
The FROM and JOIN statements join the other tables in with their matching columns.
The COPY part outside parentheses exports to csv.
You can add additional query language (e.g. WHERE statements) to pull specific things out.
*/
 
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
	obs.breeding_code,
	obs.breeding_category,
	obs.behavior_code,
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
	sub.observer_id,
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
	sub.trip_comments,
	obs.species_comments

FROM      obs LEFT JOIN brd
            ON obs.common_name = brd.common_name  
              LEFT JOIN sub
            ON obs.sampling_event_identifier = sub.sampling_event_identifier          
              LEFT JOIN loc
            ON sub.locality_id = loc.locality_id
   	          
           
)

TO 'C:\Users\nicho\Desktop\nawatestdatabase\nawatest.csv'
WITH (FORMAT CSV, HEADER, DELIMITER ',');
