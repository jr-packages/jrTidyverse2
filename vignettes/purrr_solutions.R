## ----setup, include = FALSE----------------------------------------------
knitr::opts_chunk$set(echo = TRUE, collapse = TRUE, fig.keep = 'none')

## ---- message = FALSE, echo = TRUE---------------------------------------
library("tidyverse")

## ---- echo = TRUE--------------------------------------------------------
data(l, package = "jrTidyverse2")

## ------------------------------------------------------------------------
map_dbl(l, length)
map_dbl(l, min)
map_dbl(l, mean)
map_dbl(l, max)

## ------------------------------------------------------------------------
map_dbl(l, ~ length(.x))
map_dbl(l, ~ min(.x))
map_dbl(l, ~ mean(.x))
map_dbl(l, ~ max(.x))

## ---- echo = TRUE--------------------------------------------------------
data(happiness, package = "jrTidyverse2")

## ------------------------------------------------------------------------
str(happiness, max.level = 0) 
# 146 element in the list
str(happiness, max.level = 1, list.len = 3)
# Yes, recursive list
str(happiness, max.level =2, list.len = 3)
# Each element of the list is another list representing a country. 
# Each list contains elements representative of happiness information 
# on that country for three successive years. Therefore there is 
# 146 countries and 12 vectors of information on each.

## ------------------------------------------------------------------------
country_names = map_chr(happiness, "Country")

## ------------------------------------------------------------------------
names(happiness) = country_names

## ------------------------------------------------------------------------
UK_rank = happiness[["United Kingdom"]]$`Happiness Rank`
mean(UK_rank)

## ------------------------------------------------------------------------
mean_hap = happiness %>% 
  map_dbl(~ mean(.x[["Happiness Score"]]))
head(mean_hap)

## ------------------------------------------------------------------------
region = happiness %>% 
  map_chr("Region")

region_hap = data.frame(region = region, mean_hap = mean_hap) 

region_hap %>% 
  group_by(region) %>% 
  summarise(av_region_hap = mean(mean_hap)) %>% 
  arrange(av_region_hap)

## ------------------------------------------------------------------------
region_hap %>% 
  group_by(region) %>% 
  summarise(av_region_hap = mean(mean_hap)) %>% 
  arrange(av_region_hap) %>% 
  ggplot() + 
  geom_col(aes(x = region, y = av_region_hap)) + 
  coord_flip()

## ---- message = FALSE, echo = TRUE---------------------------------------
library("broom")
data(beer_tidy, package = "jrTidyverse2")

## ---- echo = TRUE--------------------------------------------------------
head(beer_tidy)

## ------------------------------------------------------------------------
beer_nest = beer_tidy %>% 
    nest(-Type) 

## ---- echo = TRUE--------------------------------------------------------
fit = lm(ABV ~ Color, data = beer_tidy)

## ------------------------------------------------------------------------
beer_nest = beer_nest %>% 
  mutate(fit = map(data, ~lm(ABV ~ Color, data = .x)))

## ------------------------------------------------------------------------
beer_nest = beer_nest %>% 
  mutate(tidyfit = map(fit, ~augment(.x)))

## ------------------------------------------------------------------------
beer_nest = beer_nest %>% 
  select(Type, tidyfit) %>% 
  unnest()

## ---- echo = TRUE--------------------------------------------------------
ggplot(beer_nest) + 
  geom_line(aes(x = Color, y = .fitted, colour = Type), size = 2) 

