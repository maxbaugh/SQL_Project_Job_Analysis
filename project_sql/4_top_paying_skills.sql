/*
 Question: What are the top skills based on salary? 
 - Look at the average salary associated with each skill for Data Analysts
 - Focuses on roles with specified salaries, regardless of location
 - Why? It reveals how different skills impact salary levels for Data Analysts
 and helps identify the most financially rewarding skills to acquire or improve
 */
SELECT skills,
    ROUND(AVG(salary_year_avg), 0) AS avg_salary
FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = True -- AND job_work_from_home = True
GROUP BY skills
ORDER BY avg_salary DESC
LIMIT 25
    /*
     Insights on the top 25 skills for data analysts:
     
     1. **Salary Variation**: While some skills like PySpark offer higher average salaries, there's significant variation across different skills. For instance, PySpark commands an average salary of $208,172, whereas MicroStrategy, though in the top 25, offers an average salary of $121,619. This suggests that the choice of skill can significantly impact earning potential.
     
     2. **Tool Diversity**: The list encompasses a diverse range of tools and technologies, from programming languages like Python and Swift to data processing frameworks like Apache Spark and Databricks, and version control systems like GitLab and Bitbucket. This reflects the multidisciplinary nature of data analysis, where professionals need to be proficient in various tools to tackle different challenges effectively.
     
     3. **Emerging Technologies**: Skills like Kubernetes, Golang, and Elasticsearch are indicative of the evolving landscape of data analysis. Proficiency in these emerging technologies not only enhances a data analyst's capabilities but also positions them well for future opportunities as industries continue to adopt advanced tools for data management and analysis.
     */