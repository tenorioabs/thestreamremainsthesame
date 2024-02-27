# Garantir que o pacote necessário está instalado e carregado
if (!requireNamespace("httr", quietly = TRUE)) install.packages("httr")
library(httr)

# Lista de URLs e seus respectivos nomes a serem usados como "group-title"
url_m3u8 <- list("https://i.mjh.nz/PlutoTV/br.m3u8"="Brasil - Pluto",
                 "https://iptv-org.github.io/iptv/countries/br.m3u"="Brasil - GitHub",
                 "https://www.apsattv.com/ssungbra.m3u"="Brasil - SamsungTVPlus",
                 "https://lib.bz/br.m3u"="Legal - Brasil",
                 "https://raw.githubusercontent.com/helenfernanda/gratis/main/iptvlegal.m3u"="Legal - Brasil",
                 "https://iptv-org.github.io/iptv/categories/music.m3u"="Music",
                 "https://i.mjh.nz/PBS/all.m3u8"="PBS",
                 "https://i.mjh.nz/Plex/all.m3u8"="Plex",
                 "https://i.mjh.nz/PlutoTV/all.m3u8"="PlutoTV",
                 "https://i.mjh.nz/Roku/all.m3u8"="Roku",
                 "https://i.mjh.nz/SamsungTVPlus/all.m3u8"="SamsungTVPlus",
                 "https://i.mjh.nz/Stirr/all.m3u8"="Stirr",
                 "https://www.apsattv.com/10fast.m3u"="10 Play",
                 "https://www.apsattv.com/anthymtv.m3u"="AnthymTV",
                 "https://www.apsattv.com/bumblebeetv.m3u"="BumbleBeeTV",
                 "https://www.apsattv.com/cineverse.m3u"="Cineverse",
                 "https://www.apsattv.com/distro.m3u"="Distro",
                 "https://www.apsattv.com/freetv.m3u"="FreeTV",
                 "https://www.apsattv.com/freemoviesplus.m3u"="FreeMoviesPlus",
                 "https://www.apsattv.com/galxytv.m3u"="GalxyTV",
                 "https://www.apsattv.com/herogotv.m3u"="HerogoTV",
                 "https://www.apsattv.com/igocast.m3u"="Igocast",
                 "https://www.apsattv.com/klowd.m3u"="KlowdTV",
                 "https://www.apsattv.com/lg.m3u"="LG",
                 "https://www.apsattv.com/localnow.m3u"="LocalNow",
                 "https://www.apsattv.com/oldredbox.m3u"="Redbox",
                 "https://www.apsattv.com/rakuten-uk.m3u"="RakutenTV",
                 "https://www.apsattv.com/rakuten-jp.m3u"="RakutenTV",
                 "https://www.apsattv.com/rakuten.m3u"="RakutenTV",
                 "https://www.apsattv.com/redbox.m3u"="Redbox",
                 "https://www.apsattv.com/rewardedtv.m3u"="RewardedTV",
                 "https://www.apsattv.com/rok.m3u"="The Roku",
                 "https://www.apsattv.com/sportstv.m3u"="SportsTV",
                 "https://www.apsattv.com/ssungaus.m3u"="SamsungTVPlus",
                 "https://www.apsattv.com/ssungbelg.m3u"="SamsungTVPlus",
                 "https://www.apsattv.com/ssungden.m3u"="SamsungTVPlus",
                 "https://www.apsattv.com/ssungfin.m3u"="SamsungTVPlus",
                 "https://www.apsattv.com/ssungire.m3u"="SamsungTVPlus",
                 "https://www.apsattv.com/ssunglux.m3u"="SamsungTVPlus",
                 "https://www.apsattv.com/ssungmex.m3u"="SamsungTVPlus",
                 "https://www.apsattv.com/ssungneth.m3u"="SamsungTVPlus",
                 "https://www.apsattv.com/ssungnor.m3u"="SamsungTVPlus",
                 "https://www.apsattv.com/ssungnz.m3u"="SamsungTVPlus",
                 "https://www.apsattv.com/ssungpor.m3u"="SamsungTVPlus",
                 "https://www.apsattv.com/ssungswe.m3u"="SamsungTVPlus",
                 "https://www.apsattv.com/tablo.m3u"="Tablo",
                 "https://www.apsattv.com/tubi.m3u"="TubiTV",
                 "https://www.apsattv.com/veely.m3u"="Veely",
                 "https://www.apsattv.com/vidaa.m3u"="Vidaa",
                 "https://www.apsattv.com/vizio.m3u"="VizioTV",
                 "https://www.apsattv.com/xiaomi.m3u"="Xiaomi",
                 "https://www.apsattv.com/xumo.m3u"="Xumo",
                 "https://www.apsattv.com/zeasn.m3u"="Zeasn",
                 "https://iptv-org.github.io/iptv/index.m3u"="GitHub")

processa_url <- function(url, nome_grupo) {
  response <- tryCatch({
    GET(url)
  }, error = function(e) {
    message("Erro ao processar URL: ", url, "; Erro: ", e)
    return(NULL)
  })
  
  if (is.null(response)) return(NULL)
  
  conteudo <- content(response, "text", encoding = "UTF-8")
  
  if (!grepl('group-title="', conteudo)) {
    conteudo <- gsub("#EXTINF:-1,", sprintf("#EXTINF:-1 group-title=\"%s\",", nome_grupo), conteudo)
  }
  
  return(conteudo)
}

# Inicializa a barra de progresso
total_urls <- length(url_m3u8)
pb <- txtProgressBar(min = 0, max = total_urls, style = 3)
progresso <- 1

conteudos_modificados <- sapply(names(url_m3u8), function(url) {
  nome_grupo <- url_m3u8[[url]]
  cat(sprintf("\nProcessando: %s\n", nome_grupo)) # Printa o nome do grupo sendo processado
  Sys.sleep(0.1) # Simula um atraso para melhor visualização da barra de progresso
  resultado <- processa_url(url, nome_grupo)
  setTxtProgressBar(pb, progresso) # Atualiza a barra de progresso
  progresso <<- progresso + 1
  return(resultado)
}, USE.NAMES = TRUE)

# Fecha a barra de progresso
close(pb)

# Salvar o conteúdo final em um arquivo
final <- paste(unlist(conteudos_modificados), collapse = "\n")
writeLines(final, "conteudo_final.m3u8")