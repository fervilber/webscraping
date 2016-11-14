---
title: "webscraping"
author: "Fernando Villalba Bergado"
date: "10 de octubre de 2016"
output: rtf_document
language: "Español"
---

# INTRODUCCIÓN

En esta serie de capítulos, voy a poner muchos ejemplos de cómo hacer **webscraping**, partiendo de cero.

Se trata de **aprender haciendo**, por lo que iré poniendo ejemplos explicados que tracen una ruta de aprendizaje para desarrollar R en el tema del rascado web o webscraping.

Cada vez que termine un capítulo actualizaré esta lista con los enlaces a los ficheros correspondientes:

1. [CAPITULO 1. PRIMEROS PASOS CON WEBSCARPING Y R](01_primeros pasos.md)
2. [CAPITULO 2. BAJAR DATOS](02_Rvest.md)
3. [CAPITULO 3. EJECUTAR FORMULARIOS](03_Rvest02.md)


# Configurar entorno de trabajo en RSTUDIO 

Para hacer este manual de R y webscraping he usado las caracteristicas de edición de ficheros markdown de RSTUDIO y Git.
He enlazado RSTUDIO con GitHub para así practicar el uso de esta web como archivo y gestor de versiones de código.

Trabajo en modo local en RSTUDIO y cuando tengo cambios importantes los subo (push) directamente con RSTUDIOGit.

Para que RSTUDIO reconozca el directorio local y lo enlace con GitHub he tenido que poner en GitBAsh el enlace remoto, actualizar el STAGE del repo hace un commit general y por ultimo subir todo el repo a GitHub:

```
$ git remote add origin https://github.com/fervilber/webscraping.git
$ git add -A
$ git commit -m "actualiza todo"
$ git push -u origin master
```
Este es el enlace al repo de GitHub con la [documentacion](https://github.com/fervilber/webscraping.git)
 de este trabajo.

Hecho esto, RSTUDIO reconoce el enlace y permite ya trabajar desde la ventana de git en RSTUDIO, de forma muy simple.


## ENLACES

1. [LINK](http://www.programmingr.com/)
2. [LINK](https://csgillespie.github.io/efficientR/introduction.html)
3. [LINK](https://blog.rstudio.org/2014/11/24/rvest-easy-web-scraping-with-r/)
4. [LINK](http://stat4701.github.io/edav/2015/04/02/rvest_tutorial/)



