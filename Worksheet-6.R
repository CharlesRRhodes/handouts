## lm
#get data
animals <- read.csv('data/animals.csv', stringsAsFactors = FALSE, na.strings = '')
fit <- lm(
  log(weight)~hindfoot_length,
  data = animals)

##exercise
#fit2 <-lm(
#  log(hindfoot_length ~ weight + species_id, 
 #     data=animals)
#)
library(dplyr)
# unnecessary animals_dm <- filter(animals, species_id == 'DM')
fit2 <-lm(
  hindfoot_length ~ weight + species_id, 
      data=animals
  )

fit3 <-lm(
  hindfoot_length ~ weight * species_id, 
  data=animals
)

fit4 <-lm(
  log(weight) ~ species_id, 
  data=animals
)
#Exercise 2
fit5 <-glm(
  log(weight) ~ species_id, 
  data=animals
)

fit6 <- lm(log(weight) ~ species_id,
          data = animals
          )
fit7 <- glm(log(weight) ~ species_id,
            data = animals
          )

#logit is glm with binomial distribution
## glm
#need to specify family bc not using default, no need quote in "binomial" bc it is
#in there
animals$sex <- factor(animals$sex)
fit8 <- glm(sex ~ hindfoot_length,
           family = binomial, 
           data = animals)

#add-on package for linear mixed models -- 
## lme4

# install.packages('lme4') !!

# next not yet run
library(lme4)
fit8a <- lmer(log(weight) ~ (1 | species_id) + hindfoot_length,
            data = animals)

fit <- lmer(...,
            data = animals)
#Excercise 4
fit9 <- lmer(log(weight) ~ (1 | sex) + hindfoot_length,
  data = animals)

## RStan

library(dplyr)
library(rstan)
stanimals <- animals %>%
  select(weight, species_id, hindfoot_length) %>%
  na.omit() %>%
  mutate(log_weight = log(weight),
         species_idx = as.integer(factor(species_id))) %>%
  select(-weight, -species_id)
stanimals <- c(
  N = nrow(stanimals),
  M = max(stanimals$species_idx),
  as.list(stanimals))

samp <- stan(file = 'worksheet-6.stan',
             data = stanimals,
             iter = 1000, chains = 3)
saveRDS(samp, 'stanimals.RDS')