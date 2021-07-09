library(tidytuesdayR)
library(tidyverse)
library(patchwork)
library(ggthemes)
library(data.table)

tuesdata <- tidytuesdayR::tt_load('2021-06-29')
ares <- tuesdata$animal_rescues

setDT(ares)

animals = c("Dog", "Cat")
ares[animal_group_parent %in% animals &
       property_category != "Boat" &
       cal_year != 2021,
     .(.N), 
     .(Animal = animal_group_parent, 
       cal_year, property_category)] %>% 
  ggplot(aes(cal_year, N, color = Animal)) + 
  geom_point() +
  geom_line(size = 1.5) +
  facet_wrap(~property_category, scales = "free_y") +
  labs(y = "Incidents",
       x = "Year",
       color = "Pet",
       title = "Cats or Dogs?  Residency Edition",
       subtitle = "Yearly rate of incidence at the property level",
       caption = Sys.Date()) +
  theme_dark() +
  scale_color_gdocs()

ggsave("tidytuesday_6.29.21.png", units = "px", height = 675, width = 1200, scale = 2)
