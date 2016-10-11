---
title: "02 CAP webscraping"
author: "Fernando Villalba Bergado"
date: "10 de octubre de 2016"
output: html_document
---

# CAPITULO 3. Obtener datos de formularis web
En este capitulo veremos como obtener datos de web que nos ponen formularios de entrada.
Tenemos queidentificar los campos y etiqueta de dichosformularios con FireBug o [selectorgadget](https://chrome.google.com/webstore/detail/selectorgadget/mhjhnkcfbdhnjickkkdbjoemdmbfginb), antes de empezar.

de momento todos los scritp que he probado no han dado resultado. quizás recquiera mas estudio.



##Ejemplo con RCurl
RCurl es el paquete más sencillo, pero no parece funcionar en los ejemplos que he intentado

```{r}

url <- "https://www.treasurydirect.gov/GA-FI/FedInvest/selectSecurityPriceDate.htm"
td.html <- postForm(url,
                    submit = "Show Prices",
                    priceDate.year  = 2016,
                    priceDate.month = 10,
                    priceDate.day   = 7,
                   .opts = curlOptions(ssl.verifypeer = FALSE))

```
esto no funciona
## USO DE RVEST CON FORMULARIOS

Hemos visto en anteriores capitulos el uso de RVest desde la forma más simple a una más compleja con milanuncios.

Vamos a seguir complicando la bajada de datos en web que tienen formularios de entrada:
Los ejemplo que estoy usando los he sacado de:
[LINK](http://stat4701.github.io/edav/2015/04/02/rvest_tutorial/)


##EJEMPLO 2 con Rvest
probamos con rvest, pero la salida no parece consistente

```{r}
## hacer una busqueda en google

url <- "http://www.google.com";
s <- html_session(url);
f0 <- html_form(s)

f1 <-set_values(f0[[1]], q = "Cieza")
f1$url <- url
test <- submit_form(s, f1)
aurl<-test$ur
a <- read_html(ruta);
codigo <- test %>% html_nodes(".r a") %>% html_text


##f0 <- html_form(read_html("http://www.google.com"))[[1]]
url <- "http://www.google.com";
s <- html_session(url);
f0 <- html_form(read_html("http://www.google.com"))[[1]]
f1 <-set_values(f0, q = "Cieza")
test <- submit_form(s, f1)
test;

```
---------

library(rvest)

url       <-"http://www.perfectgame.org/"   ## page to spider
pgsession <-html_session(url)               ## create session
pgform    <-html_form(pgsession)[[1]]       ## pull form from session

# Note the new variable assignment 

filled_form <- set_values(pgform, `#Header1_HeaderTop1_tbUsername` = "myemail@gmail.com",`#Header1_HeaderTop1_tbPassword` = "mypassword")

submit_form(pgsession,filled_form)
------------


url       <-"http://www.google.es/"   ## page to spider
pgsession <-html_session(url)               ## create session
pgform    <-html_form(pgsession)[[1]]       ## pull form from session

# Note the new variable assignment 

filled_form <- set_values(pgform,
  `ctl00$Header2$HeaderTop1$tbUsername` = "myemail@gmail.com", 
  `ctl00$Header2$HeaderTop1$tbPassword` = "mypassword")

submit_form(pgsession,filled_form)




Otro ejemplo con rvest:

#ejemplo para sacar el precio de los bonos del tesoro a partir de una web que contienen un formulario

  url <- "https://www.treasurydirect.gov/GA-FI/FedInvest/selectSecurityPriceDate.htm"

  s <- html_session(url)
  f0 <- html_form(s)
  f1 <- set_values(f0[[2]], priceDate.year=2015, priceDate.month=12, priceDate.day=15)
  f1$url <- url
  test <- submit_form(s, f1)
 


```{r}
library(magrittr)
my_url = "https://www.openair.com/index.pl"
openair <- html_session(my_url)

login <-  html_form(openair) %>%
  extract2(1) %>%
  set_values(
    account_nickname = "does_not_matter_here",
    user_nickname = "does_not_matter_here",
    password = "does_not_matter_here"
  );
login$url <- 'https://www.openair.com/index.pl'
  
  
  test <- openair %<>% submit_form(login);
  test;
```  
##EJEMPLO 3
```{r}
library(httr)
url <- "https://www.treasurydirect.gov/GA-FI/FedInvest/selectSecurityPriceDate.htm"

fd <- list(
    submit = "Show Prices",
    priceDate.year  = 2015,
    priceDate.month = 10,
    priceDate.day   = 7
)

resp<-POST(url, body=fd, encode="form")
content(resp);
```
```
# Attempt to crawl LinkedIn, requires useragent to access Linkedin Sites
uastring <- "Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2228.0 Safari/537.36"
session <- html_session("https://www.linkedin.com/job/", user_agent(uastring))
form <- html_form(session)[[1]]
form <- set_values(form, keywords = "Data Science", location="New York")
 
new_url <- submit_geturl(session,form)
new_session <- html_session(new_url, user_agent(uastring))
jobtitle <- new_session %>% html_nodes(".job [itemprop=title]") %>% html_text
company <- new_session %>% html_nodes(".job [itemprop=name]") %>% html_text
location <- new_session %>% html_nodes(".job [itemprop=addressLocality]") %>% html_text
description <- new_session %>% html_nodes(".job [itemprop=description]") %>% html_text
url <- new_session %>% html_nodes(".job [itemprop=title]") %>% html_attr("href")
url <- paste(url, ')', sep='')
url <- paste('[Link](', url, sep='')
df <- data.frame(jobtitle, company, location, url)

df %>% kable
```


## ENLACES

1.[EJEMPLO1](https://blog.rstudio.org/2014/11/24/rvest-easy-web-scraping-with-r/)


# LA COSA SE COMPLICA

* [SIGUIENTE](03_Rvest02.md)
* [ANTERIOR](01_primeros pasos.md)
* [INDICE](readme.md)
