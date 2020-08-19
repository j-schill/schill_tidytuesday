require(tidytuesdayR)
require(magrittr)
require(data.table)
require(ggplot2)
require(ggthemes)
require(dplyr)
require(ggpubr)

#Read in the data
tuesdata <- tidytuesdayR::tt_load('2020-08-18')
tuesdata <- tidytuesdayR::tt_load(2020, week = 34)
plants <- tuesdata$plants

#Turn my set into a data.table
plants <- plants %>% as.data.table()


#threats vs. actions slide

#sum the threats and the actions
grouped <- plants[, 
                  j= .("Threats" = sum(threat_AA, threat_BRU, threat_RCD, threat_EPM, threat_CC, threat_HID, threat_P, threat_TS, threat_NSM, threat_GE, threat_NA), 
                       "Actions" = sum(action_LWP, action_SM, action_LP, action_RM, action_EA, action_NA)), 
                  keyby = .(binomial_name, country, continent, group, year_last_seen)]



tidytues1 <- grouped[!is.na(year_last_seen)] %>% 
  ggplot(aes(x = factor(year_last_seen, levels = c("Before 1900",
                                                   "1900-1919",
                                                   "1920-1939",
                                                   "1940-1959",
                                                   "1960-1979",
                                                   "1980-1999",
                                                   "2000-2020")))) +
  geom_col(aes(y = Actions), fill = "seagreen2") +
  geom_col(aes(y = -Threats), fill = "orangered2") +
  geom_line(aes(x = year_last_seen, y = uniqueN(continent))) +
  theme_few()+
  theme(axis.text.x = element_text(angle = 90)) +
  facet_grid(cols = vars(continent),drop = FALSE, scales = "free") +
  xlab(NULL) +
  ylab("Threats vs. Actions")


#plot 2
tidytues2 <- grouped[!is.na(year_last_seen), uniqueN(binomial_name), keyby = .(continent, year_last_seen)] %>% 
  ggplot(aes(x = factor(year_last_seen, levels = c("Before 1900",
                                                   "1900-1919",
                                                   "1920-1939",
                                                   "1940-1959",
                                                   "1960-1979",
                                                   "1980-1999",
                                                   "2000-2020")), 
             y = V1, 
             group = continent, 
             color = continent)) +
  geom_line() +
  geom_point() +
  scale_y_continuous(trans = "log", breaks = c(1, 2, 10, 25, 55)) +
  xlab(NULL) +
  ylab("Number of Extinct Plants") +
  labs(title = "Timeline of Extinct Plants by Continent")


#combine into final plot
multi.page <- ggarrange(tidytues2, tidytues1,
                        nrow = 2, ncol = 1)
