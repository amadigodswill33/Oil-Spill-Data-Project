# Oil Spill Analysis
![spillimages](https://github.com/amadigodswill33/Oil-Spill-Data-Project/assets/94016023/c86211a3-1ab3-4ece-8dba-170cffc8ef48)

## Table of Contents
1. [Project Description](#project-description)
2. [Data Source](#data-source)
3. [Project Overview](#project-overview)
    - [Data Cleaning/Preparation](#data-cleaningpreparation)
    - [Exploratory Data Analysis](#exploratory-data-analysis)
    - [Data Analytics](#data-analytics)
4. [Result and Impact](#result-and-impact)
5. [Conclusion](#conclusion)
6. [Recommendation](#recommendation)

## Project Description
This project conducts a detailed analysis of oil spill data in the Niger Delta region spanning 2021 to 2023. Utilizing SQL Server for data preparation, exploratory data analysis (EDA) techniques in Tableau, and advanced data analysis methods in SQL Server, the project aims to derive meaningful insights.

## Data Source
The oil spill dataset used in this project was retrieved from NOSDRA. It encompasses oil spill incidents within the Niger Delta region between 2021 and 2023, serving as the foundation for the comprehensive analysis undertaken.

## Tools
SQL Server, Tableau

## Project Overview
This is an important phase of the project as the following stages were accomplished.

### 1. Data Cleaning/Preparation
In this stage, the Oil Spill Dataset undergoes meticulous cleaning and preparation using SQL Server. Addressing missing values and performing data cleaning and formatting.
```sql code
SELECT COUNT(
	CASE WHEN EstimatedQuantity IS NULL THEN 1
	END)
	FROM Spill_Report..Spill_Sheet;   

UPDATE Spill_Report..Spill_Sheet
SET EstimatedQuantity = 0
WHERE EstimatedQuantity IS NULL;
```
View SQL code [here](https://github.com/amadigodswill33/Oil-Spill-Data-Project/blob/main/Oil_spill_project.sql) 

### 2. Exploratory Data Analysis 
This stage involves thorough EDA techniques using Tableau to answer key questions:
- What is the oil spill volume and financial impact?
- What was the monthly trend in oil spill volume and financial impact over the years?
- Can we identify the specific months where the highest oil spill incidents occurred?
- What are the causes of oil spill in the region?
- How does the percentage contribution of Sabotage/Theft compare to other causes across the specific period?
- Which states are impacted the most?
- Can we visualize the regional distribution of oil spill incidents?
- What recovery techniques were employed during the investigation period?
- What is the monthly trend like in the oil spill incidents?
- Which months recorded high recovery volume?

### 4. Data Analytics
This project employs a robust data analytics approach to delve into the intricacies of oil spill data in the Niger Delta region spanning 2021 to 2023. The analytics process involves a combination of meticulous data cleaning and preparation using SQL Server, exploratory data analysis (EDA) techniques in Tableau. This holistic methodology ensures a comprehensive examination of the dataset, yielding meaningful insights and actionable outcomes. have a view of the [Dashboard here...](https://public.tableau.com/app/profile/godswill.amadi/viz/Nigerian_Oil_Spill_Report/Dashboard1?publish=yes)

## Result and Impact
The analytical findings from this project have far-reaching implications, uncovering significant aspects of oil spills in the Niger Delta region:
![Dashboard 1 (1)](https://github.com/amadigodswill33/Oil-Spill-Data-Project/assets/94016023/e30732d5-d429-4829-aeb9-0f2fbda853de)

1. **Peak in 2022:** The year 2022 marked the zenith in recorded oil spills, totaling 45.74k barrels valued at 3.54M$. Unfortunately, a substantial 89.18% of this spillage remained unrecovered.

2. **Decline in 2023:** In contrast, 2023 witnessed a substantial decline in recorded oil spills, dropping to 13.45k barrels. Despite this reduction, recovery rates were still poor, with 87.57% of the spills unrecovered.

3. **Primary Causes of Oil Spills:** Corrosion, Operational Error, and Sabotage/Theft emerged as the top three causes of oil spills in the Niger/Delta region. Sabotage/Theft, on average, contributed to 87.44% of the recorded oil spills during this period, while Operational Error was the least at 3.55%.

4. **Regional Impact:** The states most impacted by this environmental challenge were identified as Rivers, Delta, and Bayelsa.

5. **Effective Recovery Techniques:** Among the recovery methods employed, Containment booms proved more effective in recovering crude oil spills, including condensate spills, totaling 51k barrels within the investigation period. The use of Pit and Sorbents followed as effective recovery methods.

6. **Shift in Incidents:** October 2022 recorded the highest oil spill incident at 27k barrels, followed by a sudden collapse in incidents starting from December 2022 at 1,000 barrels. This shift may be attributed to new federal government policies combating oil theft and bunkering in the Niger/Delta.

7. **High Recovery Months:** June 2022, January 2023, and June 2023 stood out as months with high recovery volumes of spilled oil. View the dynamic [Dashboard Here](https://public.tableau.com/app/profile/godswill.amadi/viz/Nigerian_Oil_Spill_Report/Dashboard1?publish=yes).

## Conclusion
In conclusion, the data analytics journey through SQL Server, Tableau, and data preparation has provided a comprehensive understanding of oil spill dynamics in the Niger Delta region. The insights gained highlight critical issues, emphasizing the need for proactive measures to prevent and mitigate oil spills and protect the region's ecological balance.

## Recommendation
Considering the analytical outcomes, the following recommendations are proposed:

1. **Preventive Measures:** Strengthen preventive measures, particularly targeting the top causes identified (Corrosion, Operational Error, and Sabotage/Theft).

2. **Collaborative Response:** Encourage collaborative responses among the impacted states (Rivers, Delta, and Bayelsa) to enhance the effectiveness of interventions during oil spill incidents.

3. **Continuous Monitoring and Policy Adaptation:** Maintain vigilant monitoring of oil spill incidents, adapting policies to address emerging trends, as observed in the significant shift in incidents following the federal government policies in December 2022.

4. **Investment in Recovery Technologies:** Invest in and promote the use of effective recovery technologies, such as Containment booms, to minimize the environmental impact of oil spills.

Your involvement in this data analytics exploration significantly contributes to our understanding of the challenges posed by oil spills in the Niger Delta region. Thank you for joining us on this analytical journey!
