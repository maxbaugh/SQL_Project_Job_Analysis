/*
 Question: What skills are required for the top-paying data analyst jobs?
 - Use the top 10 highest-paying Data Analyst jobs from first query
 - Add the specific skills required for these roles
 - Why? It provides a detailed look at which high-paying jobs demand certain skills, 
 helping job seekers understand which skills to develop that align with top salaries
 */
WITH top_paying_jobs AS (
    SELECT job_id,
        job_title,
        salary_year_avg,
        name AS company_name
    FROM job_postings_fact
        LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
    WHERE job_title_short = 'Data Analyst'
        AND job_location = 'Anywhere'
        AND salary_year_avg IS NOT NULL
    ORDER BY salary_year_avg DESC
    LIMIT 10
)
SELECT top_paying_jobs.*,
    skills
FROM top_paying_jobs
    INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY salary_year_avg DESC
    /*
     Analyzing the skills required for these top 10 data analyst roles reveals some interesting patterns:
     
     SQL: SQL is consistently the most sought-after skill across all roles, appearing in every job posting. This underscores the importance of database querying and manipulation for data analysis.
     
     Python: Python is also highly valued, being present in the skill requirements for most roles. Its versatility in data analysis, machine learning, and scripting likely contributes to its popularity.
     
     Tableau: Tableau is a prominent visualization tool, appearing in several job postings. This suggests a significant emphasis on data visualization skills for communicating insights effectively.
     
     Excel: Despite the prevalence of more specialized tools and languages, Excel remains relevant, being listed in multiple postings. Its familiarity and widespread use in data analysis tasks likely contribute to its continued importance.
     
     Other Tools and Technologies: Various other tools and technologies appear in the skill requirements, including R, Azure, AWS, Power BI, Databricks, PySpark, Jupyter, Hadoop, Crystal, Oracle, Flow, Git, Bitbucket, Atlassian suite (Jira, Confluence), SAP, and Snowflake. This indicates the diverse technology stacks and ecosystems in which data analysts operate, with specific requirements varying based on the organization's infrastructure and preferences.
     
     Specialized Skills: Some roles require more specialized skills tailored to specific domains or tasks, such as AV Performance Analysis or ERM (Enterprise Risk Management). These skills may include Git, Bitbucket, Atlassian suite, and others, reflecting the unique needs of those roles.
     
     Overall, proficiency in SQL and Python, coupled with experience in data visualization tools like Tableau and general-purpose tools like Excel, appears to be essential for most data analyst roles. Additionally, familiarity with cloud platforms, big data technologies, version control systems, and domain-specific tools enhances a candidate's competitiveness in the job market.
     
     [
     {
     "job_id": 226942,
     "job_title": "Data Analyst",
     "job_location": "Anywhere",
     "job_schedule_type": "Full-time",
     "salary_year_avg": "650000.0",
     "job_posted_date": "2023-02-20 15:13:33",
     "company_name": "Mantys"
     },
     {
     "job_id": 547382,
     "job_title": "Director of Analytics",
     "job_location": "Anywhere",
     "job_schedule_type": "Full-time",
     "salary_year_avg": "336500.0",
     "job_posted_date": "2023-08-23 12:04:42",
     "company_name": "Meta"
     },
     {
     "job_id": 552322,
     "job_title": "Associate Director- Data Insights",
     "job_location": "Anywhere",
     "job_schedule_type": "Full-time",
     "salary_year_avg": "255829.5",
     "job_posted_date": "2023-06-18 16:03:12",
     "company_name": "AT&T"
     },
     {
     "job_id": 99305,
     "job_title": "Data Analyst, Marketing",
     "job_location": "Anywhere",
     "job_schedule_type": "Full-time",
     "salary_year_avg": "232423.0",
     "job_posted_date": "2023-12-05 20:00:40",
     "company_name": "Pinterest Job Advertisements"
     },
     {
     "job_id": 1021647,
     "job_title": "Data Analyst (Hybrid/Remote)",
     "job_location": "Anywhere",
     "job_schedule_type": "Full-time",
     "salary_year_avg": "217000.0",
     "job_posted_date": "2023-01-17 00:17:23",
     "company_name": "Uclahealthcareers"
     },
     {
     "job_id": 168310,
     "job_title": "Principal Data Analyst (Remote)",
     "job_location": "Anywhere",
     "job_schedule_type": "Full-time",
     "salary_year_avg": "205000.0",
     "job_posted_date": "2023-08-09 11:00:01",
     "company_name": "SmartAsset"
     },
     {
     "job_id": 731368,
     "job_title": "Director, Data Analyst - HYBRID",
     "job_location": "Anywhere",
     "job_schedule_type": "Full-time",
     "salary_year_avg": "189309.0",
     "job_posted_date": "2023-12-07 15:00:13",
     "company_name": "Inclusively"
     },
     {
     "job_id": 310660,
     "job_title": "Principal Data Analyst, AV Performance Analysis",
     "job_location": "Anywhere",
     "job_schedule_type": "Full-time",
     "salary_year_avg": "189000.0",
     "job_posted_date": "2023-01-05 00:00:25",
     "company_name": "Motional"
     },
     {
     "job_id": 1749593,
     "job_title": "Principal Data Analyst",
     "job_location": "Anywhere",
     "job_schedule_type": "Full-time",
     "salary_year_avg": "186000.0",
     "job_posted_date": "2023-07-11 16:00:05",
     "company_name": "SmartAsset"
     },
     {
     "job_id": 387860,
     "job_title": "ERM Data Analyst",
     "job_location": "Anywhere",
     "job_schedule_type": "Full-time",
     "salary_year_avg": "184000.0",
     "job_posted_date": "2023-06-09 08:01:04",
     "company_name": "Get It Recruit - Information Technology"
     }
     ]
     */