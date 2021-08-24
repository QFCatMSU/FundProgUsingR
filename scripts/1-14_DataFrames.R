{
  rm(list=ls());  # cleans out the Environment every time the code is executed
  options(show.error.locations = TRUE);  # show the line number of errors in the Console
  
  library(rnoaa);
  library(reshape2);
  myToken = "LfoeHFkVUMLcokHXGCTTjukJteFEcvvM";
  
  source("scripts/toolbox.r");  # load script with isDivisible() function
  lansingWeather = ncdc(datasetid="GHCND", 
                        datatypeid=c("TMAX", "TAVG", "TMIN", "PRCP", 
                                     "SNOW", "AWND", "WDF2", "WSF2", 
                                     "WT01", "WT09"),
                        stationid = "GHCND:USW00014836", 
                        startdate = "2016-01-01", enddate ="2016-01-31",
                        token = myToken,
                        limit = 400);
  
  lansingWeatherDF = lansingWeather$data;
  
  lansingWeatherRS = dcast(data = lansingWeatherDF, 
                           formula = date ~ datatype, 
                           value.var = "value");
}