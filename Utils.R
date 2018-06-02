#########################################################################################################
#
#                 FEATURE ENGINEERING
#
#########################################################################################################

### PACKAGES
library(tidyverse)
library(readxl)
library(ggplot2)
library(scales)
library(TTR)
library(lubridate)

### LOAD DATA
com_data <- read_excel("./data/DemandForecast_Challenge (1).xlsx", sheet = "HistoricoVentas") 
colnames(com_data) <- tolower(colnames(com_data))

#########################################################################################################
#                 FEATURE ENGINEERING AND DATASETS
#########################################################################################################

# TIME DUMMIES
com_data <- com_data %>%
  mutate(month = as.factor(month(com_data$mes)),
         year = as.factor(year(com_data$mes)),
         sku = as.factor(sku),
         subagencia = as.factor(subagencia))

# drop original date
com_data$mes <- NULL
save(com_data, file="./data/data_baseline.Rda")


#########################################################################################################
#                 EVALUATION METRICS
#########################################################################################################



