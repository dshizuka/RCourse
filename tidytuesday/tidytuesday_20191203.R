library(tidyverse)
library(ggmap)

tickets <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-12-03/tickets.csv")

tickets

dbpk=tickets %>% filter(violation_desc=="DOUBLE PARKED")

plot(dbpk$lon, dbpk$lat, pch=19, col=gray(0.5, 0.3), las=1)



qmplot(lon, lat, data = dbpk, maptype = "toner-lite", color = "tomato")
