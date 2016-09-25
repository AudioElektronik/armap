# library(armap)
# library(artuik)
# library(dplyr)
# library(tibble)
#
# towns <- gadm_map$towns
#
# tuik_towns <- town_population %>%
#   select(city, town) %>%
#   mutate(has = TRUE) %>%
#   arutil::make_frame_utf8()
# gadm_towns <- towns@data %>%
#   rename(city = NAME_1, town = NAME_2) %>%
#   select(city, town) %>%
#   mutate(has = TRUE) %>%
#   arutil::make_frame_utf8()
#
# join <- full_join(tuik_towns, gadm_towns,
#                   by = c("city", "town"), suffix = c("_tuik", "_gadm")) %>%
#   filter(is.na(has_tuik) | is.na(has_gadm)) %>%
#   arrange(city)
#
# gadm_town_rename <- tibble::frame_data(
#   ~city           ,	~old_town          ,	~new_town,
#   "Adana         ",	"Karaisali        ",	"Karaisalı       ",
#   "Afyonkarahisar",	"Sincanlı         ",	"Sinanpaşa       ",
#   "Ağrı          ",	"Doğubeyazıt      ",	"Doğubayazıt     ",
#   "Ankara        ",	"Şultan Koçhisar  ",	"Şereflikoçhisar ",
#   "Antalya       ",	"İbradi           ",	"İbradı          ",
#   "Antalya       ",	"Kale             ",	"Demre           ",
#   "Aydın         ",	"Merkez           ",	"Efeler          ",
#   "Bursa         ",	"Mustafa Kemalpaşa",	"Mustafakemalpaşa",
#   "Denizli       ",	"Akköy            ",	"Pamukkale       ",
#   "Denizli       ",	"Merkez           ",	"Merkezefendi    ",
#   "Edirne        ",	"Süleoğlu         ",	"Süloğlu         ",
#   "Elazığ        ",	"Aricak           ",	"Arıcak          ",
#   "Erzurum       ",	"Ilıca            ",	"Aziziye         ",
#   "Erzurum       ",	"Merkez           ",	"Yakutiye        ",
#   "Eskişehir     ",	"Mihalıçcık       ",	"Mihalıççık      ",
#   "Giresun       ",	"Şultan Karahisar ",	"Şebinkarahisar  ",
#   "Hatay         ",	"Merkez           ",	"Antakya         ",
#   "İstanbul      ",	"Arnavutkoy       ",	"Arnavutköy      ",
#   "İstanbul      ",	"Atasehir         ",	"Ataşehir        ",
#   "İstanbul      ",	"Basaksehir       ",	"Başakşehir      ",
#   "İstanbul      ",	"Beylikduzu       ",	"Beylikdüzü      ",
#   "İstanbul      ",	"Çekmekoy         ",	"Çekmeköy        ",
#   "Kastamonu     ",	"Pınarbası        ",	"Pınarbaşı       ",
#   "Kırıkkale     ",	"Bahşılı          ",	"Bahşili         ",
#   "Konya         ",	"Hadım            ",	"Hadim           ",
#   "Malatya       ",	"Arapkir          ",	"Arapgir         ",
#   "Malatya       ",	"Pötürge          ",	"Pütürge         ",
#   "Mardin        ",	"Merkez           ",	"Artuklu         ",
#   "Muğla         ",	"Merkez           ",	"Menteşe         ",
#   "Ordu          ",	"Merkez           ",	"Altınordu       ",
#   "Samsun        ",	"Asarcik          ",	"Asarcık         ",
#   "Samsun        ",	"Ondokuz Mayıs    ",	"19 Mayıs        ",
#   "Siirt         ",	"Aydınlar         ",	"Tillo           ",
#   "Tekirdağ      ",	"Merkez           ",	"Süleymanpaşa    ",
#   "Trabzon       ",	"Merkez           ",	"Ortahisar       "
# ) %>%
#   dplyr::mutate_all(dplyr::funs(trimws(.))) %>%
#   arutil::make_frame_utf8()
#
# gadm_towns <- gadm_towns %>%
#   left_join(replace_data, by = c("city", "town" = "old_town")) %>%
#   mutate(town = ifelse(!is.na(new_town), new_town, town)) %>%
#   select(-new_town)
#
# join2 <- full_join(tuik_towns, gadm_towns,
#                   by = c("city", "town"), suffix = c("_tuik", "_gadm")) %>%
#   filter(is.na(has_tuik) | is.na(has_gadm)) %>%
#   arrange(city)
#
# gadm_town_parent <- frame_data(
#   ~city          ,  ~tuik_town    , ~gadm_parent,
#   "Adana        ",	"Çukurova    ",	"Seyhan    ",
#   "Adana        ",	"Sarıçam     ",	"Yüreğir   ",
#   "Ankara       ",	"Pursaklar   ",	"Çubuk     ",
#   "Antalya      ",	"Aksu        ",	"Merkez    ",
#   "Antalya      ",	"Döşemealtı  ",	"Merkez    ",
#   "Antalya      ",	"Kepez       ",	"Merkez    ",
#   "Antalya      ",	"Konyaaltı   ",	"Merkez    ",
#   "Antalya      ",	"Muratpaşa   ",	"Merkez    ",
#   "Balıkesir    ",	"Altıeylül   ",	"Merkez    ",
#   "Balıkesir    ",	"Karesi      ",	"Merkez    ",
#   "Diyarbakır   ",	"Bağlar      ",	"Merkez    ",
#   "Diyarbakır   ",	"Kayapınar   ",	"Merkez    ",
#   "Diyarbakır   ",	"Sur         ",	"Merkez    ",
#   "Diyarbakır   ",	"Yenişehir   ",	"Merkez    ",
#   "Erzurum      ",	"Palandöken  ",	"Yakutiye  ",
#   "Eskişehir    ",	"Odunpazarı  ",	"Merkez    ",
#   "Eskişehir    ",	"Tepebaşı    ",	"Merkez    ",
#   "Hatay        ",	"Arsuz       ",	"İskenderun",
#   "Hatay        ",	"Defne       ",	"Antakya   ",
#   "Hatay        ",	"Payas       ",	"Dörtyol   ",
#   "İzmir        ",	"Bayraklı    ",	"Karşıyaka ",
#   "İzmir        ",	"Karabağlar  ",	"Konak     ",
#   "Kahramanmaraş",	"Dulkadiroğlu",	"Merkez    ",
#   "Kahramanmaraş",	"Onikişubat  ",	"Merkez    ",
#   "Kocaeli      ",	"Başiskele   ",	"Merkez    ",
#   "Kocaeli      ",	"Çayırova    ",	"Gebze     ",
#   "Kocaeli      ",	"Darıca      ",	"Gebze     ",
#   "Kocaeli      ",	"Dilovası    ",	"Gebze     ",
#   "Kocaeli      ",	"İzmit       ",	"Merkez    ",
#   "Kocaeli      ",	"Kartepe     ",	"Merkez    ",
#   "Manisa       ",	"Şehzadeler  ",	"Merkez    ",
#   "Manisa       ",	"Yunusemre   ",	"Merkez    ",
#   "Mersin       ",	"Akdeniz     ",	"Merkez    ",
#   "Mersin       ",	"Mezitli     ",	"Merkez    ",
#   "Mersin       ",	"Toroslar    ",	"Merkez    ",
#   "Mersin       ",	"Yenişehir   ",	"Merkez    ",
#   "Muğla        ",	"Seydikemer  ",	"Fethiye   ",
#   "Ordu         ",	"Çatalpınar  ",	"Kabataş   ",
#   "Sakarya      ",	"Adapazarı   ",	"Merkez    ",
#   "Sakarya      ",	"Arifiye     ",	"Merkez    ",
#   "Sakarya      ",	"Erenler     ",	"Merkez    ",
#   "Sakarya      ",	"Serdivan    ",	"Merkez    ",
#   "Samsun       ",	"Atakum      ",	"Merkez    ",
#   "Samsun       ",	"Canik       ",	"Merkez    ",
#   "Samsun       ",	"İlkadım     ",	"Merkez    ",
#   "Şanlıurfa    ",	"Eyyübiye    ",	"Merkez    ",
#   "Şanlıurfa    ",	"Haliliye    ",	"Merkez    ",
#   "Şanlıurfa    ",	"Karaköprü   ",	"Merkez    ",
#   "Tekirdağ     ",	"Ergene      ",	"Çorlu     ",
#   "Tekirdağ     ",	"Kapaklı     ",	"Çerkezköy ",
#   "Van          ",	"İpekyolu    ",	"Merkez    ",
#   "Van          ",	"Tuşba       ",	"Merkez    ",
#   "Zonguldak    ",	"Kilimli     ",	"Merkez    ",
#   "Zonguldak    ",	"Kozlu       ",	"Merkez    "
#   ) %>%
#   dplyr::mutate_all(dplyr::funs(trimws(.))) %>%
#   arutil::make_frame_utf8()
#
#
#
#
#
# ) %>%
#   arutil::make_frame_utf8()
#
#
# gadm_city_rename <- tibble::frame_data(
#   ~gadm_city  ,	  ~tuik_city,
#   "Adiyaman  ",		"Adıyaman      ",
#   "Afyon     ",		"Afyonkarahisar",
#   "Agri      ",		"Ağrı          ",
#   "Aydin     ",		"Aydın         ",
#   "Balikesir ",		"Balıkesir     ",
#   "Çankiri   ",		"Çankırı       ",
#   "Diyarbakir",		"Diyarbakır    ",
#   "Eskisehir ",		"Eskişehir     ",
#   "Gümüshane ",		"Gümüşhane     ",
#   "Istanbul  ",		"İstanbul      ",
#   "Izmir     ",		"İzmir         ",
#   "K. Maras  ",		"Kahramanmaraş ",
#   "Kinkkale  ",		"Kırıkkale     ",
#   "Kirklareli",		"Kırklareli    ",
#   "Kirsehir  ",		"Kırşehir      ",
#   "Mugla     ",		"Muğla         ",
#   "Mus       ",		"Muş           ",
#   "Nevsehir  ",		"Nevşehir      ",
#   "Nigde     ",		"Niğde         ",
#   "Sanliurfa ",		"Şanlıurfa     ",
#   "Sirnak    ",		"Şırnak        ",
#   "Tekirdag  ",		"Tekirdağ      ",
#   "Usak      ",		"Uşak          ",
#   "Zinguldak ",		"Zonguldak     "
# ) %>%
#   arutil::make_frame_utf8() %>%
#   dplyr::mutate_all(dplyr::funs(trimws(.))) %>%
#   {setNames(.$tuik_city, .$gadm_city)}
