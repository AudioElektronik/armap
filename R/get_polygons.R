#' Get only polygons from the map object
#'
#' @export
get_polygons <- function() {
  tibble::tibble(
    city = armap::gadm_map$NAME_1,
    town = armap::gadm_map$NAME_2,
    polygon = armap::gadm_map@polygons
  )
}
