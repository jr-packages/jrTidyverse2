## ----setup, include = FALSE----------------------------------------------
knitr::opts_chunk$set(echo = TRUE, collapse = TRUE, fig.keep = 'none')

## ---- message=FALSE, echo = TRUE-----------------------------------------
library("tidyverse")
data(names, package = "jrTidyverse2")

## ------------------------------------------------------------------------
names %>% 
  mutate(name = str_trim(name)) %>% 
  mutate(name = str_to_title(name)) %>% 
  count(name) %>% 
  arrange(n)

## ---- echo = TRUE--------------------------------------------------------
data(beer, package = "jrTidyverse2")

## ---- echo = TRUE--------------------------------------------------------
head(beer)

## ---- echo = TRUE--------------------------------------------------------
url = beer$URL

## ------------------------------------------------------------------------
url = url%>% 
  str_extract("/[a-zA-Z-_0-9]*$") 

## ------------------------------------------------------------------------
url = url %>% 
  str_replace("/", "") 

## ------------------------------------------------------------------------
url = url %>% 
  str_replace_all("(\\-|\\_)", " ")

## ------------------------------------------------------------------------
url = url %>% 
  str_to_title() %>% 
  str_trim()
beer$URL = url

## ---- echo = TRUE--------------------------------------------------------
df = data.frame(x = c(2,4,6,8))

## ---- echo = TRUE--------------------------------------------------------
df = df %>% 
  mutate(y = if_else(condition = x > 5, true = 1, false = 0))
df

## ---- echo = TRUE, results='hide'----------------------------------------
str_detect(beer$URL, "Ale")

## ---- echo = TRUE--------------------------------------------------------
beer = beer %>% 
  mutate(
    Ale = if_else(str_detect(URL, "Ale"), 1, 0)
         )

## ------------------------------------------------------------------------
beer = beer %>% 
  mutate(Ale = if_else(str_detect(URL, "Ale"), 1, 0),
         Ipa = if_else(str_detect(URL, "Ipa"), 1, 0),
         Stout = if_else(str_detect(URL, "Stout"), 1, 0)
         )

## ---- echo = TRUE--------------------------------------------------------
beer = beer %>% 
  gather(Type, Yes, Ale, Ipa, Stout) %>% 
  filter(Yes != 0) %>% 
  select(-Yes)

## ------------------------------------------------------------------------
ggplot(beer, aes(x = ABV, y = Color)) + 
  geom_point(aes(colour = Type))

