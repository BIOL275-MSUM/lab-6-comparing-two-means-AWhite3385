
# load packages -----------------------------------------------------------

library(tidyverse)


# read data ---------------------------------------------------------------

fish <- read_csv("chap12q19ElectricFish.csv")


# put data in tidy format ------------------------------------------------

fish_long <- 
  pivot_longer(fish, speciesUpstream:speciesDownstream,
               names_to = "location",
               values_to = "species") %>% 
  mutate(location = str_remove(location, c("species"))) %>% 
  print()


# Question A t-test -------------------------------------------------------

t.test(formula = species ~ location, data = fish_long)

# Question B difference in means -----------------------------------------
(16.41667 - 14.58333)
#1.83334
#95 percent confidence interval:
#-4.587031  8.253697

# Question C histograms --------------------------------------------------

fish_long %>% 
  ggplot(aes(x = species)) +
  geom_histogram(
    aes(fill = location), 
    bins = 7, 
    alpha = 0.5, 
    position = "identity"
  ) +
  scale_fill_manual(values = c("red","blue")) +
  theme_minimal() + 
  facet_wrap(~ location, ncol = 1) 
  

