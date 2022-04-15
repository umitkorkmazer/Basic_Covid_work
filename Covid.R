#Import txt file
setwd(dirname(rstudioapi::getSourceEditorContext()$path))
data_1 <- read.csv("covid-data-2020.txt", sep = "\t")

#Taking 1000 random data in file
set.seed(10091998)
samples_1 <- data_1[sample(nrow(data_1), 1000), ]

library(tidyverse)

#Calculating q1, q2 and q3
samples_1 %>% group_by(location, month) %>% summarize(min = min(new_cases, na.rm = TRUE), Q1 = quantile(new_cases, 0.25, na.rm = TRUE), Q2 = quantile(new_cases, 0.5, na.rm = TRUE), Q3 = quantile(new_cases, 0.75, na.rm = TRUE), max = max(new_cases, na.rm = TRUE))

#Finding the highest daily cases and deaths separately for each country. 
samples_1 %>% group_by(location) %>% summarize(max_case = max(new_cases, na.rm = TRUE), max_death = max(new_deaths, na.rm = TRUE))

#Identifing the month in which the mean daily cases is the highest for each country.
samples_1 %>% group_by(location, month) %>% summarize("Mean of dailycases" = mean(new_cases, na.rm = TRUE))

#Selecting 3 country and plot the distribution of daily cases by month. 
ggplot(filter(samples_1, location == c("Turkey", "Russia", "United Kingdom")), aes(x = new_cases, y = month, color = location)) + geom_boxplot()
