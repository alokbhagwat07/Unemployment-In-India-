-- Creating a table unemployment_rate_statewise
-- Data source: https://dge.gov.in/dge/sites/default/files/2024-01/2160.pdf
-- GOVERNMENT OF INDIA, MINISTRY OF LABOUR AND EMPLOYMENT, RAJYA SABHA UNSTARRED QUESTION NO. 2160 TO BE ANSWERED ON 21ST DECEMBER, 2023

 CREATE TABLE unemployment_rate_statewise  (
    id INT AUTO_INCREMENT PRIMARY KEY,
    state VARCHAR(100),
    ur_2018_19 DECIMAL(4,1),
    ur_2019_20 DECIMAL(4,1),
    ur_2020_21 DECIMAL(4,1),
    ur_2021_22 DECIMAL(4,1),
    ur_2022_23 DECIMAL(4,1)
);


INSERT INTO unemployment_rate_statewise (state, ur_2018_19, ur_2019_20, ur_2020_21, ur_2021_22, ur_2022_23) VALUES
('Andhra Pradesh', 5.3, 4.7, 4.1, 4.1, 4.1),
('Arunachal Pradesh', 6.7, 7.7, 7.7, 7.7, 4.8),
('Assam', 7.7, 7.9, 6.4, 3.9, 1.7),
('Bihar', 9.8, 5.1, 4.6, 5.9, 3.9),
('Chhattisgarh', 5.4, 2.0, 2.5, 2.5, 2.4),
('Delhi', 10.4, 8.6, 6.3, 6.3, 1.9),
('Goa', 8.7, 22.0, 12.2, 12.2, 7.1),
('Gujarat', 3.2, 2.0, 2.2, 2.0, 1.7),
('Haryana', 9.3, 6.3, 9.3, 9.0, 6.1),
('Himachal Pradesh', 8.3, 3.4, 4.9, 4.8, 4.0),
('Jharkhand', 5.0, 3.0, 3.1, 3.1, 1.7),
('Karnataka', 3.6, 4.2, 2.7, 3.2, 2.4),
('Kerala', 9.0, 10.0, 10.1, 9.6, 7.0),
('Madhya Pradesh', 3.5, 3.0, 1.9, 2.1, 1.6),
('Maharashtra', 5.0, 3.2, 3.7, 3.5, 3.1),
('Manipur', 9.4, 9.5, 5.6, 6.9, 4.7),
('Meghalaya', 2.7, 3.5, 1.7, 2.6, 2.0),
('Mizoram', 7.0, 3.7, 3.5, 5.4, 2.2),
('Nagaland', 17.4, 25.7, 19.2, 9.2, 4.3),
('Odisha', 7.0, 6.2, 5.3, 6.0, 3.9),
('Punjab', 7.4, 7.3, 6.2, 6.4, 4.4),
('Rajasthan', 5.7, 4.5, 4.7, 4.7, 4.4),
('Sikkim', 3.1, 2.2, 1.1, 1.6, 1.2),
('Tamil Nadu', 6.6, 5.3, 5.2, 4.8, 4.2),
('Telangana', 8.3, 7.0, 4.9, 3.2, 4.4),
('Tripura', 10.0, 7.3, 10.2, 11.4, 11.3),
('Uttarakhand', 8.9, 7.1, 6.9, 7.8, 4.5),
('Uttar Pradesh', 5.7, 4.2, 4.2, 4.2, 2.9),
('West Bengal', 8.3, 7.0, 5.3, 3.8, 2.2),
('A & N Island', 13.5, 12.6, 9.1, 7.1, 9.7),
('Chandigarh', 7.3, 5.9, 7.4, 7.4, 3.7),
('D & N Haveli', 1.5, 5.3, 4.0, 4.2, 2.5),
('Daman & Diu', 3.0, 2.9, 7.1, 3.9, 2.0),
('Jammu & Kashmir', 5.1, 6.3, 5.9, 5.2, 4.4),
('Ladakh', 9.0, 10.1, 3.4, 1.9, 1.1),
('Lakshadweep', 31.6, 13.7, 13.4, 17.2, 7.1),
('Puducherry', 8.3, 7.6, 6.7, 5.8, 5.6);

-- Queries for Demand side analysis

-- importing csv

SHOW VARIABLES LIKE "secure_file_priv";
SET GLOBAL local_infile = 1;


LOAD DATA LOCAL INFILE 'C:\\Users\\siddharth bhagwat\\Desktop\\postings.csv'
INTO TABLE postings
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
;
LOAD DATA LOCAL INFILE 'C:\\Users\\siddharth bhagwat\\Desktop\\company_industries.csv'
INTO TABLE job_industries
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
;

show tables;
SELECT * FROM job_skills LIMIT 20;

-- DATA CLEANING
SELECT * FROM skills ;
UPDATE skills
SET skill_name = 'Art & Creative' 
WHERE  skill_abr = 'ART';

SELECT count(*) FROM job_industries ;

-- Fetched top demanding roles 
SELECT title, count(*) AS Roles FROM postings
GROUP BY title
HAVING count(*) > 1
ORDER BY count(*) DESC;

ALTER TABLE job_industry
ADD COLUMN domain VARCHAR(50);

-- UPDATE job_industry
SET domain = CASE
    WHEN industry_code IN ('ANLS','PRDM','RSC','RSCH') THEN 'Technology & Data'
    WHEN industry_code IN ('GENB','PRJM','CNSL') THEN 'Business & Management'
    WHEN industry_code IN ('ADVR','DSGN','ART') THEN 'Marketing & Communication'
    WHEN industry_code IN ('SUPL','DIST','PRCH') THEN 'Supply & Operations'
    WHEN industry_code IN ('EDU','TRNG') THEN 'Education & Training'
    WHEN industry_code IN ('HCPR') THEN 'Healthcare'
    WHEN industry_code IN ('CUST') THEN 'Customer & Service Sector'
    ELSE 'Other'
END;

ALTER TABLE skills_to_fields
ADD COLUMN sector VARCHAR(100);

-- UPDATE skills_to_fields
-- SET sector = 
SELECT  industry_name , CASE
    WHEN industry_name REGEXP 'Software|IT|Internet|SaaS|AI|ML|Data|Computer' THEN 'Technology & IT'
    WHEN industry_name REGEXP 'Finance|Bank|Insurance|Capital' THEN 'Finance & Banking'
    WHEN industry_name REGEXP 'Healthcare|Hospital|Medical|Biotech|Pharma' THEN 'Healthcare & Life Sciences'
    WHEN industry_name REGEXP 'Education|Training|Learning|University|Research' THEN 'Education & Research'
    WHEN industry_name REGEXP 'Manufacturing|Automobile|Engineering|Electronics' THEN 'Engineering & Manufacturing'
    WHEN industry_name REGEXP 'Retail|Fashion|Apparel|E-commerce' THEN 'Retail & Consumer Goods'
    WHEN industry_name REGEXP 'Construction|Real Estate|Architecture' THEN 'Infrastructure & Real Estate'
    WHEN industry_name REGEXP 'Energy|Oil|Gas|Mining|Utilities' THEN 'Energy & Environment'
    WHEN industry_name REGEXP 'Government|Political|NGO|Social Services' THEN 'Public Administration & Social Sector'
    WHEN industry_name REGEXP 'Telecom|Wireless|Telecommunications' THEN 'Telecommunications'
    WHEN industry_name REGEXP 'Media|Entertainment|Film|Sports' THEN 'Media & Entertainment'
    WHEN industry_name REGEXP 'Agriculture|Dairy|Food' THEN 'Agriculture & Food Industry'
    WHEN industry_name REGEXP 'Travel|Tourism|Transportation|Logistics' THEN 'Travel, Transport & Logistics'
    WHEN industry_name REGEXP 'Defense|Aerospace|Military' THEN 'Defense & Aerospace'
    WHEN industry_name REGEXP 'Legal|Law' THEN 'Legal Services'
    WHEN industry_name REGEXP 'HR|Staffing|Recruiting' THEN 'Human Resources'
    ELSE 'Other / Miscellaneous'
END as bh 
FROM industries
;

-- clustering industries 
-- UPDATE job_postings
-- SET sector_field = 

select *, 
CASE
    WHEN industry_name LIKE '%Software%' OR industry_name LIKE '%IT%' OR industry_name LIKE '%AI%' 
         OR industry_name LIKE '%Data%' OR industry_name LIKE '%Cyber%' OR industry_name LIKE '%Cloud%' 
         OR industry_name = 'Computer Networking Products' 
         OR industry_name = 'Technology, Information and Internet'
         THEN 'Computer Science & IT'

    WHEN industry_name LIKE '%Bank%' OR industry_name LIKE '%Finance%' OR industry_name LIKE '%Insurance%' 
         OR industry_name LIKE '%FinTech%' OR industry_name LIKE '%Investment%' OR industry_name LIKE 'Accounting'
         OR industry_name LIKE 'Real Estate' OR industry_name LIKE 'Financial Services' OR industry_name LIKE 'Business Consulting and Services'
         THEN 'Commerce / Finance & Management'

    WHEN industry_name LIKE '%Hospital%' OR industry_name LIKE '%Healthcare%' OR industry_name LIKE '%Medical%' 
         OR industry_name LIKE '%Pharma%' OR industry_name LIKE '%Biotech%' OR industry_name LIKE 'Veterinary Services'
         THEN 'Medical & Life Sciences'

    WHEN industry_name LIKE '%Education%' OR industry_name LIKE '%Research%' OR industry_name LIKE '%Training%' 
         THEN 'Education / Research'

    WHEN industry_name LIKE '%Retail%' OR industry_name LIKE '%Marketing%' OR industry_name LIKE '%Media%' 
         OR industry_name LIKE '%Advertising%' 
         THEN 'Management / Marketing'

    WHEN industry_name LIKE '%Automobile%' OR industry_name LIKE '%Manufacturing%' OR industry_name LIKE '%Energy%' 
         OR industry_name LIKE '%Construction%' OR industry_name LIKE '%Machinery%' OR industry_name = 'Civil Engineering'
         OR industry_name LIKE '%Materials' OR industry_name = 'Telecommunications' OR industry_name = 'Shipbuilding' 
         THEN 'Core Engineering'

    WHEN industry_name LIKE '%Agriculture%' OR industry_name LIKE '%Farming%' OR industry_name LIKE '%Food%' 
         OR industry_name LIKE '%Forestry%' 
         THEN 'Agriculture'

    WHEN industry_name LIKE '%Law%' OR industry_name LIKE '%Legal%' 
         THEN 'Law'

    WHEN industry_name LIKE '%Government%' OR industry_name LIKE '%NGO%' OR industry_name LIKE '%Public%'
         THEN 'Public Administration & Social Sciences'

    WHEN industry_name LIKE '%Sports%' OR industry_name LIKE '%Art%' OR industry_name LIKE '%Entertainment%'
         OR industry_name LIKE '%Cinema%' OR industry_name LIKE '%Design%'
         THEN 'Arts & Humanities'

    WHEN industry_name LIKE '%Tourism%' OR industry_name LIKE '%Hotel%' 
    OR industry_name LIKE '%Aviation%' OR industry_name LIKE 'Travel Arrangements'
         THEN 'Hospitality / Tourism'

    WHEN industry_name LIKE '%Logistics%' OR industry_name LIKE '%Supply%' OR industry_name LIKE '%Procurement%' 
         THEN 'Logistics / Operations'

    ELSE 'Other'
END as Category
FROM industries
;

 -- Jobs present in industry secotor
 SELECT 
    ic.category AS industry_category,
    COUNT(DISTINCT ji.job_id) AS job_count
FROM job_industries ji
JOIN industries_categories ic 
    ON ji.industry_id = ic.industry_id
GROUP BY ic.category
ORDER BY job_count DESC;

-- skills requirement per category
SELECT 
    ic.category,
    s.skill_name,
    COUNT(*) AS demand_count
FROM job_skills js
JOIN skills s
    ON js.skill_abr = s.skill_abr
JOIN job_industries ji
    ON js.job_id = ji.job_id
JOIN industries_categories ic
    ON ji.industry_id = ic.industry_id
GROUP BY 
    ic.category, 
    s.skill_name
ORDER BY 
    ic.category,
    demand_count DESC
LIMIT 100;

-- Industry wise top skills
WITH skill_counts AS (
    SELECT 
        ic.category,
        s.skill_name,
        COUNT(*) AS demand_count,
        ROW_NUMBER() OVER (
            PARTITION BY ic.category 
            ORDER BY COUNT(*) DESC
        ) AS rn
    FROM job_skills js
    JOIN skills s
        ON js.skill_abr = s.skill_abr
    JOIN job_industries ji
        ON js.job_id = ji.job_id
    JOIN industries_categories ic
        ON ji.industry_id = ic.industry_id
    GROUP BY 
        ic.category, 
        s.skill_name
)
SELECT 
    category,
    skill_name,
    demand_count
FROM skill_counts
WHERE rn <= 10
ORDER BY category, demand_count DESC;


-- Skill mismatch and  top demanded skills
SELECT * FROM Job_skills limit 20;
SELECT * FROM Skills;

-- Top demanded skill
SELECT s.skill_name AS skill,
       COUNT(js.job_id) AS Demand_count
FROM job_skills js
JOIN skills s ON js.skill_abr = s.skill_abr
GROUP BY s.skill_name
ORDER BY Demand_count DESC

;
select skill_name from skills ;

-- category wise demand count for top 100 demanding skill and category
SELECT category, SUM(demand_count) total_demand_category FROM (
SELECT 
    ic.category,
    s.skill_name,
    COUNT(*) AS demand_count
FROM job_skills js
JOIN skills s
    ON js.skill_abr = s.skill_abr
JOIN job_industries ji
    ON js.job_id = ji.job_id
JOIN industries_categories ic
    ON ji.industry_id = ic.industry_id
GROUP BY 
    ic.category, 
    s.skill_name
ORDER BY 
    demand_count DESC
LIMIT 100)t 
GROUP BY category
ORDER BY total_demand_category DESC
 ;
 
 select 11327741 / 37032245 * 100;
 -- EDA of supply

 USE unemployment_ind;
 show tables;
select * from enrolment_at_under_graduate_level_in_major_disciplines;

-- Updating Core where it is null
 UPDATE enrolment_at_under_graduate_level_in_major_disciplines
 SET Core = CASE WHEN Core = '' THEN Discipline END
 WHERE Core = '' ;

-- Cleaning
delete from enrolment_at_under_graduate_level_in_major_disciplines
where Discipline = 'Engineering & Technology Total';

-- program wise passout top 100
SELECT * FROM programme_wise_pass_out ORDER BY Total DESC LIMIT 100;

-- creating table for mapping
CREATE TABLE degree_sector_mapping (
    programme VARCHAR(200) PRIMARY KEY,
    sector_code VARCHAR(10),
    sector_name VARCHAR(100)
);
INSERT INTO degree_sector_mapping (programme, sector_code, sector_name) VALUES
('B.A.-Bachelor of Arts', 'SOC', 'Social Science & Humanities'),
('B.Sc.-Bachelor of Science', 'SCI', 'Science & Research'),
('B.Com.-Bachelor of Commerce', 'COM', 'Commerce, Finance & Business'),
('M.A.-Master of Arts', 'SOC', 'Social Science & Humanities'),
('B.Ed.-Bachelor of Education', 'EDU', 'Education & Training'),
('Diploma-Diploma', 'VOC', 'Vocational & Skilled Trades'),
('B.Tech.-Bachelor of Technology', 'ENG', 'Engineering & Technology'),
('B.A.(Hons)-Bachelor of Arts (Honors)', 'SOC', 'Social Science & Humanities'),
('M.Sc.-Master of Science', 'SCI', 'Science & Research'),
('B.E.-Bachelor of Engineering', 'ENG', 'Engineering & Technology'),
('M.B.A.- Master of Business Administration', 'COM', 'Commerce, Finance & Business'),
('M.Com.-Master of Commerce', 'COM', 'Commerce, Finance & Business'),
('B.B.A.-Bachelor of Business Administration', 'COM', 'Commerce, Finance & Business'),
('PG Diploma-Post Graduate Diploma', 'VOC', 'Vocational & Skilled Trades'),
('B.C.A.-Bachelor of Computer Applications', 'ENG', 'Engineering & Technology'),
('B.Sc.(Hons)-Bachelor of Science (Honors)', 'SCI', 'Science & Research'),
('D.Ed.-Diploma in Education', 'EDU', 'Education & Training'),
('L.L.B.-Bachelor of Law or Laws', 'LAW', 'Legal & Compliance'),
('G.N.M.-General Nursing & Midwifery', 'MED', 'Medical & Health Sciences'),
('B.Pharm.-Bachelor of Pharmacy', 'MED', 'Medical & Health Sciences'),
('D.Pharma-Diploma in Pharmacy', 'MED', 'Medical & Health Sciences'),
('B.Sc.(Nursing)-Bachelor of Science in Nursing', 'MED', 'Medical & Health Sciences'),
('M.B.B.S.-Bachelor of Medicine and Bachelor of Surgery', 'MED', 'Medical & Health Sciences'),
('M.Tech. -Master of Technology', 'ENG', 'Engineering & Technology'),
('M.C.A. -Master of Computer Applications', 'ENG', 'Engineering & Technology'),
('Certificate-Certificate', 'VOC', 'Vocational & Skilled Trades'),
('B.Agri.-Bachelor of Agriculture', 'AGR', 'Agriculture & Environment'),
('Ph.D.-Doctor of Philosophy', 'MIX', 'Subject Dependent'),
('A.N.M.-Auxiliary Nurse & Midwife', 'MED', 'Medical & Health Sciences'),
('M.Ed. -Master of Education', 'EDU', 'Education & Training'),
('M.S.W.-Master of Social Work', 'SOC', 'Social & Public Services'),
('D.El.Ed.-Diploma in Elementary Education', 'EDU', 'Education & Training'),
('B.A. L.L.B.-Bachelor of Arts, Bachelor of Law or Laws', 'LAW', 'Legal & Compliance'),
('B.D.S.-Bachelor of Dental Surgery', 'MED', 'Medical & Health Sciences');


SELECT p.Programme, Male, Female, Total, sector_name FROM degree_sector_mapping d
join programme_wise_pass_out p ON p.Programme = d.Programme;

select * from programme_wise_pass_out m
left join tn t ON m.Programme = t.Programme 
where sector_name is not null ;

INSERT INTO degree_sector_mapping (Programme, sector_name) VALUES
('B.Sc.(FDP)-Bachelor of Science in Footwear Design and Production', 'Science & Technology'),
('Bachelor in Astrology', 'Traditional Studies'),
('D.Mus.-Doctor of Music', 'Performing Arts'),
('Public Services', 'Management / Public Admin'),
('Robotics and Automation', 'Engineering'),
('Fashion Art', 'Design & Arts'),
('M.F.T. -Master of Foreign Trade', 'Management'),
('M.P.O-Master in Prosthetics and Orthotics', 'Medical / Paramedical'),
('B.X.R.T- Bachelor in X-Ray Radiographer Technician', 'Medical / Paramedical'),
('M.V.A.-Master of Visual Arts', 'Design & Arts'),
('B.Dance-Bachelor of Dance', 'Performing Arts'),
('B.Com. B.Ed.-Bachelor of Commerce, Bachelor of Education', 'Commerce + Education'),
('B.P.O-Bachelor of Prosthetics and Orthotics', 'Medical / Paramedical'),
('B.Sc. L.L.B.-Bachelor of Science, Bachelor of Law or Laws', 'Science + Law'),
('D.Sc.-Doctor of Science', 'Science'),
('Textile Design', 'Design & Arts'),
('Automotive Mechatronics Captive(Anand Group)', 'Engineering'),
('Entrepreneurship', 'Management'),
('PGDBA', 'Management'),
('D.O.T.A- Diploma in Operation Theater Assistant', 'Medical / Paramedical'),
('D.Litt.-Doctor of Literature', 'Arts & Humanities'),
('B.M.L.T- Bachelor in Medical Lab Technology', 'Medical / Paramedical'),
('B.Nat.(Yogic Sciences)-Bachelor of Naturopathy and Yogic Sciences', 'Medical - Ayurveda'),
('B.C.E.-Bachelor of Civil Engineering', 'Engineering'),
('D.Phil.-Doctor of Philosophy', 'Research / Academia'),
('Medical Laboratory Technician', 'Medical / Paramedical'),
('Interior Design and Decoration', 'Design & Arts'),
('B.Plan.-Bachelor of Planning', 'Architecture & Planning'),
('M.P.H. -Master of Public Health', 'Medical / Public Health'),
('Integrated M.C.A.-Integrated Master of Computer Applications', 'IT / Computer Science'),
('B.Stat.-Bachelor of Statistics', 'Science & Technology'),
('M.Mgt.-Master of Management', 'Management'),
('B.S.W.-Bachelor of Social Work', 'Social Sciences'),
('B.Tech M.Tech-Bachelor of Technology, Master of Technology', 'Engineering');

-- Query to fetch total jobs per industry
WITH jobs_per_Industry AS (
SELECT Category, Cat_id, count(job_id) Total_jobs_per_Industry FROM industries_categories ic 
JOIN job_industries ji ON ic.industry_id = ji.industry_id group by Category, Cat_id)
SELECT * FROM jobs_per_Industry j 
;

-- to count students per csector

SELECT p.sector_name, d.id, SUM(p.Total) Passouts_by_sector FROM passout_by_sectors p 
JOIN degree_sector_mapping d ON p.sector_name = d.sector_name
GROUP BY p.sector_name, d.id
;

-- combining both the fields
WITH jobs_per_Industry AS (
	SELECT Category, Cat_id, count(job_id) Total_jobs_per_Industry FROM industries_categories ic 
	JOIN job_industries ji ON ic.industry_id = ji.industry_id group by Category, Cat_id),
passouts_by_sector AS (select p.sector_name, d.id, SUM(p.Total) Total_Passouts from passout_by_sectors p 
	JOIN degree_sector_mapping d ON p.sector_name = d.sector_name
	GROUP BY p.sector_name, d.id)
SELECT Category AS industry_Category, Total_jobs_per_Industry, sector_name AS Educational_Sector,Total_Passouts FROM jobs_per_Industry j 
	JOIN passouts_by_sector ps
	ON j.Cat_id = ps.id
;

select *,Total_jobs_per_Industry / (select sum(Total_jobs_per_Industry)  from final_map) * 100 AS Share_in_industry,
Total_Passouts /(select sum(Total_Passouts)  from final_map) * 100 AS Share_in_Education
from final_map