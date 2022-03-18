# eBird_to_postgreSQL

*Script to go from an eBird download to a PostgreSQL database.* 

The file (Splits...) takes your eBird download and splits it into 4 tables - OBS, SUB, LOC, and BRD. You can optionally add a fifth USR table (if you get user info from eBird central). The Entity Relationship Diagram below shows how these tables connect to each other and what's in them.

The file (Creating...) contains code to create these 4 tables in PostgreSQL, and then populate those tables with the data from the tables you made. 

The Query folder contains a variety of queries to grab various things from the database. Would love it if people can add files here if you have some that have been working for you. I have a master one based on recreating the EBD that I find helpful - it's easier for me personally to delete columns from this I don't need than to craft new queries from scratch.

There are archive folders with old versions of Splits.. and Creating... as these files change when columns are added to the EBD. This probably is not needed for most people, but I'm hesitant to erase them in case I need them!

![erd](https://github.com/nmanich/eBird_to_postgreSQL/blob/master/ERD6.png)
