---
title: "02 CAP webscraping"
author: "Fernando Villalba Bergado"
date: "10 de octubre de 2016"
output: html_document
---

# CAPITULO 2. USO DE PAQUETE RVest.

## INSTALACIÓN

RVest es un paquete de R que sirve para hacer webscraping, esto es obteer datos de la web en bruto.
Rvest es la parte simplifica del paquete httr, mas completo y del que pondremos un ejemplo en capitulos siguientes.

Para instalarlo :
```{r}
install.packages("rvest")
library(rvest)
lego_movie <- read_html("http://www.imdb.com/title/tt1490017/")
```
El código anterior instala el paquete y lo carga.

## USO

Para extraer el contenido de una web usamos la funcion `read_html()` aportando como argumento una url.
En este caso la url de la pelicula **Lego** en la base de datos pública de IMDb.
Esta pagina contiene mucha información y lo que buscamos es obtenes desde R la valoracion de la pelicula:

```{r}
lego_movie <- read_html("http://www.imdb.com/title/tt1490017/")
```
Con la linea anterior leemos la web y almacenamos en una variable el codigo fuente de página.

Lo interesante de rvest(), es que sabiendo CSS y podemos localizar de forma muy precisa los datos que queremos de una web y obtenerlos en R.Usaremos para ello `selectorgadget` que es una extension de CHrome que nos permite obtener los selectores CSS para los elementos de la web que nos interesen.

Siqueremos saber más de `selectorgadget` podemos practicar con el ejemplo `vignette("selectorgadget")`, ya que es un sistema muy bueno para ir directamente a la etiqueta que buscamos.

Usando `selectorgadget` hemos identificado que la etiqueta "strong span" corresponde con la valoracion de la pelicula.
para bajar el valor usamos la funcion:

1. `html_node()` encuentra el primer nodo que coincide con el selector
2. `html_text()`  extrae el contenido de la funcion anterior como texto.

La forma de llamar a la funcion es poner la variable que contiene el codigo fuente de la web seguida de %>% y llamar a las dos funciones:

```{r}
lego_movie %>% 
  html_node("strong span") %>%
  html_text() %>%
  as.numeric()
```
Lo dificil aquí es llegar a la conclusión de que "strong span" es la etiqueta CSS que define el valor de la puntuación.
Para obtener ese selector, hemos usado
[selectorgadget](https://chrome.google.com/webstore/detail/selectorgadget/mhjhnkcfbdhnjickkkdbjoemdmbfginb), que es un complemento o extension del navegador **Chrome**.

Lo instalamos y su uso es fácil, seleccionamos lo que queremos obtener, y nos resalta en amarillo todo lo que tiene esa etiqueta en la pagina web. Como seguramente hay muchas cosas más de las que deseamos, vamos cliqueando encima de aquellas que no queremos, hasta que en la seleccion amarilla nos quede sólo lo que queremos, y el nombre de la etiqueta que aparece en la ventana es lo que usamos en la funcion html_node().

en Firefox si tenemos firebug, podemos sacar las etiquetas, pero es más complejo.

Otro ejemplo es sacar el listado de actores de la película:


```{r}
lego_movie %>%
  html_nodes("#titleCast .itemprop span") %>%
  html_text()
```
o tambien obtenemos lo mismo con esto la etiqueta ".itemprop .itemprop""
```{r}
  lego_movie %>%
  html_nodes(".itemprop .itemprop") %>%
  html_text()
```

Para tener los autores y nombres de los comentarios nos fijamos que se almacenan en una table en la web:


```{r}
lego_movie %>%
  html_nodes("table") %>%
  .[[3]] %>%
  html_table()
```

Otro ejemplo, obtener el poster de la película:

```{r}
#Scrape the website for the url of the movie poster
poster <- lego_movie %>%
  html_nodes("#title-overview-widget img") %>%
  html_attr("src")
poster
```
## EJEMPLO CON MILANUNCIOS

Vamos a obtener una tabla con los pisos que se venden en Murcia en milanuncios con las siguientes caracteristicas:
1. por debajo de 65.000???
2. por encima de 10.000 ??? para quitar los alquileres
3. con 3 habitaciones minimo
4. Cerca de la playa

Hacemos esa busqueda en su web y guardamos la direccion o ruta.
Lo que buscamos es obtener una tabla con los datos siguientes:

1. Código del anuncio
2. Titulo
3. Desrcripcion completa
4. Precio de venta
5. ruta de enlace al anuncio

```{r}
ruta <- "http://www.milanuncios.com/venta-de-viviendas-en-murcia/?desde=10000&hasta=65000&dormd=3&playa=100";

lee_milanuncios<- read_html(ruta);

codigo <- lee_milanuncios %>% html_nodes(".x5") %>% html_text
titulo <- lee_milanuncios %>% html_nodes(".aditem-detail-title") %>% html_text
descripcion <- lee_milanuncios %>% html_nodes(".tx") %>% html_text
# quito los tabuladores, saltos de linea de la descripcion para no tener errores en el  .csv
descripcion <- gsub("\t"," ",descripcion, fixed = TRUE);
descripcion <- gsub("\r"," ",descripcion, fixed = TRUE);
descripcion <- gsub("\n"," ",descripcion, fixed = TRUE);


precio <- lee_milanuncios %>% html_nodes(".aditem-price") %>% html_text
#precio<-sub("???","",precio);
#precio<-as.numeric(precio, format="%???");

url <- lee_milanuncios %>% html_nodes(".aditem-detail-title") %>% html_attr("href")
url <- paste("http://www.milanuncios.com",url);

#quito un caracter que sobra en en blanco
url <- gsub(" ","",url, fixed = TRUE)

df <- data.frame(codigo, titulo, descripcion, precio, url);
df
ruta<- paste(getwd(),"/datosmilanuncios.csv", sep="");
a<-c("id","codigo","titulo","descripcion","precio","url");
write.table(df, file = ruta, sep = "\t", col.names = a, qmethod = "double");
df
```
Con lo que obtenemos un dataframe con los datos buscados directamente de la web.

Falta por resolver el problema del numeor de paginas, ya que en el navegador esta es solo la primera pagina, y habría que seguir con las paginas siguientes


## EJEMPLO 3

```{r}
movie <- read_html("http://www.imdb.com/title/tt1490017/")
cast <- html_nodes(movie, "#titleCast span.itemprop")
A <- html_text(cast)
Ahtml_name(cast)
html_attrs(cast)
html_attr(cast, "class")
```

## ENLACES

1.[EJEMPLO1](https://blog.rstudio.org/2014/11/24/rvest-easy-web-scraping-with-r/)


# LA COSA SE COMPLICA

* [SIGUIENTE](03_Rvest02.md)
* [ANTERIOR](01_primeros pasos.md)
* [INDICE](readme.md)
