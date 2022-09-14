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
