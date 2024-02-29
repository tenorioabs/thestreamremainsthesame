# Carregar pacotes necessários
if (!requireNamespace("httr", quietly = TRUE)) install.packages("httr")
library(httr)
if (!requireNamespace("dplyr", quietly = TRUE)) install.packages("dplyr")
library(dplyr)
if (!requireNamespace("pbapply", quietly = TRUE)) install.packages("pbapply")
library(pbapply)
if (!requireNamespace("crayon", quietly = TRUE)) install.packages("crayon")
library(crayon)

# Lista de URLs
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
                 "https://iptv-org.github.io/iptv/countries/br.m3u"="Brazil",
                 "https://iptv-org.github.io/iptv/countries/ca.m3u"="Canada",
                 "https://iptv-org.github.io/iptv/countries/us.m3u"="United States",
                 "https://iptv-org.github.io/iptv/countries/uk.m3u"="Great Britain",
                 "https://lib.bz"="Brazil",
                 "http://m3u4u.com/m3u/782dyqzg7rf1118gn4zp"="Brazil", # ott
                 "http://m3u4u.com/m3u/p192y734qvuvvvgwymeg"="Brazil", # meu tedio
                 "http://m3u4u.com/m3u/8p4ey89wg3sqq7k4ng1v"="Music") # pluto music # Aqui você deve inserir sua lista de URLs como no script original

# Função para processar cada URL
processa_url <- function(url, nome_grupo) {
  response <- tryCatch({
    GET(url)
  }, error = function(e) {
    message("Erro ao processar URL: ", url, "; Erro: ", e$message)
    return(NULL)
  })
  
  if (is.null(response) || response$status_code != 200) {
    message("Falha ao acessar a URL: ", url)
    return(NULL)
  }
  
  conteudo <- content(response, "text", encoding = "UTF-8")
  
  # Verificação e ajuste da tag 'group-title'
  if (!grepl('group-title="', conteudo)) {
    mensagem_url <- sprintf("Tag 'group-title' não encontrada em %s. ", url)
    mensagem_valor <- sprintf("Atribuindo valor '%s'.", nome_grupo)
    message(crayon::red(mensagem_url), crayon::green(mensagem_valor))
    conteudo <- gsub("(#EXTINF:-1)", sprintf("\\1 group-title=\"%s\"", nome_grupo), conteudo)
  }
  
  # Remover linhas vazias entre #EXTINF e a URL
  conteudo <- gsub("#EXTINF:-1,(\\s+)?\\n(https?://)", "#EXTINF:-1,\\n\\1", conteudo)
  
  return(conteudo)
}

# Processar URLs e coletar o conteúdo ajustado para cada uma
conteudos_ajustados <- pblapply(names(url_m3u8), function(url) {
  nome_grupo <- url_m3u8[[url]]
  conteudo <- processa_url(url, nome_grupo)
  return(conteudo)
}, cl = 1)

# Concatenar todos os conteúdos ajustados
conteudo_final <- paste(unlist(conteudos_ajustados), collapse = "\n")

# Contar quantos canais VH1 aparecem
num_canais_vh1 <- sum(grepl("VH1\\+", conteudo_final))

# Salvar o conteúdo final no arquivo "conteudo_final.m3u8"
writeLines(conteudo_final, "minha_lista.m3u8")

message("Arquivo 'minha_lista.m3u8' salvo com sucesso.")
message(sprintf("Número de canais VH1 na lista final: %d", num_canais_vh1))