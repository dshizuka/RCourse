library(tmap)

?tm_shape

tm_shape(World, crs="auto") +
  tm_polygons()

##info on CRS system
#https://r-tmap.github.io/tmap/articles/foundations_crs

tm_shape(World, crs="+proj=laea") +
  tm_polygons()

tm_shape(World, crs="+proj=laea", bbox="FULL") +
  tm_polygons() +
  tm_style("natural") +
  tm_graticules(n.x=10, n.y=10)

tm_shape(World, crs="+proj=aeqd", bbox="FULL") +
  tm_polygons() +
  tm_style("natural") +
  tm_graticules(n.x=10, n.y=10)

#EPSG:4326 - WGS 84 datum ensemble for 2D (latitude, longitude) coordinates with 2 meter accuracy, used by the Global Positioning System among others.
#EPSG:3857 - Web Mercator projection of WGS 84, used for display by many web-based mapping tools, including Google Maps and OpenStreetMap.
#EPSG:9989 - International Terrestrial Reference Frame 2020 (ITRF2020) for 3D coordinates (latitude, longitude, ellipsoidal height) with subcentimeter accuracy, used for monitoring continental drift among others.[4]

tm_shape(World, crs=4326) +
  tm_polygons() +
  tm_style("natural")

tm_shape(World, crs=3857) +
  tm_polygons() +
  tm_style("natural")

tm_shape(World, crs=9989) +
  tm_polygons() +
  tm_style("natural")


### just in ggplot

library(tidyverse)
library(maps)
library(mapproj)

#import map data
?map_data
world=map_data("world")

worldmap=ggplot(world, aes(long, lat))+
  geom_polygon(aes(group=group),fill="white", color="black", linewidth=0.1)
worldmap

worldmap + coord_map(projection="mercator")
worldmap + coord_map(projection="azequalarea")
worldmap + coord_map(projection="gilbert")

unique(world$region)


us=map_data("state")
us
usmap=ggplot(us, aes(long, lat))+
  geom_polygon(aes(group=group), fill="white", color="black", linewidth=0.1)
usmap
usmap + coord_map(projection="mercator")
usmap + coord_map(projection="azequalarea")

nemap=ggplot(us %>% filter(region=="nebraska"), aes(long, lat))+
  geom_polygon(aes(group=group), fill="white", color="black", linewidth=0.1)
nemap

ne_county=map_data("county")
nemap=ggplot(ne_county %>% filter(region=="nebraska"), aes(long, lat))+
  geom_polygon(aes(group=group), fill="white", color="black", linewidth=0.1)
nemap

####
#sf

#download shapefile and use it.
library(sf)

#e.g., I downloaded US county data from US census bureau: https://www.census.gov/geographies/mapping-files/time-series/geo/carto-boundary-file.html

us_shp=st_read("data/cb_2018_us_county_20m/cb_2018_us_county_20m.shp")

ggplot() +
  geom_sf(data=us_shp, fill="goldenrod") +
  coord_sf(xlim=c(-180,-50)) +
  theme_bw()

co_data=read.csv("data/co-est2024-alldata.csv")
head(co_data)

us_shp %>% filter(STATEFP==1)

#downloaded NE counties data from https://www.nebraskamap.gov/datasets/county-boundaries-2/explore
ne=st_read("data/NE_County_Boundaries/County_Boundaries.shp")

ne_data=co_data %>% filter(STNAME=="Nebraska")

ne_full2024=ne %>% mutate(CountyFIPS=as.numeric(CountyFIPS)) %>% left_join(co_data %>% filter(STNAME=="Nebraska"), by=join_by("CountyFIPS"=="COUNTY"))

ggplot() +
  geom_sf(data=ne_full2024, aes(fill=POPESTIMATE2024)) +
  theme_bw()

ggplot() +
  geom_sf(data=ne_full2024, aes(fill=RBIRTH2024)) +
  theme_bw()

unl=data.frame(long=693904.69351446, lat=4521004.547643)

ggplot() +
  geom_sf(data=ne_full2024, aes(fill=NPOPCHG2024)) +
  theme_bw() +
  geom_point(data=unl, aes(x=long, y=lat))

##
library(tigris)
