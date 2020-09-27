require(tidytuesdayR)
require(data.table)
require(ggthemes)
require(dplyr)
require(ggpubr)
require(tidyverse)

#Read in the data
tuesdata <- tidytuesdayR::tt_load('2020-09-22')
exp <- tuesdata$expeditions %>% as.data.table()
myfont <- "Times New Roman"
death_rate <- exp[, .(members = sum(members), 
                      deaths = sum(member_deaths)), 
                  .(oxygen_used, trekking_agency)]
death_rate <- death_rate[, death_rate := ifelse(deaths/members < .01, "< 1%",
                                                ifelse(deaths/members < .10, "1% < 10%",
                                                       "10% <"))]
dr <- death_rate[, .N, .(oxygen_used, death_rate)] %>% 
  ggplot(aes(y = N, x = death_rate)) + coord_flip() +
  geom_bar(aes(fill = oxygen_used), position = "dodge", stat = "identity") +
  geom_text(aes(y = N, x = death_rate, label = N, group = oxygen_used), 
            position = position_dodge(width = 1), hjust = -.2, size = 3) +
  scale_y_continuous(limits = c(0, 670)) +
  theme_bw() + xlab(NULL) + ylab(NULL) + labs(title = "% Member Death Freq.") +
  theme(text = element_text(family = myfont),
        legend.position = c(.7, .6),
        axis.text.y = element_text(hjust = .5),
        axis.text.x = element_blank(),
        axis.ticks.x = element_blank()) +
  scale_fill_tableau(palette = "Tableau 10", type = "regular")

time_series <- exp[, .(members = sum(members), staff = sum(hired_staff)), year] %>% 
  ggplot() +
  geom_line(aes(x = year, y = members), color = "dodgerblue") +
  annotate("text", family = myfont, x = 1980, y = 1300, label = "members", color = "dodgerblue") +
  geom_line(aes(x = year, y = staff), color = "green4") +
  annotate("text", x = 2007, y = 500, label = "staff", color = "green4", family = myfont) +
  theme_bw() +
  labs(title = "Mountain Climbing Expeditions Over Time") +
  theme(text = element_text(family = myfont)) +
  xlab(NULL) + ylab(NULL)
death_ot <- exp[, .(deaths = sum(member_deaths)), year] %>% 
  ggplot(aes(x = year, y = deaths)) +
  scale_x_continuous(position = "top") +
  geom_line(color = "red3") + 
  theme_bw() + xlab(NULL) + ylab(NULL) +
  annotate("text", x = 1970, y = 20, label = "deaths", color = "red3", family = myfont) +
  theme(plot.margin = margin(t = -4, r = 5, b = 10, l = 14.5),
        axis.text.x = element_blank(),
        text = element_text(family = myfont))

ggarrange(time_series, death_ot, ncol = 1, nrow = 2, heights = c(4,1)) %>% 
  ggarrange(., dr, ncol = 2, nrow = 1, widths = c(2,1)) %>%  
  annotate_figure(bottom = text_grob(paste("@schill_josh -", Sys.Date(), "- #tidytuesday"),
                                     hjust = 1.2, x = 1, face = "italic", size = 10))

ggsave(width = 8, height = 4.5, units = "in", filename = "tidytuesday_climbing_expeditions_92720.png")
