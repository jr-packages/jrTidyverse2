## ----setup, include = FALSE----------------------------------------------
knitr::opts_chunk$set(echo = TRUE, collapse = TRUE, fig.keep = 'none')

## ---- message = FALSE, echo = TRUE---------------------------------------
library(tidyverse)
data(okcupid, package = "jrTidyverse2")

## ------------------------------------------------------------------------
drinks_in = okcupid %>% 
  group_by(drinks) %>% 
  summarise(av_in = mean(income)) 

## ---- echo = TRUE--------------------------------------------------------
drinks_in %>% 
  ggplot(aes(x = drinks, y = av_in)) + 
  geom_point()

## ---- echo = TRUE--------------------------------------------------------
x = c(1,2,3,NA)
(y = factor(x))

## ---- echo = TRUE--------------------------------------------------------
fct_explicit_na(y, "unknown")

## ------------------------------------------------------------------------
drinks_in %>% 
  mutate(drinks = fct_explicit_na(drinks, "Unknown")) %>% 
  ggplot(aes(x = drinks, y = av_in)) + 
  geom_point()

## ------------------------------------------------------------------------
drinks_in %>% 
  mutate(drinks = fct_explicit_na(drinks, "Unknown")) %>% 
  mutate(drinks = fct_reorder(drinks, av_in)) %>% 
  ggplot(aes(x = drinks, y = av_in)) + 
  geom_point()

## ------------------------------------------------------------------------
drinks_in %>% 
  mutate(drinks = fct_explicit_na(drinks, "Unknown")) %>% 
  mutate(drinks = fct_relevel(drinks, 
                              "Unknown", "not at all",
                              "rarely", "socially",
                              "often", "very often",
                              "desperately")) %>% 
  ggplot(aes(x = drinks, y = av_in)) + 
  geom_point()

## ------------------------------------------------------------------------
okcupid %>% 
  mutate(drinks = fct_explicit_na(drinks, "Unknown")) %>% 
  mutate(drinks = fct_collapse(drinks,
                               Low = c("not at all", "rarely"),
                               Medium = c("socially", "often"),
                               High = c("very often", "desperately"))) %>%
  group_by(drinks) %>% 
  summarise(av_in = mean(income)) %>% 
  ggplot(aes(x = drinks, y = av_in)) + 
  geom_point()

