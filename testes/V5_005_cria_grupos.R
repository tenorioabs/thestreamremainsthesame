################################################################################
################################################################################
# Bloco 5, substitui nomes de grupos e atualiza o arquivo "minha_lista_concatenada.m3u8"
# Define o caminho do arquivo de entrada e de saída
arquivo_entrada <- "minha_lista_concatenada.m3u8"
arquivo_saida <- "minha_lista_concatenada.m3u8"

# Lê o conteúdo do arquivo de entrada
conteudo <- readLines(arquivo_entrada, warn = FALSE)

# Lista de títulos de grupos que devem ser mantidos
titulos_mantidos <- c("Australia",
                      "Brazil",
                      "Canada",
                      "EFL",
                      "EPL",
                      "Great Britain",
                      "MLB",
                      "Music",
                      "NFL",
                      "NHL",
                      "Portugal",
                      "United States",
                      "NBA",
                      "UFC",
                      "Video Game")

# Função para verificar e substituir os títulos dos grupos
substituir_titulos <- function(linha) {
  # Verifica se a linha é um canal
  if (grepl("^#EXTINF:", linha)) {
    if (grepl('group-title="Canais \\| Band"', linha)) { linha <- sub('group-title="Canais \\| Band"', 'group-title="Brazil"', linha) }
    if (grepl('group-title="Canais \\| Campeonatos "', linha)) { linha <- sub('group-title="Canais \\| Campeonatos "', 'group-title="Brazil"', linha) }
    if (grepl('group-title="Canais \\| Jogos de hoje "', linha)) { linha <- sub('group-title="Canais \\| Jogos de hoje "', 'group-title="Brazil"', linha) }
    if (grepl('group-title="Canais \\| NBA League Pass"', linha)) { linha <- sub('group-title="Canais \\| NBA League Pass"', 'group-title="NBA"', linha) }
    if (grepl('group-title="\\(AU\\) Australia"', linha)) { linha <- sub('group-title="\\(AU\\) Australia"', 'group-title="Australia"', linha) }
    if (grepl('group-title="\\(BR\\) Brazil"', linha)) { linha <- sub('group-title="\\(BR\\) Brazil"', 'group-title="Brazil"', linha) }
    if (grepl('group-title="\\(CA\\) Canada"', linha)) { linha <- sub('group-title="\\(CA\\) Canada"', 'group-title="Canada"', linha) }
    if (grepl('group-title="\\(PT\\) Portugal"', linha)) { linha <- sub('group-title="\\(PT\\) Portugal"', 'group-title="Portugal"', linha) }
    if (grepl('group-title="\\(UK\\) United Kingdom"', linha)) { linha <- sub('group-title="\\(UK\\) United Kingdom"', 'group-title="Great Britain"', linha) }
    if (grepl('group-title="\\(US\\) United States"', linha)) { linha <- sub('group-title="\\(US\\) United States"', 'group-title="United States"', linha) }
    if (grepl('group-title="Amazon Events"', linha)) { linha <- sub('group-title="Amazon Events"', 'group-title="United States"', linha) }
    if (grepl('group-title="Animation"', linha)) { linha <- sub('group-title="Animation"', 'group-title="United States"', linha) }
    if (grepl('group-title="Animation;Classic"', linha)) { linha <- sub('group-title="Animation;Classic"', 'group-title="United States"', linha) }
    if (grepl('group-title="Animation;Classic;Entertainment;Family;Movies"', linha)) { linha <- sub('group-title="Animation;Classic;Entertainment;Family;Movies"', 'group-title="United States"', linha) }
    if (grepl('group-title="Animation;Culture;Entertainment"', linha)) { linha <- sub('group-title="Animation;Culture;Entertainment"', 'group-title="United States"', linha) }
    if (grepl('group-title="Animation;Entertainment;Movies;Series"', linha)) { linha <- sub('group-title="Animation;Entertainment;Movies;Series"', 'group-title="United States"', linha) }
    if (grepl('group-title="Animation;Kids"', linha)) { linha <- sub('group-title="Animation;Kids"', 'group-title="United States"', linha) }
    if (grepl('group-title="Animation;Kids;Music"', linha)) { linha <- sub('group-title="Animation;Kids;Music"', 'group-title="United States"', linha) }
    if (grepl('group-title="Animation;Kids;Religious"', linha)) { linha <- sub('group-title="Animation;Kids;Religious"', 'group-title="United States"', linha) }
    if (grepl('group-title="Au"', linha)) { linha <- sub('group-title="Au"', 'group-title="Australia"', linha) }
    if (grepl('group-title="AU SPORTS AND RUGBY"', linha)) { linha <- sub('group-title="AU SPORTS AND RUGBY"', 'group-title="Australia"', linha) }
    if (grepl('group-title="Australia"', linha)) { linha <- sub('group-title="Australia"', 'group-title="Australia"', linha) }
    if (grepl('group-title="Auto;Entertainment"', linha)) { linha <- sub('group-title="Auto;Entertainment"', 'group-title="United States"', linha) }
    if (grepl('group-title="BEIN Sports"', linha)) { linha <- sub('group-title="BEIN Sports"', 'group-title="United States"', linha) }
    if (grepl('group-title="BONUS SPORTS CHANNELS"', linha)) { linha <- sub('group-title="BONUS SPORTS CHANNELS"', 'group-title="United States"', linha) }
    if (grepl('group-title="BRASIL"', linha)) { linha <- sub('group-title="BRASIL"', 'group-title="Brazil"', linha) }
    if (grepl('group-title="Brasil: cinema em português"', linha)) { linha <- sub('group-title="Brasil: cinema em português"', 'group-title="Brazil"', linha) }
    if (grepl('group-title="Brasil: cristianismo em português"', linha)) { linha <- sub('group-title="Brasil: cristianismo em português"', 'group-title="Brazil"', linha) }
    if (grepl('group-title="Brasil: educativos e documentários"', linha)) { linha <- sub('group-title="Brasil: educativos e documentários"', 'group-title="Brazil"', linha) }
    if (grepl('group-title="Brasil: esportes e e-sports"', linha)) { linha <- sub('group-title="Brasil: esportes e e-sports"', 'group-title="Brazil"', linha) }
    if (grepl('group-title="Brasil: humor; novelas e séries"', linha)) { linha <- sub('group-title="Brasil: humor; novelas e séries"', 'group-title="Brazil"', linha) }
    if (grepl('group-title="Brasil: infanto-juvenis"', linha)) { linha <- sub('group-title="Brasil: infanto-juvenis"', 'group-title="Brazil"', linha) }
    if (grepl('group-title="Brasil: lifestyle e realities"', linha)) { linha <- sub('group-title="Brasil: lifestyle e realities"', 'group-title="Brazil"', linha) }
    if (grepl('group-title="Brasil: maratona de ficção"', linha)) { linha <- sub('group-title="Brasil: maratona de ficção"', 'group-title="Brazil"', linha) }
    if (grepl('group-title="Brasil: notícias em português"', linha)) { linha <- sub('group-title="Brasil: notícias em português"', 'group-title="Brazil"', linha) }
    if (grepl('group-title="Brasil: rádios em português"', linha)) { linha <- sub('group-title="Brasil: rádios em português"', 'group-title="Brazil"', linha) }
    if (grepl('group-title="Brasil: variedades em português"', linha)) { linha <- sub('group-title="Brasil: variedades em português"', 'group-title="Brazil"', linha) }
    if (grepl('group-title="Business"', linha)) { linha <- sub('group-title="Business"', 'group-title="United States"', linha) }
    if (grepl('group-title="Business;Legislative;News"', linha)) { linha <- sub('group-title="Business;Legislative;News"', 'group-title="United States"', linha) }
    if (grepl('group-title="Business;News"', linha)) { linha <- sub('group-title="Business;News"', 'group-title="United States"', linha) }
    if (grepl('group-title="Business;Travel"', linha)) { linha <- sub('group-title="Business;Travel"', 'group-title="United States"', linha) }
    if (grepl('group-title="Caça; pesca e rodeio em inglês"', linha)) { linha <- sub('group-title="Caça; pesca e rodeio em inglês"', 'group-title="United States"', linha) }
    if (grepl('group-title="CANADA"', linha)) { linha <- sub('group-title="CANADA"', 'group-title="Canada"', linha) }
    if (grepl('group-title="Canais \\| Abertos"', linha)) { linha <- sub('group-title="Canais \\| Abertos"', 'group-title="Brazil"', linha) }
    if (grepl('group-title="Canais \\| Globo Sul"', linha)) { linha <- sub('group-title="Canais \\| Globo Sul"', 'group-title="Brazil"', linha) }
    if (grepl('group-title="Canais \\| Religiosos"', linha)) { linha <- sub('group-title="Canais \\| Religiosos"', 'group-title="Brazil"', linha) }
    if (grepl('group-title="Canais \\| Variedades "', linha)) { linha <- sub('group-title="Canais \\| Variedades "', 'group-title="Brazil"', linha) }
    if (grepl('group-title="Canais \\| Cine Sky"', linha)) { linha <- sub('group-title="Canais \\| Cine Sky"', 'group-title="Brazil"', linha) }
    if (grepl('group-title="Canais \\| Dc Comics 24 Horas"', linha)) { linha <- sub('group-title="Canais \\| Dc Comics 24 Horas"', 'group-title="Brazil"', linha) }
    if (grepl('group-title="Canais \\| Desenhos 24 horas"', linha)) { linha <- sub('group-title="Canais \\| Desenhos 24 horas"', 'group-title="Brazil"', linha) }
    if (grepl('group-title="Canais \\| Discovery"', linha)) { linha <- sub('group-title="Canais \\| Discovery"', 'group-title="Brazil"', linha) }
    if (grepl('group-title="Canais \\| Documentarios"', linha)) { linha <- sub('group-title="Canais \\| Documentarios"', 'group-title="Brazil"', linha) }
    if (grepl('group-title="Canais \\| ESPN"', linha)) { linha <- sub('group-title="Canais \\| ESPN"', 'group-title="Brazil"', linha) }
    if (grepl('group-title="Canais \\| Esportes"', linha)) { linha <- sub('group-title="Canais \\| Esportes"', 'group-title="Brazil"', linha) }
    if (grepl('group-title="Canais \\| Estadio TNT Sports"', linha)) { linha <- sub('group-title="Canais \\| Estadio TNT Sports"', 'group-title="Brazil"', linha) }
    if (grepl('group-title="Canais \\| Filmes & Series"', linha)) { linha <- sub('group-title="Canais \\| Filmes & Series"', 'group-title="Brazil"', linha) }
    if (grepl('group-title="Canais \\| Filmes 24 horas"', linha)) { linha <- sub('group-title="Canais \\| Filmes 24 horas"', 'group-title="Brazil"', linha) }
    if (grepl('group-title="Canais \\| Globo Centro-Oeste"', linha)) { linha <- sub('group-title="Canais \\| Globo Centro-Oeste"', 'group-title="Brazil"', linha) }
    if (grepl('group-title="Canais \\| Globo Nordeste"', linha)) { linha <- sub('group-title="Canais \\| Globo Nordeste"', 'group-title="Brazil"', linha) }
    if (grepl('group-title="Canais \\| Globo Norte"', linha)) { linha <- sub('group-title="Canais \\| Globo Norte"', 'group-title="Brazil"', linha) }
    if (grepl('group-title="Canais \\| Globo Sudeste"', linha)) { linha <- sub('group-title="Canais \\| Globo Sudeste"', 'group-title="Brazil"', linha) }
    if (grepl('group-title="Canais \\| HBO"', linha)) { linha <- sub('group-title="Canais \\| HBO"', 'group-title="Brazil"', linha) }
    if (grepl('group-title="Canais \\| HBO MAX"', linha)) { linha <- sub('group-title="Canais \\| HBO MAX"', 'group-title="Brazil"', linha) }
    if (grepl('group-title="Canais \\| Infantil"', linha)) { linha <- sub('group-title="Canais \\| Infantil"', 'group-title="Brazil"', linha) }
    if (grepl('group-title="Canais \\| Legendados"', linha)) { linha <- sub('group-title="Canais \\| Legendados"', 'group-title="Brazil"', linha) }
    if (grepl('group-title="Canais \\| Marvel 24 Horas"', linha)) { linha <- sub('group-title="Canais \\| Marvel 24 Horas"', 'group-title="Brazil"', linha) }
    if (grepl('group-title="Canais \\| Natureza - Relax"', linha)) { linha <- sub('group-title="Canais \\| Natureza - Relax"', 'group-title="Brazil"', linha) }
    if (grepl('group-title="Canais \\| NFL Gamepass"', linha)) { linha <- sub('group-title="Canais \\| NFL Gamepass"', 'group-title="NFL"', linha) }
    if (grepl('group-title="Canais \\| Noticias"', linha)) { linha <- sub('group-title="Canais \\| Noticias"', 'group-title="Brazil"', linha) }
    if (grepl('group-title="Canais \\| Paramount \\+ "', linha)) { linha <- sub('group-title="Canais \\| Paramount \\+ "', 'group-title="Brazil"', linha) }
    if (grepl('group-title="Canais \\| Pay-per-view"', linha)) { linha <- sub('group-title="Canais \\| Pay-per-view"', 'group-title="Brazil"', linha) }
    if (grepl('group-title="Canais \\| Portugal"', linha)) { linha <- sub('group-title="Canais \\| Portugal"', 'group-title="Portugal"', linha) }
    if (grepl('group-title="Canais \\| Premiere"', linha)) { linha <- sub('group-title="Canais \\| Premiere"', 'group-title="Brazil"', linha) }
    if (grepl('group-title="Canais \\| Record"', linha)) { linha <- sub('group-title="Canais \\| Record"', 'group-title="Brazil"', linha) }
    if (grepl('group-title="Canais \\| SBT"', linha)) { linha <- sub('group-title="Canais \\| SBT"', 'group-title="Brazil"', linha) }
    if (grepl('group-title="Canais \\| Shows 24H"', linha)) { linha <- sub('group-title="Canais \\| Shows 24H"', 'group-title="Brazil"', linha) }
    if (grepl('group-title="Canais \\| Sport World"', linha)) { linha <- sub('group-title="Canais \\| Sport World"', 'group-title="Brazil"', linha) }
    if (grepl('group-title="Canais \\| SporTV"', linha)) { linha <- sub('group-title="Canais \\| SporTV"', 'group-title="Brazil"', linha) }
    if (grepl('group-title="Canais \\| Star  Sports"', linha)) { linha <- sub('group-title="Canais \\| Star  Sports"', 'group-title="Brazil"', linha) }
    if (grepl('group-title="Canais \\| Star Channel"', linha)) { linha <- sub('group-title="Canais \\| Star Channel"', 'group-title="Brazil"', linha) }
    if (grepl('group-title="Canais \\| Telecine"', linha)) { linha <- sub('group-title="Canais \\| Telecine"', 'group-title="Brazil"', linha) }
    if (grepl('group-title="Canais \\| Top 15 Cine Sky"', linha)) { linha <- sub('group-title="Canais \\| Top 15 Cine Sky"', 'group-title="Brazil"', linha) }
    if (grepl('group-title="Canais \\| United States"', linha)) { linha <- sub('group-title="Canais \\| United States"', 'group-title="United States"', linha) }
    if (grepl('group-title="Casa e decoração em inglês"', linha)) { linha <- sub('group-title="Casa e decoração em inglês"', 'group-title="United States"', linha) }
    if (grepl('group-title="Celebridades e cultura pop em inglês"', linha)) { linha <- sub('group-title="Celebridades e cultura pop em inglês"', 'group-title="United States"', linha) }
    if (grepl('group-title="Cinema em inglês"', linha)) { linha <- sub('group-title="Cinema em inglês"', 'group-title="United States"', linha) }
    if (grepl('group-title="Classic"', linha)) { linha <- sub('group-title="Classic"', 'group-title="United States"', linha) }
    if (grepl('group-title="Classic;Movies"', linha)) { linha <- sub('group-title="Classic;Movies"', 'group-title="United States"', linha) }
    if (grepl('group-title="Classic;Music"', linha)) { linha <- sub('group-title="Classic;Music"', 'group-title="Music"', linha) }
    if (grepl('group-title="Comedy"', linha)) { linha <- sub('group-title="Comedy"', 'group-title="United States"', linha) }
    if (grepl('group-title="Comedy;Movies"', linha)) { linha <- sub('group-title="Comedy;Movies"', 'group-title="United States"', linha) }
    if (grepl('group-title="Comedy;Series"', linha)) { linha <- sub('group-title="Comedy;Series"', 'group-title="United States"', linha) }
    if (grepl('group-title="Cooking"', linha)) { linha <- sub('group-title="Cooking"', 'group-title="United States"', linha) }
    if (grepl('group-title="Cooking;Shop"', linha)) { linha <- sub('group-title="Cooking;Shop"', 'group-title="United States"', linha) }
    if (grepl('group-title="Cricket"', linha)) { linha <- sub('group-title="Cricket"', 'group-title="United States"', linha) }
    if (grepl('group-title="Cristianismo em inglês"', linha)) { linha <- sub('group-title="Cristianismo em inglês"', 'group-title="United States"', linha) }
    if (grepl('group-title="Culture"', linha)) { linha <- sub('group-title="Culture"', 'group-title="United States"', linha) }
    if (grepl('group-title="Culture;Documentary;Education;Kids;Lifestyle;Science"', linha)) { linha <- sub('group-title="Culture;Documentary;Education;Kids;Lifestyle;Science"', 'group-title="United States"', linha) }
    if (grepl('group-title="Culture;Documentary;Entertainment;General;Movies;Music"', linha)) { linha <- sub('group-title="Culture;Documentary;Entertainment;General;Movies;Music"', 'group-title="United States"', linha) }
    if (grepl('group-title="Culture;Education"', linha)) { linha <- sub('group-title="Culture;Education"', 'group-title="United States"', linha) }
    if (grepl('group-title="Culture;Education;Entertainment"', linha)) { linha <- sub('group-title="Culture;Education;Entertainment"', 'group-title="United States"', linha) }
    if (grepl('group-title="Culture;Education;Lifestyle"', linha)) { linha <- sub('group-title="Culture;Education;Lifestyle"', 'group-title="United States"', linha) }
    if (grepl('group-title="Culture;Entertainment"', linha)) { linha <- sub('group-title="Culture;Entertainment"', 'group-title="United States"', linha) }
    if (grepl('group-title="Culture;Entertainment;Music"', linha)) { linha <- sub('group-title="Culture;Entertainment;Music"', 'group-title="United States"', linha) }
    if (grepl('group-title="Culture;Entertainment;News"', linha)) { linha <- sub('group-title="Culture;Entertainment;News"', 'group-title="United States"', linha) }
    if (grepl('group-title="Culture;Family"', linha)) { linha <- sub('group-title="Culture;Family"', 'group-title="United States"', linha) }
    if (grepl('group-title="Culture;General"', linha)) { linha <- sub('group-title="Culture;General"', 'group-title="United States"', linha) }
    if (grepl('group-title="Culture;General;Music;News"', linha)) { linha <- sub('group-title="Culture;General;Music;News"', 'group-title="United States"', linha) }
    if (grepl('group-title="Culture;Music"', linha)) { linha <- sub('group-title="Culture;Music"', 'group-title="United States"', linha) }
    if (grepl('group-title="Culture;News"', linha)) { linha <- sub('group-title="Culture;News"', 'group-title="United States"', linha) }
    if (grepl('group-title="Culture;Religious"', linha)) { linha <- sub('group-title="Culture;Religious"', 'group-title="United States"', linha) }
    if (grepl('group-title="Culture;Science"', linha)) { linha <- sub('group-title="Culture;Science"', 'group-title="United States"', linha) }
    if (grepl('group-title="Culture;Sports"', linha)) { linha <- sub('group-title="Culture;Sports"', 'group-title="United States"', linha) }
    if (grepl('group-title="Culture;Travel"', linha)) { linha <- sub('group-title="Culture;Travel"', 'group-title="United States"', linha) }
    if (grepl('group-title="Darwin"', linha)) { linha <- sub('group-title="Darwin"', 'group-title="United States"', linha) }
    if (grepl('group-title="DAZN SPORTS"', linha)) { linha <- sub('group-title="DAZN SPORTS"', 'group-title="United States"', linha) }
    if (grepl('group-title="Documentaries \\(EN\\)"', linha)) { linha <- sub('group-title="Documentaries \\(EN\\)"', 'group-title="United States"', linha) }
    if (grepl('group-title="Documentário"', linha)) { linha <- sub('group-title="Documentário"', 'group-title="Brazil"', linha) }
    if (grepl('group-title="Documentários em inglês"', linha)) { linha <- sub('group-title="Documentários em inglês"', 'group-title="United States"', linha) }
    if (grepl('group-title="Documentary"', linha)) { linha <- sub('group-title="Documentary"', 'group-title="United States"', linha) }
    if (grepl('group-title="Documentary;Education"', linha)) { linha <- sub('group-title="Documentary;Education"', 'group-title="United States"', linha) }
    if (grepl('group-title="Documentary;Entertainment"', linha)) { linha <- sub('group-title="Documentary;Entertainment"', 'group-title="United States"', linha) }
    if (grepl('group-title="Documentary;Entertainment;News"', linha)) { linha <- sub('group-title="Documentary;Entertainment;News"', 'group-title="United States"', linha) }
    if (grepl('group-title="Documentary;Lifestyle"', linha)) { linha <- sub('group-title="Documentary;Lifestyle"', 'group-title="United States"', linha) }
    if (grepl('group-title="Documentary;News"', linha)) { linha <- sub('group-title="Documentary;News"', 'group-title="United States"', linha) }
    if (grepl('group-title="Documentary;Science"', linha)) { linha <- sub('group-title="Documentary;Science"', 'group-title="United States"', linha) }
    if (grepl('group-title="Documentary;Travel"', linha)) { linha <- sub('group-title="Documentary;Travel"', 'group-title="United States"', linha) }
    if (grepl('group-title="DOCUMENTRY"', linha)) { linha <- sub('group-title="DOCUMENTRY"', 'group-title="United States"', linha) }
    if (grepl('group-title="Education"', linha)) { linha <- sub('group-title="Education"', 'group-title="United States"', linha) }
    if (grepl('group-title="Education;General"', linha)) { linha <- sub('group-title="Education;General"', 'group-title="United States"', linha) }
    if (grepl('group-title="Education;Kids"', linha)) { linha <- sub('group-title="Education;Kids"', 'group-title="United States"', linha) }
    if (grepl('group-title="Education;Outdoor"', linha)) { linha <- sub('group-title="Education;Outdoor"', 'group-title="United States"', linha) }
    if (grepl('group-title="Education;Outdoor;Relax"', linha)) { linha <- sub('group-title="Education;Outdoor;Relax"', 'group-title="United States"', linha) }
    if (grepl('group-title="Education;Religious"', linha)) { linha <- sub('group-title="Education;Religious"', 'group-title="United States"', linha) }
    if (grepl('group-title="Education;Science"', linha)) { linha <- sub('group-title="Education;Science"', 'group-title="United States"', linha) }
    if (grepl('group-title="EFL CHAMPS"', linha)) { linha <- sub('group-title="EFL CHAMPS"', 'group-title="EFL"', linha) }
    if (grepl('group-title="EFL LEAGUE 1"', linha)) { linha <- sub('group-title="EFL LEAGUE 1"', 'group-title="EFL"', linha) }
    if (grepl('group-title="EFL LEAGUE 2"', linha)) { linha <- sub('group-title="EFL LEAGUE 2"', 'group-title="EFL"', linha) }
    if (grepl('group-title="Entertainment"', linha)) { linha <- sub('group-title="Entertainment"', 'group-title="United States"', linha) }
    if (grepl('group-title="ENTERTAINMENT"', linha)) { linha <- sub('group-title="ENTERTAINMENT"', 'group-title="United States"', linha) }
    if (grepl('group-title="Entertainment;Family"', linha)) { linha <- sub('group-title="Entertainment;Family"', 'group-title="United States"', linha) }
    if (grepl('group-title="Entertainment;General"', linha)) { linha <- sub('group-title="Entertainment;General"', 'group-title="Music"', linha) }
    if (grepl('group-title="Entertainment;Music"', linha)) { linha <- sub('group-title="Entertainment;Music"', 'group-title="United States"', linha) }
    if (grepl('group-title="Entertainment;Music;News"', linha)) { linha <- sub('group-title="Entertainment;Music;News"', 'group-title="United States"', linha) }
    if (grepl('group-title="Entertainment;News"', linha)) { linha <- sub('group-title="Entertainment;News"', 'group-title="United States"', linha) }
    if (grepl('group-title="Entertainment;Series"', linha)) { linha <- sub('group-title="Entertainment;Series"', 'group-title="United States"', linha) }
    if (grepl('group-title="Entertainment;Sports"', linha)) { linha <- sub('group-title="Entertainment;Sports"', 'group-title="United States"', linha) }
    if (grepl('group-title="Entertainment;Travel"', linha)) { linha <- sub('group-title="Entertainment;Travel"', 'group-title="United States"', linha) }
    if (grepl('group-title="EPL"', linha)) { linha <- sub('group-title="EPL"', 'group-title="EPL"', linha) }
    if (grepl('group-title="ESPN PLUS"', linha)) { linha <- sub('group-title="ESPN PLUS"', 'group-title="United States"', linha) }
    if (grepl('group-title="Esportes"', linha)) { linha <- sub('group-title="Esportes"', 'group-title="Brazil"', linha) }
    if (grepl('group-title="Esportes em inglês"', linha)) { linha <- sub('group-title="Esportes em inglês"', 'group-title="United States"', linha) }
    if (grepl('group-title="Esportes em inglês: automobilismo"', linha)) { linha <- sub('group-title="Esportes em inglês: automobilismo"', 'group-title="United States"', linha) }
    if (grepl('group-title="Esportes em inglês: lutas"', linha)) { linha <- sub('group-title="Esportes em inglês: lutas"', 'group-title="United States"', linha) }
    if (grepl('group-title="Extrema direita \\| EUA"', linha)) { linha <- sub('group-title="Extrema direita \\| EUA"', 'group-title="United States"', linha) }
    if (grepl('group-title="Family"', linha)) { linha <- sub('group-title="Family"', 'group-title="United States"', linha) }
    if (grepl('group-title="Family;General"', linha)) { linha <- sub('group-title="Family;General"', 'group-title="United States"', linha) }
    if (grepl('group-title="Family;Movies"', linha)) { linha <- sub('group-title="Family;Movies"', 'group-title="United States"', linha) }
    if (grepl('group-title="Family;Movies;Series"', linha)) { linha <- sub('group-title="Family;Movies;Series"', 'group-title="United States"', linha) }
    if (grepl('group-title="Family;Religious"', linha)) { linha <- sub('group-title="Family;Religious"', 'group-title="United States"', linha) }
    if (grepl('group-title="Filmes"', linha)) { linha <- sub('group-title="Filmes"', 'group-title="United States"', linha) }
    if (grepl('group-title="Fite TV"', linha)) { linha <- sub('group-title="Fite TV"', 'group-title="United States"', linha) }
    if (grepl('group-title="Game shows em inglês"', linha)) { linha <- sub('group-title="Game shows em inglês"', 'group-title="United States"', linha) }
    if (grepl('group-title="General"', linha)) { linha <- sub('group-title="General"', 'group-title="United States"', linha) }
    if (grepl('group-title="General;Music"', linha)) { linha <- sub('group-title="General;Music"', 'group-title="Music"', linha) }
    if (grepl('group-title="General;News"', linha)) { linha <- sub('group-title="General;News"', 'group-title="United States"', linha) }
    if (grepl('group-title="General;Religious"', linha)) { linha <- sub('group-title="General;Religious"', 'group-title="United States"', linha) }
    if (grepl('group-title="General;Series"', linha)) { linha <- sub('group-title="General;Series"', 'group-title="United States"', linha) }
    if (grepl('group-title="GOLF"', linha)) { linha <- sub('group-title="GOLF"', 'group-title="United States"', linha) }
    if (grepl('group-title="Hub Premier"', linha)) { linha <- sub('group-title="Hub Premier"', 'group-title="United States"', linha) }
    if (grepl('group-title="Humor em inglês"', linha)) { linha <- sub('group-title="Humor em inglês"', 'group-title="United States"', linha) }
    if (grepl('group-title="Infantil"', linha)) { linha <- sub('group-title="Infantil"', 'group-title="Brazil"', linha) }
    if (grepl('group-title="Infantis em inglês"', linha)) { linha <- sub('group-title="Infantis em inglês"', 'group-title="United States"', linha) }
    if (grepl('group-title="Jornalismo"', linha)) { linha <- sub('group-title="Jornalismo"', 'group-title="Brazil"', linha) }
    if (grepl('group-title="Kids"', linha)) { linha <- sub('group-title="Kids"', 'group-title="Brazil"', linha) }
    if (grepl('group-title="KIDS"', linha)) { linha <- sub('group-title="KIDS"', 'group-title="United States"', linha) }
    if (grepl('group-title="Kids;Music"', linha)) { linha <- sub('group-title="Kids;Music"', 'group-title="United States"', linha) }
    if (grepl('group-title="Kids;Religious"', linha)) { linha <- sub('group-title="Kids;Religious"', 'group-title="United States"', linha) }
    if (grepl('group-title="Kids;Science"', linha)) { linha <- sub('group-title="Kids;Science"', 'group-title="United States"', linha) }
    if (grepl('group-title="Legislative"', linha)) { linha <- sub('group-title="Legislative"', 'group-title="United States"', linha) }
    if (grepl('group-title="Legislative;News"', linha)) { linha <- sub('group-title="Legislative;News"', 'group-title="United States"', linha) }
    if (grepl('group-title="Lifestyle"', linha)) { linha <- sub('group-title="Lifestyle"', 'group-title="United States"', linha) }
    if (grepl('group-title="Lifestyle;Shop"', linha)) { linha <- sub('group-title="Lifestyle;Shop"', 'group-title="United States"', linha) }
    if (grepl('group-title="LIVE EVENTS usa time zone"', linha)) { linha <- sub('group-title="LIVE EVENTS usa time zone"', 'group-title="United States"', linha) }
    if (grepl('group-title="LIVE FOOTBALL EXTRA"', linha)) { linha <- sub('group-title="LIVE FOOTBALL EXTRA"', 'group-title="United States"', linha) }
    if (grepl('group-title="LocalNow: Action"', linha)) { linha <- sub('group-title="LocalNow: Action"', 'group-title="United States"', linha) }
    if (grepl('group-title="LocalNow: Comedy"', linha)) { linha <- sub('group-title="LocalNow: Comedy"', 'group-title="United States"', linha) }
    if (grepl('group-title="LocalNow: Drama"', linha)) { linha <- sub('group-title="LocalNow: Drama"', 'group-title="United States"', linha) }
    if (grepl('group-title="LocalNow: En Espanol"', linha)) { linha <- sub('group-title="LocalNow: En Espanol"', 'group-title="United States"', linha) }
    if (grepl('group-title="LocalNow: Entertainment"', linha)) { linha <- sub('group-title="LocalNow: Entertainment"', 'group-title="United States"', linha) }
    if (grepl('group-title="LocalNow: Explore"', linha)) { linha <- sub('group-title="LocalNow: Explore"', 'group-title="United States"', linha) }
    if (grepl('group-title="LocalNow: Family And Faith"', linha)) { linha <- sub('group-title="LocalNow: Family And Faith"', 'group-title="United States"', linha) }
    if (grepl('group-title="LocalNow: Gaming And More"', linha)) { linha <- sub('group-title="LocalNow: Gaming And More"', 'group-title="United States"', linha) }
    if (grepl('group-title="LocalNow: Horror And SciFi"', linha)) { linha <- sub('group-title="LocalNow: Horror And SciFi"', 'group-title="United States"', linha) }
    if (grepl('group-title="LocalNow: Lifestyle"', linha)) { linha <- sub('group-title="LocalNow: Lifestyle"', 'group-title="United States"', linha) }
    if (grepl('group-title="LocalNow: Local"', linha)) { linha <- sub('group-title="LocalNow: Local"', 'group-title="United States"', linha) }
    if (grepl('group-title="LocalNow: More Cities"', linha)) { linha <- sub('group-title="LocalNow: More Cities"', 'group-title="United States"', linha) }
    if (grepl('group-title="LocalNow: Movies And TV"', linha)) { linha <- sub('group-title="LocalNow: Movies And TV"', 'group-title="United States"', linha) }
    if (grepl('group-title="LocalNow: Music And Arts"', linha)) { linha <- sub('group-title="LocalNow: Music And Arts"', 'group-title="United States"', linha) }
    if (grepl('group-title="LocalNow: News And Opinion"', linha)) { linha <- sub('group-title="LocalNow: News And Opinion"', 'group-title="United States"', linha) }
    if (grepl('group-title="LocalNow: Reality"', linha)) { linha <- sub('group-title="LocalNow: Reality"', 'group-title="United States"', linha) }
    if (grepl('group-title="LocalNow: Recommended"', linha)) { linha <- sub('group-title="LocalNow: Recommended"', 'group-title="United States"', linha) }
    if (grepl('group-title="LocalNow: Relaxation"', linha)) { linha <- sub('group-title="LocalNow: Relaxation"', 'group-title="United States"', linha) }
    if (grepl('group-title="LocalNow: Sports"', linha)) { linha <- sub('group-title="LocalNow: Sports"', 'group-title="United States"', linha) }
    if (grepl('group-title="LocalNow: World Interest"', linha)) { linha <- sub('group-title="LocalNow: World Interest"', 'group-title="United States"', linha) }
    if (grepl('group-title="LOI TV"', linha)) { linha <- sub('group-title="LOI TV"', 'group-title="United States"', linha) }
    if (grepl('group-title="Maratona de episódios em inglês"', linha)) { linha <- sub('group-title="Maratona de episódios em inglês"', 'group-title="United States"', linha) }
    if (grepl('group-title="MLB USA"', linha)) { linha <- sub('group-title="MLB USA"', 'group-title="MLB"', linha) }
    if (grepl('group-title="Motor Sports"', linha)) { linha <- sub('group-title="Motor Sports"', 'group-title="United States"', linha) }
    if (grepl('group-title="Movies"', linha)) { linha <- sub('group-title="Movies"', 'group-title="United States"', linha) }
    if (grepl('group-title="MOVIES"', linha)) { linha <- sub('group-title="MOVIES"', 'group-title="United States"', linha) }
    if (grepl('group-title="Movies;Music"', linha)) { linha <- sub('group-title="Movies;Music"', 'group-title="Music"', linha) }
    if (grepl('group-title="Movies;News"', linha)) { linha <- sub('group-title="Movies;News"', 'group-title="United States"', linha) }
    if (grepl('group-title="Movies;Series"', linha)) { linha <- sub('group-title="Movies;Series"', 'group-title="United States"', linha) }
    if (grepl('group-title="Music;News"', linha)) { linha <- sub('group-title="Music;News"', 'group-title="Music"', linha) }
    if (grepl('group-title="Music;News;Religious"', linha)) { linha <- sub('group-title="Music;News;Religious"', 'group-title="Music"', linha) }
    if (grepl('group-title="Music;Religious"', linha)) { linha <- sub('group-title="Music;Religious"', 'group-title="Music"', linha) }
    if (grepl('group-title="Música"', linha)) { linha <- sub('group-title="Música"', 'group-title="Music"', linha) }
    if (grepl('group-title="Música instrumental e som ambiente"', linha)) { linha <- sub('group-title="Música instrumental e som ambiente"', 'group-title="Music"', linha) }
    if (grepl('group-title="Música: karaokê"', linha)) { linha <- sub('group-title="Música: karaokê"', 'group-title="Music"', linha) }
    if (grepl('group-title="NATIONAL LEAGUE"', linha)) { linha <- sub('group-title="NATIONAL LEAGUE"', 'group-title="MLB"', linha) }
    if (grepl('group-title="NBA USA"', linha)) { linha <- sub('group-title="NBA USA"', 'group-title="NBA"', linha) }
    if (grepl('group-title="News"', linha)) { linha <- sub('group-title="News"', 'group-title="United States"', linha) }
    if (grepl('group-title="News and Music"', linha)) { linha <- sub('group-title="News and Music"', 'group-title="Music"', linha) }
    if (grepl('group-title="News;Religious"', linha)) { linha <- sub('group-title="News;Religious"', 'group-title="United States"', linha) }
    if (grepl('group-title="NFL USA"', linha)) { linha <- sub('group-title="NFL USA"', 'group-title="NFL"', linha) }
    if (grepl('group-title="NHL USA"', linha)) { linha <- sub('group-title="NHL USA"', 'group-title="NHL"', linha) }
    if (grepl('group-title="Notícias em inglês"', linha)) { linha <- sub('group-title="Notícias em inglês"', 'group-title="United States"', linha) }
    if (grepl('group-title="Notícias em inglês: dinheiro"', linha)) { linha <- sub('group-title="Notícias em inglês: dinheiro"', 'group-title="United States"', linha) }
    if (grepl('group-title="Novelas e séries em inglês"', linha)) { linha <- sub('group-title="Novelas e séries em inglês"', 'group-title="United States"', linha) }
    if (grepl('group-title="Optus Sports"', linha)) { linha <- sub('group-title="Optus Sports"', 'group-title="United States"', linha) }
    if (grepl('group-title="Outdoor"', linha)) { linha <- sub('group-title="Outdoor"', 'group-title="United States"', linha) }
    if (grepl('group-title="PAY PER VIEW"', linha)) { linha <- sub('group-title="PAY PER VIEW"', 'group-title="United States"', linha) }
    if (grepl('group-title="PDC DARTS"', linha)) { linha <- sub('group-title="PDC DARTS"', 'group-title="United States"', linha) }
    if (grepl('group-title="Peacock TV"', linha)) { linha <- sub('group-title="Peacock TV"', 'group-title="United States"', linha) }
    if (grepl('group-title="Perth"', linha)) { linha <- sub('group-title="Perth"', 'group-title="United States"', linha) }
    if (grepl('group-title="Pets em inglês"', linha)) { linha <- sub('group-title="Pets em inglês"', 'group-title="United States"', linha) }
    if (grepl('group-title="PORTUGAL"', linha)) { linha <- sub('group-title="PORTUGAL"', 'group-title="Portugal"', linha) }
    if (grepl('group-title="Portugese"', linha)) { linha <- sub('group-title="Portugese"', 'group-title="Portugal"', linha) }
    if (grepl('group-title="PPV \\| LIVE EVENTS"', linha)) { linha <- sub('group-title="PPV \\| LIVE EVENTS"', 'group-title="United States"', linha) }
    if (grepl('group-title="Pública"', linha)) { linha <- sub('group-title="Pública"', 'group-title="Brazil"', linha) }
    if (grepl('group-title="Reality shows em inglês"', linha)) { linha <- sub('group-title="Reality shows em inglês"', 'group-title="United States"', linha) }
    if (grepl('group-title="Reality shows em inglês: crimes e julgamentos"', linha)) { linha <- sub('group-title="Reality shows em inglês: crimes e julgamentos"', 'group-title="United States"', linha) }
    if (grepl('group-title="RedBox: Action Sci-Fi & Horror"', linha)) { linha <- sub('group-title="RedBox: Action Sci-Fi & Horror"', 'group-title="United States"', linha) }
    if (grepl('group-title="RedBox: Classics & Nostalgia"', linha)) { linha <- sub('group-title="RedBox: Classics & Nostalgia"', 'group-title="United States"', linha) }
    if (grepl('group-title="RedBox: Comedy"', linha)) { linha <- sub('group-title="RedBox: Comedy"', 'group-title="United States"', linha) }
    if (grepl('group-title="RedBox: Crime & Scandal"', linha)) { linha <- sub('group-title="RedBox: Crime & Scandal"', 'group-title="United States"', linha) }
    if (grepl('group-title="RedBox: En Espanol"', linha)) { linha <- sub('group-title="RedBox: En Espanol"', 'group-title="United States"', linha) }
    if (grepl('group-title="RedBox: Food & Home"', linha)) { linha <- sub('group-title="RedBox: Food & Home"', 'group-title="United States"', linha) }
    if (grepl('group-title="RedBox: Kids & Family"', linha)) { linha <- sub('group-title="RedBox: Kids & Family"', 'group-title="United States"', linha) }
    if (grepl('group-title="RedBox: Movies"', linha)) { linha <- sub('group-title="RedBox: Movies"', 'group-title="United States"', linha) }
    if (grepl('group-title="RedBox: Music"', linha)) { linha <- sub('group-title="RedBox: Music"', 'group-title="Music"', linha) }
    if (grepl('group-title="RedBox: News & Weather"', linha)) { linha <- sub('group-title="RedBox: News & Weather"', 'group-title="United States"', linha) }
    if (grepl('group-title="RedBox: Reality & Game Shows"', linha)) { linha <- sub('group-title="RedBox: Reality & Game Shows"', 'group-title="United States"', linha) }
    if (grepl('group-title="RedBox: Sports & Gaming"', linha)) { linha <- sub('group-title="RedBox: Sports & Gaming"', 'group-title="United States"', linha) }
    if (grepl('group-title="RedBox: Summer Movies Showcase"', linha)) { linha <- sub('group-title="RedBox: Summer Movies Showcase"', 'group-title="United States"', linha) }
    if (grepl('group-title="RedBox: Travel & Lifestyle"', linha)) { linha <- sub('group-title="RedBox: Travel & Lifestyle"', 'group-title="United States"', linha) }
    if (grepl('group-title="RedBox: Westerns"', linha)) { linha <- sub('group-title="RedBox: Westerns"', 'group-title="United States"', linha) }
    if (grepl('group-title="REGIONAL"', linha)) { linha <- sub('group-title="REGIONAL"', 'group-title="Brazil"', linha) }
    if (grepl('group-title="Relax"', linha)) { linha <- sub('group-title="Relax"', 'group-title="United States"', linha) }
    if (grepl('group-title="Religioso"', linha)) { linha <- sub('group-title="Religioso"', 'group-title="Brazil"', linha) }
    if (grepl('group-title="Religious"', linha)) { linha <- sub('group-title="Religious"', 'group-title="United States"', linha) }
    if (grepl('group-title="RMC SPORTS"', linha)) { linha <- sub('group-title="RMC SPORTS"', 'group-title="United States"', linha) }
    if (grepl('group-title="Science"', linha)) { linha <- sub('group-title="Science"', 'group-title="United States"', linha) }
    if (grepl('group-title="Series"', linha)) { linha <- sub('group-title="Series"', 'group-title="United States"', linha) }
    if (grepl('group-title="Setanta Sports Events"', linha)) { linha <- sub('group-title="Setanta Sports Events"', 'group-title="United States"', linha) }
    if (grepl('group-title="Shop"', linha)) { linha <- sub('group-title="Shop"', 'group-title="United States"', linha) }
    if (grepl('group-title="SKY SPORTS"', linha)) { linha <- sub('group-title="SKY SPORTS"', 'group-title="United States"', linha) }
    if (grepl('group-title="Sports"', linha)) { linha <- sub('group-title="Sports"', 'group-title="United States"', linha) }
    if (grepl('group-title="SPORTS"', linha)) { linha <- sub('group-title="SPORTS"', 'group-title="United States"', linha) }
    if (grepl('group-title="Stan Sports"', linha)) { linha <- sub('group-title="Stan Sports"', 'group-title="United States"', linha) }
    if (grepl('group-title="Super League Plus"', linha)) { linha <- sub('group-title="Super League Plus"', 'group-title="United States"', linha) }
    if (grepl('group-title="Supersport - Astro"', linha)) { linha <- sub('group-title="Supersport - Astro"', 'group-title="United States"', linha) }
    if (grepl('group-title="Televendas em inglês"', linha)) { linha <- sub('group-title="Televendas em inglês"', 'group-title="United States"', linha) }
    if (grepl('group-title="TNT SPORTS"', linha)) { linha <- sub('group-title="TNT SPORTS"', 'group-title="United States"', linha) }
    if (grepl('group-title="Travel"', linha)) { linha <- sub('group-title="Travel"', 'group-title="United States"', linha) }
    if (grepl('group-title="UFC EVENTS"', linha)) { linha <- sub('group-title="UFC EVENTS"', 'group-title="UFC"', linha) }
    if (grepl('group-title="UHD SPORTS (good net only)"', linha)) { linha <- sub('group-title="UHD SPORTS (good net only)"', 'group-title="United States"', linha) }
    if (grepl('group-title="UK"', linha)) { linha <- sub('group-title="UK"', 'group-title="Great Britain"', linha) }
    if (grepl('group-title="UK |  Movies"', linha)) { linha <- sub('group-title="UK |  Movies"', 'group-title="Great Britain"', linha) }
    if (grepl('group-title="UK | Documentary"', linha)) { linha <- sub('group-title="UK | Documentary"', 'group-title="Great Britain"', linha) }
    if (grepl('group-title="UK | Entertainment"', linha)) { linha <- sub('group-title="UK | Entertainment"', 'group-title="Great Britain"', linha) }
    if (grepl('group-title="UK | Football Club"', linha)) { linha <- sub('group-title="UK | Football Club"', 'group-title="Great Britain"', linha) }
    if (grepl('group-title="UK | INDIAN"', linha)) { linha <- sub('group-title="UK | INDIAN"', 'group-title="Great Britain"', linha) }
    if (grepl('group-title="UK | Kids"', linha)) { linha <- sub('group-title="UK | Kids"', 'group-title="Great Britain"', linha) }
    if (grepl('group-title="UK | Music"', linha)) { linha <- sub('group-title="UK | Music"', 'group-title="Great Britain"', linha) }
    if (grepl('group-title="UK | News"', linha)) { linha <- sub('group-title="UK | News"', 'group-title="Great Britain"', linha) }
    if (grepl('group-title="UK | Sports"', linha)) { linha <- sub('group-title="UK | Sports"', 'group-title="Great Britain"', linha) }
    if (grepl('group-title="UK All"', linha)) { linha <- sub('group-title="UK All"', 'group-title="Great Britain"', linha) }
    if (grepl('group-title="UK BT Sports"', linha)) { linha <- sub('group-title="UK BT Sports"', 'group-title="Great Britain"', linha) }
    if (grepl('group-title="UK Sky Sports"', linha)) { linha <- sub('group-title="UK Sky Sports"', 'group-title="Great Britain"', linha) }
    if (grepl('group-title="United Kingdom"', linha)) { linha <- sub('group-title="United Kingdom"', 'group-title="Great Britain"', linha) }
    if (grepl('group-title="UNITED OF KINGDOM"', linha)) { linha <- sub('group-title="UNITED OF KINGDOM"', 'group-title="Great Britain"', linha) }
    if (grepl('group-title="USA"', linha)) { linha <- sub('group-title="USA"', 'group-title="United States"', linha) }
    if (grepl('group-title="USA | SPORTS"', linha)) { linha <- sub('group-title="USA | SPORTS"', 'group-title="United States"', linha) }
    if (grepl('group-title="USA ENTERTAINMENT CHANNELS"', linha)) { linha <- sub('group-title="USA ENTERTAINMENT CHANNELS"', 'group-title="United States"', linha) }
    if (grepl('group-title="USA/CA SPORTS CHANNELS"', linha)) { linha <- sub('group-title="USA/CA SPORTS CHANNELS"', 'group-title="Canada"', linha) }
    if (grepl('group-title="Variedades"', linha)) { linha <- sub('group-title="Variedades"', 'group-title="Brazil"', linha) }
    if (grepl('group-title="Variedades em inglês"', linha)) { linha <- sub('group-title="Variedades em inglês"', 'group-title="United States"', linha) }
    if (grepl('group-title="Videogame"', linha)) { linha <- sub('group-title="Videogame"', 'group-title="Video Game"', linha) }
    if (grepl('group-title="Vidio Sports"', linha)) { linha <- sub('group-title="Vidio Sports"', 'group-title="United States"', linha) }
    if (grepl('group-title="Weather"', linha)) { linha <- sub('group-title="Weather"', 'group-title="United States"', linha) }
    if (grepl('group-title="WebTV"', linha)) { linha <- sub('group-title="WebTV"', 'group-title="United States"', linha) }
    if (grepl('group-title="World"', linha)) { linha <- sub('group-title="World"', 'group-title="United States"', linha) }
    if (grepl('group-title="World Sport"', linha)) { linha <- sub('group-title="World Sport"', 'group-title="United States"', linha) }
    
    # Verifica se a linha contém algum dos títulos de grupos mantidos
    mantido <- FALSE
    for (titulo in titulos_mantidos) {
      if (grepl(sprintf('group-title="%s"', titulo), linha)) {
        mantido <- TRUE
        break
      }
    }
    
    # Se não for um título mantido, substitui por "Omitir"
    if (!mantido) {
      # Verifica se já existe um group-title para substituição
      if (grepl("group-title=", linha)) {
        linha <- sub('group-title="[^"]*"', 'group-title="Omitir"', linha)
      } else {
        # Caso não exista um group-title, adiciona um novo com "Omitir"
        linha <- sub("^#EXTINF:", '#EXTINF: group-title="Omitir",', linha)
      }
    }
  }
  return(linha)
}

# Aplica a função de substituição ao conteúdo
conteudo_modificado <- sapply(conteudo, substituir_titulos, USE.NAMES = FALSE)

# Salva o conteúdo modificado no arquivo de saída
writeLines(conteudo_modificado, arquivo_saida)

# Mensagem de conclusão
cat("O arquivo", arquivo_saida, "foi atualizado com sucesso.")