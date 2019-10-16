## ----setup, include = FALSE----------------------------------------------
knitr::opts_chunk$set(echo = TRUE, collapse = TRUE, fig.keep = 'none')

## ---- message = FALSE, echo = TRUE---------------------------------------
library("tidyverse")

## ---- echo = TRUE--------------------------------------------------------
data(cocktails, package = "jrTidyverse2")

## ------------------------------------------------------------------------
str(cocktails)

## ------------------------------------------------------------------------
drinks = tibble(cocktail = names(cocktails),
                ingredients = cocktails)

## ------------------------------------------------------------------------
drinks = drinks %>% 
  mutate(total_ingredients = map(ingredients, length))

## ------------------------------------------------------------------------
drinks %>%
  mutate(contains_rum = map_lgl(ingredients,
                                ~ any(.x == "rum"))) %>%
  filter(contains_rum)

## ---- echo = TRUE--------------------------------------------------------
(data(beer_tidy, package = "jrTidyverse2"))

## ---- echo = TRUE--------------------------------------------------------
beer_tidy %>% 
  group_by(Type) %>% 
  sample_n(3)

## ------------------------------------------------------------------------
pub = beer_tidy %>% 
  nest(-Type)

## ------------------------------------------------------------------------
pub = pub %>% 
  mutate(n = c(5, 3, 1))

## ------------------------------------------------------------------------
pub = pub %>% 
  mutate(order = map2(data, n, sample_n))
# or 
# mutate(order = map2(.x = data, .y = n, ~sample_n(.x, .y)))

## ------------------------------------------------------------------------
pub %>%
  select(Type, order) %>%
  unnest(cols = order)

## ---- echo = TRUE, results='hide'----------------------------------------
library("jrTidyverse2")
get_happiness()

## ---- message = FALSE, warning = FALSE-----------------------------------
fnames = list.files("happiness", recursive = TRUE, full.names = TRUE)
happiness = tibble(fname = fnames) %>%
  mutate(data = map(fnames, read_csv)) %>% 
  unnest()

## ---- echo = FALSE, results='hide', message = FALSE, warning = FALSE-----
file.remove(fnames)
file.remove("happiness/")

## ------------------------------------------------------------------------
happiness = happiness %>% 
  mutate(Year = parse_number(fname)) %>% 
  select(-fname)
# or
# happiness = happiness %>%
#   mutate(Year = str_remove(fname, ".csv"),
#          Year = as.numeric(Year)) %>%
#   select(-fname)

## ------------------------------------------------------------------------
happiness %>% 
  filter(Country %in% c("Denmark", "United Kingdom", "United States")) %>% 
  ggplot(aes(x = Year, y = `Happiness Rank`, colour = Country)) + 
  geom_line() + 
  geom_point()

## ---- eval = FALSE-------------------------------------------------------
#  happiness_nest = happiness %>%
#    nest(cols = -Country)
#  map2(happiness_nest$Country, happiness_nest$data,
#       ~write_csv(.y, path = paste0(.x, ".csv"))

