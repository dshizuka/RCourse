mean.custom=function(x) sum(x)/length(x)


vec=c(1:10, NA)
vec

mean.custom(vec)


mean.custom=function(x, remove.na) {
  if(remove.na==F) sum(x)/length(x)
  else sum(x[is.na(x)==F]/length(x[is.na(x)==F]))
}

mean.custom(vec, remove.na=T)
mean.custom(vec, remove.na=F)

mean.custom(vec)



if (NA%in%vec) print("there is an NA")


#what is the mean of 1:10?
answer=5.5
if (answer==mean(1:10)) print("you are correct")

answer=5
if (answer==mean(1:10)) print("you are correct")

answer=5.5
if (answer==mean(1:10)) print("you are correct") else print("you are incorrect")

answer=5
if (answer==mean(1:10)) print("you are correct") else print("you are incorrect")



###
average=function(x, type="arithmetic"){
  if(type=="arithmetic") sum(x)/length(x)
  else if (type=="geometric") prod(x)^(1/length(x))
  else "we can't handle that type of average"
}

average(1:10)
average(1:10, type="arithmetic")
average(1:10, type="geometric")
average(1:10, type="median")

exp(mean(log(1:10)))


average=function(x, type="arithmetic"){
  if(type=="arithmetic") sum(x)/length(x)
  else (type=="geometric") prod(x)^(1/length(x))
}


average=function(x, type="arithmetic"){
  if(type=="arithmetic") sum(x)/length(x)
  else if (type=="geometric") prod(x)^(1/length(x))
}


se=function(x) sqrt(var(x)/length(x))


se=function(x, na.rm=F) {
  if(na.rm==F) sqrt(var(x)/length(x))
  else if (na.rm==T) sqrt(var(x[is.na(x)==F])/length(x[is.na(x)==F]))
}