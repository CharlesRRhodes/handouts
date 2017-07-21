## Importing vector data

library(sf)
library(rgdal)

shp <- 'data/cb_2016_us_county_5m'
counties <- st_read(shp, stringsAsFactors = FALSE)
#very good practice to look at/preview class of the object
class(counties)


## Bounding box

library(dplyr)
counties_md <- filter(counties, STATEFP == '24')

## Grid

grid_md <- st_make_grid(counties_md, n=4)


## Plot layers

plot(grid_md)
plot(counties_md$geometry, add=T)

## Create geometry

sesync <- st_sfc(
    st_point(c(-76.503394, 38.976546)),
        crs=4626)


counties_md <- st_transform(counties_md, 
                            crs=st_crs(sesync))
plot(counties_md$geometry)
plot(sesync, col = "green", pch = 20, add = T)

counties_md <- st_transform(counties_md, 
                            crs=st_crs(sesync))
plot(counties_md$geometry)
plot(sesync, col = "green", pch = 20, add = T)

st_within(sesync, counties_md)


## Exercise 1
#produce map of MD, w County in which SESYNC is in red
#counties_of_sesync <- filter(counties_md,  == '')
# this isolates the right county, side hack: plot(counties_md[sesync,]$geometry)
plot(sesync, col = 'red', pch = 20, add = T)
st_within(sesync, counties_md)

overlay <- st_within(sesync, counties_md)
class(overlay)
#this is easier to understand: index_selected <- overlay[[1]]
county_sesync <- counties_md[overlay[[1]],]
plot (county_sesync$geometry, col = "red")
plot (county_sesync$geometry, border = "blue")
plot(sesync, pch=20, col="green", add=T)

## Coordinate transforms

shp <- 'data/huc250k'
huc <- st_read(shp)
plot(huc)

st_crs(huc)

prj <- '+proj=aea +lat_1=29.5 +lat_2=45.5 +lat_0=23 +lon_0=-96 +x_0=0 +y_0=0 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs'

counties_md <- st_transform(counties_md, crs=prj)
st_crs(counties_md)

huc <- st_transform(huc, crs=prj)
sesync <- st_transform(sesync, crs=prj)

plot(counties_md$geometry)
plot(huc, border = 'blue', add = TRUE)
plot(sesync, col = 'green', pch = 20, add = TRUE)

## Geometric operations on vector layers

state_md <- st_union(counties_md)
plot(state_md)

huc_md <- st_intersection(huc, state_md)
plot(huc_md, border = 'blue', col = NA, add = TRUE)

## Exercise 2

...#skip

## Working with raster data

library(raster)
nlcd <- raster("data/nlcd_agg.grd")
extent <- matrix()

## Crop

extent1 <- matrix(st_bbox(huc_md), nrow=2)
nlcd <- crop(nlcd, extent1)
plot(nlcd)
plot(state_md, add =)

## Raster data attributes

lc_types <- nlcd@data@attributes[[1]]$Land.Cover.Class

## Raster math

pasture <- mask(nlcd, nlcd == 81, maskvalue = FALSE)
plot(pasture)
#2nd argum is factor=25, you can see this lang can be skipped
nlcd_agg <- aggregate(nlcd, 25, fun=modal)
res(nlcd)
res(nlcd_agg)
plot(nlcd_agg)
freq(nlcd_agg)

## Exercise 3

...

## Mixing rasters and vectors: prelude

sesync <- as(sesync, "Spatial")
huc_md <- as(huc_md, "Spatial")
counties_md <- as(counties_md, "Spatial")

## Mixing rasters and vectors

plot(nlcd)
plot(sesync, col = 'green', pch = 16, cex = 2, ...)

#store result of extract here; useful!
sesync_lc <- extract(nlcd, sesync)

county_nlcd <- extract(nlcd_agg, counties_md[1,])

modal_lc <- extract(nlcd_agg, huc_md, fun=modal)
... <- lc_types[modal_lc + 1]

