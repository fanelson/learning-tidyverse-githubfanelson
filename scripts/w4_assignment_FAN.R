
# Using the dplyr verbs ---------------------------------------------------

#import the dataset called "gapminder"
library(gapminder)
install.packages('gapminder')
library(tidyverse)
gapminder <- read_csv("https://gge-ucd.github.io/R-DAVIS/data/gapminder.csv")

glimpse(gapminder)

# REORDER CODE ------------------------------------------------------------

# Create a new dataframe called dollar_per_day_GDP
dollar_per_day_GDP <- gapminder %>% 
  mutate(dailyGDP = gdpPercap / 365) %>%
  filter(dailyGDP < 1) %>%
  select(country, year, gdpPercap) %>%
  arrange(year)
dollar_per_day_GDP

print(gapminder, n=30)

# just a quick way t ocheck and see how many records per conutry and year
gapminder %>%
  group_by(country, year) %>%
  tally() %>%
  arrange(desc(n))

# add total GDP per year
gdp_yr <- gapminder %>%
  mutate(yrGDP = pop*gdpPercap)
gdp_yr

