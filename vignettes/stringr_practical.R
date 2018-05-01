## ----setup, include = FALSE----------------------------------------------
knitr::opts_chunk$set(collapse = TRUE, results = "hide", fig.keep = 'none')

## ---- message=FALSE, echo = TRUE-----------------------------------------
library("stringr")
library("dplyr")
data(names, package = "jrTidyverse2")

## ---- results='asis', echo=FALSE-----------------------------------------
names %>% 
  mutate(name = str_trim(name)) %>% 
  mutate(name = str_to_title(name)) %>% 
  unique() %>% 
  pull(name)

## ------------------------------------------------------------------------
names %>% 
  count(name)

## ---- echo = FALSE-------------------------------------------------------
names %>% 
  mutate(name = str_trim(name)) %>% 
  mutate(name = str_to_title(name)) %>% 
  count(name)

## ------------------------------------------------------------------------
data(beer, package = "jrTidyverse2")

## ------------------------------------------------------------------------
head(beer)

## ------------------------------------------------------------------------
url = beer$URL

## ---- echo = FALSE-------------------------------------------------------
url = url%>% 
  str_extract("/[a-zA-Z-_0-9]*$") 

## ---- echo = FALSE-------------------------------------------------------
url = url %>% 
  str_replace("/", "") 

## ---- echo = FALSE-------------------------------------------------------
url = url %>% 
  str_replace_all("(\\-|\\_)", " ")

## ---- echo=FALSE---------------------------------------------------------
url = url %>% 
  str_to_title() %>% 
  str_trim()
beer$URL = url

## ------------------------------------------------------------------------
df = data.frame(x = c(2,4,6,8))

## ------------------------------------------------------------------------
df = df %>% 
  mutate(y = if_else(condition = x > 5, true = 1, false = 0))
df

## ------------------------------------------------------------------------
str_detect(beer$URL, "Ale")

## ---- echo = FALSE-------------------------------------------------------
beer = beer %>% 
  mutate(
    Ale = if_else(str_detect(URL, "Ale"), 1, 0)
         )

## ---- echo=FALSE---------------------------------------------------------
beer = beer %>% 
  mutate(Ale = if_else(str_detect(URL, "Ale"), 1, 0),
         Ipa = if_else(str_detect(URL, "Ipa"), 1, 0),
         Stout = if_else(str_detect(URL, "Stout"), 1, 0)
         )

## ------------------------------------------------------------------------
library("tidyr")
beer = beer %>% 
  gather(Type, Yes, Ale, Ipa, Stout) %>% 
  filter(Yes != 0) %>% 
  select(-Yes)

## ------------------------------------------------------------------------
library("ggplot2")
beer %>% 
ggplot(aes(x = ABV, y = Color)) + 
  geom_point(aes(colour = Type))

