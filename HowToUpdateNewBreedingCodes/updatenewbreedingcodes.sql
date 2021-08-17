/*  
This is how you overwrite old breeding codes with changed breeding codes.
 */

--make an update csv with these 3 columns, the obsid you want to change, and the new breeding code and category
CREATE TABLE newcodes (
newcode_global_unique_identifier VARCHAR(50) UNIQUE NOT NULL PRIMARY KEY,
newbreeding_code VARCHAR(2),
newbreeding_category CHAR(2));

--load the table you created above with the csv you made from your data with intended changes
COPY NEWCODES FROM 'C:\Users\nicho\Desktop\nawatestdatabase\newcodes.csv' DELIMITER ',' CSV HEADER NULL AS 'NA';

--make changes to update the breeding codes and breeding category within the obs table of the database
UPDATE obs
SET breeding_code = newbreeding_code
FROM newcodes
WHERE global_unique_identifier = newcode_global_unique_identifier;

UPDATE obs
SET breeding_category = newbreeding_category
FROM newcodes
WHERE global_unique_identifier = newcode_global_unique_identifier;





