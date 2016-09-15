#' Merge map regions
#'
#' This function merges polygons in a map given a matching region
#'
#' @param map \code{\link[sp]{SpatialPolygonsDataFrame}}
#' @param matching_region matching region for each polygon. Merge will be
#'    done according to these regions
#'
#' @export
merge_region <- function(map, matching_region) {
  merged_polygons <- maptools::unionSpatialPolygons(map, matching_region)
  regions <- names(merged_polygons)

  # Here data.frame is used because rowname is necessary and tibbles
  # don't support rownames anymore
  polygon_data <- data.frame(
    rowname = regions,
    region = regions
  ) %>%
    tibble::column_to_rownames()

  sp::SpatialPolygonsDataFrame(merged_polygons, data = polygon_data)
}

