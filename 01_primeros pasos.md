---
title: "webscraping"
author: "Fernando Villalba"
date: "7 de octubre de 2016"
output: html_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

# CAPITULO 1. PRIMEROS PASOS CON WEBSCARPING Y R

## INTRODUCCIÓN

Hay una enorme cantidad de datos disponibles en la web. Parte de esta información se encuentra compilada y preparada para descarga directa y descargable, pero la mayoría de estos datos son simple  contenido web, como blogs, como noticias,como foros, opiniones,webs, ets.

El acceso a los datos es bastante sencillo en unas pocas webs que los aportan cocinados y preparados ,sólo tienes que descargar el archivo y hacer la importación a R o al programa que uses para analizar los datos.

Eso ocurre muy pocas veces, pues la gran mayoría de la información esta como simple codigo html, codigo que contienen datos dentro, estos datos son los que llamaremos datos "salvajes".

Conseguir extraer informacion de estos datos salvajes y convertirlos en un formato analizable es más difícil, es una tarea compleja, que en la jerga informática actual se llama "web scraping".Webscrapping consisten en obtener datos brutos o salvajes de internet para despues analizarlos con metodos de data science.

En este capitulo analizamos la manera más sencialla de hacerlo con R, a partir de las funciones más básica "readlines ()" desde el paquete base y  "getURL ()"" del paquete RCurl hacen posible esta tarea


## 01.LECTURA DE UNA PAGINA WEB DESDE R

El paquete básico de instalacion de R continene la funcion `readLines()`, que lee una url. 
Esta funcion tienen problemas cuando el servdor es seguro, es decir la url comienza por 'https://', por lo que solo la usaremos para web normales que comiencen con http://.

Con `readLines()` adquirimos los datos, pero para extraer lo que buscamos en el codigo html debemos hacer algo más.
Usaremos funciones como `grep ()`, `gsub ()`o equivalentes para analizar el codigo fuente de la web descargada y extraer lo que buscamos.


```{r}
  # Obtenemos la fuente o código de la url
  web_pag <- readLines("http://programmingr.com/jan09rlist.html")

  # Busca dentro del fichero de codigo descargado "web_pag"" la linea o lineas que contienen la palabra "description"
  # y las almacena en la variable var_description
  var_description <- web_pag[grep("description", web_pag)]

  # Remplaza o borra caracteres dentro de una linea
  # gsub(patron, remplazo, string, ignore.case = FALSE, perl = FALSE, fixed = FALSE, useBytes = FALSE)
  # quita la palabra meta de las lineas leidas
  var_description_limpia <- gsub("meta", "", var_description, fixed = TRUE)
```
Para auna descripcion m´s detallada de gsub ver<http://www.endmemo.com/program/R/gsub.php>

## 02. LEER PAGINAS WEB CON RCurl()

La mayor parte de paginas web usan protocolo https:// por lo que el metodo de `readLines()` no es efectivo. 

Para leer estas webs podemos usar el paquete `RCurl()`, y la fucnion `getURL()`, que es equivalente a `readLines()`, pero con muchas más posibilidades.
Una vez descargada la web podemos usar la fucnion 'htmlTreeParse()`del paquete XML, para analizar sintacticamente el fichero.


```{r}
  # Instalamos y cargamos el paquete  RCurl si no lo tenemos
  install.packages("RCurl", dependencies = TRUE)
  library("RCurl")

  # Instalamos y cargamos el paquete XML()
  install.packages("XML", dependencies = TRUE)
  library("XML")

  # Bajamos una web como archivo
  web_txt <- getURL("https://stat.ethz.ch/pipermail/r-help/2009-January/date.html", ssl.verifypeer = FALSE)
  
  #Analizamos (Parse) el fichero descargado en la variable aterior
  web_txt_analizada <- htmlTreeParse(web_txt)

```


# LA COSA SE COMPLICA

[link](http://www.programmingr.com/)
[link2](readme2.md)



