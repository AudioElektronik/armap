#' Add lat long to polygons
#'
#' Each polygon has a labpt point that is approx center of it
#' This function adds that to SpatialPolygonsDataFrame object
#'
#' @param map \code{\link[sp]{SpatialPolygonsDataFrame}} object.
#'
#' @export
add_point_to_polygons <- function(map) {
  point_data <- dplyr::bind_rows(
    lapply(map@polygons,
           function(p) {
             data.frame(lat = p@labpt[1], lon = p@labpt[2])
           }
    ))

  map@data <- map@data %>%
    dplyr::bind_cols(point_data)

  map
}
