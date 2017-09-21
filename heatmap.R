library(jsonlite)
x <- fromJSON("location.json")

# extracting the locations dataframe
loc = x$locations

# converting time column from posix milliseconds into a readable time scale
loc$time = as.POSIXct(as.numeric(x$locations$timestampMs)/1000, origin = "1970-01-01")

# converting longitude and latitude from E7 to GPS coordinates
loc$lat = loc$latitudeE7 / 1e7
loc$lon = loc$longitudeE7 / 1e7

library(ggplot2)
library(ggmap)

map <- get_map(c(-122.414191, 37.776366), zoom = 15, source = 'stamen', maptype = "toner")

ggmap(map) + geom_point(data = loc, aes(x = lon, y = lat), alpha = 0.5, color = "red") + 
  theme(legend.position = "right") + 
  labs(
    x = "Longitude", 
    y = "Latitude", 
    title = "Location history data points",
    caption = "\nA simple point plot shows recorded positions.")