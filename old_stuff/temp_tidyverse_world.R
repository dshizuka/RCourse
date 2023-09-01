install.packages("WDI")
library(WDI)

WDIsearch("mortality")
mort.rate_indicator=WDIsearch("mortality")[4,1]

WDIsearch("GDP")

gdp.capita_indicator=WDIsearch("GDP")[473,1]

mort.rate=WDI(indicator=mort.rate_indicator, start=1990, end=2020)
head(mort.rate)

gdp.capita=WDI(indicator=gdp.capita_indicator, start=1990, end=2020)
gdp.capita

dat=WDI(indicator=c("gdp.capita"=gdp.capita_indicator, "mort.rate"=mort.rate_indicator), start=1990, end=2020)
head(dat)

library(help="WDI")
unique(dat$iso2c)

library(countrycode)
d=codelist %>% select(country.name.en, iso2c)
as.data.frame(d)

match(dat$iso2c, codelist$iso2c)

library(tidyverse)

world_bank_pop
unique(world_bank_pop$country)

?countrycode
cnames=countrycode(unique(world_bank_pop$country), origin='iso3c', destination='country.name')
length(which(is.na(cnames)==F))


countries_list=codelist %>% select(country.name.en, iso2c, iso3c)
countries_list

df=inner_join(world_bank_pop, countries_list, by=c("country"="iso3c"))
nrow(df)
length(unique(df$country))
nrow(world_bank_pop)


wb_countries()
