#' Cleaning data from gadm
#'
#' This function is for cleaning up the data retrieved from gadm.
#'
#' @param file_path file path of the gadm data to clean. Expected type of data
#'    is explained at \code{inst/exdata/README.md} file.
#'
#' @export
clean_gadm <- function(file_path = system.file("exdata/TUR_adm2.rds",
                                               package = "armap")) {
  gadm <- readRDS(file_path)

  gadm_data <- gadm@data

  gadm@data <- gadm@data %>%
    # Variables from gadm could have white space,
    # new line etc at the end or front
    dplyr::mutate(NAME_1 = trimws(NAME_1)) %>%
    dplyr::mutate(NAME_2 = trimws(NAME_2)) %>%

    # Changing city names
    dplyr::left_join(gadm_city_rename, by = c("NAME_1" = "gadm_city")) %>%
    dplyr::mutate(NAME_1 = ifelse(!is.na(tuik_city), tuik_city, NAME_1)) %>%
    dplyr::select(-tuik_city) %>%

    # Changing town names
    dplyr::left_join(gadm_town_rename, by = c("NAME_1" = "city",
                                              "NAME_2" = "old_town")) %>%
    dplyr::mutate(NAME_2 = ifelse(!is.na(new_town), new_town, NAME_2)) %>%
    dplyr::select(-new_town)

  # For some reason town uskudar contains the polygons for town silivri
  # in gadm data. Both of these towns belong to Istanbul. Silivri is not
  # present in the data.frame of the object. In order to fix this, I manually
  # divided polygons of uskudar and added it to the SpatialPolygonsDataFrame
  # as Silivri. I haven't documented the process and I don't think it's worth
  # the effort to regenerate.
  is_uskudar <- gadm$NAME_1 == "İstanbul" & gadm$NAME_2 == "Üsküdar"
  gadm <- gadm[!is_uskudar, ] # Taking out Uskudar with Silivri's polygon

  # Adding uskudar and silivri seperated. This is internal data in package.
  gadm <- rbind(gadm, uskudar_silivri)

  # Malatya has a polygon for city center which is actaully a part of town
  # Yesilyurt. Steps for creating merged yesilyurt is not present. Assigning
  # from internal data
  is_yesilyurt_merkez   <- (gadm$NAME_1 == "Malatya"
                            & gadm$NAME_2 %in% c("Merkez", "Yeşilyurt"))

  # Discard seperate yesilyurt and merkez
  gadm <- gadm[!is_yesilyurt_merkez,]

  # Adding the merged version
  gadm <- rbind(gadm, yesilyurt)

  gadm
}
