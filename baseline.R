#########################################################################################################
#
#                 BASELINE GBM MEDIAN
#
#########################################################################################################

# rm(list = ls())
# 
# ### PACKAGES
# library(dplyr)
# library(Matrix)
# library(xgboost)
# #library(ggplot2)
# 
# ### DATA
# load("./data/data_baseline.Rda")
# #train_data <- com_data %>% filter(!(year=="2018" & month=="2"))
# #test_data <- com_data %>% filter(year=="2018" & month=="2")
# 
# train_data <- com_data %>% filter(!(year=="2018" & month=="2" & hectolitros>1000))
# test_data <- com_data %>% filter(year=="2018" & month=="2" & hectolitros>1000)
# 
# ### EVALUATION METRIC
# sMAPE <- function(hectolitros_pred, hectolitros) {  
#       sum(abs(hectolitros-hectolitros_pred))/sum(hectolitros)
# }
# 
# # ### FITTED VALUE PLOT
# # plot_fitted_values <- function(hectolitros_pred, hectolitros) {
# #   df <- data.frame(hectolitros_pred, hectolitros)
# #   df <- filter(df, hectolitros>0 & hectolitros<2500)
# #   ggplot(df, aes(x=hectolitros, y=hectolitros_pred)) + geom_point()
# # }
# 
# 
# # PREDICTION BASELINE
# baseline_model <- lm(hectolitros ~ month+year+sku+subagencia, data = train_data)
# baseline_preds <- predict(baseline_model, newdata=test_data)
# 
# summary(baseline_model)
# #plot_fitted_values(baseline_preds, test_data$hectolitros)
# 
# # # GBM 
# # dtrain <- xgb.DMatrix(data = sparse.model.matrix(~month+year+sku+subagencia, train_data), 
# #                      label = train_data$hectolitros)
# # dtest <- xgb.DMatrix(data = sparse.model.matrix(~month+year+sku+subagencia, test_data), 
# #                      label = test_data$hectolitros)
# # 
# # param <- list(objective = "reg:linear", 
# #               eval_metric = 'mae', max.depth =10, 
# #               eta = 0.01, subsample = 0.9, 
# #               colsample_bytree = 0.5, nthread = 10, verbose = 1)
# # 
# # watchlist <- list(eval = dtest)
# # 
# # xgb_model <- xgb.train(param, data = dtrain,
# #                        watchlist, nrounds = 20000, maximize = FALSE, 
# #                        print_every_n = 100) #early_stopping_rounds = 50
# # 
# # xgb_preds <- predict(xgb_model, newdata=dtest)
# 
# # Checar performance
# sMAPE(baseline_preds, test_data$hectolitros)
# #sMAPE(xgb_preds, test_data$hectolitros)

sayHello <- function(){
  print('hello')
}

sayHello()