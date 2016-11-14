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


############ FUNCIONES GENERALES DE TEXTO
trim <- function (x) gsub("^\\s+|\\s+$", "", x)

## comienza el proceso de lectura
lee_milanuncios<- read_html(ruta);
#cacula el numero de paginas de la busqueda
#1. Lee la fila del num de paginas
n_pag<-lee_milanuncios %>% html_nodes(".adlist-paginator-summary") %>% html_text
#2. la convierte en un vector
n_pag<-unlist(strsplit(trim(n_pag)," "))
#3. Lee el ultimo valor del vector que es el numero de páginas de la busqueda 
num_pag<-n_pag[length(n_pag)]
if(is.null(num_pag)){num_pag<-0}
ruta_destino<- paste(getwd(),"/datosmilanuncios.csv", sep="");
data<-data.frame()

# lee una a una cada pagina de la seeccion
ruta1<-ruta
#para ello uso el loop siguiente
for (i in 0:num_pag) {
  if (i == 0) {
  }else{
    ruta1<-paste(ruta, "?pagina=",i, sep = "")
  }
  data<-rbind(leemilanuncios(ruta1),data)
  print(nrow(data))
  
}

# lo guardamos en una fichero
a<-c("codigo","titulo","precio","url","descripcion");
write.table(data, file = ruta_destino, sep = "\t", col.names = a, qmethod = "double")
head(data)