library(tidyverse)
library(lubridate)
CO2
co2

plot(co2, type="l")
as.data.frame(co2)
co2 %>% pivot_longer()
str(co2)
names(co2)
rownames(co2)
?ts
summary(co2)
co2
?co2

years=1959:1997
months=1:12
co2.dat=data.frame(expand.grid(months, years), as.numeric(co2))
names(co2.dat)=c("month", "year", "value")

co2.annual=co2.dat %>% group_by(year) %>% summarise(year.mean=mean(value))

ggplot(co2.annual, aes(x=year, y=year.mean))+ geom_line() + geom_point()

co2.boot=co2.dat %>% group_by(year) %>%
  summarise(mean.boot=mean(sample(value, 12, replace=T)))

ggplot(co2.boot, aes(x=year, y=mean.boot))+ geom_line() + geom_point()

lm.fit=(lm(year.mean~year, data=co2.annual))
summary(lm.fit)
obs.slope=summary(lm.fit)$coefficients[2,1]

co2.boot=co2.dat %>% group_by(year) %>%
  summarise(mean.boot=mean(sample(value, 12, replace=T)))

ggplot(co2.boot, aes(x=year, y=mean.boot))+ geom_line() + geom_point()

times=1000
boot.fits=list()
for(i in 1:times){
  co2.boot=co2.dat %>% group_by(year) %>%
    summarise(mean.boot=mean(sample(value, 12, replace=T)))
  boot.fits[[i]]=lm(mean.boot~year, data=co2.boot)
}

boot.slopes=sapply(boot.fits, function(x) summary(x)$coefficients[2,1])

hist(boot.slopes)
ci.slopes.boot=quantile(boot.slopes, probs=c(0.025, 0.975))
ci.slopes.boot

times=1000
jk.fits=list()
for(i in 1:times){
  co2.jk=co2.dat %>% group_by(year) %>%
    summarise(mean.jk=mean(sample(value, 6, replace=F)))
  jk.fits[[i]]=lm(mean.jk~year, data=co2.jk)
}

jk.slopes=sapply(jk.fits, function(x) summary(x)$coefficients[2,1])

hist(jk.slopes)
ci.slopes.jk=quantile(jk.slopes, probs=c(0.025, 0.975))
ci.slopes.jk

data()

trees
