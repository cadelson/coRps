---
title: "coRps_ggplot_week2"
output: html_document
---
  
##Install packages
install.packages("tidyverse")
install.packages("devtools")
install.packages("skimr")
install.packages("scales")
install.packages("extrafont")
install.packages("patchwork")
install.packages("extrafont")
install.packages("ICPIutilities")


##See what packages are loaded with tidyverse
tidyverse::tidyverse_packages()

##Next time, just have to use this
library("tidyverse")
library("devtools")
library("skimr")
library("scales")
library("extrafont")
library("patchwork")
library("ICPIutilities")


df_hts <- read_csv("https://raw.githubusercontent.com/USAID-OHA-SI/coRps/master/2020-03-30/FY20_MilkyWay_Testing.csv")
glimpse(df_hts)

##Uploads data
df_tx <- read_csv("https://raw.githubusercontent.com/USAID-OHA-SI/coRps/master/2020-03-30/FY20_MilkyWay_NewtoNetNew.csv")

########View Data####################################
glimpse(df_tx)
##Shows each variable, number of observations and number of variables, examples and what type they are

view(df_tx)
##shows table, works like browse in STATA

distinct(df_tx, primepartner)
#shows each time of partner

count(df_tx, primepartner)
#Counts each time a variable appears in dataset
#####################################################


ggplot(data=df_tx, main="Treatment Performance by Funding Agency")+
  geom_point(aes(x=TX_NET_NEW, y=TX_NEW, size=6, alpha=.5, color=fundingagency))+
  scale_color_manual(values=c("gray60", "gray30", "purple"))+
  geom_vline(aes(xintercept = 0)) +
  geom_hline(aes(yintercept = 0))+
  geom_abline(intercept=0, slope=1)+
  labs(x="TX_NET_NEW", Y="TX_NEW", title="Treatment Performance by Funding Agency")+
  theme_minimal() +
  scale_x_continuous(label = comma) +
  theme(strip.text = element_text(face = "bold", size = 12),
        text = element_text(family = "Source Sans Pro"),
        title = element_text(face = "bold"),
        legend.position = "none")
#put size outside the aesthetic
