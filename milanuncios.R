#############################################
#### RUTINA PARA DESCARGAR COMO DATA FRAME DATOS
#### DE UNA BUSQUEDA EN MILANUNCIOS
#############################################

#############################################
library(rvest)

# Escribir la busqueda que se quiere realizar en el codigo de url web
# es bastante sencillo
ruta<-"http://www.milanuncios.com/parcelas-en-cieza-murcia/?desde=2000&hasta=70000"
#ruta<-"http://www.milanuncios.com/parcelas-en-murcia/?desde=10000&hasta=70000&m2=10000"
#ruta<-"http://www.milanuncios.com/venta-de-viviendas-en-san-pedro-del-pinatar-murcia/?desde=6000&hasta=70000&orden=baratos&dormd=3&m2d=70&playa=200"

source("leemilanuncios.R")

#


