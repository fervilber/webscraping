---
title: "02 CAP webscraping"
author: "Fernando Villalba Bergado"
date: "10 de octubre de 2016"
output: html_document
---

# CAPITULO 3. SEGUIMOS CON RVest.

## USO DE RVES CON FORMULARIOS

Hemos visto en anteriores capitulos el uso de RVest desde la forma más simple a una más compleja con milanuncios.

Vamos a seguir complicando la bajada de datos en web que tienen formularios de entrada:
Los ejemplo que estoy usando los he sacado de:
[LINK](http://stat4701.github.io/edav/2015/04/02/rvest_tutorial/)

```{r}
# Attempt to crawl Columbia Lionshare for jobs
session <- html_session("http://www.careereducation.columbia.edu/lionshare")
form <- html_form(session)[[1]]
form <- set_values(form, username = "uni")
#Below code commented out in Markdown

#pw <- .rs.askForPassword("Password?")
#form <- set_values(form, password = pw)
#rm(pw)
#session2 <- submit_form(session, form)
#session2 <- follow_link(session2, "Job")
#form2 <- html_form(session2)[[1]]
#form2 <- set_values(form2, PositionTypes = 7, Keyword = "Data")
#session3 <- submit_form(session2, form2)

# Unable to scrape because the table containing the job data uses javascript and doesn't load soon enough for rvest to collect information
```
Con la linea anterior leemos la web y almacenamos en una variable el codigo fuente de página.


## ENLACES

1.[EJEMPLO1](https://blog.rstudio.org/2014/11/24/rvest-easy-web-scraping-with-r/)


# LA COSA SE COMPLICA

* [SIGUIENTE](03_Rvest02.md)
* [ANTERIOR](01_primeros pasos.md)
* [INDICE](readme.md)
