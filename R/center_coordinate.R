#' This function finds the center of multiple coordinates
#'
#' @param coordinates list of c(lat, lon) coordinates to be averaged
#'
#' @export
center_coordinate <- function(coordinates) {
  # Getting the unique coordinate count to decide if its worth averaging
  unique_coor <- unique(arutil::strip_na(coordinates))
  count <- length(unique_coor)

  if (count == 0) {
    NA
  } else if (count == 1) {
    unique_coor[[1]]
  } else {
    # Making a matrix, coordinates are multiples of two
    coor_matrix <- t(matrix(unlist(unique_coor), nrow = 2))

    # Getting the centroid
    center <- rgeos::gCentroid(
      sp::SpatialPoints(coor_matrix,
                        proj4string = sp::CRS("+init=epsg:4326")))

    c(center$x, center$y)
  }
}
