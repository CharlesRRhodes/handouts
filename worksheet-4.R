## Tidy data concept

counts_df <- data.frame(
  day = c("Monday", "Tuesday", "Wednesday"),
  wolf = c(2, 1, 3),
  hare = c(4,4,4),
  fox = c(4,4,4)
)

## Reshaping multiple columns in category/value pairs
library(tidyr)
counts_gather <- gather(counts_df,
                        key = "species",
                        value = "count",
                        wolf:fox)

counts_spread <- spread(counts_gather,
                        key = species,
                        value = count)

## Exercise 1
counts_gather <- counts_gather[-8, ]
counts_spread <- spread(counts_gather,
                        key = species,
                        value = count)

#fail!: counts_gather <- gather(counts_spread, key = "species", value = "count", na.rm = TRUE)


## Read comma-separated-value (CSV) files

animals <- read.csv('data/animals.csv')
str(animals)
animals <- read.csv('data/animals.csv', na.strings = "")
str(animals)


library(dplyr)
library(RPostgreSQL)

con <- dbConnect(PostgreSQL(), host = 'localhost', dbname = 'portal')
animals_db <- tbl(con, 'animals')
animals <- collect(animals_db)
## good to disconnect after linking to a db!
dbDisconnect(con)

## Subsetting and sorting

library(dplyr)
animals_1990_winter <- filter(animals,
                              year == 1990,
                              month %in% 1:3)

animals_1990_winter <- select(animals_1990_winter, -year)

sorted <- arrange(animals_1990_winter, 
                  desc(species_id), weight)

## Exercise 2

...

## Grouping and aggregation

animals_1990_winter_gb <- group_by(animals_1990_winter, species_id)

counts_1990_winter <- summarize(animals_1990_winter_gb, count = n())

## Exercise 3

animals_avg_wtfoot <- filter(animals, species_id == "DM")
animals_avg_wtfoot <- group_by(animals_avg_wtfoot, month)
soutn3 <- summarize(animals_avg_wtfoot, avg_wt = mean(weight, na.rm =TRUE),
                    avg_hf = mean(hindfoot_length, na.rm = TRUE, count = n()))


## Pivot tables through aggregate and spread
#skipped in class
animals_1990_winter_gb <- group_by(animals_1990_winter, ...)
counts_by_month <- ...(animals_1990_winter_gb, ...)
pivot <- ...

## Transformation of variables

prop_1990_winter <- mutate(counts_1990_winter,
                           prop = count/sum(count))

#Exercise 4

...

## Chainning with pipes

prop_1990_winter_piped <- animals %>%
  filter(year == 1990, month %in% 1:3) %>%
    select (-year) %>% # group by species_id
    group_by(species_id) %>%
      summarize(count = n()) %>%  # summarize with counts
      mutate(prop = count / sum(count))  # mutate into proportions

