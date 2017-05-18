#' This function converts a frame with polygons to SpatialPolygonsDataFrame
#'
#' @param frame a data frame containing polygon class ojects
#' @param polygon_var the column of data frame that contains polygons
#'
#' @export
convert_spdf <- function(frame, polygon_var) {
  polygon_list <- frame[[polygon_var]]

  # Making sure polygon list doesn't have names. This causes problems
  # on leaflet side. Nasty bug.
  names(polygon_list) <- NULL

  # Creating a SpatialPolygons object from polygon list. This
  # is required if you want to convert to SpatialPolygonsDataFrame
  sp_polygons <- sp::SpatialPolygons(polygon_list,
                                     proj4string = sp::CRS("+init=epsg:4326"))

  # Taking the polygons out of data, it will be in SPDF already
  data <- dplyr::select(frame, -dplyr::matches(polygon_var))

  # Adding polygon ID
  data$ID <- sapply(polygon_list, function(poly) poly@ID)

  # Creating the SPDF with the data.
  sp::SpatialPolygonsDataFrame(sp_polygons, data, match.ID = FALSE)
}
