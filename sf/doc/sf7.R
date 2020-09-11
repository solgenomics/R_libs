## ----echo=FALSE, include=FALSE------------------------------------------------
knitr::opts_chunk$set(collapse = TRUE)
EVAL = !inherits(try(sf_use_s2(TRUE), silent=TRUE), "try-error")

## ----eval=EVAL----------------------------------------------------------------
library(sf)
nc = read_sf(system.file("gpkg/nc.gpkg", package="sf")) # wrong ring directions
library(s2)
s2_area(st_as_s2(nc, oriented = FALSE)[1:3]) # corrects ring direction, correct area:
s2_area(st_as_s2(nc, oriented = TRUE)[1:3]) # wrong direction: Earth's surface minus area
nc = read_sf(system.file("gpkg/nc.gpkg", package="sf"), check_ring_dir = TRUE)
s2_area(st_as_s2(nc, oriented = TRUE)[1:3]) # no second correction needed here:

## ----eval=EVAL----------------------------------------------------------------
as_s2_geography(TRUE)

## ----eval=EVAL----------------------------------------------------------------
co = s2_data_countries()
oc = s2_difference(as_s2_geography(TRUE), s2_union_agg(co)) # oceans
b = s2_buffer_cells(as_s2_geography("POINT(-30 52)"), 9800000) # visible half
i = s2_intersection(b, oc) # visible ocean
plot(st_transform(st_as_sfc(i), "+proj=ortho +lat_0=52 +lon_0=-30"), col = 'blue')

## ----eval=EVAL----------------------------------------------------------------
a = as_s2_geography("POINT(0 0)")
b = as_s2_geography("POLYGON((0 0,1 0,1 1,0 1,0 0))")
s2_intersects(a, b, s2_options(model = "open")) 
s2_intersects(a, b, s2_options(model = "closed"))
s2_intersects(a, b, s2_options(model = "semi-open")) # a toss
s2_intersects(a, b) # default: semi-open

## ----eval=EVAL----------------------------------------------------------------
fiji = s2_data_countries("Fiji")
aa = s2_data_countries("Antarctica")
s2_bounds_cap(fiji)
s2_bounds_rect(c(fiji,aa))

## ----eval=EVAL----------------------------------------------------------------
sf_use_s2()

## ----eval=EVAL----------------------------------------------------------------
sf_use_s2(FALSE)

## ----eval=EVAL----------------------------------------------------------------
sf_use_s2(TRUE)

## ----eval=EVAL----------------------------------------------------------------
library(sf)
library(units)
nc = read_sf(system.file("gpkg/nc.gpkg", package="sf"))
sf_use_s2(TRUE)
a1 = st_area(nc)
sf_use_s2(FALSE)
a2 = st_area(nc)
plot(a1, a2)
abline(0, 1)
summary((a1 - a2)/a1)

## ----eval=EVAL----------------------------------------------------------------
nc_ls = st_cast(nc, "MULTILINESTRING")
l1 = st_length(nc_ls)
l2 = st_length(nc_ls, use_lwgeom = TRUE)
plot(l1 , l2)
abline(0, 1)
summary((l1-l2)/l1)

## ----eval=EVAL----------------------------------------------------------------
d1 = st_distance(nc, nc[1:10,])
d2 = st_distance(nc, nc[1:10,], use_lwgeom = TRUE)
dim(d1)
dim(d2)
plot(as.vector(d1), as.vector(d2))
abline(0, 1)
summary(as.vector(d1)-as.vector(d2))

