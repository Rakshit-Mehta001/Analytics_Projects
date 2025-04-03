WITH top_paying_jobs AS (
SELECT
    job_id,
    job_title,
    salary_year_avg,
    name AS company_name
FROM
    job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE
    job_title_short = 'Data Analyst' AND
    job_location = 'Anywhere' AND
    salary_year_avg IS NOT NULL
ORDER BY 
    salary_year_avg DESC
LIMIT 12
)
SELECT
    top_paying_jobs.job_id,
    top_paying_jobs.job_title,
    top_paying_jobs.company_name,
    top_paying_jobs.salary_year_avg, 
    STRING_AGG(skills_dim.skills, ', ') AS skill_set
FROM
    top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id 
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
GROUP BY   
    top_paying_jobs.job_id, top_paying_jobs.job_title, top_paying_jobs.company_name,
    top_paying_jobs.salary_year_avg
ORDER BY
    top_paying_jobs.salary_year_avg DESC


/* 
Insights from the Skill Analysis:
SQL (9 mentions) is the most in-demand skill for data analyst roles.
Python (8 mentions) follows closely, indicating strong demand for programming expertise.
Tableau (6 mentions) is the top visualization tool required.
Excel (4 mentions) and R (4 mentions) are still relevant but less emphasized.
Azure, Pandas, and Snowflake (3 mentions each) indicate a growing demand for cloud and data processing tools.
Go (3 mentions) is surprisingly present, suggesting some roles require software engineering knowledge.
Bitbucket (2 mentions) hints at the use of version control and collaboration tools. 

[
  {
    "job_title": "Associate Director- Data Insights",
    "company_name": "AT&T",
    "salary_year_avg": "255829.5",
    "skill_set": "sql, python, r, azure, databricks, aws, pandas, pyspark, jupyter, excel, tableau, power bi, powerpoint"
  },
  {
    "job_title": "Data Analyst, Marketing",
    "company_name": "Pinterest Job Advertisements",
    "salary_year_avg": "232423.0",
    "skill_set": "sql, python, r, hadoop, tableau"
  },
  {
    "job_title": "Data Analyst (Hybrid/Remote)",
    "company_name": "Uclahealthcareers",
    "salary_year_avg": "217000.0",
    "skill_set": "sql, crystal, oracle, tableau, flow"
  },
  {
    "job_title": "Principal Data Analyst (Remote)",
    "company_name": "SmartAsset",
    "salary_year_avg": "205000.0",
    "skill_set": "sql, python, go, snowflake, pandas, numpy, excel, tableau, gitlab"
  },
  {
    "job_title": "Director, Data Analyst - HYBRID",
    "company_name": "Inclusively",
    "salary_year_avg": "189309.0",
    "skill_set": "sql, python, azure, aws, oracle, snowflake, tableau, power bi, sap, jenkins, bitbucket, atlassian, jira, confluence"
  },
  {
    "job_title": "Principal Data Analyst, AV Performance Analysis",
    "company_name": "Motional",
    "salary_year_avg": "189000.0",
    "skill_set": "sql, python, r, git, bitbucket, atlassian, jira, confluence"
  },
  {
    "job_title": "Principal Data Analyst",
    "company_name": "SmartAsset",
    "salary_year_avg": "186000.0",
    "skill_set": "sql, python, go, snowflake, pandas, numpy, excel, tableau, gitlab"
  },
  {
    "job_title": "ERM Data Analyst",
    "company_name": "Get It Recruit - Information Technology",
    "salary_year_avg": "184000.0",
    "skill_set": "sql, python, r"
  },
  {
    "job_title": "DTCC Data Analyst",
    "company_name": "Robert Half",
    "salary_year_avg": "170000.0",
    "skill_set": "java, go, excel"
  },
  {
    "job_title": "REMOTE Director of Data Analytics",
    "company_name": "A-Line Staffing Solutions",
    "salary_year_avg": "170000.0",
    "skill_set": "sql, python, azure"
  }
]
*/



