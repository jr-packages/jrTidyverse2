## ----setup, include = FALSE----------------------------------------------
knitr::opts_chunk$set(collapse = TRUE, results = "hide", fig.keep = 'none')

## ------------------------------------------------------------------------
library("purrr")

## ------------------------------------------------------------------------
l = list(x = rnorm(10), y = rnorm(15), z = rnorm(20))

## ---- echo = FALSE-------------------------------------------------------
map_dbl(l, min)
map_dbl(l, mean)
map_dbl(l, max)

## ---- echo = FALSE-------------------------------------------------------
map_dbl(l, ~ min(.x))
map_dbl(l, ~ mean(.x))
map_dbl(l, ~ max(.x))

## ------------------------------------------------------------------------
data(happiness, package = "jrTidyverse2")

## ---- echo = FALSE-------------------------------------------------------
str(happiness, max.level = 0) 
# 146 element in the list
str(happiness, max.level = 1, list.len = 3)
# Yes, recursive list
str(happiness, max.level =2, list.len = 3)
# Each element of the list is another list representing a country. Each list contains elements representative of happiness information on that country for three successive years. Therefore there is 146 countries and 12 vectors of information on each.

## ---- echo = FALSE-------------------------------------------------------
country_names = map_chr(happiness, "Country")

## ---- echo = FALSE-------------------------------------------------------
names(happiness) = country_names

## ---- echo = FALSE-------------------------------------------------------
UK_rank = happiness[["United Kingdom"]]$`Happiness Rank`
mean(UK_rank)

## ---- echo = FALSE-------------------------------------------------------
mean_hap = happiness %>% 
  map_dbl(~ mean(.x[["Happiness Score"]]))
mean_hap

## ---- echo = FALSE, message = FALSE--------------------------------------
region = happiness %>% 
  map_chr("Region")

region_hap = data.frame(region = region, mean_hap = mean_hap) 

library("dplyr")
region_hap %>% 
  group_by(region) %>% 
  summarise(av_region_hap = mean(mean_hap)) %>% 
  arrange(av_region_hap)

## ---- message = FALSE----------------------------------------------------
library("tidyr")
library("broom")
data(beer_tidy, package = "jrTidyverse2")

## ------------------------------------------------------------------------
head(beer_tidy)

## ---- echo = FALSE-------------------------------------------------------
beer_nest = beer_tidy %>% 
    nest(-Type) 

## ------------------------------------------------------------------------
fit = lm(ABV ~ Color, data = beer_tidy)

## ---- echo = FALSE-------------------------------------------------------
beer_nest = beer_nest %>% 
  mutate(fit = map(data, ~lm(ABV ~ Color, data = .x)))

## ---- echo = FALSE-------------------------------------------------------
beer_nest = beer_nest %>% 
  mutate(tidyfit = map(fit, ~augment(.x)))

## ---- echo = FALSE-------------------------------------------------------
beer_nest = beer_nest %>% 
  select(Type, tidyfit) %>% 
  unnest()

## ------------------------------------------------------------------------
library("ggplot2")
ggplot(beer_nest) + 
  geom_line(aes(x = Color, y = .fitted, colour = Type), size = 2) 

