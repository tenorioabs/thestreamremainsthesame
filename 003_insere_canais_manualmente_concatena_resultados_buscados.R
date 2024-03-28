################################################################################
################################################################################
# Bloco 3, Insere novos canais manualmente e concatena listas
# Definir os caminhos dos arquivos
caminho_lista_original <- nome_coluna
caminho_lista_modificada <- "canais_encontrados_modificados.m3u8"
caminho_lista_concatenada <- nome_coluna

# Ler os conteúdos dos arquivos
conteudo_lista_original <- readLines(caminho_lista_original)
conteudo_lista_modificada <- readLines(caminho_lista_modificada)

# Concatenar os conteúdos
conteudo_concatenado <- c(conteudo_lista_original, conteudo_lista_modificada)

if (valor_numerico == 2) {
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
} 

# Escrever o conteúdo concatenado em um novo arquivo
writeLines(conteudo_concatenado, caminho_lista_concatenada)

cat("Os arquivos foram concatenados com sucesso e os novos canais foram adicionados. O resultado foi salvo em", caminho_lista_concatenada, "\n")
################################################################################
################################################################################