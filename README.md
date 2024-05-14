# Introduction
Dive into the data job market! Focusing on data analyst roles, this project explores 💰 top-paying jobs, 🔥in-demand skills, and where 📈 high demand meets high salary in data analytics

SQL queries? Check them out here: [project_sql folder](/project_sql/)

# Background
Driven by a mission to navigate the data analyst job market more effectively, this project was born from a desire to triangulate top-paid and in-demand skills, streamlining others work to find optimal jobs.

Data originates from [SQL Course](https://lukebarousse.com/sql). It's packed with insights on job titles, salaries, locations, and essential skills.

# Tools I Used
For my deep dive into the data analyst job market, I utilized several key tools: 

- **SQL:** The backbone of my analysis, allowing me to query the database and unearth critical insights.
- **PostgreSQL:** The chosen database management system, ideal for handling the job posting data.
- **Visual Studio Code:** My default database management tool for executing SQL queries
- **Git & GitHub:** Essential for version control and sharing my SQL scripts and analysis, ensuring collaboration and project tracking.

# The Analysis

### 1. Top Paying Data Analyst Jobs
To identify the highest-paying roles, I filtered data analyst positions by average yearly salary and location, focusing on remote jobs. This query highlights the high paying opporunities in the field. 

```sql
SELECT job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
    name AS company_name
FROM job_postings_fact
    LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE job_title_short = 'Data Analyst'
    AND job_location = 'Anywhere'
    AND salary_year_avg IS NOT NULL
ORDER BY salary_year_avg DESC
LIMIT 10
```

Insights on the top 10 highest paying data analyst jobs:

- **Diverse Job Titles:** Despite all roles falling under the umbrella of data analysis, the job titles vary significantly, from "Data Analyst" to "Director of Analytics" and "Associate Director- Data Insights." This diversity suggests a range of responsibilities and seniority levels within the field, catering to different skill sets and career trajectories.

- **Salary Disparity:** The salary range among the top 10 highest paying data analyst jobs is considerable, with the highest salary at $650,000 and the lowest at $184,000 per year. This disparity may be attributed to factors such as industry, company size, location, and the specific skill set and experience required for each role.

- **Remote Work Opportunities:** The job locations are specified as "Anywhere," indicating remote work flexibility for these positions. This highlights a growing trend in the job market, where employers are increasingly offering remote or hybrid work arrangements, enabling candidates to work from various locations without compromising on salary or job responsibilities.

### 2. Top Paying Skills
To identify the top paying skills I narrowed my search to Remote Data Analyst roles with skills that pay the highest paying salaries. 

```sql
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
```
 Analyzing the skills required for these top 10 data analyst roles reveals some interesting patterns:
     
- **SQL:** SQL is consistently the most sought-after skill across all roles, appearing in every job posting. This underscores the importance of database querying and manipulation for data analysis.
     
- **Python:** Python is also highly valued, being present in the skill requirements for most roles. Its versatility in data analysis, machine learning, and scripting likely contributes to its popularity.
     
- **Tableau:** Tableau is a prominent visualization tool, appearing in several job postings. This suggests a significant emphasis on data visualization skills for communicating insights effectively.
     
- **Excel:** Despite the prevalence of more specialized tools and languages, Excel remains relevant, being listed in multiple postings. Its familiarity and widespread use in data analysis tasks likely contribute to its continued importance.
     
- Overall, proficiency in SQL and Python, coupled with experience in data visualization tools like Tableau and general-purpose tools like Excel, appears to be essential for most data analyst roles. Additionally, familiarity with cloud platforms, big data technologies, version control systems, and domain-specific tools enhances a candidate's competitiveness in the job market.

### 3. Most Demanded Skills
To identify the skills for Remote Data Analyst roles that occurred most often I counted the skills by their job id and ordered in descending order. 

```sql
SELECT skills,
    COUNT(skills_job_dim.job_id) AS demand_count
FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE job_title_short = 'Data Analyst'
    AND job_work_from_home = True
GROUP BY skills
ORDER BY demand_count DESC
LIMIT 5
```

| Skills   | Demand Count |
|----------|--------------|
| SQL      | 7291         |
| Excel    | 4611         |
| Python   | 4330         |
| Tableau  | 3745         |
| Power BI | 2609         |


### 4. Top Paying Skills
To identify the top paying skills for Remote Data Analyst jobs by taking the yearly average salary and skill. 25 skills were then ordered by their associated salary from highest to lowest. 

```sql
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
```
| Skills         | Avg Salary |
|----------------|------------|
| PySpark        | 208,172    |
| Bitbucket      | 189,155    |
| Couchbase      | 160,515    |
| Watson         | 160,515    |
| DataRobot      | 155,486    |
| GitLab         | 154,500    |
| Swift          | 153,750    |
| Jupyter        | 152,777    |
| Pandas         | 151,821    |
| Elasticsearch  | 145,000    |
| Golang         | 145,000    |
| NumPy          | 143,513    |
| Databricks     | 141,907    |
| Linux          | 136,508    |
| Kubernetes     | 132,500    |
| Atlassian      | 131,162    |
| Twilio         | 127,000    |
| Airflow        | 126,103    |
| Scikit-Learn   | 125,781    |
| Jenkins        | 125,436    |
| Notion         | 125,000    |
| Scala          | 124,903    |
| PostgreSQL     | 123,879    |
| GCP            | 122,500    |
| Microstrategy  | 121,619    |

Insights on the top 25 skills for data analysts:
     
- **Salary Variation**: While some skills like PySpark offer higher average salaries, there's significant variation across different skills. For instance, PySpark commands an average salary of $208,172, whereas MicroStrategy, though in the top 25, offers an average salary of $121,619. This suggests that the choice of skill can significantly impact earning potential.
     
- **Tool Diversity**: The list encompasses a diverse range of tools and technologies, from programming languages like Python and Swift to data processing frameworks like Apache Spark and Databricks, and version control systems like GitLab and Bitbucket. This reflects the multidisciplinary nature of data analysis, where professionals need to be proficient in various tools to tackle different challenges effectively.
     
- **Emerging Technologies**: Skills like Kubernetes, Golang, and Elasticsearch are indicative of the evolving landscape of data analysis. Proficiency in these emerging technologies not only enhances a data analyst's capabilities but also positions them well for future opportunities as industries continue to adopt advanced tools for data management and analysis.

### 5. Optimal Skills
Identify skills in high demand associated with high average salaries for Data Analyst roles. Targets skills that offer job security and financial benefits, offering strategic insights for career development in data analysis

```sql
SELECT skills_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS demand_count,
    ROUND(AVG(job_postings_fact.salary_year_avg), 0) AS avg_salary
FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = True
GROUP BY skills_dim.skill_id
HAVING COUNT(skills_job_dim.job_id) > 10
ORDER BY avg_salary DESC,
    demand_count DESC
LIMIT 25;
```

| Skill ID | Skill       | Demand Count | Avg Salary |
|----------|-------------|--------------|------------|
| 8        | go          | 27           | 115320     |
| 234      | confluence  | 11           | 114210     |
| 97       | hadoop      | 22           | 113193     |
| 80       | snowflake   | 37           | 112948     |
| 74       | azure       | 34           | 111225     |
| 77       | bigquery    | 13           | 109654     |
| 76       | aws         | 32           | 108317     |
| 4        | java        | 17           | 106906     |
| 194      | ssis        | 12           | 106683     |
| 233      | jira        | 20           | 104918     |
| 79       | oracle      | 37           | 104534     |
| 185      | looker      | 49           | 103795     |
| 2        | nosql       | 13           | 101414     |
| 1        | python      | 236          | 101397     |
| 5        | r           | 148          | 100499     |
| 78       | redshift    | 16           | 99936      |
| 187      | qlik        | 13           | 99631      |
| 182      | tableau     | 230          | 99288      |
| 197      | ssrs        | 14           | 99171      |
| 92       | spark       | 13           | 99077      |
| 13       | c++         | 11           | 98958      |
| 186      | sas         | 63           | 98902      |
| 7        | sas         | 63           | 98902      |
| 61       | sql server  | 35           | 97786      |
| 9        | javascript  | 20           | 97587      |

Insights on the 25 most demanded skills for data analysis:

- **Cloud Computing Platforms:** Skills like Azure, AWS, and Google BigQuery are highly demanded, reflecting the widespread adoption of cloud technologies for data storage, processing, and analysis. Professionals with expertise in these platforms are sought after for their ability to leverage cloud-based solutions effectively.

- **Database Management Systems:** Oracle, SQL Server, and MySQL remain in high demand, emphasizing the continued importance of relational database management systems (RDBMS) in data analysis. Proficiency in these systems is essential for managing and querying large datasets efficiently.

- **Business Intelligence Tools:** Tableau, Looker, and Qlik are among the top demanded skills, highlighting the significance of data visualization and business intelligence tools in data analysis workflows. Professionals with expertise in these tools can effectively communicate insights derived from data to stakeholders, driving informed decision-making.

# What I Learned
**Complex SQL Queries:** I've mastered a digital treasure map, where I navigated through databases using intricate commands to uncover valuable insights buried within.

**Data Aggregation:** I'm now a skilled chef, blending diverse ingredients from various markets to create a flavorful dish - that's data aggregation, mixing data from different sources to reveal comprehensive insights.

**Analytical Wizardry:** I pictured myself as a wizard, wielding programming languages like magical spells to transform raw data into actionable insights that drive decision-making and spark innovation.

# Conclusions

### Closing Thoughts

This project enhanced my SQL skills and I gained valuable insights into the data anaylst job market. I am better positioned as a data analyst since I know which skills are most lucrative and which companies are posting the most jobs. The skills I've developed will allow me to search high paying jobs in the area I'm most interested.
