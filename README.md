# eBird_to_postgreSQL

*Script to go from an eBird download to a PostgreSQL database.* 

The file (Splits...) takes your eBird download and splits it into 4 tables - OBS, SUB, LOC, and BRD. You can optionally add a fifth user table (if you get user info from eBird central).

The file (Creating...) contains code to create these 4 tables in PostgreSQL, and then populate those tables with the data from the tables you made.

The file (ERD...; see below) shows how these tables connect to each other and what's in them.

The Query folder contains a variety of queries to grab various things from the database. Would love it if people can add files here if you have some that have been working for you. 

![erd](https://github.com/nmanich/eBird_to_postgreSQL/blob/master/ERD6.png)
