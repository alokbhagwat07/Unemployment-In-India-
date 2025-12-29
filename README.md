# Unemployment in India: Structural Skill & Industry Mismatch

Analyzed the gap between education output, industry demand, and unemployment across Indian states using **Python (Pandas, NumPy)**, **SQL**, and **Tableau** to uncover structural causes of youth unemployment.

---

## Project Overview

Unemployment in India is often discussed as a lack of jobs. This project approaches the problem differently — as a **structural mismatch** between education output, skill quality, and industry demand, compounded by **uneven industrial distribution across regions**. Instead of opinions, the analysis relies on **real education data** and **real job-market data** to identify where and why mismatches occur.

The project is structured into independent analytical modules, each addressing a different root cause of unemployment.

---

## Key Questions Addressed

* Is there a mismatch between what students study and what industries demand?
* How does the **distribution of industries and colleges across states** relate to unemployment?
* Are unemployment issues structural rather than purely cyclical?
* Why do engineers remain unemployed despite apparent demand for engineering roles?

---

## Project Structure (Modular Analysis)

### Module 1: Education vs Job Demand

**Focus:** Structural mismatch between education supply and job demand

* Uses **AISHE (2021–22)** education data to analyze student pass-outs by discipline
* Uses **1.24 lakh+ LinkedIn job postings (2023–24)** to analyze industry and skill demand
* Maps education disciplines and job categories into common sector groups

**Identifies:**

* Oversupply sectors (e.g., Social Sciences, Commerce)
* Undersupply sectors (e.g., Engineering, IT, Healthcare, Vocational skills)
* The **engineering unemployment paradox**: high demand for skilled engineers, but low employability due to skill-quality gaps

**Outputs:**

* Demand vs Supply divergence charts
* Sector-level mismatch insights

---

### Module 2: Industry Presence vs Unemployment (State-Level Analysis)

**Focus:** Relationship between industrial structure and unemployment across states

* Maps industries present across Indian states
* Compares industrial concentration with unemployment indicators
* Highlights regions with limited industrial diversity and higher unemployment

**Outputs:**

* State-wise industry distribution analysis
* Unemployment vs industrial presence comparisons

---

### Module 3: Industry Presence vs Number of Colleges (Python-Based Analysis)

**Focus:** Alignment between **industrial demand** and **educational infrastructure** at the state level

* Analyzes the **number of colleges by state and discipline** using AISHE data
* Maps **industry categories by state** and compares them with local college density
* Uses **Python (Pandas, NumPy)** for data cleaning, aggregation, normalization, and correlation analysis

**Identifies:**

* States with **high college concentration but limited industrial presence** (potential graduate saturation)
* States with **strong industry presence but fewer relevant colleges** (talent import dependence)
* Structural imbalance between where education capacity exists and where jobs are created

**Outputs:**

* Industry vs number of colleges comparison tables
* State-level imbalance indicators supporting structural unemployment findings

---

## Tools Used

* **Python (Pandas, NumPy)** – primary analysis, preprocessing, aggregation, state-wise comparisons
* **SQL** – data modeling, joins, sector mapping
* **Tableau** – visualization and storytelling dashboards
* **Excel** – validation and preprocessing

---

## Key Findings

* Engineering and IT roles are in demand, but only a fraction of graduates are job-ready
* Social Sciences and Commerce show significant graduate oversupply
* States with limited industrial diversity tend to show higher unemployment
* Mismatch exists not only between **skills and jobs**, but also between **industry locations and college distribution**
* India faces a **skill-quality and spatial mismatch**, not just a job shortage

---

## Limitations

This study focuses on **structural factors** (skills, education capacity, and industry structure). It does not fully model:

* Informal employment
* Wage quality
* Population growth dynamics
* Short-term economic cycles

Findings should be interpreted as **diagnostic insights**, not causal proofs.

---

## Contributors

**Alok Bhagwat — Lead Data Analyst & Research Architect**

* Designed and executed Python-based analysis using Pandas and NumPy
* Conducted **Industry vs Number of Colleges** state-level analysis
* Implemented data cleaning, preprocessing, and aggregation pipelines
* Performed exploratory data analysis and statistical comparisons
* Supported analytical reasoning and interpretation of structural mismatches

**Siddharth Bhagwat — Visualization & Research Contributor**

* Conceptualized the project and defined core research questions
* Conducted background research through articles, reports, and policy documents
* Identified and sourced education and job-market datasets
* Assisted with sector-mapping logic and analytical framework
* Contributed to Tableau dashboard design and narrative presentation

---

## Conclusion

This analysis shows that unemployment in India is driven less by a lack of jobs and more by a **structural mismatch** between education output, skill quality, industrial demand, and regional industry placement. While sectors such as technology, healthcare, and vocational trades face talent shortages, others produce graduates far beyond available opportunities. The persistence of unemployment among engineers reflects a **skill-quality gap**, not a demand deficit. Overall, solving unemployment requires better alignment between education outcomes, skill development, **college distribution**, and regional industrial structure — not just higher graduate numbers.

---

## About

Analyzed the gap between education output, industry demand, college distribution, and unemployment across Indian states using **Python, SQL, and Tableau** to uncover structural causes of youth unemployment.
