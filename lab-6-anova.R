
# load packages -----------------------------------------------------------

library(tidyverse)


# read data ---------------------------------------------------------------

crabs <- read_csv("chap15q27FiddlerCrabFans.csv")
crabs

# QUESTION D --------------------------------------------------------------

# graph the distribution of body temperatures for each crab type


 crabs %>% 
  ggplot(mapping = aes(x = crabType, y = bodyTemperature)) +
  geom_jitter(aes(color = crabType)) +
  labs(y = NULL) +
  guides(color = "none") +
  theme_minimal() +
  theme(strip.placement = "outside")

# QUESTION E --------------------------------------------------------------

# ANOVA

