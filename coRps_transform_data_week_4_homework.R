---
  title: Data Transformation
date: 2020-05-11
output: html_document
---
  
  ```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

## Overview

This exercise is devided into 2 parts and designed to work you through data transformation processes.

1. Subsetting your data

2. Transform your data


## Load required libraries

```{r}
#Dependencies
library(tidyverse)
library(ICPIutilities)
```


## import row data
```{r}
dataset_url <- "https://media.githubusercontent.com/media/ICPI/TrainingDataset/master/Output/MER_Structured_TRAINING_Datasets_PSNU_IM_FY18-20_20200214_v1_1.txt"
df_dplyr <- read_msd(dataset_url, save_rds = FALSE)
df_et <- read_msd("C:/Users/cadelson/Desktop/Ethiopia/MSD_Facility_Ethiopia_18_20.txt")
glimpse(df_et)

df_et %>%
  filter(indicator %in% c("TX_CURR", "TX_NEW", "HTS_TST", "HTS_TST_POS"),
  operatingunit %in% c("Ethiopia"),
  standardizeddisaggregate == "Total Numerator") %>% 
  select(operatingunit, psnu, fundingagency, mech_name, indicator, fiscal_year:cumulative)
  glimpse()
  

glimpse(df_et)

set.seed(42)

extra_zeros <- df_dplyr %>% 
  sample_n(10) %>% 
  mutate_if(is.double, ~ 0)

df_dplyr <- bind_rows(df_dplyr, extra_zeros)
```

## Subsetting your data

Subset the original dataset by filtering down indicators and operatingunits.

You only need to keep 4 indicators: TX_CURR, TX_NEW, HTS_TST, HTS_TST_POS 

and 2 operating units: Saturn, Jupiter


```{r}
df_et %>%
  filter(indicator %in% c("HTS_TST", "HTS_TST_POS", "TX_CURR", "TX_NEW"), 
  operatingunit %in% c("Ethiopia")) %>% 
  glimpse()

```


Subset your dataset again and only keep columns of interest, about 12 of them

You will need to select: operatingunit, psnu, fundingagency, mech_name, indicator, and all columns between fiscal_year and cumulative


```{r}
df <- df %>% 
  select(...)

df_et %>% select(operatingunit, psnu, fundingagency, mech_name, indicator, fiscal_year:cumulative)%>%
glimpse()
```


Try to rename some of the columns: operatingunit, fundingagency and cumulative


```{r}
df <- df %>% 
  rename(...)

df_et %>% rename(country=operatingunit, agency=fundingagency, total=cumulative) %>%
  glimpse()

```


## Transform you data

Re-calculate the cumulative results values and make sure results makes sense


```{r}
df <- df %>% 
  rowwise() %>% 
  mutate(cumulative_result = ...)


df_et %>% 
  filter_at(vars(starts_with("qtr")), any_vars(!is.na(.))) %>% 
  filter(fiscal_year==2019) %>%
  mutate(cumulative_result = qtr1+qtr2+qtr3+qtr4) %>%
  glimpse()

df_et %>% 
  filter(fiscal_year==2019) 
  filter(indicator=="HTS_TST") %>%
  mutate(cumulative_result = qtr1+qtr2+qtr3+qtr4, na.rm= FALSE) %>%
  select(qtr1, qtr2, qtr3, qtr4, indicator, cumulative, cumulative_result) %>%
  view()


df_et %>% 
  distinct(cumulative, cumulative_result)

distinct(df_et, mech_name)
glimpse(df_et)
```

Make sure zero in the cumulative result field is NA

```{r}
df <- df %>%
  mutate(cumulative_result = ...)
```

Add a new column to hold the average result of all 4 quarters

Make sure to exlude NAs. Does this average result make sense to you?

df_et %>%
  mutate(avg_cum = cumulative/4, na.rm=FALSE) %>%
  filter(avg_cum>0) %>% 
  glimpse()

  ```{r}
df <- df %>%
  mutate(...)
```

Get a list of IM and Indicator with achievement rates greater than 100 %

Focus on one operating unit and the current fiscal year

```{r}
df_et %>% 
  mutate(achievement=cumulative/targets) %>%   
  filter(standardizeddisaggregate=="numerator",) %>% 
  filter(fiscal_year==2019)
  distinct(...) %>% 
  pull(...)
    
df_et %>% 
  mutate(achievement=cumulative/targets, na.rm=FALSE) %>%
  filter(fiscal_year==2019)
  filter(indicator=="HTS_TST_POS") %>%
  glimpse()
  
  df_et %>% 
    mutate(achievement = cumulative/targets, na.rm=FALSE) %>%
    filter(fiscal_year==2019) %>%
    glimpse()