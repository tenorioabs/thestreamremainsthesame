################################################################################
################################################################################
source("V2_09_instala_carrega_pacotes.R")
################################################################################
################################################################################
# Bloco 1, recebe a lista de URLs e concatena em um arquivo chamado "minha_lista.m3u8"
# Lista de URLs
url_m3u8 <- c(
  "http://135.148.169.68:80/get.php?username=ottplayerchannel&password=JFYQWKNbCUe5&type=m3u",
  "http://141.94.143.123:25461/get.php?username=mmaxvod1&password=mmaxvvod2&type=m3u",
  "http://172.104.235.228/get.php?username=zanoviPane2024&password=zanoviPanel2024&type=m3u",
  "http://2hubs.ddns.net:25461/get.php?username=bronder&password=drL3ksLUHg&type=m3u",
  "http://2hubs.ddns.net:25461/get.php?username=solidtv&password=0elrXWdEdl&type=m3u",
  "http://5.182.209.225:25461/get.php?username=9YWRad7Ueb&password=ERXyxqmUs6&type=m3u",
  "http://6oclock.xyz:80/get.php?username=gZpw5weynu&password=C6gJj6DfxV&type=m3u",
  "http://6oclock.xyz:80/get.php?username=oVTsSvYjZu&password=cAXDNm9LY9&type=m3u",
  "http://89.187.167.92:80/playlist.m3u?type=m3u&deviceUser=alex1234&devicePass=alex1234&type=m3u",
  "http://89.187.167.94/playlist.m3u?deviceUser=alex1234&devicePass=alex1234",
  "http://claymorej2.pinals.xyz:8080/get.php?username=TomasClicKTv&password=TKm9apZJ2qHP&type=m3u",
  "http://emuligl.info/get.php?username=tviritv&password=td6522SNAtHt&type=m3u",
  "http://globo.xphost18.xyz:2052/get.php?username=JgfgjjbcfyyDFD&password=678888yygfFFD&type=m3u",
  "http://iptv.nextnet.krd:25461/get.php?username=nextnet&password=3738&type=m3u",
  "http://iptv.icsnleb.com:25461/get.php?username=12&password=12&type=m3u",
  "http://newlife3.wanicelife.com:8880/get.php?username=12mmk110068&password=37783517&type=m3u",
  "http://redima.pro:8880/get.php?username=restv002&password=restv2024vnt002&type=m3u",
  "http://s.apkwuv.xyz/get.php?username=demopadexchange&password=demopad&type=m3u",
  "http://sport.xphost19.xyz:2082/get.php?username=Jvyct679999967DDDF4477&password=Xpluxxx3333ggghy5t57&type=m3u",
  "http://tlpires.com:8080/get.php?username=ganhar5&password=36282b8j68f&type=m3u",
  "http://yesimes.oknirvana.club:8880/get.php?username=DAANM091&password=t9xnxDuGgj&type=m3u",
  "https://gist.githubusercontent.com/justloop/f985f43a89efe41100a67876fe540184/raw/a6c9f7c43392613333f96228bef757c0621b4c3b/playlist.m3u",
  "https://i.mjh.nz/PBS/all.m3u8",
  "https://i.mjh.nz/Plex/all.m3u8",
  "https://i.mjh.nz/PlutoTV/all.m3u8",
  "https://i.mjh.nz/SamsungTVPlus/all.m3u8",
  "https://i.mjh.nz/Stirr/all.m3u8",
  "https://i.mjh.nz/all/raw.m3u8",
  "https://iptv-org.github.io/iptv/categories/music.m3u",
  "https://iptv-org.github.io/iptv/index.m3u",
  "https://lib.bz/br.m3u",
  "https://od.lk/s/MzJfMTY2NzU4NDVf/Free2ViewTV-2021-Master.m3u",
  "https://raw.githubusercontent.com/helenfernanda/gratis/main/iptvlegal.m3u",
  "https://u.m3uiptv.com/wp-content/plugins/download-attachments/includes/download.php?id=1OYWBKsZXkruvtk4G8R_AQ",
  "https://u.m3uiptv.com/wp-content/plugins/download-attachments/includes/download.php?id=3mRVtYuyKP0ijyPm59fZyQ",
  "https://u.m3uiptv.com/wp-content/plugins/download-attachments/includes/download.php?id=4PBwVTvK2QONRry1fsCNCQ",
  "https://u.m3uiptv.com/wp-content/plugins/download-attachments/includes/download.php?id=5e2ObaCqHeJf31FcOsp_1g",
  "https://u.m3uiptv.com/wp-content/plugins/download-attachments/includes/download.php?id=8WdmTItw138DMDd49qu3BQ",
  "https://u.m3uiptv.com/wp-content/plugins/download-attachments/includes/download.php?id=DHUcm_JSd_8jbMgauKg1Bw",
  "https://u.m3uiptv.com/wp-content/plugins/download-attachments/includes/download.php?id=Dsp1-BbjLvEKQCl6ApDPDw",
  "https://u.m3uiptv.com/wp-content/plugins/download-attachments/includes/download.php?id=E-WYMtfmQjpO8_UXWpq3tA",
  "https://u.m3uiptv.com/wp-content/plugins/download-attachments/includes/download.php?id=EC2aA1B88Dbvr0iBg_BCxA",
  "https://u.m3uiptv.com/wp-content/plugins/download-attachments/includes/download.php?id=F-wWsuS-3Kz84ow6N5jXQQ",
  "https://u.m3uiptv.com/wp-content/plugins/download-attachments/includes/download.php?id=GSzJGOv5jLE_N_sOGYdDKQ",
  "https://u.m3uiptv.com/wp-content/plugins/download-attachments/includes/download.php?id=GSzJGOv5jLE_N_sOGYdDKQ",
  "https://u.m3uiptv.com/wp-content/plugins/download-attachments/includes/download.php?id=HyR3nGtbSkqOv4WMBn4wMQ",
  "https://u.m3uiptv.com/wp-content/plugins/download-attachments/includes/download.php?id=M93Oz32LSBA8sx4v7xOR5g",
  "https://u.m3uiptv.com/wp-content/plugins/download-attachments/includes/download.php?id=MY-LswJfJBb2GOYa_BX6cA",
  "https://u.m3uiptv.com/wp-content/plugins/download-attachments/includes/download.php?id=Nl0vPsl6fVcwYlwmRLnFDA",
  "https://u.m3uiptv.com/wp-content/plugins/download-attachments/includes/download.php?id=NlyjGoKC84M1d0sf2BclWA",
  "https://u.m3uiptv.com/wp-content/plugins/download-attachments/includes/download.php?id=O9jaF8ThUfmtgRcZYZrMnw",
  "https://u.m3uiptv.com/wp-content/plugins/download-attachments/includes/download.php?id=PzYshfmbJjIYxVj2dqEfVA",
  "https://u.m3uiptv.com/wp-content/plugins/download-attachments/includes/download.php?id=RSuNcpWaErlxbj6YgOI9Wg",
  "https://u.m3uiptv.com/wp-content/plugins/download-attachments/includes/download.php?id=RYXPm6matJjBUJMY-kPfOw",
  "https://u.m3uiptv.com/wp-content/plugins/download-attachments/includes/download.php?id=SzV8Edc2xLopLOX8rKJ4gQ",
  "https://u.m3uiptv.com/wp-content/plugins/download-attachments/includes/download.php?id=V6_dDDPWzpuPcLTYH1ZHpw",
  "https://u.m3uiptv.com/wp-content/plugins/download-attachments/includes/download.php?id=VxcosKfVZtmZ8ifQq81kag",
  "https://u.m3uiptv.com/wp-content/plugins/download-attachments/includes/download.php?id=XKreuYpOyGLwIqFJePv92Q",
  "https://u.m3uiptv.com/wp-content/plugins/download-attachments/includes/download.php?id=YMzmRnGKzoGlRjCy3iSgjQ",
  "https://u.m3uiptv.com/wp-content/plugins/download-attachments/includes/download.php?id=YMzmRnGKzoGlRjCy3iSgjQ",
  "https://u.m3uiptv.com/wp-content/plugins/download-attachments/includes/download.php?id=ZOr1bL7-wBvq6bdGYqoOzA",
  "https://u.m3uiptv.com/wp-content/plugins/download-attachments/includes/download.php?id=ZhvoXn_LWGxAMBjmRdQF_Q",
  "https://u.m3uiptv.com/wp-content/plugins/download-attachments/includes/download.php?id=e3vA-uX683JMVZJeFogQZg",
  "https://u.m3uiptv.com/wp-content/plugins/download-attachments/includes/download.php?id=fBcKbP_Fl-Zwr9p4IA_oDg",
  "https://u.m3uiptv.com/wp-content/plugins/download-attachments/includes/download.php?id=h6dsrs5rR6NjqeBixFVH2w",
  "https://u.m3uiptv.com/wp-content/plugins/download-attachments/includes/download.php?id=hQ4Ie4VCjjGXQGohpL2uQQ",
  "https://u.m3uiptv.com/wp-content/plugins/download-attachments/includes/download.php?id=iFARMM9vtncICdCyQOZdgQ",
  "https://u.m3uiptv.com/wp-content/plugins/download-attachments/includes/download.php?id=jiMsGGVufamP5VUugNDveA",
  "https://u.m3uiptv.com/wp-content/plugins/download-attachments/includes/download.php?id=mOnhC9-hpFaVHSRLrtZmaQ",
  "https://u.m3uiptv.com/wp-content/plugins/download-attachments/includes/download.php?id=rZ6xvb4n3Tag2LfQzweLig",
  "https://u.m3uiptv.com/wp-content/plugins/download-attachments/includes/download.php?id=sE0DtPNNBegeop_xbWup8Q",
  "https://u.m3uiptv.com/wp-content/plugins/download-attachments/includes/download.php?id=uYi6FTb8YnUe59njmkTp2Q",
  "https://u.m3uiptv.com/wp-content/plugins/download-attachments/includes/download.php?id=xUk0u_kF-iveUdgqwe9l5Q",
  "https://u.m3uiptv.com/wp-content/plugins/download-attachments/includes/download.php?id=yE_GUWGBgz3HK_0j4VV40g",
  "https://u.m3uiptv.com/wp-content/plugins/download-attachments/includes/download.php?id=yHeu0vZw7z6h4HFSUSx6nA",
  "https://www.apsattv.com/localnow.m3u",
  "https://www.apsattv.com/redbox.m3u",
  "https://www.apsattv.com/rakuten.m3u",
  "https://www.apsattv.com/tubi.m3u",
  "https://www.apsattv.com/klowd.m3u",
  "https://www.apsattv.com/lg.m3u",
  "https://www.apsattv.com/vizio.m3u",
  "https://www.apsattv.com/tcl.m3u",
  "http://m3u4u.com/m3u/w16vy5xw9gaxx42jn39p"
)

processa_url <- function(url) {
  response <- tryCatch({
    GET(url)
  }, error = function(e) {
    message("Erro ao processar URL: ", url, "; Erro: ", e)
    return(NULL)
  })
  
  if (is.null(response)) return(NULL)
  
  conteudo <- content(response, "text", encoding = "UTF-8")
  return(conteudo)
}

# Processar URLs e coletar o conteúdo para cada uma
conteudos <- lapply(url_m3u8, processa_url)

# Filtrar linhas em branco para cada conteúdo e então unlist
# Aqui, ajustamos para garantir que mesmo após a concatenação, linhas completamente vazias sejam removidas
conteudos_filtrados <- lapply(conteudos, function(x) grep("^\\S", x, value = TRUE))
conteudo_final_sem_filtro <- paste(unlist(conteudos_filtrados), collapse = "\n")

# Novo passo: remover linhas completamente vazias após a concatenação
conteudo_final <- gsub("\n{2,}", "\n", conteudo_final_sem_filtro)

# Salvar o conteúdo final no arquivo "minha_lista.m3u8", eliminando linhas em branco
writeLines(conteudo_final, "minha_lista.m3u8")

message("Arquivo 'minha_lista.m3u8' salvo com sucesso, sem linhas em branco.")
################################################################################
################################################################################
# Bloco 2, carrega o arquivo "minha_lista.m3u8", aplica Regex e cria novo grupo
# chamado "Music" e salva no arquivo "canais_encontrados_modificados.m3u8"
# Ler o arquivo com os dados dos canais
caminho_do_arquivo <- "minha_lista.m3u8"
linhas <- readLines(caminho_do_arquivo)

# Especificar os nomes dos canais buscados
canais_buscados <- c("4Music",
                      "AMusic Channel",
                      "AXS TV Now",
                      "BMTV",
                      "Best of MTV",
                      "Broadway On Demand",
                      "CMT",
                      "CMusic",
                      "Classica",
                      "Classic Rock",
                      "Deluxe Lounge HD",
                      "DittyTV",
                      "Djazz",
                      "IFM TV",
                      "KMTV",
                      "Live Music Replay",
                      "Littoral FM",
                      "Loupe Art",
                      "MTV Approved Hip Hop",
                      "MTV Beats",
                      "MTV Biggest Pop",
                      "MTV Classic",
                      "MTV Flow Latino",
                      "MTV Frauen Power",
                      "MTV German Music",
                      "MTV Hits France",
                      "MTV Just Tattoo of Us",
                      "MTV Love",
                      "MTV Movie Hits",
                      "MTV Music",
                      "MTV Original Version",
                      "MTV Party",
                      "MTV Pluto TV",
                      "MTV Rocks",
                      "MTV RockZone",
                      "MTV Summer Hits",
                      "MTV Tattoo a dos",
                      "MTV Unplugged",
                      "MTV Urban Music",
                      "MTV Vergüenza ajena",
                      "MTV en español",
                      "MTV: Best of",
                      "Music Legends Network",
                      "Naturescape",
                      "Now 80's",
                      "Now 80s",
                      "Now Rock",
                      "OFIVE",
                      "OurVinyl TV",
                      "Pluto TV Fireplace",
                      "Pluto TV MTV",
                      "Qello",
                      "Qwest",
                      "Rock Story",
                      "Rock TV",
                      "Stingray",
                      "Trace",
                      "Vevo",
                      "VH1",
                      "Vivaldi TV",
                      "WMX",
                      "XITE",
                      "Xite",
                      "Yo! MTV Raps Classic")

# Inicializar uma lista para armazenar os resultados da busca
resultados_busca <- list()

# Definir o novo valor para "group-title"
novo_group_title <- "Music"

# Inicializar os elementos da lista para cada canal buscado
for (canal in canais_buscados) {
  resultados_busca[[canal]] <- c()
}

# Buscar os canais e modificar a tag "group-title"
canais_encontrados <- c()
capturar_proxima_linha <- FALSE

for (linha in linhas) {
  if (capturar_proxima_linha) {
    # Adiciona a URL do canal encontrado na lista
    canais_encontrados <- c(canais_encontrados, linha)
    capturar_proxima_linha <- FALSE # Reseta o indicador para captura da próxima linha
    next
  }
  
  for (canal in canais_buscados) {
    if (str_detect(linha, fixed(canal))) {
      # Substituir o valor da tag "group-title" pelo valor especificado
      linha_modificada <- str_replace(linha, pattern = "group-title=\"[^\"]*\"", replacement = sprintf("group-title=\"%s\"", novo_group_title))
      
      # Extrair o nome do canal e armazenar na lista de resultados
      nome_canal <- str_extract(linha, "(?<=,).*$")
      resultados_busca[[canal]] <- c(resultados_busca[[canal]], nome_canal)
      
      # Salvar a linha modificada em um vetor temporário para posterior salvamento
      canais_encontrados <- c(canais_encontrados, linha_modificada)
      capturar_proxima_linha <- TRUE # Seta o indicador para capturar a próxima linha (URL)
      
      break # Interrompe o loop interno uma vez que o canal foi encontrado e modificado
    }
  }
}

# Verificar se algum canal foi encontrado e salvar os canais modificados em um novo arquivo
if (length(canais_encontrados) > 0) {
  writeLines(canais_encontrados, "canais_encontrados_modificados.m3u8")
  cat("Canais encontrados com a tag 'group-title' modificada para '", novo_group_title, "' e suas URLs foram salvos em 'canais_encontrados_modificados.m3u8'.\n", sep="")
}

# Imprime os resultados
for (canal in names(resultados_busca)) {
  if (length(resultados_busca[[canal]]) > 0) {
    cat("Canal:", canal, "\n")
    cat("Quantidade encontrada:", length(resultados_busca[[canal]]), "\n")
    cat("Nomes dos canais:\n", paste(resultados_busca[[canal]], collapse = "\n"), "\n\n")
  } else {
    cat("Nenhum canal encontrado para:", canal, "\n\n")
  }
}

################################################################################
################################################################################
# Bloco 3, Insere novos canais manualmente e concatena listas
# Definir os caminhos dos arquivos
caminho_lista_original <- "minha_lista.m3u8"
caminho_lista_modificada <- "canais_encontrados_modificados.m3u8"
caminho_lista_concatenada <- "minha_lista_concatenada.m3u8"

# Ler os conteúdos dos arquivos
conteudo_lista_original <- readLines(caminho_lista_original)
conteudo_lista_modificada <- readLines(caminho_lista_modificada)

# Concatenar os conteúdos
conteudo_concatenado <- c(conteudo_lista_original, conteudo_lista_modificada)

# Adicionar os dois novos canais ao conteúdo concatenado
novos_canais <- c("#EXTINF:-1 tvg-id=\"MTV.jp\" tvg-logo=\"https://upload.wikimedia.org/wikipedia/commons/thumb/0/0d/MTV-2021.svg/512px-MTV-2021.svg.png\" group-title=\"Music\",MTV Japan\nhttp://jp.vthanhnetwork.com/MTV/index.m3u8",
                  "#EXTINF:-1 tvg-id=\"MusicJapanTV.jp\" tvg-logo=\"https://pbs.twimg.com/profile_images/875521212432003073/jTDObCPJ_200x200.jpg\" group-title=\"Music\",Music Japan TV\nhttp://cdns.jp-primehome.com:8000/zhongying/live/playlist.m3u8?cid=cs06",
                  "#EXTINF:-1 tvg-id=\"TheCountryNetwork.us\" tvg-logo=\"https://upload.wikimedia.org/wikipedia/en/d/dd/The_Country_Network_Logo.png\" group-title=\"Music\",The Country Network\nhttps://cdn-uw2-prod.tsv2.amagi.tv/linear/amg01201-cinedigmenterta-countrynetwork-cineverse/playlist.m3u8",
                  "#EXTINF:-1 tvg-id=\"KMBYLD5.us\" tvg-logo=\"https://i.imgur.com/GlpYAKt.png\" group-title=\"Music\",Blues TV\nhttps://2-fss-2.streamhoster.com/pl_138/205510-3094608-1/playlist.m3u8",
                  "#EXTINF:-1,tvg-id=\"OurVinylTV\" tvg-logo=\"https://pbs.twimg.com/profile_images/1108077246999392258/e1rqU54I_400x400.png\" group-title=\"Music\",OurVinylTV USA\nhttps://ourvinyltv-ourvinyltv-1-us.tcl.wurl.tv/playlist.m3u8",
                  "#EXTINF:-1,tvg-id=\"OurVinylTV\" tvg-logo=\"https://pbs.twimg.com/profile_images/1108077246999392258/e1rqU54I_400x400.png\" group-title=\"Music\",OurVinylTV Brazil\nhttps://ourvinyltv-ourvinyltv-1-br.tcl.wurl.tv",
                  "#EXTINF:-1,tvg-id=\"OurVinylTV\" tvg-logo=\"https://pbs.twimg.com/profile_images/1108077246999392258/e1rqU54I_400x400.png\" group-title=\"Music\",OurVinylTV France\nhttps://ourvinyltv-ourvinyltv-1-fr.tcl.wurl.tv/playlist.m3u8",
                  "#EXTINF:-1,tvg-id=\"OurVinylTV\" tvg-logo=\"https://pbs.twimg.com/profile_images/1108077246999392258/e1rqU54I_400x400.png\" group-title=\"Music\",OurVinylTV Mexico\nhttps://ourvinyltv-ourvinyltv-1-mx.tcl.wurl.tv/playlist.m3u8",
                  "#EXTINF:-1 tvg-id=\"BandNews.br\" tvg-logo=\"https://i.imgur.com/WwSAtkh.png\" group-title=\"Brazil\",Band News\nhttps://cdn2.connectbr.com.br/Band-News/tracks-v1a1/playlist.m3u8",
                  "#EXTINF:-1 tvg-id=\"CNNBrasil.br\" tvg-logo=\"https://i.imgur.com/5AK7gLc.png\" group-title=\"Brazil\",CNN Brasil\nhttp://video01.soultv.com.br/cnnbrasil/cnnbrasil/playlist.m3u8",
                  "#EXTINF:-1 tvg-id=\"GloboNews.br\" tvg-logo=\"https://upload.wikimedia.org/wikipedia/commons/8/89/Logotipo_da_GloboNews.png\" group-title=\"Brazil\",Globo News\nhttp://209.222.97.92:16436/GloboNews",
                  "#EXTINF:-1 tvg-id=\"4music.uk\" tvg-name=\"UK - 4Music\" tvg-logo=\"http://attp.ddns.net:25461/images/3716d07c2ea18053da67e42f23510673.png\" group-title=\"Music\",4Music\nhttp://2hubs.ddns.net:25461/Faucon1tvMT/g8pHKUYxwDhx/59948",
                  "#EXTINF:-1 tvg-id=\"Cnn.us\" tvg-name=\"USA - CNN\" tvg-logo=\"http://attp.ddns.net:25461/images/3b28681ca92c1a20a634cecda3944f7d.png\" group-title=\"United States\",CNN USA\nhttp://2hubs.ddns.net:25461/Faucon1tvMT/g8pHKUYxwDhx/57214",
                  "#EXTINF:-1 tvg-id=\"Cnn.ca\" tvg-name=\"CA - CNN HD\" tvg-logo=\"http://attp.ddns.net:25461/images/92de8241eb80455f9f1eb8bf008a79eb.png\" group-title=\"Canada\",CNN CA HD\nhttp://2hubs.ddns.net:25461/Faucon1tvMT/g8pHKUYxwDhx/61130",
                  "#EXTINF:-1 tvg-id=\"Cnn.ca\" tvg-name=\"CA - CNN INTERNATIONAL  HD\" tvg-logo=\"http://attp.ddns.net:25461/images/92de8241eb80455f9f1eb8bf008a79eb.png\" group-title=\"Canada\",CNN INTERNATIONAL CA HD\nhttp://2hubs.ddns.net:25461/Faucon1tvMT/g8pHKUYxwDhx/61131",
                  "#EXTINF:-1 tvg-id=\"Cnn.us\" tvg-name=\"USA - CNN HD\" tvg-logo=\"http://attp.ddns.net:25461/images/8b0b0df3207d9e82299feba06c904a17.png\" group-title=\"United States\",CNN USA HD\nhttp://2hubs.ddns.net:25461/Faucon1tvMT/g8pHKUYxwDhx/58495")

conteudo_concatenado <- c(conteudo_concatenado, novos_canais)

# Escrever o conteúdo concatenado em um novo arquivo
writeLines(conteudo_concatenado, caminho_lista_concatenada)

cat("Os arquivos foram concatenados com sucesso e os novos canais foram adicionados. O resultado foi salvo em", caminho_lista_concatenada, "\n")
################################################################################
################################################################################
# Bloco 4, apenas modifica a primeira linha indicado xml (epg) default
# Definir o caminho do arquivo
caminho_do_arquivo <- "minha_lista_concatenada.m3u8"

# Ler o arquivo
linhas <- readLines(caminho_do_arquivo)

# Substituir a URL na primeira linha
if (grepl("^#EXTM3U", linhas[1])) {
  linhas[1] <- gsub('x-tvg-url="[^"]+"', 'x-tvg-url="https://raw.githubusercontent.com/tenorioabs/thestreamremainsthesame/main/minha_lista_concatenada.xml.gz"', linhas[1], perl = TRUE)
}

# Remover as linhas com a tag x-tvg-url, exceto a primeira linha
linhas_para_manter <- c(linhas[1], linhas[!grepl('x-tvg-url=', linhas) | !grepl('^#EXTM3U', linhas)])

# Salvar o arquivo com as modificações
writeLines(linhas_para_manter, caminho_do_arquivo)

# Mensagem de confirmação
cat("O arquivo foi atualizado. A URL na tag 'x-tvg-url' da primeira linha foi substituída.\n")

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
                      "Great Britain",
                      "Music",
                      "United States",
                      "NBA League Pass",
                      "Campeonatos Estaduais",
                      "Esportes Pay-Per-View",
                      "Jogos de Hoje",
                      "Premiere")

# Função para verificar e substituir os títulos dos grupos
substituir_titulos <- function(linha) {
  # Verifica se a linha é um canal
  if (grepl("^#EXTINF:", linha)) {
    # Transforma "USA" em "United States" antes de qualquer coisa
    if (grepl('group-title="USA"', linha)) {
      linha <- sub('group-title="USA"', 'group-title="United States"', linha)
    }
    
    # Adiciona uma condição para tratar "LocalNow:" seguido por quaisquer caracteres
    if (grepl('group-title="LocalNow:.*"', linha)) {
      linha <- sub('group-title="LocalNow:.*"', 'group-title="United States"', linha)
    }
    
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
################################################################################
################################################################################
# Bloco 6, atualiza GitHub
#source("V2_02_cria_xml.R")
#file.remove("minha_lista_concatenada.xml")
file.remove("canais_encontrados_modificados.m3u8")
file.remove("minha_lista.m3u8")

#source("V2_00_tabula_group_title.R")

source("V2_04_double_check_brasil.R")

#source("V2_00_tabula_group_title.R")
              
source("V2_05_testa_links_m3u8.R")

source("V2_06_atribui_logo_remove_repetidos.R")

file.remove("minha_lista_concatenada.m3u8")

source("V2_03_funcoes_github.R")
dia_hora <- Sys.time()
dia_hora <- str_replace_all(string = dia_hora, pattern = "-", replacement = "")
dia_hora <- str_replace_all(string = dia_hora, pattern = ":", replacement = "")
dia_hora <- str_replace_all(string = dia_hora, pattern = " ", replacement = "")
github_windows(paste0("atualizacao_", dia_hora))
#github_linux("Reformulação Geral")
################################################################################
################################################################################
# Define o nome atual do arquivo e o novo nome
nome_atual <- "minha_lista_concatenada.xml.gz"
novo_nome <- "minha_lista_concatenada_ativa.xml.gz"

# Usa a função file.rename() para alterar o nome do arquivo
resultado <- file.rename(nome_atual, novo_nome)

# Verifica se a renomeação foi bem-sucedida
if (resultado) {
  cat("O arquivo foi renomeado com sucesso para", novo_nome, "\n")
} else {
  cat("Falha ao renomear o arquivo. Verifique se o arquivo existe e se você tem permissão para alterá-lo.\n")
}

#system("shutdown /s /t 0")
