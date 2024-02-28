# Garantir que o pacote necessário está instalado e carregado
if (!requireNamespace("httr", quietly = TRUE)) install.packages("httr")
library(httr)
library(dplyr)

# Lista de URLs e seus respectivos nomes a serem usados como "group-title"
url_m3u8 <- list("https://i.mjh.nz/Plex/ca.m3u8"="Canada",
                 "https://i.mjh.nz/Plex/us.m3u8"="United States",
                 "https://i.mjh.nz/PlutoTV/br.m3u8"="Brazil",
                 "https://i.mjh.nz/PlutoTV/ca.m3u8"="Canada",
                 "https://i.mjh.nz/PlutoTV/us.m3u8"="United States",
                 "https://i.mjh.nz/PlutoTV/gb.m3u8"="Great Britain",
                 "https://i.mjh.nz/SamsungTVPlus/ca.m3u8"="Canada",
                 "https://i.mjh.nz/SamsungTVPlus/gb.m3u8"="Great Britain",
                 "https://i.mjh.nz/SamsungTVPlus/us.m3u8"="United States",
                 "https://www.apsattv.com/ssungbra.m3u"="Brazil",
                 "http://m3u4u.com/m3u/782dyqzg7rf1118gn4zp"="Brazil",
                 "https://iptv-org.github.io/iptv/countries/br.m3u"="Brazil",
                 "https://iptv-org.github.io/iptv/countries/ca.m3u"="Canada",
                 "https://iptv-org.github.io/iptv/countries/us.m3u"="United States",
                 "https://iptv-org.github.io/iptv/countries/uk.m3u"="Great Britain",
                 "https://lib.bz"="Brazil",
                 "http://m3u4u.com/m3u/p192y734qvuvvvgwymeg"="Brazil")

processa_url <- function(url) {
  response <- tryCatch({
    GET(url)
  }, error = function(e) {
    message("Erro ao processar URL: ", url, "; Erro: ", e)
    return(NULL)
  })
  
  if (is.null(response)) return(NULL)
  
  conteudo <- content(response, "text", encoding = "UTF-8")
  
  # Encontra as tags "group-title" no conteúdo
  tags_encontradas <- gregexpr("group-title=\"[^\"]*\"", conteudo, perl = TRUE)
  tags <- regmatches(conteudo, tags_encontradas)[[1]]
  
  # Retorna as tags encontradas
  return(tags)
}

# Inicializa a barra de progresso
total_urls <- length(url_m3u8)
pb <- txtProgressBar(min = 0, max = total_urls, style = 3)
progresso <- 1

# Inicializa o dataframe para acumular os resultados
df_tags <- data.frame(tags_encontradas=character(), url=character(), ferramenta=character(), stringsAsFactors = FALSE)

for (url in names(url_m3u8)) {
  cat(sprintf("\nProcessando: %s\n", url)) # Printa a URL sendo processada para manter um feedback visual
  Sys.sleep(0.1) # Simula um atraso para melhor visualização da barra de progresso
  
  tags <- processa_url(url)
  
  if (length(tags) > 0) {
    # Extrai as tags e as adiciona ao dataframe com a URL e o nome da ferramenta
    tags_temp_df <- data.frame(tags_encontradas = tags, 
                               url = rep(url, length(tags)), 
                               ferramenta = rep(url_m3u8[[url]], length(tags)), 
                               stringsAsFactors = FALSE)
    df_tags <- rbind(df_tags, tags_temp_df)
  }
  
  setTxtProgressBar(pb, progresso) # Atualiza a barra de progresso
  progresso <- progresso + 1
}

# Fecha a barra de progresso
close(pb)

# Exibe o dataframe final
#print(df_tags)

# Salvar o dataframe em um arquivo CSV, se necessário
#write.csv(df_tags, "tags_group_title_encontradas.csv", row.names = FALSE)

df_tags <- df_tags %>% distinct_all()
