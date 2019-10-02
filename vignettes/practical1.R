## ----setup, include = FALSE----------------------------------------------
knitr::opts_chunk$set(echo = FALSE, collapse = TRUE, results = "hide", fig.keep = 'none')

## ---- message = FALSE, echo = TRUE---------------------------------------
library("tidyverse")

## ---- echo = TRUE--------------------------------------------------------
data(toy, package = "jrTidyverse2")

## ------------------------------------------------------------------------
length(toy)

## ------------------------------------------------------------------------
toy$z = "fun with lists"
# or
toy[["z"]] = "fun with lists"
# or
toy["z"] = "fun with lists"

## ------------------------------------------------------------------------
mean(toy$d)

## ------------------------------------------------------------------------
mean(toy$e$f)

## ---- message = FALSE----------------------------------------------------
toy$e %>% 
  filter(g == "a") %>% 
  summarise(mean(f))

## ---- echo = TRUE--------------------------------------------------------
x = c(1,4,9,25)
sqrt(x)

## ------------------------------------------------------------------------
map_dbl(x, sqrt)

## ---- echo = TRUE--------------------------------------------------------
data(happiness, package = "jrTidyverse2")

## ------------------------------------------------------------------------
str(happiness, max.level = 0) 
# 146 element in the list

## ------------------------------------------------------------------------
str(happiness, max.level = 1, list.len = 3)
# Yes, recursive list

## ------------------------------------------------------------------------
str(happiness, max.level =2, list.len = 3)
# Each element of the list is another list representing a country. 
# Each list contains elements representative of happiness information 
# on that country for three successive years. Therefore there is 
# 146 countries and 12 pieces of information on each.

## ------------------------------------------------------------------------
country_names = map_chr(happiness, "Country")

## ------------------------------------------------------------------------
names(happiness) = country_names

## ------------------------------------------------------------------------
happiness[["United Kingdom"]]$`Happiness Rank`

## ------------------------------------------------------------------------
happiness %>% 
  map_dbl(~ mean(.x[["Happiness Score"]])) %>% 
  sort(decreasing = TRUE) %>% 
  head()

## ------------------------------------------------------------------------
happiness %>%
  map_dbl( ~ .x$`Happiness Score`[3] - .x$`Happiness Score`[1]) %>%
  sort(decreasing = TRUE) %>%
  head()

## ------------------------------------------------------------------------
map_dbl(happiness, ~.x$`Health (Life Expectancy)`[3] - .x$`Health (Life Expectancy)`[1]) %>% 
  sort() %>% 
  head()

## ------------------------------------------------------------------------
map_lgl(happiness, ~(.x$`Economy (GDP per Capita)`[3] - .x$`Economy (GDP per Capita)`[1]) < 0) %>% 
  sum()

## ------------------------------------------------------------------------
region = happiness %>% 
  map_chr("Region")

av_gen = happiness %>% 
  map_dbl(~mean(.x$Generosity))

region_gen = tibble(region = region, av_gen = av_gen) 

region_gen %>% 
  group_by(region) %>% 
  summarise(av_region_gen = mean(av_gen)) %>% 
  arrange(av_region_gen)

## ------------------------------------------------------------------------
region_gen %>% 
  group_by(region) %>% 
  summarise(av_region_gen = mean(av_gen)) %>% 
  arrange(av_region_gen)%>% 
  ggplot() + 
  geom_col(aes(x = region, y = av_region_gen)) + 
  coord_flip()

