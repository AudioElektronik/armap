#' Renaming city names in gadm data
#'
#' City names in map data taken from \href{http://gadm.org}{gadm} does not
#' align with city names from tuik. This frame is for converting them to the
#' way they are used in tuik.
gadm_city_rename <- tibble::frame_data(
  ~gadm_city  ,	  ~tuik_city,
  "Adiyaman  ",		"Adıyaman      ",
  "Afyon     ",		"Afyonkarahisar",
  "Agri      ",		"Ağrı          ",
  "Aydin     ",		"Aydın         ",
  "Balikesir ",		"Balıkesir     ",
  "Çankiri   ",		"Çankırı       ",
  "Diyarbakir",		"Diyarbakır    ",
  "Eskisehir ",		"Eskişehir     ",
  "Gümüshane ",		"Gümüşhane     ",
  "Istanbul  ",		"İstanbul      ",
  "Izmir     ",		"İzmir         ",
  "K. Maras  ",		"Kahramanmaraş ",
  "Kinkkale  ",		"Kırıkkale     ",
  "Kirklareli",		"Kırklareli    ",
  "Kirsehir  ",		"Kırşehir      ",
  "Mugla     ",		"Muğla         ",
  "Mus       ",		"Muş           ",
  "Nevsehir  ",		"Nevşehir      ",
  "Nigde     ",		"Niğde         ",
  "Sanliurfa ",		"Şanlıurfa     ",
  "Sirnak    ",		"Şırnak        ",
  "Tekirdag  ",		"Tekirdağ      ",
  "Usak      ",		"Uşak          ",
  "Zinguldak ",		"Zonguldak     "
) %>%
  arutil::make_frame_utf8() %>%
  dplyr::mutate_all(dplyr::funs(trimws(.))) %>%
  {setNames(.$tuik_city, .$gadm_city)}

#' Renaming town names in gadm data
#'
#' Town names in map data taken from \href{http://gadm.org}{gadm} does not
#' align with town names from tuik. This frame is for converting them to the
#' way they are used in tuik.
gadm_town_rename <- tibble::frame_data(
  ~city           ,	~old_town          ,	~new_town,
  "Adana         ",	"Karaisali        ",	"Karaisalı       ",
  "Afyonkarahisar",	"Sincanlı         ",	"Sinanpaşa       ",
  "Ağrı          ",	"Doğubeyazıt      ",	"Doğubayazıt     ",
  "Ankara        ",	"Şultan Koçhisar  ",	"Şereflikoçhisar ",
  "Antalya       ",	"İbradi           ",	"İbradı          ",
  "Antalya       ",	"Kale             ",	"Demre           ",
  "Aydın         ",	"Merkez           ",	"Efeler          ",
  "Bursa         ",	"Mustafa Kemalpaşa",	"Mustafakemalpaşa",
  "Denizli       ",	"Akköy            ",	"Pamukkale       ",
  "Denizli       ",	"Merkez           ",	"Merkezefendi    ",
  "Edirne        ",	"Süleoğlu         ",	"Süloğlu         ",
  "Elazığ        ",	"Aricak           ",	"Arıcak          ",
  "Erzurum       ",	"Ilıca            ",	"Aziziye         ",
  "Erzurum       ",	"Merkez           ",	"Yakutiye        ",
  "Eskişehir     ",	"Mihalıçcık       ",	"Mihalıççık      ",
  "Giresun       ",	"Şultan Karahisar ",	"Şebinkarahisar  ",
  "Hatay         ",	"Merkez           ",	"Antakya         ",
  "İstanbul      ",	"Arnavutkoy       ",	"Arnavutköy      ",
  "İstanbul      ",	"Atasehir         ",	"Ataşehir        ",
  "İstanbul      ",	"Basaksehir       ",	"Başakşehir      ",
  "İstanbul      ",	"Beylikduzu       ",	"Beylikdüzü      ",
  "İstanbul      ",	"Çekmekoy         ",	"Çekmeköy        ",
  "Kastamonu     ",	"Pınarbası        ",	"Pınarbaşı       ",
  "Kırıkkale     ",	"Bahşılı          ",	"Bahşili         ",
  "Konya         ",	"Hadım            ",	"Hadim           ",
  "Malatya       ",	"Arapkir          ",	"Arapgir         ",
  "Malatya       ",	"Pötürge          ",	"Pütürge         ",
  "Mardin        ",	"Merkez           ",	"Artuklu         ",
  "Muğla         ",	"Merkez           ",	"Menteşe         ",
  "Ordu          ",	"Merkez           ",	"Altınordu       ",
  "Samsun        ",	"Asarcik          ",	"Asarcık         ",
  "Samsun        ",	"Ondokuz Mayıs    ",	"19 Mayıs        ",
  "Siirt         ",	"Aydınlar         ",	"Tillo           ",
  "Tekirdağ      ",	"Merkez           ",	"Süleymanpaşa    ",
  "Trabzon       ",	"Merkez           ",	"Ortahisar       "
) %>%
  dplyr::mutate_all(dplyr::funs(trimws(.))) %>%
  arutil::make_frame_utf8()

