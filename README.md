# eBird_to_postgreSQL

Trying to automate taking an eBird download and bringing it into a PostgreSQL database. Work in progress!

Currently there are 4 files here

1. The first file (Splits...) takes your eBird download and splits it into 4 tables - OBS, SUB, LOC, and BRD. You can optionally add a fifth user table (if you get user info from eBird central).

2. The second file (ERD.bmp; see below) shows how these tables connect to each other and what's in them.

3. The third file (Creating...) contains code to create these 5 tables in PostgreSQL, and then populate those tables with the data from the tables you made in step 1.

4. The fourth file (Query...) contains a query that can reassemble the EBD. You can modify this code as part of more specific queries to select a subset of the database.

![erd](https://github.com/nmanich/eBird_to_postgreSQL/blob/master/ERD5.png)
