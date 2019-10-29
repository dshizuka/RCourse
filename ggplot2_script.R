library(ggplot2)
library(tidyverse)

iris

colorset=rainbow(3) #create a palette of 3 colors
pt.cols=colorset[as.numeric(iris$Species)] #This is now a vector of colors for each point

plot(Sepal.Width~Sepal.Length, data=iris, xlab="Sepal Length", ylab="Sepal Width", las=1, pch=19, col=pt.cols)

###with ggplot

#step 1
p = ggplot(data=iris, mapping=aes(x=Sepal.Length, y=Sepal.Width))
p

#step 2
p = ggplot(iris, aes(x=Sepal.Length, y=Sepal.Width)) +
  geom_point()
p

# step 3
p = ggplot(iris, aes(x=Sepal.Length, y=Sepal.Width, color=Species)) +
  geom_point(size=2)
p

# step 3 - alternative
p = ggplot(iris, aes(x=Sepal.Length, y=Sepal.Width)) +
  geom_point(aes(color=Species), size=2)
p

#step 4: labels
ggplot(iris, aes(x=Sepal.Length, y=Sepal.Width)) +
  geom_point(aes(col=Species), size=2) +
  labs(x="Sepal Length (cm)", y="Sepal Width (cm)")


ggplot(iris, aes(x= Species, y=Sepal.Width)) +
  geom_boxplot()


ggplot(iris, aes(x= Species, y=Sepal.Width, fill=Species)) +
  geom_bar(stat="summary", fun.y="mean")



ggplot(iris, aes(x= Species, y=Sepal.Width, fill=Species)) +
  geom_bar(stat="summary", fun.y="mean")

se=function(x) sqrt(var(x)/length(x))
ymax=function(x) mean(x) + se(x)
ymin=function(x) mean(x) - se(x)
ggplot(iris, aes(x= Species, y=Sepal.Width)) +
  stat_summary(fun.y= mean, fun.ymin = ymin, fun.ymax=ymax)


####


ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point(mapping = aes(color = class))

ggplot(data = filter(mpg, class!="2seater"), mapping = aes(x = displ, y = hwy)) +
  geom_point(mapping = aes(color = class))

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point(mapping = aes(color = class)) +
  geom_smooth(method="lm", color="black")

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point(mapping = aes(color = class)) +
  geom_smooth(method="lm", aes(x = displ, y = hwy, col=class), se=F)

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point(mapping = aes(color = class)) +
  geom_smooth(method="lm", aes(x = displ, y = hwy, col=class), se=F) +
  labs(x="Enging Displacement", y="Highway Miles Per Gallon")

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point(mapping = aes(color = class)) +
  geom_smooth(method="loess", se=T) +
  labs(x="Engine Displacement", y="Highway Miles Per Gallon")

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point(mapping = aes(color = drv)) +
  geom_smooth(method="lm", aes(x = displ, y = hwy, col=drv), se=F)+
  labs(x="Engine Displacement", y="Highway Miles Per Gallon")
