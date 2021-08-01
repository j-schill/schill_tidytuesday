library(tidytuesdayR)
library(tidyverse)
library(patchwork)
library(ggthemes)
library(forcats)

date <- '2021-07-27'
#load in data
tuesdata <- tidytuesdayR::tt_load(date)

olmps <- tuesdata$olympics
#the marathon

mar <- olmps %>% filter(event == "Athletics Men's Marathon")

cols <- c("Gold" = "gold", "Silver" = "lightsteelblue", "Bronze" = "chocolate")

mar %>% 
  mutate(medal = fct_reorder(medal, desc(medal))) %>%
  ggplot(aes(height, weight)) + 
  geom_tile(aes(fill = medal),
              alpha = ifelse(is.na(mar$medal), 
                             .3,
                             1)) +
  scale_fill_manual(values = cols) +
  geom_segment(aes(x = 160, xend = 167,
                   y = 80, yend = 57),
               arrow = arrow(type = "closed", 
                             angle = 15), 
               size = .3) + #kipchoge
  geom_segment(aes(x = 190, xend = 181,
                   y = 50, yend = 61),
               arrow = arrow(type = "closed", 
                             angle = 15), 
               size = .3) + #rupp
  annotate("text", 160, 80, 
           label = "Eliud Kipchoge", vjust = -.5, 
           family = "georgia") +
  annotate("text", 190, 50, 
           label = "Galen Rupp", vjust =1,
           family = "georgia") +
  theme_fivethirtyeight() +
  theme(text = element_text(family = "georgia"),
        axis.text.y = element_text()) +
  coord_cartesian(ylim = c(40, 85)) +
  labs(title = "Weights (kg) and Heights (cm) of \nOlympic Marathon Athletes 1896 - 2016", 
       fill = "Medal", 
       caption = "@schill_josh - #tidytuesday")



setwd("C:/Users/joshs/iCloudDrive/R Practice/tidytuesday")

ggsave(paste0("tidytuesday_", date, ".jpeg"), 
       units = "px",
       scale = 1)
