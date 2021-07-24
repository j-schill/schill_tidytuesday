extrafont::loadfonts(device="win")
library(tidytuesdayR)
library(tidyverse)
library(patchwork)
library(ggthemes)
library(data.table)

date <- '2021-07-20'
#load in data
tuesdata <- tidytuesdayR::tt_load(date)

drt <- tuesdata$drought

setDT(drt)

wisc <- drt[state_abb == "WI",]
wisc[, map_date := as.Date(as.character(map_date), format = "%Y%m%d")]
wisc[, drought_lvl := factor(drought_lvl,
                             levels = c("None","D0","D1","D2","D3","D4"),
                             labels = c("No Drought",
                                        "Abnormally Dry",
                                        "Moderate Drought",
                                        "Severe Drought",
                                        "Extreme Drought",
                                        "Exceptional Drought"))]

wisc %>% 
  ggplot(aes(map_date, area_pct/100)) +
  geom_area(aes(group = drought_lvl, 
                fill = drought_lvl)) +
  scale_fill_brewer(type = "seq",
                    palette = 7,
                    direction = 1,
                    aesthetics = "fill") +
  theme_void() +
  theme(legend.title = element_blank(),
        plot.title = element_text(hjust = .5),
        legend.position= c(.5, -.15), 
        plot.margin = margin(0,0,15,0, "mm"), #trbl
        legend.direction = "horizontal",
        axis.text.x = element_text(vjust = 4),
        axis.text.y = element_text(color = "orange",
                                   face = "bold",
                                   hjust = .5,
                                   margin = margin(1,-.5,1,0,"cm")),
        # axis.ticks.y.left = element_line(),
        # axis.ticks.length.y.left = unit(5, "mm"),
        aspect.ratio = 9/25) +
  scale_x_date(date_breaks = "4 years",
               date_labels = "%Y") +
  scale_y_continuous(labels = scales::percent,
                     breaks = c(0, .5, 1)) +
  labs(title = "Wisconsin Drought % Land Coverage 2001 - 2021")

 setwd("C:/Users/joshs/iCloudDrive/R Practice/tidytuesday")

ggsave(paste0("tidytuesday_", date, ".jpeg"), 
       units = "px",
       scale = 1)
