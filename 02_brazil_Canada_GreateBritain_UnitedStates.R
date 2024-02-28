# Carregar pacotes necessários
if (!requireNamespace("httr", quietly = TRUE)) install.packages("httr")
library(httr)
if (!requireNamespace("dplyr", quietly = TRUE)) install.packages("dplyr")
library(dplyr)
if (!requireNamespace("pbapply", quietly = TRUE)) install.packages("pbapply")
library(pbapply)
if (!requireNamespace("crayon", quietly = TRUE)) install.packages("crayon")
library(crayon)

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
                 "http://m3u4u.com/m3u/p192y734qvuvvvgwymeg"="Brazil",
                 "http://m3u4u.com/m3u/69wkng49r8svvxg3yq8g"="Brazil",
                 "http://m3u4u.com/m3u/8p4ey89wg3sqq7k4ng1v"="Music")

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
    # Usando o pacote crayon para adicionar cor ao texto
    mensagem_url <- sprintf("Tag 'group-title' não encontrada em %s. ", url)
    mensagem_valor <- sprintf("Atribuindo valor '%s'.", nome_grupo)
    message(crayon::red(mensagem_url), crayon::green(mensagem_valor))
    conteudo <- gsub("(#EXTINF:-1)", sprintf("\\1 group-title=\"%s\"", nome_grupo), conteudo)
  } else {
    linhas <- strsplit(conteudo, "\n")[[1]]
    linhas_ajustadas <- sapply(linhas, function(linha) {
      if (grepl('group-title="', linha)) {
        titulo_atual <- gsub('.*group-title="([^"]*)".*', '\\1', linha)
        if (titulo_atual != "Music") {
          return(gsub('group-title="[^"]*"', sprintf('group-title="%s"', nome_grupo), linha))
        }
      }
      return(linha)
    })
    conteudo <- paste(linhas_ajustadas, collapse = "\n")
  }
  
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

# Salvar o conteúdo final no arquivo "conteudo_final.m3u8"
writeLines(conteudo_final, "conteudo_final.m3u8")

message("Arquivo 'conteudo_final.m3u8' salvo com sucesso.")

################################################################################

# Define o caminho para o arquivo M3U8 unificado
arquivo <- "conteudo_final.m3u8"

# Lê o conteúdo do arquivo
conteudo <- readLines(arquivo, warn = FALSE)

# Filtra as linhas que contêm a tag "group-title"
linhas_com_group_title <- grep("group-title", conteudo, value = TRUE)

# Extrai os valores da tag "group-title"
valores_group_title <- sapply(linhas_com_group_title, function(linha) {
  matches <- regmatches(linha, regexec('group-title="([^"]+)"', linha))
  if (length(matches[[1]]) > 1) matches[[1]][2] else NA
})

# Remove possíveis valores NA resultantes de linhas mal formatadas
valores_group_title <- na.omit(valores_group_title)

# Calcula a frequência de cada valor de "group-title"
tabulacao <- as.data.frame(table(valores_group_title))

# Exibe a tabulação
print(tabulacao)

writexl::write_xlsx(tabulacao, "tabulacao_conteudo_final.xlsx")
