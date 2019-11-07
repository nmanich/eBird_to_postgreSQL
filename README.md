# eBird_to_postgreSQL
Trying to get a version of the EBD running on my machine in postgres. Work in progress.

Currently there are 3 files here

1. The first file takes your eBird download and splits it into 4 tables - OBS, SUB, LOC, and BRD. You can optionally add a user table (if you get user info from eBird central).

2. The ERD file shows how these tables connect to each other and what's in them.

3. The third file contains code to create these 5 tables in PostgreSQL, and then populate those tables with the data from the tables you made in step 1.
