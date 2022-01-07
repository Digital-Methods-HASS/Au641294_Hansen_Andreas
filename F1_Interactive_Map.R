#Interactiv Leaflet Formula One Map
#Author: Andreas Tang Hansen
#Thank you to F1.Fansite for allowing me to use their data,they have plenty of Formula One data that is very useful.


# First install the required packages. "Leaflet" is the tools to create the map and "htmlwidgets" is the ability to load and show the map in "viewer" 
install.packages("leaflet")
install.packages("htmlwidgets")

#Then we need to activate the libraries
library(leaflet)
library(htmlwidgets)

#Then we need to get R, to read the required data to create the map. The file can be found and downloaded on my repository
#Tell R to read the csv with this command, remember to add the .csv at the end, otherwise R won't know it is a CSV file it is reading.

read.csv("F1_dataset_CSV_v.2a.csv") -> f1dataset    #You can name the dataset any name, this is just what I chose
colnames(f1dataset)     #Here I can check the column names, they should match up with the dataset.
data.class(f1dataset)   #Here I can check the data class of my dataset. It should be data.frames in order for it to work with this code and it should be data.frames by default.


#Now we start creating the map, first we activate Leaflet and pipe the command forward
leaflet() %>%
  addProviderTiles("Esri.WorldPhysical", group = "Physical") %>%  #Here I am adding tilesets to my map and giving them a name in the layercontrol. I chose Esri as I believe it to be the most aesthetically pleasing to look at and the easiest to work with.
  addProviderTiles("Esri.WorldImagery", group = "Aerial") %>%     #WorldPhysical is a standard map and WorldImagery is satelite photography. MtbMap shows a Geomap, but unfortunately it only seems to work in Europe
  addProviderTiles("MtbMap", group = "Geo") %>%
  addLayersControl(                                             #From 27 to 29. I am first adding the layer control
    baseGroups = c("Aerial", "Physical", "Geo"),                #Here I am adding the layers. You need to place the group names and not the actual names of the layers
    options = layersControlOptions(collapsed = T)) %>%          #Here I create the actual layer control with layers. the option, that I toggle on, is to collapse the controller when it is not in use.
  addCircleMarkers(lng = f1dataset$Longtitude,                  #Then I add the markers here. the "lng" and "lat" are the coordinates the map should place the markers at. I asked R to create it from the "longtitude" and "latitude" columns in the "F1dataset"
                    lat = f1dataset$Latitude,
                    popup = paste("<strong>Circuits: <strong>",f1dataset$Circuits,                                                   #Here I tell R to show pasted data from the dataset to the popups when you click on the markers. I tell which data from which column should appear in which order. If you cannot remember the names of the columns then use the "colnames" command as shown in line 18
                                  "<br><strong>Years_raced_on_circuit : </strong>" ,f1dataset$Years_raced_on_circuit,                #The command "<br><strong> tells R to show the column-name in bold text. Beware that "br" is a linebreaker and therefore it needs to be separated by lines
                                  "<br><strong>No_of_years_raced_on_circuit : </strong>", f1dataset$No_of_years_raced_on_circuit,
                                  "<br><strong>First_winner : </strong>", f1dataset$First_winner,
                                  "<br><strong>Lastest_winner : </strong>", f1dataset$Latest_winner,
                                  "<br><strong>Fastest_lap_record_holder : </strong>", f1dataset$Fastest_lap_record_holder,
                                  "<br><strong>Most_Wins : </strong>", f1dataset$Most_Wins,
                                  "<br><strong>Grand_Prixs_Held : </strong>", f1dataset$Grand_Prixs_Held),
                   color ="Red",
                   weight = 12,            #Here I chose the color,weight/boldness and radius of my circle markers
                   radius = 8, 
                   clusterOptions = markerClusterOptions(spiderfyOnMaxZoom = TRUE)) %>%  #This a cluster option that allows me to cluster my markers. It is useful to save on PC memory and also if two markers are on each other, such as the circuits in Bahrain, then you can select between them more easily. The "spider" cluster is very useful if you have multiple markers in the same spot. I do not have very many in the same spot.
  setView(lng = 41.7317067, lat = 40.9982951, zoom = 3) #Lastly I set where mapview shall start. as long as the longtitude, latitude and zoom numbers are valid, then it doesn't matter what you write, as you can still freely move around the map and zoom in and out
# And now you have a Interactive Formula One Map, that shows you information about the circuits and the F1 history behind them.
                    