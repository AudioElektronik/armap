#' This function fits the given leaflet map to polygons bounds
#'
#' @param leaflet a leaflet map instance
#' @param polygons a polygons object to zoom
#'
#' @export
fit_leaflet_box <- function(leaflet, polygons) {
  # Converting polygons to spatial polygons to get the bounding box
  sp_pol <- sp::SpatialPolygons(list(polygons))

  # Getting bounding box of sp as numeric
  coords <- as.numeric(sp_pol@bbox)

  # Calling leaflet fit bounds with the arguments
  do.call(leaflet::fitBounds, c(list(leaflet), coords))
}
