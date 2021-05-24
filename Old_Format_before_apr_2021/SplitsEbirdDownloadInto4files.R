# the time this script takes to run will vary with the number of cores available
# and the amount of RAM. on a computer with 8 cores and 32 GB RAM, this took
# just over a minute to run on a decade of data.

library(data.table)
library(parallel)

# number of cores used for file read/writes; one less than all cores available
n_core <- detectCores() - 1

#read in download from ebird, change this to your file name; read in all columns
#as character
file <- "ebd_US-WI_201801_201812_relSep-2019.txt"
ebird <- fread(file, quote = "", na.strings = "", nThread = n_core,
               check.names = TRUE, colClasses = "character")

#this removes dots from column names, which were spaces
names(ebird) <- gsub("\\.", "", names(ebird))

### OBS

#this selects specific columns for obs
obs <- ebird[,c(1,2,5,9,10,11,12,31,41,42,43,44,46)]

#export file to csv
fwrite(obs, file = "obs.csv", quote = TRUE, nThread = n_core, na = "NA")

rm("obs")  # remove because it's a very large item and we're done with it

### LOC

#this selects specific columns for loc
loc <- ebird[,c(13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27)]

# remove duplicated locations
loc <- unique(loc)

# there are still duplicated locations because some locations have records with
# and without ATLASBLOCK; this removes those cases, keeping only the record with
# ATLASBLOCK
lid_blk <- loc[! is.na(ATLASBLOCK), LOCALITYID]
loc <- loc[(! LOCALITYID %in% lid_blk) | ! is.na(ATLASBLOCK)]

# should return 0
anyDuplicated(loc$LOCALITYID)

#export file to csv
fwrite(loc, file = "loc.csv", quote = TRUE, nThread = n_core, na = "NA")

### SUB

#this selects specific columns for sub
sub <- ebird[,c(24, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 45)]

#remove rows with duplicated checklists, leaving a file with only unique checklists
sub <- sub[!duplicated(sub$SAMPLINGEVENTIDENTIFIER), ]

#export file to csv
fwrite(sub, file = "sub.csv", quote = TRUE, nThread = n_core, na = "NA")

### BRD

#this selects specific columns for bird
bird <- ebird[,c(3, 4, 5, 6, 7, 8)]

#remove rows with duplicated birds, leaving a file with only unique common names
bird <- bird[!duplicated(bird$COMMONNAME), ]

# note that the above potentially removes subspecies/form info; to keep this,
# use the following instead
# bird <- unique(bird)

#export file to csv
fwrite(bird, file = "brd.csv", quote = TRUE, nThread = n_core, na = "NA")
