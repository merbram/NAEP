---
title: "NAEP Data Analysis"
author: "Meredith Bramlett"
format:
  pdf:
    documentclass: scrartcl
    number-sections: true
    fontsize: 12pt
    linestretch: 2 
    include-in-header: 
      text: |
        \usepackage{float}
    toc: true
    toc-depth: 2
    keep-md: true
    echo: false
    warning: false
    message: false
    eval: true
    results: 'hide'
editor: visual
---






**INTRODUCTION**

The National Assessment of Educational Progress (NAEP), commonly referredt o as "The Nation's Report Card", is a congressionally mandated standardized test administered annually to 4th, 8th, and 12th grade students across the nation. Overseen and administered by the National Center for Education Statistics, NAEP is the only assessment that allows for nationwide comparisons of all students, including both public and private school attendees, in a variety of subjects across demographic groups. Since its first administration in 1969, this test has provided valuable information to educators, policymakers, and stakeholders on student progress, achievement gaps, and changes in educational outcomes.

However, under the current federal administration, the future of NAEP is uncertain. In recent weeks, mass lay-offs have reduced the number of staff working on NAEP testing by 97%, and the 12th grade exam has been cancelled for 2025. These staffing and funding cuts threaten the continuation of the NAEP exam, which has been a useful benchmark for education standards for many years.

This analysis will focus on 8th grade math scores from the years 2019, 2022, and 2024, and will examine trends in performance and disparities in achievement by race, gender, and economic status. 

As a former public school math teacher, I am particularly invested in student achievement in math. Math scores on standardized testing are widely recognized as a strong predictor of future academic and career success (https://nwcommons.nwciowa.edu/cgi/viewcontent.cgi?article=1145&context=education_masters). 


**DATA AND METHODS**


This analysis was conducted using publicly available data from NAEP website to exam trends in 8th grade achievement in math scores. Specifically, it seeks to investigate:

-The impact of the COVID-19 pandemic on 8th grade math achievement scores -Nationwide and statewide trends across time -Disparities in scores across gender, race, and economic status

The variables of interest in this analysis are:

-**Year**: 2019, 2022, 2024

-**State**: All 50 states, the District of Columbia, Department of Defense Education Activity (DoDEA)

-**Race/Ethnicity**: White, Black, Hispanic, Asian/Pacific Islander, American Indian/Native American, Two or More Races

-**Gender**: Male, Female

-**Economic Status**: Economically Disadvantaged, Not Economically Disadvantaged


NAEP utilizes a multistage sampling method to create a representative sample of students across the nation. Schools are identified by the US Department of Education (DOE) and then verified for by state departments of education. Schools are then stratified by location type and racial/ethnic demographics, and arranged by achievement level on state standardized exams. A random sample from each stratum is selected and then confirmed for eligibility from each state department of education. Once a school is selected, a random sample of students within the school are selected for each subject area based on grade (4th, 8th, 12th). Generally, 30 students are selected per grade per subject from each school, with about 95% participation rate for the 4th and 8th grade exams. In 2024, approximately 115,000 8th grade students took the NAEP math exam.

While individual student scores are not available, the aggregated subgroup scores reflect NAEP's internal weighting procedures to preserve national representativeness.  

This analysis was conducted using two separate data sets and all cleaning, visualization, and statistical analysis was done using R Studio. The first data set contained the variables year, state, race, and aggregated score by gender. The second data set contained the variables year, state, gender, and aggregated score by economic status. Discrepancies between this analysis and NAEP’s overall trends may reflect subgroup-level aggregation (e.g., by gender and economic status) rather than total population averages.

In order to prepare the data for analysis, both data sets were cleaned and converted to long format using the pivot.longer function in tidyverse. The two data sets were then merged by their common variables of year, state, and gender. 

Summary statistics were computed for the state, year, and key demographic variables. Tables 1-3 provide an overview of average 8th grade math scores by race and econmoic status for the years 2019, 2022, and 2024.  



\begin{table}[H]
\centering
\caption{\label{tab:unnamed-chunk-1}Table 1: Average NAEP Math Score by Year}
\centering
\begin{tabular}[t]{lcrr}
\toprule
Year & Mean Score & SD & N\\
\midrule
\cellcolor{gray!10}{2019} & \cellcolor{gray!10}{278.6} & \cellcolor{gray!10}{17.8} & \cellcolor{gray!10}{864}\\
2022 & 270.5 & 17.7 & 864\\
\cellcolor{gray!10}{2024} & \cellcolor{gray!10}{269.9} & \cellcolor{gray!10}{19.0} & \cellcolor{gray!10}{864}\\
\bottomrule
\end{tabular}
\end{table}

\begin{table}[H]
\centering
\caption{\label{tab:unnamed-chunk-1}Table 2: Average NAEP Math Score by Race and Year}
\centering
\begin{tabular}[t]{llccr}
\toprule
Race & Year & Mean Score & SD & N\\
\midrule
\cellcolor{gray!10}{American Indian/Alaska Native} & \cellcolor{gray!10}{2019} & \cellcolor{gray!10}{258.8} & \cellcolor{gray!10}{6.8} & \cellcolor{gray!10}{108}\\
American Indian/Alaska Native & 2022 & 253.4 & 7.0 & 108\\
\cellcolor{gray!10}{American Indian/Alaska Native} & \cellcolor{gray!10}{2024} & \cellcolor{gray!10}{249.5} & \cellcolor{gray!10}{9.8} & \cellcolor{gray!10}{108}\\
Asian/Pacific Islander & 2019 & 306.7 & 16.3 & 108\\
\cellcolor{gray!10}{Asian/Pacific Islander} & \cellcolor{gray!10}{2022} & \cellcolor{gray!10}{300.4} & \cellcolor{gray!10}{15.0} & \cellcolor{gray!10}{108}\\
\addlinespace
Asian/Pacific Islander & 2024 & 300.7 & 16.8 & 108\\
\cellcolor{gray!10}{Black} & \cellcolor{gray!10}{2019} & \cellcolor{gray!10}{258.4} & \cellcolor{gray!10}{7.0} & \cellcolor{gray!10}{108}\\
Black & 2022 & 250.9 & 6.2 & 108\\
\cellcolor{gray!10}{Black} & \cellcolor{gray!10}{2024} & \cellcolor{gray!10}{250.5} & \cellcolor{gray!10}{7.0} & \cellcolor{gray!10}{108}\\
Hispanic & 2019 & 267.7 & 9.1 & 108\\
\addlinespace
\cellcolor{gray!10}{Hispanic} & \cellcolor{gray!10}{2022} & \cellcolor{gray!10}{259.5} & \cellcolor{gray!10}{8.9} & \cellcolor{gray!10}{108}\\
Hispanic & 2024 & 257.2 & 9.1 & 108\\
\cellcolor{gray!10}{Two or more races} & \cellcolor{gray!10}{2019} & \cellcolor{gray!10}{285.1} & \cellcolor{gray!10}{7.5} & \cellcolor{gray!10}{108}\\
Two or more races & 2022 & 276.4 & 8.6 & 108\\
\cellcolor{gray!10}{Two or more races} & \cellcolor{gray!10}{2024} & \cellcolor{gray!10}{275.7} & \cellcolor{gray!10}{10.2} & \cellcolor{gray!10}{108}\\
\addlinespace
White & 2019 & 291.0 & 7.3 & 108\\
\cellcolor{gray!10}{White} & \cellcolor{gray!10}{2022} & \cellcolor{gray!10}{283.5} & \cellcolor{gray!10}{7.8} & \cellcolor{gray!10}{108}\\
White & 2024 & 284.4 & 9.2 & 108\\
\bottomrule
\end{tabular}
\end{table}

\begin{table}[H]
\centering
\caption{\label{tab:unnamed-chunk-1}Table 3: Average NAEP Math Score by Economic Status and Year}
\centering
\begin{tabular}[t]{llccr}
\toprule
Economic Status & Year & Mean Score & SD & N\\
\midrule
\cellcolor{gray!10}{Disadvantaged} & \cellcolor{gray!10}{2019} & \cellcolor{gray!10}{265.2} & \cellcolor{gray!10}{7.5} & \cellcolor{gray!10}{108}\\
Disadvantaged & 2022 & 258.0 & 8.2 & 108\\
\cellcolor{gray!10}{Disadvantaged} & \cellcolor{gray!10}{2024} & \cellcolor{gray!10}{256.5} & \cellcolor{gray!10}{8.3} & \cellcolor{gray!10}{108}\\
NotDisadvantaged & 2019 & 294.4 & 5.2 & 108\\
\cellcolor{gray!10}{NotDisadvantaged} & \cellcolor{gray!10}{2022} & \cellcolor{gray!10}{284.3} & \cellcolor{gray!10}{10.0} & \cellcolor{gray!10}{108}\\
\addlinespace
NotDisadvantaged & 2024 & 285.0 & 10.7 & 108\\
\bottomrule
\end{tabular}
\end{table}



**Results**

The impact of the COVID-19 pandemic on education in the US is widely known and well-documented, (Pinto, Santiago. (August 2023) "The Pandemic's Effects on Children's Education." Federal Reserve Bank of Richmond Economic Brief, No. 23-29). Test scores dropped, student anxiety and depression increased, school enrollment was down, and chronic absenteeism was up. But even before the nationwide school shut down, scores were showing a concerning downward trend (https://www.axios.com/2021/10/15/nations-report-card-falling-reading-math-scores), with a widening gap between the highest performing and lowest performing students.

Figure 1 shows a clear downward trend in national average math scores among 8th graders for the years 2019, 2022, and 2024. A sharp drop of over 8 points coincides with the academic disruptions caused by the COVID-19 pandemic. The continued decline into 2024 suggests that post-pandemic remediation efforts have not fully offset earlier learning losses. This trend aligns with national concerns about persistent achievement gaps and long-term impacts on student preparedness.



::: {.cell}
::: {.cell-output-display}
![](Naep-Write-Up_files/figure-pdf/unnamed-chunk-2-1.pdf)
:::
:::



The 2024 heatmap shows significant regional differences in student performance. States in the Northeast and Upper Midwest, such as Massachusetts and New Jersey, tend to report higher average scores, shown in darker blue shades. In contrast, Southern states like Arkansas and Alabama generally report lower average scores. This reflects existing gaps in educational opportunity that are often tied to differences in funding, local economies, and access to academic resources. 



::: {.cell}
::: {.cell-output-display}
![](Naep-Write-Up_files/figure-pdf/unnamed-chunk-3-1.pdf)
:::
:::


When comparing the change in average score from 2022 to 2024, most states continued to experience a decline. Arizona and Alaska saw the biggest decline in scores, with Nebraska and Pennsylvania seeing the biggest increase. Cuts in funding and an increase in student-teacher ratio could be contributing factors to Alaska's large average decrease in scores (https://static1.squarespace.com/static/56e32eb29f72664158653203/t/6765c5141a0f95656e5982e9/1734722836562/How+Legislature+short-changed+students+Dec+16+2024.pdf), while Arizona ranks at the bottom in the nation for funding per pupil and faces a teacher shortage crisis (https://www.consumeraffairs.com/movers/best-states-for-public-education.html). 





::: {.cell}
::: {.cell-output-display}
![](Naep-Write-Up_files/figure-pdf/fig.barchange-1.pdf)
:::
:::



While the pandemic certainly disrupted learning for all students, those effects were not proportionally distributed. Gender, race, and economic disparities that already existed were amplified in the wake of the pandemic. 

Prior to the pandemic, the national average 8th grade math scores for males and females were roughly the same. Post-pandemic, an achievement gap between genders appears to have widened and has worsened into 2024. While the scores seem to be diverging, a t-test for mean differences by gender did not yield a statistically significant result, t(355) = -1.203, p = .223. This suggests that although there may be a slight widening of the gender gap in math performance, the difference may not be large enough across students to conclude that a true gender-based difference exists in the overall population.
 


::: {.cell}
::: {.cell-output-display}
![](Naep-Write-Up_files/figure-pdf/unnamed-chunk-4-1.pdf)
:::
:::



In 2024, Asian/Pacific Islander students had the highest average score (300.7) while Black students had the lowest average score (250.5), a difference of 50.2 points, likely indicating that Asian/Pacific Islander students are significantly more proficient in basic mathematical and problem-solving skills. And while all races showed a large drop in average scores from 2019 to 2022, White and Asian/Pacific Islander students showed improvement in 2024 scores while Black and Hispanic student scores continued to decline. 

A one-way ANOVA was conducted to examine differences in 2024 math scores by race, and results showed a statistically significant difference in at least one group mean, F(5, 325) = 217.3, p < .001. A follow-up Tukey’s HSD test confirmed that the mean scores for each racial group were significantly different from one another. While disparities in NAEP math scores by race are not new, the pandemic appears to have intensified the existing achievement gap. Though COVID-19 wasn’t the root cause of these differences, it acted as a catalyst that magnified long-standing inequities in access to quality instruction, academic resources, and educational support systems.





::: {.cell}
::: {.cell-output-display}
![](Naep-Write-Up_files/figure-pdf/unnamed-chunk-5-1.pdf)
:::
:::



---
