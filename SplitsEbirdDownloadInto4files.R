#this can take a while to run (up to an hour for a decade of state level data)

library(tidyverse)

#read in download from ebird, change this to your file name
ebird <- read.delim("ebd_US-WI_rehwoo_199501_200012_relSep-2019.txt", sep="\t", header=TRUE, quote = "", stringsAsFactors = FALSE, na.strings=c(""))

#this removes dots from column names, which were spaces
names(ebird) <- gsub("\\.", "", names(ebird))

### OBS

ebirdforobs <- ebird

#change NAs to blanks 
ebirdforobs <- sapply(ebirdforobs, as.character)
ebirdforobs[is.na(ebirdforobs)] <- " "
ebirdforobs

#this selects specific columns for obs
obs <- ebirdforobs[,c(1,2,5,9,10,11,12,24,30,31,41,42,43,44,46)]

#export file to csv
write.csv(obs, file = "obs.csv", row.names=FALSE)

### LOC

#this selects specific columns for loc
loc <- ebird[,c(1, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27)]

#convert to tibble
loctib <- as_tibble(loc)

#remove rows with duplicated locations, leaving a file with only unique locations
nowwithfewer <- loctib[!duplicated(loctib$LOCALITYID), ]

#export file to csv
write.csv(nowwithfewer, file = "loc.csv", row.names=FALSE)

### SUB

#this selects specific columns for sub
sub <- ebird[,c(1, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 45)]

#convert to tibble
subtib <- as_tibble(sub)

#remove rows with duplicated checklists, leaving a file with only unique checklists
nowwithfewersubs <- subtib[!duplicated(subtib$SAMPLINGEVENTIDENTIFIER), ]

#export file to csv
write.csv(nowwithfewersubs, file = "sub.csv", row.names=FALSE)

### BRD

#this selects specific columns for bird
bird <- ebird[,c(3, 4, 5, 6, 7, 8)]

#convert to tibble
birdtib <- as_tibble(bird)

#remove rows with duplicated birds, leaving a file with only unique common names
nowwithfewerbirds <- birdtib[!duplicated(birdtib$COMMONNAME), ]

#export file to csv
write.csv(nowwithfewerbirds, file = "brd.csv", row.names=FALSE)
