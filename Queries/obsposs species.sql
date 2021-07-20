-- Pulls out records for "obsposs treatment" (where observed and possible are considered a distinct category with "breeding category level 1.5" (like "Other Observations" of Ohio atlas))
-- Remember: *cut down to only EBIRD_ATL_WI records*
-- Pull Whooping Crane separately, as it is sensitive: 5/15 to 7/15

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

FROM      obs LEFT JOIN brd
            ON obs.common_name = brd.common_name  
              LEFT JOIN sub
            ON obs.sampling_event_identifier = sub.sampling_event_identifier          
              LEFT JOIN loc
            ON sub.locality_id = loc.locality_id
   	     LEFT JOIN usr
            ON sub.observer_id = usr.observer_id  

WHERE 

(
obs.common_name = 'Spotted Sandpiper'

AND 

(((obs.breeding_category is null OR obs.breeding_category = 'C1') AND sub.observation_date >= '2015-06-01' AND sub.observation_date <= '2015-07-31')

OR ((obs.breeding_category is null OR obs.breeding_category = 'C1') AND sub.observation_date >= '2016-06-01' AND sub.observation_date <= '2016-07-31')

OR ((obs.breeding_category is null OR obs.breeding_category = 'C1') AND sub.observation_date >= '2017-06-01' AND sub.observation_date <= '2017-07-31')

OR ((obs.breeding_category is null OR obs.breeding_category = 'C1') AND sub.observation_date >= '2018-06-01' AND sub.observation_date <= '2018-07-31')

OR ((obs.breeding_category is null OR obs.breeding_category = 'C1') AND sub.observation_date >= '2019-06-01' AND sub.observation_date <= '2019-07-31'))

OR

(obs.common_name = 'Spotted Sandpiper' AND obs.breeding_category = 'C2')
)

OR

(
obs.common_name = 'Laughing Gull'

AND 

(((obs.breeding_category is null OR obs.breeding_category = 'C1') AND sub.observation_date >= '2015-06-01' AND sub.observation_date <= '2015-07-15')

OR ((obs.breeding_category is null OR obs.breeding_category = 'C1') AND sub.observation_date >= '2016-06-01' AND sub.observation_date <= '2016-07-15')

OR ((obs.breeding_category is null OR obs.breeding_category = 'C1') AND sub.observation_date >= '2017-06-01' AND sub.observation_date <= '2017-07-15')

OR ((obs.breeding_category is null OR obs.breeding_category = 'C1') AND sub.observation_date >= '2018-06-01' AND sub.observation_date <= '2018-07-15')

OR ((obs.breeding_category is null OR obs.breeding_category = 'C1') AND sub.observation_date >= '2019-06-01' AND sub.observation_date <= '2019-07-15'))

OR

(obs.common_name = 'Laughing Gull' AND obs.breeding_category = 'C2')
)




)

TO 'C:\Users\nicho\Desktop\Apr2021Database\spsatest23.csv'
WITH (FORMAT CSV, HEADER, DELIMITER ',');