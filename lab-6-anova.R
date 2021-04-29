
# load packages -----------------------------------------------------------

library(tidyverse)


# read data ---------------------------------------------------------------

crabs <- read_csv("chap15q27FiddlerCrabFans.csv")
crabs

# QUESTION D --------------------------------------------------------------

# graph the distribution of body temperatures for each crab type


crabs %>% 
  ggplot(aes(x = bodyTemperature)) +
  geom_histogram(
    aes(fill = crabType ), 
    bins = 15, 
    alpha = 0.5,
    position= "identity",
    na.rm = TRUE)+
  labs(x= "Temperature", y="Frequency", fill="Type of Crab")+
  facet_wrap(~crabType)

# QUESTION E --------------------------------------------------------------

aov_crabs <-
  aov( bodyTemperature ~ crabType, data = crabs)
aov_crabs

summary(aov_crabs)

# ANOVA

