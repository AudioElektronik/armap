#' City apartment sales of Turkey
#'
#' A dataset containing maps of Turkey's administrative regions.
#' Raw data was obtained on September 1, 2016. Check source for details.
#'
#' Some city names were not Turkish and those were found manually and modified.
#' Unfortunately the full steps of data generation were not documented at
#' the time. This data is a list of 3 variables \code{country, cities, towns}.
#' All have the respective regions map data as polygons.
#'
#' Each variable is a \code{\link[sp]{SpatialPolygonsDataFrame}}.
#'
#' @source \url{http://www.gadm.org/country} - downloaded for Turkey
"gadm_map"
