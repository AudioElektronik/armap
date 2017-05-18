#' Map data accessor function
#'
#' There is a lot of map data and variations in this package. This function
#' is for having one point to access them. Through this, maps for towns
#' cities or the whole country of Turkey can be received. Also, maps polygons
#' can be clustered as regions.
#'
#' @param level granularity of the map.
#' @param istanbul_part whether istanbul will be split into two continent parts
#' @param city_to_region a frame containing two variables \code{city, region}.
#'    city map will be merged according to those regions
#'
#' @export
get_map <- function(level = c("town", "city", "country"),
                                     istanbul_part = FALSE,
                                     city_to_region = NULL) {

  if (level == "town" | istanbul_part) {
    map <- gadm_map$towns

    # Preparing town map
    map_data <- map@data %>%
      dplyr::rename(city = NAME_1, town = NAME_2)

    if (istanbul_part) {
      map_data <- arutil::add_istanbul_part(map_data)
    }

    map@data <- map_data
  }

  if (level == "city") {
    if (istanbul_part) {
      # If Istanbul is asked to be seperated, then the previous
      # if block created the map for towns with seperated İstanbul.
      # We will use it for region merge
      map <- merge_region(map, map$city)
      map@data <- map@data %>%
        # merge_region() function saved region in the `region` variable
        dplyr::rename(city = region)
    } else {
      map <- gadm_map$cities
      map_data <- gadm_map$cities@data %>%
        dplyr::rename(city = NAME_1)
      map@data <- map_data
    }
  }

  if (!is.null(city_to_region)) {
    map@data <- map@data %>%
      dplyr::left_join(city_to_region, by = "city")

    # This map will have region data in its data.frame. We are not
    # altering it like on the if block of city because it is actually a region.
    map <- merge_region(map, map$region)
  }

  # Arge dokuman ekleme denemesi
  if (level == "country") {
    # Only country is left
    map <- gadm_map$country
  }

  # Adding central points to polygons
  map %>% add_point_to_polygons()
}


#' @importFrom dplyr %>%
NULL

# test_fonksiyonu <- function(test) {
#   print("deneme")
# }
