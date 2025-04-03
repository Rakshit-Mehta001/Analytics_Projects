WITH job_role AS 
(
    SELECT
        job_id,
        salary_year_avg
    FROM
        job_postings_fact
    WHERE
        job_title_short = 'Data Analyst'
        AND salary_year_avg IS NOT NULL
)
SELECT
    skills_dim.skills,
    skills_dim.type,
    ROUND(AVG(job_role.salary_year_avg), 2) AS Top_Skills_avg
FROM
    skills_dim
LEFT JOIN skills_job_dim
    ON skills_job_dim.skill_id = skills_dim.skill_id
LEFT JOIN job_role
    ON job_role.job_id = skills_job_dim.job_id
WHERE 
    job_role.salary_year_avg IS NOT NULL
GROUP BY 
    skills_dim.skills, skills_dim.type
ORDER BY 
    Top_Skills_avg DESC
LIMIT 25;

/*
1. Niche & Specialized Tools Dominate: High-paying skills like SVN ($400K), Solidity ($179K), and Couchbase ($160K)
suggest that expertise in less common or specialized tools (version control, blockchain, NoSQL databases) commands
premium salaries.  
2. AI/ML Libraries in Demand: MXNet, PyTorch, TensorFlow, and Hugging Face (avg. $120K–$149K) highlight the premium
on machine learning and deep learning skills, even for data analysts.  
3. DevOps & Cloud Skills Pay Well: Terraform, VMware, Kafka, and Ansible (avg. $124K–$147K) reflect the growing overlap 
between data analysis and infrastructure/automation roles.
*/