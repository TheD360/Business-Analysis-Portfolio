-- QUERYING THE DIVESHOP DATABASE.THE DIVESHOP IS A DIVE PARK THAT TOURIST AND LOCALS COME TO VISIT AND HAVE A GOOD TIME AT.
-- THE ER Diagram of the database can be found IN THE SAME FILE AS THIS SCRIPT
-- ABOVE EACH QUERY IS THE QUESTION THE QUERY IS SET/INTENDED TO ANSWER (ADDRESS OR SATISFY)
-- THIS SCRIPT COVERS BASIC QUERIES NEEDED FOR THE INITIAL STAGE OF DATA ANALYSIS (DATA RETRIEVAL OF VARIOUS KINDS)


-- RETURN A LIST OF THE NAME, CITY AND STATE OF EACH PARTICIPANT (RETRIEVING DATA FROM A DATABASE)
SELECT PART_FNAME + ' ' + PART_LNAME AS PART_NAME, PART_CITY, PART_STATE 
FROM PARTICIPANT
ORDER BY PART_ID

-- RETRUN A LIST OF ALL SITES THAT ARE LOCATED IN THE 'Cozumel Reef'(RETRIEVING DATA FROM A DATABASE WITH 1 SPECIFIC CONDITION)
SELECT SITE_NAME 
FROM SITE
WHERE SITE_AREA = 'Cozumel Reef'
ORDER BY SITE_ID

-- LIST THE NAME AND BASECOST OF EACH SITE WITH A BASE COST OF LESS THAN $30 AND A PRINCIPAL INTREST OF 'Marine Life'
-- (RETRIEVING DATA FROM A DATABASE THAT MATCHES MORE THAT ONE CRITERIA/CONDITION).
SELECT SITE_NAME, SITE_BASECOST AS BASE_COST FROM SITE 
WHERE SITE_BASECOST < 30.00 and SITE_INTEREST = 'Marine Life'

-- LIST THE MINIMUM, MAXIMUM AND AVERAGE DEPTH OF SITES IN 'Werk Alley'
-- (RETURNING DATA FROM A DATABASE THAT MEET CERTAIN AGGREGATE FUNCTOIN RESULTS).
SELECT  MIN(SITE_depth) AS min_depth, MAX(SITE_depth) AS max_depth, AVG(SITE_depth) AS avg_depth
FROM SITE
WHERE SITE_AREA = 'Wreck Alley';

-- LIST THE TOTAL NUMBER OF SITES AT EACH SKILL LEVEL
-- (USE OF AGGREGATE FUNCTION ALONGSIDE 'GROUP BY' AND 'ORDER BY' CLAUSE)
SELECT SITE_SKILLLEVEL, COUNT(SITE_SKILLLEVEL) 'Count' 
FROM SITE  
GROUP BY  SITE_SKILLLEVEL
ORDER BY SITE_SKILLLEVEL

-- LIST THE NAME AND DEPTH OF THE SITE WITH GREATEST DEPTH
-- (USE OF SUBQUERY)
SELECT SITE_NAME, SITE_DEPTH
FROM SITE
WHERE SITE_DEPTH = (SELECT MAX(SITE_DEPTH) FROM SITE)

-- LIST THE NAMES OF ALL SITES NOT VISITED BY ANY TOURS THROUGH OUT JULY 2012. USE A 'NOT EXISTS' CONSTRUCT
SELECT SITE_NAME, SITE_ID FROM SITE S
WHERE not exists ( SELECT * FROM TOUR T WHERE S.SITE_ID = T.SITE_ID and T.TOUR_DATE LIKE '2012-07%' )

-- LIST THE NAME OF EACH SITE WITH AN 'Experienced' SKILL LEVEL BUT WITH A 'Mild' current.
SELECT SITE_NAME 
FROM SITE
WHERE SITE_SKILLLEVEL = 'Experienced' and SITE_CURRENT = 'Mild';

-- LIST THE NAMES OF THE SITES THAT HAVE AN ABOVE-AVERAGE BASE COST
SELECT SITE_NAME
FROM SITE
WHERE SITE_BASECOST > (SELECT AVG(SITE_BASECOST) FROM SITE);

-- LIST THE NAME OF ALL SITES TO WHICH NO TOURS WERE SCHEDULED IN JULY 2012. USE A SET DIFFERENCE OPERATIONS.
SELECT SITE_NAME 
FROM SITE S 
WHERE S.SITE_ID not in(
	SELECT T.SITE_ID 
	FROM TOUR T 
	WHERE T.TOUR_DATE between '2012-07-01' and '2012-07-31'
	);