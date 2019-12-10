library(tidyverse)
library(ggmap)
library(lubridate)
library(gganimate)

tickets <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-12-03/tickets.csv")

tickets
unique(tickets$violation_desc)
dbpk=tickets %>% filter(violation_desc=="DOUBLE PARKED") %>% mutate(hour=hour(issue_datetime)) %>% mutate(month=month(issue_datetime))


plot(dbpk$lon, dbpk$lat, pch=19, col=gray(0.5, 0.3), las=1)

qmplot(lon, lat, data = dbpk, maptype = "toner-background", color = hour) +
  facet_wrap(~hour)

hist(dbpk$hour, col="gray", breaks=24)
hist(dbpk$month, col="tomato", breaks=12)

stcl=tickets %>% filter(violation_desc=="STREET CLEANING") %>% mutate(hour=hour(issue_datetime)) %>% mutate(month=month(issue_datetime))
hist(stcl$hour, col="gray", breaks=24)
hist(stcl$month, col="tomato", breaks=12)

qmplot(lon, lat, data = stcl, maptype = "toner-background", color = "tomato") +
  facet_wrap(~hour)
