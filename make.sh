#!/bin/bash

# Simplifying Proportion(5%)
PROPORTION=0.05

# Simplify the original ESRI Shapefile and generates TopoJSON.
# Map the *_name, *_code columns into name, code.
topojson --simplify-proportion $PROPORTION -o topojson/regions.topojson -p code=state_code,name=state_name,code=city_code,name=city_name,code=dong_code,name=dong_name --shapefile-encoding utf8 -- shp/state.shp shp/city.shp shp/dong.shp

# Generates GeoJSON from TopoJSON
geojson topojson/regions.topojson -o geojson/ 

# Generates ESRI Shapefile from GeoJSON
rm simplified_shp/* > /dev/null
ogr2ogr -f "ESRI Shapefile" simplified_shp/state.shp geojson/state.json -lco ENCODING=UTF-8
ogr2ogr -f "ESRI Shapefile" simplified_shp/city.shp geojson/city.json -lco ENCODING=UTF-8
ogr2ogr -f "ESRI Shapefile" simplified_shp/dong.shp geojson/dong.json -lco ENCODING=UTF-8
