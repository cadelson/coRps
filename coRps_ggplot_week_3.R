---
  title: "ggplot Exercises | 2020-04-13"
output: html_document
---
  
 ```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

## Overivew

#Below are three questions to work on to test our ggplot skills.


## Setup

```{r}
#Dependencies
library(tidyverse)
library(scales)
#import data
df_trends <- read_csv("https://raw.githubusercontent.com/USAID-OHA-SI/coRps/master/2020-04-13/FY18-20_Jupiter_txtrends.csv")

df_linkage <- read_csv("https://raw.githubusercontent.com/USAID-OHA-SI/coRps/master/2020-04-13/FY19_Saturn_linkage.csv")

df_achievement <- read_csv("https://raw.githubusercontent.com/USAID-OHA-SI/coRps/master/2020-04-13/FY20_Neptune_txnew_achievement.csv")
```


## Linkage

#The USAID/Saturn team is interested in knowing where partners are seeing less than ideal linkage to treatment. Using `df_linkage`, help them create a scatter plot that looks at testing and treatment, flagging where they're far from a 1:1 relationship. Consider using different aesthetics to convey a message to your audience.
glimpse(df_linkage)
ggplot(df_linkage)+
  geom_point(aes(HTS_TST_POS, TX_NEW, color=linkage))+
  geom_abline(intercept=0, slope=1)


  facet_wrap(.~primepartner)


## Treatment Trends

#A number of questions have come up recently about treatment trends in Jupiter. You will want to use `df_trends` to review trends in TX_CURR, TX_NEW, and TX_NET_NEW from FY18 to the present visualize through a line chart. Consider using different aesthetics to convey a message to your audience.

glimpse(df_trends)
ggplot(df_trends)+
  geom_line(aes(period, indicator))+
  facet_wrap(.~indicator, nrow=3)
```

## Target Achievement

#In preparation for the FY20Q1 POART, you want to assess different partners' achievement for TX_NEW by sex in Neptune. You will want to show both the real results/targets as well as the percent achievement. Consider using different aesthetics to convey a message to your audience.

glimpse(df_achievement)
ggplot(df_achievement)+
  geom_bar(aes(indicator), stat_count=cumulative)
