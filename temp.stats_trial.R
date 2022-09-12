library(ggplot2)
library(tidyverse)

mtcars


lm.fit=summary(lm(mpg~hp, mtcars))


glm.fit=summary(glm(mpg~hp, mtcars, family="gaussian"))

str(lm.fit)
str(glm.fit)

ggplot(mtcars, aes(x=hp, y=mpg)) +
  geom_point() +
  geom_smooth(method="lm")

#Linear Models + GLM

mpg

lm.fit=lm(hwy~displ, data=mpg)
summary(lm.fit)

glm.fit=glm(hwy~displ, data=mpg, family="gaussian")
summary(glm.fit)

lm.fit=lm(hwy~displ + drv, data=mpg, family="gaussian")
summary(lm.fit)
anova(lm.fit)

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point() +
  geom_smooth(method="lm", aes(x = displ, y = hwy), se=F, color="black")

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point() +
  geom_smooth(method="lm", aes(x = displ, y = hwy), se=T, color="black")

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point(mapping = aes(color = drv)) +
  geom_smooth(method="lm", aes(x = displ, y = hwy, color=drv), se=T) +
  xlab("Engine Displacement (volume)") +
  ylab("Highway miles per gallon")


snails

prop.fit=glm(cbind(Deaths, N)~Temp+Rel.Hum, data=snails, family="binomial")
summary(prop.fit)

ggplot(snails) +
  geom_point(aes(x=Rel.Hum, Deaths/N, color=Temp))


msleep
newdat=msleep %>% mutate(rem_yn=is.na(sleep_rem)==F) %>% mutate(rel.brain=brainwt/bodywt)
table(newdat$order, newdat$rem_yn)


summary(glm(rem_yn~rel.brain, data=newdat))

ggplot(newdat, aes(x=log(brainwt/bodywt), y=rem_yn+0))+
  geom_point() +
  geom_smooth(method="glm", method.args = list(family = "binomial"))

diamonds$expensive=diamonds$price >= 10000
diamonds
table(diamonds$expensive)

glm.fit=glm(expensive~carat, data=diamonds)
summary(glm.fit)
ggplot(diamonds, aes(x=carat, y=expensive+0))+
  geom_point() +
  geom_smooth(method="glm", method.args = list(family = "binomial"))

