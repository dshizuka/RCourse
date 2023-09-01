##Tidy Tuesday exercise, week 50 (12/03/2019)

library(tidyverse)
library(ggmap)
library(lubridate)
library(gganimate)

tickets <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-12-03/tickets.csv")

tickets
unique(tickets$violation_desc)
dbpk=tickets %>% filter(violation_desc=="DOUBLE PARKED") %>% mutate(hour=hour(issue_datetime)) %>% mutate(month=month(issue_datetime)) %>% mutate(hour3=as.numeric(cut(hour, 8))) %>% mutate(hour3.label=c("0:00-2:59", "3:00-5:59", "6:00-8:59", "9:00-11:59", "12:00-14:59", "15:00-17:59", "18:00-20:59", "21:00-23:59")[hour3])

dbpk$hour3.label=factor(dbpk$hour3.label, levels=c("0:00-2:59", "3:00-5:59", "6:00-8:59", "9:00-11:59", "12:00-14:59", "15:00-17:59", "18:00-20:59", "21:00-23:59"))

#plot(dbpk$lon, dbpk$lat, pch=19, col=gray(0.5, 0.3), las=1)

qmplot(lon, lat, data = dbpk, maptype = "toner-background", color = I(rgb(1,0,0,0.3))) +
  facet_wrap(~hour3.label)

#qmplot(lon, lat, data = dbpk, maptype = "toner-background", color = I(rgb(1,0,0,0.3))) + facet_wrap(~hour3, labeller=labeller(hour3=hour3.label))

hist(dbpk$hour, col="gray", breaks=24, xlab="Hour", main="Double-parking tickets")

