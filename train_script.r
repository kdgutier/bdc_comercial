library(tidyverse)
library(readxl)
library(ggplot2)
library(scales)
library("TTR")
library(lubridate)
library(DataExplorer)
library(DT)
library(sweep)
library(forecast)

#leer datos
root <- '~/Dropbox/bdc_comercial/data/'
com_data <- read_excel(paste0(root,"DemandForecast_Challenge (1).xlsx"), sheet = "HistoricoVentas")

#pasar los headers a minusculas
colnames(com_data) <- tolower(colnames(com_data))

#crear id unico
com_data$unique_id <- paste0(com_data$subagencia,com_data$sku)

#rand<-sample(com_data$unique_id,5)
#com_data2 <- filter(com_data, unique_id %in% rand)

base_line <- function(series){
  fit <- auto.arima(series)
  return(fit)
}

create_ts <- function(id,db){
  series <- filter(db, unique_id == id)
  series <- ts(series, frequency=12, start=c(2013,1))
  series <- series[,"hectolitros"]
  return(series)
}

#head(create_ts("1021700000203", com_data2))
#test<-create_ts("1021700000203", com_data2)
resultado_final<-data_frame(unique_id=as.character(), 
                            marzo=as.numeric(), abril=as.numeric(), mayo=as.numeric())


#indices
index1 <- [1:4472] #KIN
index2 <- [4473:8943] #ANDRES

#ejecutar for loop con base en los indices
for (x in unique(com_data$unique_id)index1){
  rm(fit)
  print(x)
  ts<-create_ts(x,com_data)
  print(head(ts))
  fit<-base_line(ts)
  #fit<-base_line(create_ts(unique_id,com_data2))
  name<-as.character(x)
  print(fit$coef)
  save(fit, file=paste0("./models/",name,".rda"))
  resultado_final <- rbind(resultado_final, cbind(x, as.numeric(forecast(fit,3)$mean)))
}
resultado_final$mes<-c("Mar-18","Apr-18","May-18")
save(resultado_final, file="resultado_final.rda")

forecast_kam<-function(sku,subagencia,n=2){
  unique_id <- paste0(subagencia,sku)
  load(paste0("./models/",unique_id,".rda"))
  return(forecast(fit,n)$mean[1])
}

forecast_kam("1020300000001")
