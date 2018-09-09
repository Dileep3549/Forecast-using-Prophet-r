#install.packages("pageviews")
#install.packages("prophet")
library(pageviews)
library(ggplot2)
library(prophet)
inp <- article_pageviews( article = "Narendra Modi",
                          platform = "all",
                          user_type = "all", 
                          start =as.Date("2017-01-01"),
                          end = as.Date("2018-08-31"), reformat = TRUE)


#### Tim series plot 
qplot(date , views ,data=inp)
summary(inp)


#### missing data and log transformation 
#here we dont have any views as zero else we should convert to NA
 # we do a log transformation for counts to understand seasonality better

ds<-inp$date
y<-log(inp$views)
df<-data.frame(ds,y)

## now lets do a quick plot 
qplot(ds,y, data=df)


## now seasonality is pretty clear

#----Forecasting  with prophet package -----#
mdl<-prophet(df)
mdl

#-----prediction---------#  
future<-make_future_dataframe(mdl,periods=365)
tail(future)
forecast1<-predict(mdl,future)

#-------plot actual vs forcast-----#
plot(mdl,forecast1)
prophet_plot_components(mdl,forecast1)
