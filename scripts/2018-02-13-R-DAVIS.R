#Week 6 (do over)

library(tidyverse)

surveys_complete <- read_csv(data/surveys_complete.csv)

# First step is to load the packages that we need using the library() function
library(tidyverse)

# Next step is to get the surveys_complete data
surveys_complete <- read_csv("data/surveys_complete.csv")
glimpse(surveys_complete)

# Let's see what happens with the code given to us
ggplot(data = surveys_complete, aes(x = weight, y = hindfoot_length)) +
  geom_point()

# How would we make a scatterplot of weight versus species ID
# I accidentally made a misnamed variable so I remove it here using the rm() function.
rm(surveys_compete)

ggplot(data = surveys_complete, aes(x = species_id, y = weight)) +
  geom_point()

# We said this isn't a great way to display the data because it's ugly. And it is hard to *see* the data.

ggplot(data = surveys_complete, aes(x = species_id, y = weight)) +
  geom_boxplot()

# how might we order the box plots descending by weight?

ggplot(data = surveys_complete, aes(x = reorder(species_id, -weight), y = weight)) + geom_boxplot()

# how about ascending by weight?
ggplot(data = surveys_complete, aes(x = reorder(species_id, weight), y = weight)) + geom_boxplot()

# How can we make a horizontally oriented boxplot? Typically the y aesthetic is the continuous variable and the x has to be the categorical variable
ggplot(data = surveys_complete, aes(x = weight, y = species_id)) +
  geom_boxplot()

# Here we use an additional layer that "flips" the coordinates: coord_flip()
ggplot(data = surveys_complete, aes(x = reorder(species_id, weight), y = weight)) + geom_boxplot() +
  coord_flip()

# back to the original
ggplot(data = surveys_complete, aes(x = species_id, y = weight)) +
  geom_boxplot()

# Let's add the data back in
ggplot(data = surveys_complete, aes(x = species_id, y = weight)) +
  geom_boxplot() +
  geom_jitter(alpha = 0.3, color = "tomato")

# We lost the boxplots!
ggplot(data = surveys_complete, aes(x = species_id, y = weight)) +
  geom_jitter(alpha = 0.3, color = "tomato") +
  geom_boxplot()
# A challenge!
# geom_boxplot adds a boxplot, but hides the shape of the data. Try adding a violin geometry using the same data.

ggplot(data = surveys_complete, aes(x = species_id, y = weight)) +
  geom_violin()

# Modify the y-axis to be on the log10 scale 
ggplot(data = surveys_complete, aes(x = species_id, y = weight)) + geom_violin() + scale_y_log10()

# What if we want a custom scale? Like log to the base 2?

# Let's plot the nubmer of counts per year for each speceies.
# For each species/ year comination, count the number of observations.
yearly_counts <- surveys_complete %>%
  group_by(year, species_id) %>%
  tally()

yearly_counts

ggplot(data = yearly_counts, aes(x = year, y = n)) + geom_line()

# We want a separate line for each species
ggplot(data = yearly_counts, aes(x = year, y = n)) + geom_line(aes(group = species_id))

# let's use the color aesthetic instead of group

ggplot(data = yearly_counts, aes(x = year, y = n)) + geom_line(aes(color = species_id)) 

#Faceticing
# Multiple sub panels on a single plot. Use a factor as your data to facet on

ggplot(data = yearly_counts, aes(x = year, y = n)) + geom_line() + facet_wrap(~ species_id)

# let's just look at our fav 4 species
yearly_counts %>% 
  filter(species_id == "DM" | species_id == "DO" | species_id == "OT" | species_id == "RM") %>% 
  ggplot(aes(x = year, y = n)) +
  geom_line() +
  facet_wrap( ~ species_id)

yearly_sex_counts <- surveys_complete %>% 
  group_by(year, species_id, sex) %>% 
  tally()

yearly_sex_counts

ggplot(data = yearly_sex_counts, aes(x = year, y = n, color = sex)) +
  geom_line() +
  facet_wrap( ~ species_id)

# Modify the overall look of a plot using themes
ggplot(data = yearly_sex_counts, aes(x = year, y = n, color = sex)) +
  geom_line() +
  facet_wrap( ~ species_id) +
  theme_bw()

# How to save a plot
# by default, ggsave() will save the last plot that you created

ggsave(filename = "figures/my_plots.pdf")

my_plot <- ggplot(data = yearly_sex_counts, aes(x = year, y = n)) + geom_line(aes(color = species_id))

my_plot
glimpse(surveys_complete)

ggsave(filename = "figures/abundance_by_year_by_species.pdf", plot = my_plot)

# CHALLENGE
# Create a plot depicting the change in average weight for each species through time. Then save that plot in your figures/ folder.

# Hint: What do you need to do to the surveys_complete data frame to get the average weight per species per year?

# Hint: What function does the "per" in the above hint suggest you should use on the surveys_complete dataframe?

# Hint: To me, "per" suggests to use "group_by"

mn_wgt_surveys <- surveys_complete %>%
  group_by(species_id, year) %>%
  summarize(mn_wgt = mean(weight))

mn_wgt_figure <- ggplot(data = mn_wgt_surveys, aes(x = year, y= mn_wgt)) + geom_line(aes(color = species_id))

ggsave(filename = "figures/mn_wgt_figure.pdf", plot = mn_wgt_figure)

# Change the line thickness
mn_wgt_figure <- 
  ggplot(data = mn_wgt_surveys, aes(x = year, y = mn_wgt)) +
  geom_line(aes(color = species_id), size = 3)

(mn_wgt_figure <- 
    ggplot(data = mn_wgt_surveys, aes(x = year, y = mn_wgt)) +
    geom_line(aes(color = species_id)) +
    facet_grid(species_id ~ .))


# Week 6 Assignment -------------------------------------------------------


