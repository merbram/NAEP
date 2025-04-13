---
title: "NAEP Data Analysis"
author: "Meredith Bramlett"
format:
  pdf:
    documentclass: scrartcl
    number-sections: true
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




INTRODUCTION

The National Assessment of Educational Progress (NAEP), often referred to as "The Nation's Report Card", is a congressionaly mandated standardized test that is administered annually to 4th, 8th, and 12th grade students across the nation. Overseen and administered by the National Center for Education Statistics, NAEP is the only assessment that allows for nationwide comparisons of all students, including both public and private school attendees, in a variety of subjects across demographic groups. Since its first administration in 1969, this test has provided valuable information to educators and policymakers on student progress, achievement gaps, and changes in educational outcomes.

However, under the current federal administration, the future of NAEP is uncertain. In recent weeks, mass lay-offs have reduced the staff working on NAEP testing by 97%, and the 12th grade exam has been cancelled. These staffing and funding cuts threaten the continuation of the NAEP exam, which has been a useful benchmark for education standards for many years.

This analysis will focus on 8th grade math scores from the years 2019, 2022, and 2024, and will examine trends in performance and disparities in achievement. As a former public school math teacher, I am particularly invested in student achievement in math. Math scores on standardized testing are widely recognized as a strong predictor of future academic and career success (https://nwcommons.nwciowa.edu/cgi/viewcontent.cgi?article=1145&context=education_masters).

DATA AND METHODS

This analysis was conducted using publicly availaible data from NAEP website to exam trends in 8th grade achievement in math scores. Specifically, it seeks to investigate:

-The impact of the COVID-19 pandemic on 8th grade math achievement scores -Aationwide and statewide trends across time -Disparities in scores across gender, race, and economic status

The variables of interest in this analysis are:

-Year: 2019, 2022, 2024

-State: All 50 states, the District of Columbia, Department of Defense Education Activity (DoDEA)

-Race/Ethnicity:

White

Black

Hispanic

Asian/Pacific Islander

American Indian/Native American

Two or More Races

-Gender:

Male

Female

-Economic Status:

Economically Disadvantaged

Not Economically Disadvantaged

NAEP utilizes a multistage sampling method to create a representative sample of students across the nation. Schools are identified by the US Department of Education (DOE) and then verified for by state departments of education. Schools are then stratified by location type and racial/ethnic demographics, and arranged by achievement level on state standardized exams. A random sample from each stratum is selected and then confirmed for eligibility from each state department of education. Once a school is selected, a random sample of students within the school are selected for each subject area based on grade (4th, 8th, 12th). Generally, 30 students are selected per grade per subject from each school, with about 95% participation rate for the 4th and 8th grade exams. In 2024, approximately 115,000 8th grade students took the NAEP math exam.

While individual student scores are not available, the aggregated subgroup scores reflect NAEP's internal weighting procedures to preserve national representativeness.

This analysis was conducted using two separate data sets and all cleaning, visualization, and statistical analysis was done using R Studio. The first data set contained the variables year, state, race, and aggregated score by gender. The second data set contained the variables year, state, gender, and aggregated score by economic status.

In order to prepare the data for analysis, both data sets were cleaned and converted to long format using the pivot.longer function in tidyverse. The two data sets were then merged by their common variables of year, state, and gender. 



::: {.cell}
::: {.cell-output .cell-output-stdout}

```

The downloaded binary packages are in
	/var/folders/wq/3cc17sjx3rs30v6fnk8d09h40000gn/T//Rtmpy3WpXQ/downloaded_packages
```


:::

::: {.cell-output .cell-output-stdout}

```

The downloaded binary packages are in
	/var/folders/wq/3cc17sjx3rs30v6fnk8d09h40000gn/T//Rtmpy3WpXQ/downloaded_packages
```


:::
:::



Summary statistics were computed for the state, year, and demographic variables. Tables 1-4 



\begin{table}[!h]
\centering
\caption{\label{tab:unnamed-chunk-2}Average NAEP Math Score by Demographic Group and Year}
\centering
\begin{tabular}[t]{llccrr}
\toprule
Group Type & Economic Status & Year & Mean Score & SD & N\\
\midrule
\cellcolor{gray!10}{Econ\_Status} & \cellcolor{gray!10}{Disadvantaged} & \cellcolor{gray!10}{2019} & \cellcolor{gray!10}{265.2} & \cellcolor{gray!10}{7.5} & \cellcolor{gray!10}{108}\\
Econ\_Status & Disadvantaged & 2022 & 258.0 & 8.2 & 108\\
\cellcolor{gray!10}{Econ\_Status} & \cellcolor{gray!10}{Disadvantaged} & \cellcolor{gray!10}{2024} & \cellcolor{gray!10}{256.5} & \cellcolor{gray!10}{8.3} & \cellcolor{gray!10}{108}\\
Econ\_Status & NotDisadvantaged & 2019 & 294.4 & 5.2 & 108\\
\cellcolor{gray!10}{Econ\_Status} & \cellcolor{gray!10}{NotDisadvantaged} & \cellcolor{gray!10}{2022} & \cellcolor{gray!10}{284.3} & \cellcolor{gray!10}{10.0} & \cellcolor{gray!10}{108}\\
\addlinespace
Econ\_Status & NotDisadvantaged & 2024 & 285.0 & 10.7 & 108\\
\bottomrule
\end{tabular}
\end{table}



---

## Quarto

Quarto enables you to weave together content and executable code into a finished document. To learn more about Quarto see <https://quarto.org>.

## Running Code

When you click the **Render** button a document will be generated that includes both content and the output of embedded code. You can embed code like this:



::: {.cell}
::: {.cell-output .cell-output-stdout}

```
[1] 2
```


:::
:::



You can add options to executable code like this



::: {.cell}
::: {.cell-output .cell-output-stdout}

```
[1] 4
```


:::
:::



The `echo: false` option disables the printing of code (only output is displayed).
