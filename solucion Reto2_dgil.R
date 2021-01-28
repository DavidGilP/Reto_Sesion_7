
# Tablas en HTML
library(rvest)
# Introducimos una direcci贸n URL donde se encuentre una tabla

theurl <- "https://www.glassdoor.com.mx/Sueldos/data-scientist-sueldo-SRCH_KO0,14.htm"
file <- read_html(theurl)    # Leemos el html
# Selecciona pedazos dentro del HTML para identificar la tabla

tables <- html_nodes(file, "table")
# Hay que analizar 'tables' para determinar cual es la posici贸n en la lista 
# que contiene la tabla, en este caso es la no. 4

# Extraemos la tabla de acuerdo a la posici贸n en la lista

table1 <- html_table(tables[1], fill = TRUE)

table <- na.omit(as.data.frame(table1))   # Quitamos NA麓s que meten filas extras 
# y convertimos la lista en un data frame para su manipulaci贸n con R

str(table)  # Vemos la naturaleza de las variables
# Por 煤ltimo realizamos una conversi贸n de una columna tipo chr a num, se pueden 
# hacer las conversiones que se requieran


table$Sueldo<-gsub("MXN", "", c((table$Sueldo)))
table$Sueldo<-gsub("/mes", "", c((table$Sueldo)))
table$Sueldo<-gsub("\\$", "", c((table$Sueldo)))
table$Sueldo<-gsub(",", "", c((table$Sueldo)))
table

table$Sueldo <- as.numeric(table$Sueldo)
str(table)


table$Cargo<-gsub("Sueldos para Data Scientist en ", "", (table$Cargo))

#M醲imo sueldo
max.sueldo <- which.max(table$Sueldo)
table[max.sueldo,]

#M韓imo sueldo
min.sueldo <- which.min(table$Sueldo)
table[min.sueldo,]
