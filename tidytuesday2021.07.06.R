library(tidytuesdayR)
library(tidyverse)
library(patchwork)
library(ggthemes)
library(data.table)


#load in data
tuesdata <- tidytuesdayR::tt_load('2021-07-06')

hol = as.data.table(tuesdata$holidays)

#organize data and calculate number of lost colonies
csum = hol[!is.na(independence_from), 
           .N, 
           by = .(independence_from, year)]

setorder(csum, independence_from, year)

#calculate cumulative sum over time
csum = csum[, 
     cumulative := cumsum(N), 
     independence_from][]


setorder(csum, independence_from, year)

#if a country lost 6 or less countries, remove it
rel = csum[cumulative >= 7, unique(independence_from)]

csum = csum[independence_from %in% rel,]

csum[, 
     max := max(cumulative) == cumulative, 
     by = independence_from]

#output plot

csum %>% 
  ggplot(aes(year, cumulative, color = ifelse(csum$independence_from == "United Kingdom", 
                                              "UK", 
                                              "Other"))) +
  geom_line(aes(group = independence_from), size = 2) +
  geom_text(aes(label = ifelse(csum$max == FALSE | 
                                 !(csum$independence_from %in% rel), 
                               "", 
                               csum$independence_from)),
            size =5,
            vjust = -.3, hjust = .3) +
  theme_base() +
  theme(legend.position = "none") +
  coord_cartesian(xlim = c(1800, max(csum$year, na.rm = T)+10),
                  ylim = c(1, max(csum$cumulative)+1)) +
  scale_color_manual(values = c("gray60", "orange2"), aesthetics = c("color")) +
  labs(x=NULL,
       y="Colonies Lost",
       title = "The U.K. lost its colonial grip in the 20th century",
       caption = "source: tidytuesdayR::tt_load('2021-07-06')")

setwd("C:/Users/joshs/iCloudDrive/R Practice/tidytuesday")

ggsave("tidytuesday_07.11.21.png", units = "px", height = 675, width = 1200, scale = 2)
