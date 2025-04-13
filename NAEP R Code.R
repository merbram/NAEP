## Load Packages ##

library (tinytex)
library(tidyverse)
library(ggplot2)
library(janitor)

## Import Datasets ##
library(readxl)
NAEP_data1 <- read_excel("~/Documents/NAEP data--all states by gender race.xls")
#glimpse(NAEP_data1)

NAEP_data2<- read_excel("~/Downloads/NAEP Econ Status by Gender.xls", na=".")
#glimpse(NAEP_data2)

#str(NAEP_data1)
#str(NAEP_data2)

## Clean Up Datasets and Remove Missing Values ##
colnames(NAEP_data1) <- c("Year", "State", "Race", "Male_Score", "Female_Score")
#str(NAEP_data1)
colnames(NAEP_data2) <- c("Year", "State", "Gender","EconDis", "NotEconDis")
#str(NAEP_data2)

NAEP_clean1 <- NAEP_data1 %>%
  filter(!is.na(Male_Score) , !is.na(Female_Score)) 
#str(NAEP_clean1)

## Convert Dataset1 to Long From and Clean Up ##
library(tidyr)
library(dplyr)
NAEP_data1_long <- NAEP_clean1 %>%
  pivot_longer(cols=c('Male_Score', 'Female_Score'),
               names_to = 'Gender',
               values_to = 'Score') %>%
  mutate(
    Gender =ifelse(Gender=="Male_Score", "Male", "Female"),
    Score = as.numeric(Score)
  )

## Convert Dataset2 to Long From and Clean Up ##
NAEP_data2_long <- NAEP_data2 %>%
  pivot_longer(cols=c('EconDis', 'NotEconDis'),
               names_to = 'Econ_Status',
               values_to = 'Score') %>%
  mutate(
    Econ_Status =ifelse(Econ_Status=="EconDis", "Disadvantaged", "NotDisadvantaged"),
    Score = as.numeric(Score)
  )
#str(NAEP_data1_long)
#str(NAEP_data2_long)

## Set Up Group Type in Order to Merge Datasets 1 and 2 ## 
race_data <- NAEP_data1_long %>%
  mutate(
    GroupType = "Race",
    Group = Race
  ) %>%
  select(Year, State, Gender, GroupType, Group, Score)

econ_data <- NAEP_data2_long %>%
  mutate(
    GroupType = "Econ_Status",
    Group = Econ_Status
  ) %>%
  select(Year, State, Gender, GroupType, Group, Score)

## Put the two together ## 
NAEP_combined_long <- bind_rows(race_data, econ_data)
#glimpse(NAEP_combined_long)

## General Overview of Data ##
library (knitr)
library(dplyr)


## Create summary tables ##
    #Table 1--Avg Score by Demographic Group and Year #
table1 <- NAEP_combined_long %>%
  group_by(GroupType, Group, Year) %>%
  summarize(
    Mean_Score = round(mean(Score, na.rm = TRUE), 1),
    SD = round(sd(Score, na.rm = TRUE), 1),
    N = n(),
    .groups = "drop"
  )

    #Table 2 -- Avg Score by Year #

table2 <- NAEP_combined_long %>%
  group_by (Year) %>% 
  summarize(
    Mean_Score = round(mean(Score, na.rm=TRUE), 1),
    SD = round(sd(Score, na.rm=TRUE), 1),
    N = n()
  ) %>%
  kable(caption = "Average NAEP Math Score by Year")


    #Summary Table 3 -- Avg Score by Gender # 

table3 <- NAEP_combined_long %>%
  group_by (Gender) %>% 
  summarize(
    Mean_Score = round(mean(Score, na.rm=TRUE), 1),
    SD = round(sd(Score, na.rm=TRUE), 1),
    N = n()
  ) %>%
  kable(caption = "Average NAEP Math Score by Gender")

     #Summary Table 4 -- Avg Score by Economic Status #
table4 <- NAEP_combined_long %>%
  filter(GroupType == "Econ_Status") %>%
  group_by (Group) %>% 
  summarize(
    Mean_Score = round(mean(Score, na.rm=TRUE), 1),
    SD = round(sd(Score, na.rm=TRUE), 1),
    N = n()
  ) %>%
  kable(caption = "Average NAEP Math Score by Economic Status")

## GRAPHIC DISPLAYS ##

## Grpahic 1: Map of US with 2024 average scores ##

library(dplyr)

state_scores_2024 <- NAEP_combined_long %>%
  filter(Year == 2024) %>%
  group_by(State) %>%
  summarize(Avg_Score = mean(Score, na.rm = TRUE), 1)

library(usmap)
library(ggplot2)

state_scores_2024 <- NAEP_combined_long %>%
  filter(Year == 2024) %>%
  group_by(State) %>%
  summarize(Avg_Score = round(mean(Score, na.rm = TRUE), 1)) %>%
  mutate(state = state.abb[match(State, state.name)])  

# Create 'state' column

state_scores_2024 <- state_scores_2024 %>%
  filter(!is.na(state))

plot_usmap(data = state_scores_2024, values = "Avg_Score", color = "white") +
  scale_fill_gradient(low = "#deebf7",  # light blue
                      high = "#08306b",, name = "Avg Score") +
  labs(title = "Average 8th Grade Math NAEP Score by State (2024)") +
  theme(legend.position = "right")

## Time Series of Score Changes by Gender ##

gender_scores <- NAEP_combined_long %>%
  filter(!is.na(Gender)) %>%
  group_by(Year, Gender) %>%
  summarize(
    Avg_Score = round(mean(Score, na.rm = TRUE), 1),
    .groups = "drop"
  )

ggplot(gender_scores, aes(x = Year, y = Avg_Score, color = Gender)) +
  geom_line(size = 1.2) +
  geom_point(size = 2) +
  labs(
    title = "Average NAEP Math Score by Gender (2019–2024)",
    x = "Year",
    y = "Average Score",
    color = "Gender"
  ) +
  theme_minimal() +
  scale_color_manual(values = c("Female" = "red", "Male" = "blue")) +
  scale_x_continuous(breaks = c(2019, 2022, 2024))

## Time Series of Score Changes by Race ##

race_scores <- NAEP_combined_long %>%
  filter(GroupType == "Race", !is.na(Group)) %>%
  group_by(Year, Race = Group) %>%
  summarize(
    Avg_Score = round(mean(Score, na.rm = TRUE), 1),
    .groups = "drop"
  )

race_scores_clean <- race_scores %>%
  filter(!is.na(Race)) %>%
  mutate(Race = factor(Race, levels = c(
    "White",
    "Black",
    "Hispanic",
    "Asian/Pacific Islander",
    "American Indian/Native American",
    "Two or More Races"
  )))

ggplot(race_scores, aes(x = Year, y = Avg_Score, color = Race)) +
  geom_line(size = 1.2) +
  geom_point(size = 2) +
  labs(
    title = "Average NAEP Math Score by Race/Ethnicity (2019–2024)",
    x = "Year",
    y = "Average Score",
    color = "Race/Ethnicity"
  ) +
  theme_minimal() +
  scale_x_continuous(breaks = c(2019, 2022, 2024)) +
  scale_color_manual(values = c(
    "White" = "#8da0cb",                   # soft blue
    "Black" = "#fc8d62",                   # muted orange
    "Hispanic" = "#a6d854",                # light green
    "Asian/Pacific Islander" = "#66c2a5",  # teal
    "American Indian/Native American" = "#e78ac3", # light pink
    "Two or More Races" = "#ffd92f"        # soft yellow
  ), drop=FALSE) +
  theme(legend.position = "right")

## Statistical Analysis ##

## One Way ANOVA to Compare Mean Score by Race ##
install.packages("multcompView")
library(multcompView)

Naep_2024 <- NAEP_combined_long %>%
  filter(Year == 2024, GroupType == "Race", !is.na(Score), !is.na(Group))

anova_model <- aov(Score ~ Group, data = Naep_2024)
summary(anova_model)
TukeyHSD(anova_model)

group_means <- Naep_2024 %>%
  group_by(Group) %>%
  summarize(Mean_Score = mean(Score, na.rm = TRUE))
  
tukey_result <- TukeyHSD(anova_model)
tukey_letters <- multcompLetters4(anova_model, tukey_result)
group_means$Tukey_Group <- tukey_letters$Group$Letters

figure4 <- ggplot(group_means, aes(x = reorder(Group, Mean_Score), y = Mean_Score)) +
  geom_bar(stat = "identity", fill = "#4a90e2") +
  geom_text(aes(label = Tukey_Group), vjust = -0.5, size = 4, color = "black") +
  labs(
    title = "Average NAEP Math Score by Race (with Tukey Grouping)",
    x = "Race/Ethnicity",
    y = "Mean Score"
  ) +
  theme_minimal()


## T Test to Compare Gender Differences ## 

Gender_2024 <- NAEP_combined_long %>%
  filter(Year == 2024, GroupType == "Race") %>%
  select(Gender, Score) %>%
  filter(!is.na(Score), Gender %in% c("Male", "Female"))

t.test(Score ~ Gender, data = Gender_2024)

tinytex::is_tinytex()
