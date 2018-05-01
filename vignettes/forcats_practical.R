## ----setup, include = FALSE----------------------------------------------
knitr::opts_chunk$set(collapse = TRUE, results = "hide", fig.keep = 'none')

## ---- message = FALSE----------------------------------------------------
library(forcats)
library(tidyverse)
data(okcupid, package = "jrTidyverse")

## ---- echo = FALSE-------------------------------------------------------
drinks_in = okcupid %>% 
  group_by(drinks) %>% 
  summarise(av_in = mean(income)) 

## ------------------------------------------------------------------------
drinks_in %>% 
  ggplot(aes(x = drinks, y = av_in)) + 
  geom_point()

## ------------------------------------------------------------------------
x = c(1,2,3,NA)
(y = factor(x))

## ------------------------------------------------------------------------
fct_explicit_na(y, "unknown")

## ---- echo = FALSE-------------------------------------------------------
drinks_in %>% 
  mutate(drinks = fct_explicit_na(drinks, "Unknown")) %>% 
  ggplot(aes(x = drinks, y = av_in)) + 
  geom_point()

## ---- echo = FALSE-------------------------------------------------------
drinks_in %>% 
  mutate(drinks = fct_explicit_na(drinks, "Unknown")) %>% 
  mutate(drinks = fct_reorder(drinks, av_in)) %>% 
  ggplot(aes(x = drinks, y = av_in)) + 
  geom_point()

## ---- echo = FALSE-------------------------------------------------------
drinks_in %>% 
  mutate(drinks = fct_explicit_na(drinks, "Unknown")) %>% 
  mutate(drinks = fct_relevel(drinks, 
                              "Unknown", "not at all",
                              "rarely", "socially",
                              "often", "very often",
                              "desperately")) %>% 
  ggplot(aes(x = drinks, y = av_in)) + 
  geom_point()

## ---- echo = FALSE-------------------------------------------------------
okcupid %>% 
  mutate(drinks = fct_explicit_na(drinks, "Unknown")) %>% 
  mutate(drinks = fct_collapse(drinks,
                               Low = c("not at all", "rarely"),
                               Medium = c("socially", "often"),
                               High = c("very often", "desperately"))) %>% group_by(drinks) %>% 
  summarise(mean(income))

