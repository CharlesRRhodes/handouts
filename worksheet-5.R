## Getting started

library(dplyr)
library(ggplot2)
animals <- read.csv("data/animals.csv", na.strings = "") %>%
  filter(!is.na(species_id), !is.na(sex), !is.na(weight))

## Constructing layered graphics in ggplot

ggplot(data = animals,
       aes(x = species_id, y = weight)) +
  geom_point()

ggplot(data = animals,
       aes(x = species_id, y = weight)) + geom_boxplot()

ggplot(data = animals,
       aes(x = species_id, y = weight, ...)) +
  geom_boxplot() +
  geom_point(stat = 'summary',
             fun.y = 'mean',
             color = 'red')

ggplot(data = animals,
       aes(x = species_id, y = weight, color = species_id)) +
  geom_boxplot() +
  geom_point(stat = 'summary',
             fun.y = 'mean',
             color = 'red')

## Exercise 1
##my fail status:
#library(dplyr)
#library(ggplot2)
#animals <- read.csv("data/animals.csv", na.strings = "") %>%
 # filter(!is.na(species_id)=="DM", !is.na(sex), !is.na(weight), !is.na(year))
#ggplot(data = animals,
 #      aes(x = DM, y = weight, color_id = animals_sex)) +
#geom_line(fun.x(DM), color = 'red')

#their solution:
dm <- filter(animals, species_id == "DM")
ggplot(data = dm,
  aes(x=year, y=weight, color=sex)) +
  geom_line(stat="summary",
             fun.y="mean")

## Adding a regression line

levels(animals$sex) <- c('Female', 'Male')
animals_dm <- filter(animals, species_id=="DM")
ggplot(...,
       aes(x = year, y = weight)) +
  geom_point(...,
             size = 3,
             stat = 'summary',
             fun.y = 'mean') +
 animals_dm <- filter(animals, species_id == 'DM')

levels(animals$sex) <- c('Female', 'Male')
animals_dm <- filter(animals, species_id=="DM")
ggplot(data = animals_dm,
       aes(x = year, y = weight)) + 
  geom_point(aes(shape = sex),
             size = 3,
             stat = 'summary',
             fun.y = 'mean') +
  geom_smooth(aes(group=sex), method = 'lm')

ggplot(data = animals_dm,
       aes(x = year, y = weight, color = sex)) + 
  geom_point(aes(shape = sex),
             size = 3,
             stat = 'summary',
             fun.y = 'mean') +
  geom_smooth(method="lm")

ggplot(data = animals_dm,
       aes(...,
           ...,
           ...) + 
  geom_point(aes(shape = sex),
             size = 3,
	           stat = 'summary',
	           fun.y = 'mean') +
  geom_smooth(method = 'lm')

# Storing and re-plotting

year_wgt <- ggplot(data = animals_dm,
                   aes(x = year,
                       y = weight,
                       color = sex)) +
  geom_point(aes(shape = sex),
             size = 3,
             stat = 'summary',
             fun.y = 'mean') +
  geom_smooth(method = 'lm')

year_wgt +
  scale_color_manual(values=c("darkblue","orange"))
                     
year_wgt <- year_wgt +
  scale_color_manual(values=c("black","red"))
year_wgt

## Exercise 2
#data pre-filtered
ggplot(data = animals_dm,
       aes(x = weight, fill = sex)) + 
  geom_histogram(binwidth = 0.5)

## Axes, labels and themes

histo

histo <- histo +
  ...(title = 'Dipodomys merriami weight distribution',
       x = 'Weight (g)',
       y = 'Count') +
  scale_x_continuous(limits = c(20, 60),
                     breaks = c(20, 30, 40, 50, 60))
histo

histo2 <- histo +
  labs(title="Dipodomys merriami weight distibution",
            x="Weight (g)",
            y = "Count") +
scale_x_continuous(limits = c(20, 60),
                    breaks = c(20,30,40,50,60))
histo2

histo3 <- histo2 +
  theme_bw() +
  theme(legend.position = c(0.2, 0.5),
        plot.title = element_text("italics","bold", vjust=2),
        axis.title.y = element_text(size=13, "italics", vjust=1),
        axis.title.x = element_text(size=13, "italics", vjust=1))
histo3

## Facets

animals_common <- filter(animals, species_id %in% c('DM', 'DO', 'PP'))
  ggplot(data = animals_common,
    aes(x=weight)) +
  geom_histogram() +
  facet_wrap(~ species_id)
  labs(title = "Weight of most common species",
       x = "Count",
       y = "Weight (g)")

ggplot(data = animals_common,
       aes(x = weight)) +
  geom_histogram(...,
                 ...) +
  geom_histogram() +
  facet_wrap( ~ species_id) +
  labs(title = "Weight of most common species",
       x = "Count",
       y = "Weight (g)")

ggplot(data = animals_common,
       aes(x = weight, ...)) +
  geom_histogram(...) +
  facet_wrap( ~ species_id) +
  labs(title = "Weight of most common species",
       x = "Count",
       y = "Weight (g)") +
  guides(fill = FALSE)		

## Exercise 3

...

