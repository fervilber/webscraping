 ---
title: "Get_milanuncios"
author: "Fernando Villalba"
date: "14 de noviembre de 2016"
output: html_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

## OBJETO

Esta rutina obtinene los datos de la web de milanuncios y da como resultado una data frame grardada como fichero *.csv con los anuncios actuales con con el filtro buscado.

La web de milanuncios <http://www.milanuncios.com/> es una web de venta de segunda mano por internet. Tiene un portal inmobiliario muy activo por lo que es una buen sitio para buscar casas, parcelas o viviendas a buen precio.

## COMO FUNCIONA
Con esta rutina lo que hacemos es pasar una busquda a R.
La busqueda en milanuncios se hace de forma muy sencialla en la misma direccion o url, añadiendo los parámetros, por ejemplo para buscar parcelas en Cieza que estén entre los 2000 y los 70000 ??? ponemos: 
<http://www.milanuncios.com/parcelas-en-cieza-murcia/?desde=2000&hasta=70000>

Para buscar en San Pedro del Pinatar casa de 6000 a 70.000, y cerca de la playa con al menos 3 dormitorios y mas de 70 m2 :
<http://www.milanuncios.com/venta-de-viviendas-en-san-pedro-del-pinatar-murcia/?desde=6000&hasta=70000&orden=baratos&dormd=3&m2d=70&playa=200>

Como vemos la busqueda es muy sencilla de parametrizar en la url.

## CODIGO

partiendo de una busqueda como la anterior ejecuptamos el código:

```{r}
# cargamosla librería rvest para leer la url
library(rvest) 

# Escribimos la ruta de busqueda
ruta<-"http://www.milanuncios.com/parcelas-en-cieza-murcia/?desde=2000&hasta=70000"

# llamamos al fichero leemilanuncios.R
source("leemilanuncios.R")

```
Este sencillo código nos almacena en data un data frame los datos de cada uno de los inmuebles encontrados, los datos se guardan en un fichero **datosmilanuncios.csv**, que se puede abrir en Excel y que continene todas las paginas de resultados con los valores de código, descripcion, url, precios etc..


## CODIGO del fichero de lectura de datos.

La funcion principal se denomina leemilanuncios, y lee la ruta especifica devolviendo un df con los anuncios encontrados en la web que se pasa.


```{r}
###################################
## contenido de leemilanuncios.R ##
###################################

# funcion que lle la web de milanuncios 
leemilanuncios<- function(ruta){
  # da un data frame con los datos extraidos de la web de milanuncios
  lee_milanuncios<- read_html(ruta);
  codigo <- lee_milanuncios %>% html_nodes(".x5") %>% html_text
  codigo <- trim(codigo) #gsub("\n"," ",codigo, fixed = TRUE);
  
  titulo <- lee_milanuncios %>% html_nodes(".aditem-detail-title") %>% html_text
  descripcion <- lee_milanuncios %>% html_nodes(".tx") %>% html_text
  # quito los tabuladores, saltos de linea de la descripcion para no tener errores en el  .csv
  descripcion <- gsub("\t"," ",descripcion, fixed = TRUE);
  descripcion <- gsub("\r"," ",descripcion, fixed = TRUE);
  descripcion <- gsub("\n"," ",descripcion, fixed = TRUE);
  
  euro <- "\u20AC" # simbolo del euro.
  precio <- lee_milanuncios %>% html_nodes(".aditem-price") %>% html_text
  precio<-trim(precio)#sub("???","",precio);
  #precio<-as.numeric(precio)
  #precio<-as.numeric(precio, format="%???");
  
  url <- lee_milanuncios %>% html_nodes(".aditem-detail-title") %>% html_attr("href")
  url <- paste("http://www.milanuncios.com",url);
  
  #quito un caracter que sobra en en blanco
  url <- gsub(" ","",url, fixed = TRUE)
  
  df <- data.frame(codigo, titulo, precio, url, descripcion);
}

```
el problema es que muchas busquedas contienen más de una pagina de resultados por lo que tenemos que hacer un bucle en cada una de ellas,despues de leer el numero de paginas.



```{r}
## FUNCIONES GENERALES DE TEXTO
trim <- function (x) gsub("^\\s+|\\s+$", "", x)

## comienza el proceso de lectura
lee_milanuncios<- read_html(ruta);

#cacula el numero de paginas de la busqueda
  #1. Lee la fila del num de paginas
    n_pag<-lee_milanuncios %>% html_nodes(".adlist-paginator-summary") %>% html_text
  #2. la convierte en un vector..strsplit--> separa todas las letras y da una lista con ellas
    n_pag<-unlist(strsplit(trim(n_pag)," "))
  #3. Lee el ultimo valor del vector que es el numero de páginas de la busqueda 
    num_pag<-n_pag[length(n_pag)]
    if(is.null(num_pag)){num_pag<-0}
    
    #Establce el fichero destino der resutados
    ruta_destino<- paste(getwd(),"/datosmilanuncios.csv", sep="");
    
    data<-data.frame()

# Loop que lee cada pagina de la seeccion
ruta1<-ruta

for (i in 0:num_pag) {
  if (i == 0) {
  } else{
    ruta1<-paste(ruta, "?pagina=",i, sep = "")
  }
  
  #Añade cada pagina al df de resultados
    data<-rbind(leemilanuncios(ruta1),data)
    print(nrow(data))
}

# Guardamos todo en un fichero csv
a<-c("codigo","titulo","precio","url","descripcion");
write.table(data, file = ruta_destino, sep = "\t", col.names = a, qmethod = "double")

# Vemos los resultados
head(data)
```
