#install.packages("palmerpenguins")

#load packages
library(tidyverse)
library(palmerpenguins)

data("penguins")

#about data

head(penguins)

str(penguins)

#sexual dimorphism

penguins %>% 
  select(
    species,
    sex,
    bill_length_mm, 
    bill_depth_mm, 
    flipper_length_mm, 
    body_mass_g
  ) %>% 
  pivot_longer(
    col = where(is.numeric),
    names_to = "variable", 
    values_to = "value"
  ) %>% 
  filter(complete.cases(.)) %>% 
  ggplot(mapping = aes(x = sex, y = value)) +
  geom_jitter(aes(color = sex)) +
  facet_grid(variable ~ species, scales = "free_y", switch = "y") +
  labs(y = NULL) +
  guides(color = "none") +
  theme_minimal() +
  theme(strip.placement = "outside")

#Adelie bill depth

adelie_bill_depth <-
  penguins %>% 
  filter(species == "Adelie") %>% 
  select(sex, bill_depth_mm) %>% 
  filter(complete.cases(.)) %>% 
  print()

#distribution of bill depth
adelie_bill_depth %>% 
  ggplot(aes(x = bill_depth_mm)) +
  geom_histogram(
    aes(fill = sex), 
    bins = 15, 
    alpha = 0.5, 
    position = "identity"
  ) +
  scale_fill_manual(values = c("darkorange","cyan4")) +
  theme_minimal()

#mean and confidence interval
adelie_bill_depth_summary <-
  adelie_bill_depth %>% 
  group_by(sex) %>% 
  summarize(
    n = n(),
    mean = mean(bill_depth_mm),
    sd = sd(bill_depth_mm),
    sem = sd/sqrt(n),
    upper = mean + 1.96 * sem,
    lower = mean - 1.96 * sem
  ) %>% 
  print()

adelie_bill_depth %>% 
  ggplot(aes(x = sex, y = bill_depth_mm)) +
  geom_jitter(aes(color = sex), 
              shape = 16, alpha = 0.3, width = 0.4) +
  geom_errorbar(aes(y = mean, ymax = upper, ymin = lower), 
                data = adelie_bill_depth_summary, width = .1) +
  geom_point(aes(y = mean), 
             data = adelie_bill_depth_summary) +
  scale_color_manual(values = c("darkorange","cyan4")) +
  theme_minimal() +
  guides(color = "none")

#T-test
t.test(formula = bill_depth_mm ~ sex, data = adelie_bill_depth)
