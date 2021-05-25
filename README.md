# eBird_to_postgreSQL

*Script to go from an eBird download to a PostgreSQL database.* 

The file (Splits...) takes your eBird download and splits it into 4 tables - OBS, SUB, LOC, and BRD. You can optionally add a fifth USR table (if you get user info from eBird central).

The file (Creating...) contains code to create these 4 tables in PostgreSQL, and then populate those tables with the data from the tables you made. There are some additional tables 

IN PROGRESS: Code for non-EBD data in the eBird database that is useful to me, specifically: Sensitive Species Observations, User-Hidden Checklists, 0-Count Records, Nocturnal Checklist Tags, Atlas Block Centroids, and Atlas Block Status.

The file (ERD...; see below) shows how these tables connect to each other and what's in them.

The Query folder contains a variety of queries to grab various things from the database. Would love it if people can add files here if you have some that have been working for you. 

There's also a folder for the old versions of Splits.. and Creating... back before the eBird column headers changed with the release of the April 2021 EBD. This probably is not needed for most people, but I'm hesitant to erase them in case I need them!

![erd](https://github.com/nmanich/eBird_to_postgreSQL/blob/master/ERD6.png)
