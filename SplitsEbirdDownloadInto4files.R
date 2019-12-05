# the time this script takes to run will vary with the number of cores available
# and the amount of RAM. on a computer with 8 cores and 32 GB RAM, this took
# just under a minute to run on a decade of data.

library(data.table)
library(parallel)


# number of cores used for file read/writes; one less than all cores available
n_core <- detectCores() - 1

#read in download from ebird, change this to your file name
file <- "ebd_US-WI_rehwoo_199501_200012_relSep-2019.txt"
# read in all columns as character
ebird <- fread(file, quote = "", na.strings = "", nThread = n_core,
  check.names = TRUE, colClasses = "character")

#this removes dots from column names, which were spaces
names(ebird) <- gsub("\\.", "", names(ebird))

#change NAs to blanks
na_string <- " "  # NAs will be converted to this string
for (j in seq_along(ebird)) {
  set(ebird, which(is.na(ebird[[j]])), j, na_string)
}

### OBS

#this selects specific columns for obs
obs <- ebird[,c(1,2,5,9,10,11,12,24,30,31,41,42,43,44,46)]

#export file to csv
fwrite(obs, file = "obs.csv", quote = TRUE, nThread = n_core)

rm("obs")  # remove because it's a very large item and we're done with it

### LOC

#this selects specific columns for loc
loc <- ebird[,c(1, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27)]

#remove rows with duplicated locations, leaving a file with only unique locations
loc <- loc[!duplicated(loc$LOCALITYID), ]

#export file to csv
fwrite(loc, file = "loc.csv", quote = TRUE, nThread = n_core)

### SUB

#this selects specific columns for sub
sub <- ebird[,c(1, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 45)]

#remove rows with duplicated checklists, leaving a file with only unique checklists
sub <- sub[!duplicated(sub$SAMPLINGEVENTIDENTIFIER), ]

#export file to csv
fwrite(sub, file = "sub.csv", quote = TRUE, nThread = n_core)

### BRD

#this selects specific columns for bird
bird <- ebird[,c(3, 4, 5, 6, 7, 8)]

#remove rows with duplicated birds, leaving a file with only unique common names
bird <- bird[!duplicated(bird$COMMONNAME), ]

#export file to csv
fwrite(bird, file = "brd.csv", quote = TRUE, nThread = n_core)
