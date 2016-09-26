#' Relating gadm towns with tuik towns
#'
#' Town maps from \href{http://gadm.org}{gadm} is not complete. Some towns from
#' there are divided into two or more in reality. This frame describes which
#' towns that are available from tuik are part of which towns
#' available in gadm data.
#'
#' @export
gadm_town_parent <- tibble::frame_data(
  ~city          ,  ~tuik_town    , ~gadm_parent,
  "Adana        ",	"Çukurova    ",	"Seyhan    ",
  "Adana        ",	"Sarıçam     ",	"Yüreğir   ",
  "Ankara       ",	"Pursaklar   ",	"Çubuk     ",
  "Antalya      ",	"Aksu        ",	"Merkez    ",
  "Antalya      ",	"Döşemealtı  ",	"Merkez    ",
  "Antalya      ",	"Kepez       ",	"Merkez    ",
  "Antalya      ",	"Konyaaltı   ",	"Merkez    ",
  "Antalya      ",	"Muratpaşa   ",	"Merkez    ",
  "Balıkesir    ",	"Altıeylül   ",	"Merkez    ",
  "Balıkesir    ",	"Karesi      ",	"Merkez    ",
  "Diyarbakır   ",	"Bağlar      ",	"Merkez    ",
  "Diyarbakır   ",	"Kayapınar   ",	"Merkez    ",
  "Diyarbakır   ",	"Sur         ",	"Merkez    ",
  "Diyarbakır   ",	"Yenişehir   ",	"Merkez    ",
  "Erzurum      ",	"Palandöken  ",	"Yakutiye  ",
  "Eskişehir    ",	"Odunpazarı  ",	"Merkez    ",
  "Eskişehir    ",	"Tepebaşı    ",	"Merkez    ",
  "Hatay        ",	"Arsuz       ",	"İskenderun",
  "Hatay        ",	"Defne       ",	"Antakya   ",
  "Hatay        ",	"Payas       ",	"Dörtyol   ",
  "İzmir        ",	"Bayraklı    ",	"Karşıyaka ",
  "İzmir        ",	"Karabağlar  ",	"Konak     ",
  "Kahramanmaraş",	"Dulkadiroğlu",	"Merkez    ",
  "Kahramanmaraş",	"Onikişubat  ",	"Merkez    ",
  "Kocaeli      ",	"Başiskele   ",	"Merkez    ",
  "Kocaeli      ",	"Çayırova    ",	"Gebze     ",
  "Kocaeli      ",	"Darıca      ",	"Gebze     ",
  "Kocaeli      ",	"Dilovası    ",	"Gebze     ",
  "Kocaeli      ",	"İzmit       ",	"Merkez    ",
  "Kocaeli      ",	"Kartepe     ",	"Merkez    ",
  "Manisa       ",	"Şehzadeler  ",	"Merkez    ",
  "Manisa       ",	"Yunusemre   ",	"Merkez    ",
  "Mersin       ",	"Akdeniz     ",	"Merkez    ",
  "Mersin       ",	"Mezitli     ",	"Merkez    ",
  "Mersin       ",	"Toroslar    ",	"Merkez    ",
  "Mersin       ",	"Yenişehir   ",	"Merkez    ",
  "Muğla        ",	"Seydikemer  ",	"Fethiye   ",
  "Ordu         ",	"Çatalpınar  ",	"Kabataş   ",
  "Sakarya      ",	"Adapazarı   ",	"Merkez    ",
  "Sakarya      ",	"Arifiye     ",	"Merkez    ",
  "Sakarya      ",	"Erenler     ",	"Merkez    ",
  "Sakarya      ",	"Serdivan    ",	"Merkez    ",
  "Samsun       ",	"Atakum      ",	"Merkez    ",
  "Samsun       ",	"Canik       ",	"Merkez    ",
  "Samsun       ",	"İlkadım     ",	"Merkez    ",
  "Şanlıurfa    ",	"Eyyübiye    ",	"Merkez    ",
  "Şanlıurfa    ",	"Haliliye    ",	"Merkez    ",
  "Şanlıurfa    ",	"Karaköprü   ",	"Merkez    ",
  "Tekirdağ     ",	"Ergene      ",	"Çorlu     ",
  "Tekirdağ     ",	"Kapaklı     ",	"Çerkezköy ",
  "Van          ",	"İpekyolu    ",	"Merkez    ",
  "Van          ",	"Tuşba       ",	"Merkez    ",
  "Zonguldak    ",	"Kilimli     ",	"Merkez    ",
  "Zonguldak    ",	"Kozlu       ",	"Merkez    "
) %>%
  dplyr::mutate_all(dplyr::funs(trimws(.))) %>%
  arutil::make_frame_utf8()

#' Town parent data extended with town itself as child
#'
#' \code{\link{gadm_town_parent}} data attaches tuik towns to gadm towns.
#' However, some of those parents are themselves tuik towns. This function
#' adds those towns to the \code{gadm_town_parent} as children of themselves.
#'
#' @export
gadm_town_parent_self_children <- function() {
  # Getting parent towns that are themselves tuik towns
  self_parent <- gadm_town_parent %>%
    dplyr::distinct(city, gadm_parent) %>%
    dplyr::inner_join(artuik::tuik_towns,
                      by = c("city", "gadm_parent" = "town"))

  # Adding those towns as children of themselves
  gadm_town_parent %>%
    dplyr::bind_rows({
      self_parent %>%
        dplyr::mutate(tuik_town = gadm_parent)
    })
}
