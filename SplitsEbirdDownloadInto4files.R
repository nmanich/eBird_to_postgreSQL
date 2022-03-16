# the time this script takes to run will vary with the number of cores available
# and the amount of RAM. on a computer with 8 cores and 32 GB RAM, this took
# just over a minute to run on a decade of data.

#NOTE: there are 2 versions of this, depending on the headers you're loading in.

#NOTE: there are also 2 ways to export the table, one providing UTF-8 csvs, though 
# the other way is faster


#####STRAIGHT EBD COLUMN HEADERS

library(data.table)
library(parallel)

# number of cores used for file read/writes; one less than all cores available
n_core <- detectCores() - 1

#read in download from ebird, change this to your file name; read in all columns
#as character
file <- "EBDmergedwithSensitiveSpeciesandZeroCountRecords.txt"

ebird <- fread(file, quote = "", na.strings = "", nThread = n_core,
               check.names = TRUE, colClasses = "character")

# OPTIONAL, this limits the file to only atlas portal records
ebird  <- ebird[ebird$PROJECT.CODE == "EBIRD_ATL_WI", ]

### OBS

#this selects specific columns for obs
obs <- ebird[,c(GLOBAL.UNIQUE.IDENTIFIER, LAST.EDITED.DATE, COMMON.NAME, EXOTIC.CODE, OBSERVATION.COUNT, BREEDING.CODE, BREEDING.CATEGORY, BEHAVIOR.CODE, AGE.SEX, SAMPLING.EVENT.IDENTIFIER, HAS.MEDIA, APPROVED, REVIEWED, REASON, 
SPECIES.COMMENTS)]

head(obs)

#this is the faster way to export file to csv
#fwrite(obs, file = "obs.csv", quote = TRUE, nThread = n_core, na = "NA")

#this is the slower way to export filt to csv but it uses UTF-8 which we're using in postgres
write.csv(obs,"obs.csv",fileEncoding = "UTF-8",row.names=FALSE)

rm("obs")  # remove because it's a very large item and we're done with it

### LOC

#this selects specific columns for loc
loc <- ebird[,c(COUNTRY, COUNTRY.CODE, STATE, STATE.CODE, COUNTY, COUNTY.CODE, IBA.CODE, BCR.CODE, USFWS.CODE, ATLAS.BLOCK, LOCALITY, LOCALITY.ID, LOCALITY.TYPE, LATITUDE, LONGITUDE)]

# remove duplicated locations
loc <- loc[order(ATLAS.BLOCK),]
loc <- loc[!duplicated(loc$LOCALITY.ID), ]

# should return 0
anyDuplicated(loc$LOCALITY.ID)

#fwrite(loc, file = "loc.csv", quote = TRUE, nThread = n_core, na = "NA") #faster
write.csv(loc,"loc.csv",fileEncoding = "UTF-8",row.names=FALSE) #as UTF-8

### SUB

#this selects specific columns for sub
sub <- ebird[,c(LOCALITY.ID, OBSERVATION.DATE, TIME.OBSERVATIONS.STARTED, OBSERVER.ID, SAMPLING.EVENT.IDENTIFIER, PROTOCOL.TYPE, PROTOCOL.CODE, PROJECT.CODE, DURATION.MINUTES, EFFORT.DISTANCE.KM, EFFORT.AREA.HA, NUMBER.OBSERVERS, 
ALL.SPECIES.REPORTED, GROUP.IDENTIFIER, TRIP.COMMENTS)]

#remove rows with duplicated checklists, leaving a file with only unique checklists
sub <- sub[!duplicated(sub$SAMPLING.EVENT.IDENTIFIER), ]

#export file to csv
#fwrite(sub, file = "sub.csv", quote = TRUE, nThread = n_core, na = "NA") #faster
write.csv(sub,"sub.csv",fileEncoding = "UTF-8",row.names=FALSE) #as UTF-8

### BRD

#this selects specific columns for bird
bird <- ebird[,c(TAXONOMIC.ORDER, CATEGORY, TAXON.CONCEPT.ID, COMMON.NAME, SCIENTIFIC.NAME, SUBSPECIES.COMMON.NAME, SUBSPECIES.SCIENTIFIC.NAME)]

#remove rows with duplicated birds, leaving a file with only unique common names
bird <- bird[!duplicated(bird$COMMON.NAME), ]

# note that the above potentially removes subspecies/form info; to keep this,
# use the following instead
# bird <- unique(bird)

#export file to csv
# fwrite(bird, file = "brd.csv", quote = TRUE, nThread = n_core, na = "NA") #faster
write.csv(bird,"brd.csv",fileEncoding = "UTF-8",row.names=FALSE) #as UTF-8

##############################################################################

#####SNAKECASE HEADER VERSION

library(data.table)
library(parallel)

# number of cores used for file read/writes; one less than all cores available
n_core <- detectCores() - 1

#read in download from ebird, change this to your file name; read in all columns
#as character
file <- "EBDmergedwithSensitiveSpeciesandZeroCountRecordsGood.txt"

ebird <- fread(file, quote = "", na.strings = "", nThread = n_core,
               check.names = TRUE, colClasses = "character")

# OPTIONAL, this limits the file to only atlas portal records
ebird  <- ebird[ebird$project_code == "EBIRD_ATL_WI", ]

### OBS

#this selects specific columns for obs
obs <- ebird[,c("global_unique_identifier", "last_edited_date", "common_name", "exotic_code", "observation_count", "breeding_code", "breeding_category", "behavior_code", "age_sex", "sampling_event_identifier", "has_media", "approved", "reviewed", "reason", "species_comments")]

#this is the faster way to export file to csv
#fwrite(obs, file = "obs.csv", quote = TRUE, nThread = n_core, na = "NA")

#this is the slower way to export filt to csv but it uses UTF-8 which we're using in postgres
write.csv(obs,"obs.csv",fileEncoding = "UTF-8",row.names=FALSE)

rm("obs")  # remove because it's a very large item and we're done with it

### LOC

#this selects specific columns for loc
loc <- ebird[,c("country", "country_code", "state", "state_code", "county", "county_code", "iba_code", "bcr_code", "usfws_code", "atlas_block", "locality", "locality_id", "locality_type", "latitude", "longitude")]

# remove duplicated locations
loc <- loc[order(atlas_block),]
loc <- loc[!duplicated(loc$locality_id), ]

# should return 0
anyDuplicated(loc$locality_id)

#export file to csv
#fwrite(loc, file = "loc.csv", quote = TRUE, nThread = n_core, na = "NA") #faster
write.csv(loc,"loc.csv",fileEncoding = "UTF-8",row.names=FALSE) #as UTF-8

### SUB

#this selects specific columns for sub
sub <- ebird[,c("locality_id", "observation_date", "time_observations_started", "observer_id", "sampling_event_identifier", "protocol_type", "protocol_code", "project_code", "duration_minutes", "effort_distance_km", "effort_area_ha", "number_observers", "all_species_reported", "group_identifier", "trip_comments")]

#remove rows with duplicated checklists, leaving a file with only unique checklists
sub <- sub[!duplicated(sub$sampling_event_identifier), ]

#export file to csv
#fwrite(sub, file = "sub.csv", quote = TRUE, nThread = n_core, na = "NA") #faster
write.csv(sub,"sub.csv",fileEncoding = "UTF-8",row.names=FALSE) #as UTF-8

### BRD

#this selects specific columns for bird
bird <- ebird[,c("taxonomic_order", "category", "taxon_concept_id", "common_name", "scientific_name", "subspecies_common_name", "subspecies_scientific_name")]

#remove rows with duplicated birds, leaving a file with only unique common names
bird <- bird[!duplicated(bird$common_name), ]

# note that the above potentially removes subspecies/form info; to keep this,
# use the following instead
# bird <- unique(bird)

#export file to csv
# fwrite(bird, file = "brd.csv", quote = TRUE, nThread = n_core, na = "NA") #faster
write.csv(bird,"brd.csv",fileEncoding = "UTF-8",row.names=FALSE) #as UTF-8
