

---------------------------------------------------------------------------------------------------------------------------------------------------
--1. Extracting Data from Spill_Sheet
--Description: This section retrieves all columns from the Spill_Sheet table in the Spill_Report database.

SELECT *
FROM Spill_Report..Spill_Sheet;

---------------------------------------------------------------------------------------------------------------------------------------------------
--Handling Missing values
--Description: This segment addresses missing values in specific fields, ensuring data consistency and reliability.
	--WHERE:
			--EstimatedQuantity: Replaces NULL values with 0.
			--EstimatedSpillArea: Replaces NULL values with 0.
			--QuantityRecovered: Replaces 'nill' with 0.
			--InitialContainmentMeasures: Standardizes to 'NA' for various null or non-standard entries.
			--QuantityRecovered: Converts 'N/a', 'Nill', 'Nil' to NULL.

SELECT COUNT(
	CASE WHEN EstimatedQuantity IS NULL THEN 1
	END)
	FROM Spill_Report..Spill_Sheet;            -- We used this statement to find the actual rows with NULL values in the EstimatedQuantity field

UPDATE Spill_Report..Spill_Sheet
SET EstimatedQuantity = 0
WHERE EstimatedQuantity IS NULL;

UPDATE Spill_Report..Spill_Sheet
SET EstimatedSpillArea = 0
WHERE EstimatedSpillArea IS NULL;

UPDATE Spill_Report..Spill_Sheet
SET QuantityRecovered = 0
WHERE QuantityRecovered = 'nill';

UPDATE Spill_Report..Spill_Sheet
SET InitialContainmentMeasures = 'NA'
WHERE (InitialContainmentMeasures IS NULL) OR 
		(InitialContainmentMeasures = 'Nill') OR (InitialContainmentMeasures = 'N/A') OR 
		(InitialContainmentMeasures = 'Nil') OR (InitialContainmentMeasures = 'none');

UPDATE Spill_Report..Spill_Sheet
SET QuantityRecovered = NULL
WHERE (QuantityRecovered ='N/a') OR 
		(QuantityRecovered = 'Nill') OR 
		(QuantityRecovered = 'Nil');
SELECT *
FROM Spill_Report..Spill_Sheet;

----------------------------------------------------------------------------------------------------------------------------------------------------
--Standardizing Dates
--Description: This part converts the IncidentDate column to the date format.

UPDATE Spill_Report..Spill_Sheet
SET IncidentDate = CONVERT(DATE, IncidentDate);

SELECT *
FROM Spill_Report..Spill_Sheet;

----------------------------------------------------------------------------------------------------------------------------------------------------
--Removing Duplicate Rows
--Description: Duplicates are removed from the Spill_Sheet table based on the ID column.

DELETE FROM Spill_Report..Spill_Sheet
WHERE ID IN (
    SELECT ID
    FROM Spill_Report..Spill_Sheet
    GROUP BY ID
    HAVING COUNT(*) > 1
	);

----------------------------------------------------------------------------------------------------------------------------------------------------
--Updating Abbreviated Elements
--Description: Mappings are created in the Spill_Words table for abbreviations in the TypeofFacility, Cause, and SpillArea. 
			   --The script then updates these fields in the Spill_Sheet table based on the mappings.
	--Where:
			--1. TypeOfFacility: Maps and standardizes facility types.
			--2. Cause: Maps and standardizes spill causes.
			--3. Contaminant: Maps and standardizes contaminants.
			--4. InitialContainmentMeasures: Maps and standardizes initial containment measures.
			--5. SpillAreaHabitat: Maps and standardizes spill area habitats.

-- let's create a word mapping
CREATE TABLE Spill_Words (
	Short VARCHAR(255), Full_word VARCHAR(255)
	);
INSERT INTO Spill_Words(Short,Full_word)
	VALUES
			('fl', 'Flow Line'), ('pl', 'Pipeline'), ('wh', 'Well Head'), ('fs', 'Flow Station'), ('gl', 'Gas Line'),
			('fp', 'Floating Platform'), ('mf', 'Manifold'), ('sab', 'Sabotage/Theft'), ('eqf', 'Equipment Failure'), 
			('cor', 'Corrosion'), ('ome', 'Operational/Maintenance Error'), ('co', 'Condensate'), ('cr', 'Crude'),
			('no', 'No Spill'), ('re', 'Refined Product'), ('nd', 'Natural Depression'), ('pt','Pit'),
			('tr', 'Trench'), ('bm', 'Boom'),('bw', 'Bund Wall'), ('sb', 'Sorbents'), ('dk', 'Dunk'),
			('la', 'Land'), ('sw', 'Swamp'), ('ss', 'Seasonal Swamp'), ('iw', 'Inland Water'), ('of', 'Offshore');
SELECT *
FROM Spill_Words;

 --1. TypeOfFacility field:
UPDATE t
SET TypeOfFacility = COALESCE(m.Full_word, t.TypeOfFacility)
FROM Spill_Report..Spill_Sheet t
LEFT JOIN Spill_Words m ON CHARINDEX(m.Short, t.TypeOfFacility) > 0;

UPDATE Spill_Report..Spill_Sheet
SET TypeOfFacility =
	CASE
		WHEN LEFT(TypeOfFacility, 5) = 'other' THEN 'Other'
		ELSE TypeOfFacility
	END;

--2. Cause field:
UPDATE t
SET Cause = COALESCE(m.Full_word, t.Cause)
FROM Spill_Report..Spill_Sheet t
LEFT JOIN Spill_Words m ON CHARINDEX(m.Short, t.Cause) > 0;

--3. Contaminant:
UPDATE t
SET Contaminant = COALESCE(m.Full_word, t.Contaminant)
FROM Spill_Report..Spill_Sheet t
LEFT JOIN Spill_Words m ON CHARINDEX(m.Short, t.Contaminant) > 0;

--4. InitialContainmentMeasures
UPDATE t
SET InitialContainmentMeasures = COALESCE(m.Full_word, t.InitialContainmentMeasures)
FROM Spill_Report..Spill_Sheet t
LEFT JOIN Spill_Words m ON CHARINDEX(m.Short, t.InitialContainmentMeasures) > 0;

UPDATE Spill_Report..Spill_Sheet
SET InitialContainmentMeasures=
	CASE
		WHEN LEFT(InitialContainmentMeasures, 5) = 'other' THEN 'Other'
		ELSE InitialContainmentMeasures
	END;

--5. SpillAreaHabitat
UPDATE t
SET SpillAreaHabitat = COALESCE(m.Full_word, t.SpillAreaHabitat)
FROM Spill_Report..Spill_Sheet t
LEFT JOIN Spill_Words m ON CHARINDEX(m.Short, t.SpillAreaHabitat) > 0;

SELECT * 
FROM Spill_Report..Spill_Sheet;

----------------------------------------------------------------------------------------------------------------------------------------------------
--Filtering Table for Visualization
--Description: A new table (Spill_Table) is created by filtering rows where EstimatedQuantity is greater than 0. 
			  --This table is then further processed to convert QuantityRecovered to FLOAT where applicable.
SELECT * 
INTO Spill_Table
FROM Spill_Report..Spill_Sheet
   WHERE EstimatedQuantity > 0;

UPDATE Spill_Table
SET QuantityRecovered = TRY_CAST(QuantityRecovered AS FLOAT)
WHERE TRY_CAST(QuantityRecovered AS FLOAT) IS NOT NULL;

SELECT *
FROM Spill_Table;