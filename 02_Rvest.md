---
title: "02 CAP webscraping"
author: "Fernando Villalba"
date: "10 de octubre de 2016"
output: html_document
---

# CAPITULO 2. USO DE PAQUETE RSELENIUM.

Este programa hace un analisis de datos web, en concreto de los comentarios de un libro, en la web goodread.
El objetivo es hacer un ejemplo de lo que llaman rasgado web, webscrapping que consisten en obtener datos de internet para despues analizarlos con metodos de data science.

Lo que haremos será reprodicir el estudio de Florent Buisson, que muy amablemente expone en el blog de:
<http://datascienceplus.com/goodreads-webscraping-and-text-analysis-with-r-part-1/>.

Este estudio se divide en 3 partes:

1.Part 1: Webscraping
2.Part 2: Exploratory data analysis and sentiment analysis
3.Part 3: Predictive analytics with machine learning


##Part 1: Webscraping

Debemos comprobar si las librerias usadas las tenemos instaladas en el sistema,y caso contrario hacer una instalacion de cada una:

```{r}
install.packages("data.table");
install.packages("dplyr");
install.packages("magrittr");
install.packages("rvest");

install.packages("rJava");
install.packages("RSelenium");

```
una vez instaladas podemos llamar al primer script:
```{r }
library(data.table)   # Required for rbindlist
library(dplyr)        # Required to use the pipes %>% and some table manipulation commands
library(magrittr)     # Required to use the pipes %>%
library(rvest)        # Required for read_html
library(RSelenium)    # Required for webscraping with javascript

# solo una vez

# checkForServer(); // ESTÁ OBSOLETA

#....

url <- "https://www.goodreads.com/book/show/18619684-the-time-traveler-s-wife#other_reviews"
book.title <- "The time traveler's wife"
output.filename <- "GR_TimeTravelersWife.csv"
```
en algunos casos y si hay problemas con firefox, tendremos que hacerlo mediante una instancia del navegador de este modo:
```{r }
# startServer() // ESTÁ OBSOLETA
remDr <- remoteDriver(browserName = "firefox", port = 4444) # instantiate remote driver to connect to Selenium Server
remDr$open() # open web browser
remDr$navigate(url) 
```
problemas con selenium 
unlink(system.file("bin", package = "RSelenium"), recursive = T)
checkForServer()

## Part 2: Exploratory data analysis and sentiment analysis

You can also embed plots, for example:

```{r pressure, echo=FALSE}
plot(pressure)
```

## Part 3: Predictive analytics with machine learning.
