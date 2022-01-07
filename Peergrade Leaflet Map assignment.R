# Andreas Tang Hansen (AU641294)- submitted 7-12-2021 Digital Methods

# To install Leaflet package, run this command at your R prompt:
install.packages("leaflet")

# We will also need this widget to make pretty maps:
install.packages("htmlwidget")

# Activate the libraries
library(leaflet)
library(htmlwidgets)



# Task 1: Create a Danish equivalent of AUSmap with esri layers, 
# but call it DANmap

# For the 1st Task I did as the guide shown above the tasks:

DANmap <- leaflet() %>% # Here I ask Leaflet to create something called "DANmap"
  setView(lng = 8.9044025, lat = 56.4263246, zoom = 10) # Here I ask Leaflet to adjust the view on the map to longitude, latitude and the zoom
esri <- grep("^Esri", providers, value = TRUE) # Here I tell Leaflet which map to grab on the Leaflet map page.
for (provider in esri) {
  DANmap <- DANmap %>% addProviderTiles(provider, group = provider) # Now the tiles for the map will be created.
}

DANmap # Now DANmap will finally be created.


#Task 2:Read in the googlesheet data you and your colleagues 
# populated with data into the DANmap object you created in Task 1.
library(tidyverse)
library(googlesheets4)
library(leaflet)
# It is necessary to run the follwing libraries and make sure they are loaded. They tidy the verses and allow you to load Leaflet and Google Sheets into R.

places <- read_sheet("https://docs.google.com/spreadsheets/d/1PlxsPElZML8LZKyXbqdAYeQCDIvDps2McZx1cTVWSzI/edit#gid=124710918",
                     col_types = "cccnncnc") # The following code was provided above in the guide, but by using the link it reads the Google sheet in R.
glimpse(places) # Allows you to view the places


# Task 3: Can you cluster the points in Leaflet? Google "clustering options in Leaflet"
# Technically I answered both task 3 and 5 in this question.
  leaflet() %>% # here Leaflet already knows its DANmap it works with
  addTiles() %>%  # Readding tiles
  addMarkers( lng = places$Longitude,
              lat = places$Latitude,
              clusterOptions = markerClusterOptions(), # Here is the Answer to task 3. You place the "places" by longitude and latitude and after that ask R, to cluster the points for you.
              popup = paste("<strong>Stars1_5: </strong>",places$Stars1_5,
                            "<br><strong>Description : </strong>",places$Description)) # Here is the answer to task 5. I ask the "popup" for the markers/pointers to paste the stars and Description column from the google_sheets into the markers. the "strong" code means, that the headers for "stars" and "description" will be in BOLD
# Task 4:
# The map with with the cluster option on is good for giving you an overview of how many markers are in each area.
# The bad thing is, that it will create a triangle over the map if you hover your mouse over the marker, and within the points of the triangle is where the Point of Interest is. Therefore you have to zoom far in for it to show where the actual point of interest is.
 
 #Credits: Andreas Tang Hansen,
# I worked together with: Erik Luis Lanuza Oehlerich
# If DANmap doesn't work, it may be because you haven't downloaded all Leaflet files.
