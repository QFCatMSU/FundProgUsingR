{
  rm(list=ls());  
  options(show.error.locations = TRUE); 
  
  # give this script access to the functions in the rnoaa package
  library(rnoaa);
  
  myToken = "LfoeHFkVUMLcokHXGCTTjukJteFEcvvM";
  
  # get the maximum temperatures for every day in  January 2011 from the NOAA database
  lansWeather11 = ncdc(datasetid="GHCND",
                    #   datatypeid=c("TMAX"),
                       stationid="GHCND:USW00014836",
                       startdate = "2011-01-01", enddate ="2011-01-31",
                       token=myToken,
                       limit=1000  );
}