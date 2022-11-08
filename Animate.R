library(gganimate)
library(tidyverse)



#Cumulative sum using cumsum()

n=10000
x=cumsum(sample(c(-1,0,1),n,TRUE))
y=cumsum(sample(c(-1,0,1),n,TRUE))

move.dat=data.frame(x=x, y=y, time=1:n)

plot(move.dat$x, move.dat$y, type="l")

ggplot(move.dat, aes(x=x, y=y)) +
  geom_path()

ggplot(move.dat, aes(x=x, y=y)) +
  geom_point()

ggplot(move.dat, aes(x=x, y=y)) +
  geom_point() +
  transition_reveal(time)

ggplot(move.dat, aes(x=x, y=y)) +
  geom_point() +
  geom_path() +
  transition_reveal(time)

## Let's animate the flight of pigeons from Flack paper!

all.files.R1=list.files(list.files("data/Flack et al_Biology Letters/R1/", full.name=T), full.name=T)

all.R1=lapply(all.files.R1, function(x) read.csv(x))

ggplot(all.R1[[1]] %>% mutate(time=1:nrow(.)) %>% filter(time<1000), aes(x=Longitude, y=Latitude)) +
  geom_point() +
  geom_path() +
  transition_reveal(as.numeric(time))
####
all.filenames=list.files(list.files("data/Flack et al_Biology Letters/R1", full.names=T))

#use "substr()" to get the first letter of the filename
group=substr(all.filenames, 1,1)
id=substr(all.filenames, 3,5)
route=substr(all.filenames, 7,8)
trial=substr(all.filenames, 10,11)

metadata=data.frame(group=group, id=id, route=route, trial=trial)
metadata


for(i in 1:length(all.R1)){
  all.R1[[i]]$id=metadata$id[i]
  all.R1[[i]]$trial=metadata$trial[i]
  all.R1[[i]]$time=1:nrow(all.R1[[i]])
}

A35_alltrials=bind_rows(all.R1[1:6])

ggplot(A35_alltrials %>% filter(time<2000), aes(x=Longitude, y=Latitude, group=trial, color=as.numeric(trial))) +
  geom_point() +
  geom_path() +
  scale_color_gradient(low="yellow", high="red") +
  transition_reveal(as.numeric(time)) +
  theme_bw()
