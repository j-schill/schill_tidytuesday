library(tidytuesdayR)
library(tidyverse)
library(hrbrthemes)
library(viridis)

date <- '2021-08-10'
#load in data
tuesdata <- tidytuesdayR::tt_load(date)

investment <- tuesdata$investment


inf <- investment %>% 
  filter(meta_cat == "Total infrastructure") %>% 
  group_by(year, 
           category) %>% 
             summarize(gross_inv = sum(gross_inv)) %>% 
  mutate(category2 = category)

inf %>% 
  ggplot(aes(year, gross_inv)) + 
  geom_line(data = select(inf, -category), 
            aes(group = category2),
            color="grey", size=0.5, alpha=0.5) +
  geom_line(color = "green4", size = 1.2) +
  facet_wrap(~category) +
  theme_ipsum() +
  theme(
    legend.position="none",
    plot.title = element_text(size=14),
    panel.grid = element_blank()
  ) +
  scale_y_continuous(breaks = seq(0, 600000, 200000)) +
  theme(text = element_text(family = "georgia"),
        legend.position = "none",
        plot.background = element_rect(fill = "white"),
        axis.text.y = element_text()) +
  labs(caption = "@schill_josh - #tidytuesday",
       title = "Breakdown of Gross Investment Total Infrustructure Spend Over Time",
       y = "Millions of USD ($)",
       x = NULL)

setwd("C:/Users/joshs/iCloudDrive/R Practice/tidytuesday")

ggsave(paste0("tidytuesday_", date, ".png"), 
       units = "px",
       width = 1200,
       height = 675,
       scale = 2)
