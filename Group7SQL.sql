Select *
  , case when Cost_of_attendance between 0 and 20000 then 'Affordable'
         when Cost_of_attendance between 20000 and 35000 then 'Average'
         when Cost_of_attendance between 50000 and 10000 then 'Expensive'
    end as Level_of_Expense
from top_schools;

Select * FROM cwurData
Inner join top_schools 
on top_schools.Institution = cwurData.institution
Where country in ("Austria", "Belgium", "Bulgaria", "Croatia", "Cyprus",
"Czech Republic", "Denmark", "Estonia", "Finland", "France", "Germany",
"Greece", "Hungary", "Iceland", "Ireland", "Italy", "Lithuania",
"Netherlands", "Norway", "Poland", "Portugal", "Romania", "Serbia",
"Slovenia", "Spain", "Sweden")
Order by world_rank desc;

select c.quality_of_education,c.institution, c.country, c1.Happiness
from cwurData as c
inner join country_data as c1
group by country
having min(quality_of_education)
order by quality_of_education;

select s1.SchoolName, s1.Region,
max(s1.StartingMedianSalary) as MaxMedianSalaryBySchoolType,
s2.SchoolType from salaries_by_region as s1
inner join salaries_by_college_type as s2
on s1.SchoolName = s2.SchoolName
group by SchoolType;

select s1.SchoolName, s1.SchoolType,
s1.MidCareer90thPercentileSalary, t1.student_staff_ratio,
T1.international_students
from salaries_by_college_type as s1
inner join timesData as t1
on s1.SchoolName = t1.university_name
where s1.MidCareer90thPercentileSalary != 'N/A' 
and s1.SchoolName != 'University of Wisconsin'
group by s1.SchoolName, s1.SchoolType
order by s1.MidCareer90thPercentileSalary desc;

SELECT *, (start_salary-Cost_of_attendance)/Cost_of_attendance*100 AS ROI
FROM top_schools,
	(SELECT AVG((start_salary-Cost_of_attendance)/Cost_of_attendance*100) AS AvgROI
     FROM  top_schools) AS Average
WHERE (start_salary-Cost_of_attendance)/Cost_of_attendance*100 >= Average.AvgROI
ORDER BY ROI DESC;

SELECT institution, avg(score), avg(quality_of_education) 
FROM `582_clean_schema`.cwurData
GROUP BY institution
ORDER BY avg(score) desc
limit 10;

SELECT country, direct_expenditure_type, `2011` 
FROM education_expenditure_supplementary_data
WHERE `2011` < 2011 AND `2011` IS NOT NULL #this was added because the first row was column titles
GROUP BY country, direct_expenditure_type
ORDER BY `2011` desc ;

SELECT s1.country, avg(c1.score) 
FROM school_and_country_table as s1
JOIN cwurData as c1
ON s1.school_name = c1.institution
GROUP BY country
ORDER BY avg(c1.score) desc
LIMIT 10;

SELECT t1.country, avg(c1.score), t1.`2011` 
FROM education_expenditure_supplementary_data as t1
JOIN school_and_country_table as s1
ON t1.country = s1.country
JOIN cwurData as c1
ON s1.school_name = c1.institution
WHERE t1.`2011` < 2011 AND t1.direct_expenditure_type = 'Total'
GROUP BY country
ORDER BY avg(c1.score) desc
LIMIT 10;

SELECT institution, year, world_rank, AVG(quality_of_education), AVG(quality_of_faculty), SUM(publications), SUM(patents)
FROM cwurData
GROUP BY institution, year
ORDER BY SUM(publications) DESC;








