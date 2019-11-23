# eBird_to_postgreSQL

Script to go from an eBird download into a PostgreSQL database. 

The file (Splits...) takes your eBird download and splits it into 4 tables - OBS, SUB, LOC, and BRD. You can optionally add a fifth user table (if you get user info from eBird central).

The file (Creating...) contains code to create these 5 tables in PostgreSQL, and then populate those tables with the data from the tables you made.

The file (ERD...; see below) shows how these tables connect to each other and what's in them.

The Query folder contains a variety of queries to various things from the database. 

![erd](https://github.com/nmanich/eBird_to_postgreSQL/blob/master/ERD5.png)
