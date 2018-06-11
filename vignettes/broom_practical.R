## ----setup, include = FALSE----------------------------------------------
knitr::opts_chunk$set(collapse = TRUE, echo = FALSE, results = "hide", fig.keep = 'none')

## ---- message = FALSE, echo = TRUE---------------------------------------
library("broom")
library("tidyverse")
library("jrTidyverse2")
library("GGally")
data(beer, package = "jrTidyverse2")

## ---- echo = TRUE--------------------------------------------------------
fit = lm(ABV ~ Color, data = beer)

## ------------------------------------------------------------------------
summary(fit)$coefficients[,4]

## ------------------------------------------------------------------------
tidy_fit = tidy(fit)
tidy_fit$p.value

## ---- message = FALSE----------------------------------------------------
ggcoef(fit, exclude_intercept = TRUE,
errorbar_height = 0.5, vline_color = "red")

## ------------------------------------------------------------------------
aug_fit = augment(fit)

## ---- fig.margin = TRUE--------------------------------------------------
aug_fit %>% 
  select(ABV, Color, .fitted) %>% 
  gather(Type, Value, -Color) %>% 
  ggplot(aes(x = Color)) + 
  geom_point(aes(y = Value, colour = Type))

## OR

plot(aug_fit$Color, aug_fit$ABV)
points(aug_fit$Color, aug_fit$.fitted, col = "red", type = "l")

## ---- echo = TRUE--------------------------------------------------------
data(movies, package = "ggplot2movies")
test = t.test(budget ~ Action, data = movies)

## ------------------------------------------------------------------------
movies %>% 
  group_by(Action) %>% 
  summarise(mean(budget, na.rm = TRUE))

## ------------------------------------------------------------------------
test

## ------------------------------------------------------------------------
tidy(test) %>% 
  select(conf.low, conf.high, p.value)

## ------------------------------------------------------------------------
# Augment doesn't work on t-tests as there is no meaningful sense 
# in which a hypothesis test produces output about each initial data point.

