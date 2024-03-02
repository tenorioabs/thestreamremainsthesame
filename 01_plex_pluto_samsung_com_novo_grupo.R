# Carregar pacotes necessários
if (!requireNamespace("httr", quietly = TRUE)) install.packages("httr")
library(httr)
if (!requireNamespace("dplyr", quietly = TRUE)) install.packages("dplyr")
library(dplyr)
if (!requireNamespace("stringr", quietly = TRUE)) install.packages("stringr")
library(stringr)

source("03_funcoes_github.R")

# Lista de URLs
url_m3u8 <- c("https://i.mjh.nz/Plex/all.m3u8",
              "https://i.mjh.nz/PlutoTV/all.m3u8",
              "https://i.mjh.nz/SamsungTVPlus/all.m3u8",
              "http://m3u4u.com/m3u/m/g1rd82k597h6we7pkqej") #merged m3u4u

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

# Concatenar todos os conteúdos
conteudo_final <- paste(unlist(conteudos), collapse = "\n")

# Salvar o conteúdo final no arquivo "minha_lista.m3u8"
writeLines(conteudo_final, "minha_lista.m3u8")

message("Arquivo 'minha_lista.m3u8' salvo com sucesso.")

################################################################################
################################################################################

# Ler o arquivo com os dados dos canais
caminho_do_arquivo <- "minha_lista.m3u8"
linhas <- readLines(caminho_do_arquivo)

# Especificar os nomes dos canais buscados
canais_buscados <- c("VH1",
                     "Best of MTV", 
                     "MTV Approved Hip Hop", 
                     "MTV Biggest Pop", 
                     "MTV Classic", 
                     "MTV en español", 
                     "MTV Flow Latino", 
                     "MTV Frauen Power", 
                     "MTV German Music", 
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
                     "MTV: Best of", 
                     "Yo! MTV Raps Classic", 
                     "BMTV ", 
                     "IFM TV", 
                     "KMTV", 
                     "Littoral FM", 
                     "MTV Beats", 
                     "MTV Hits France", 
                     "Pluto TV MTV", 
                     "Stingray",
                     "Live Music Replay",
                     "CMT",
                     "Vevo",
                     "XITE",
                     "Classica",
                     "Qello",
                     "CMusic",
                     "Djazz",
                     "Naturescape",
                     "Now 80's",
                     "Now Rock",
                     "Now 80s",
                     "Deluxe Lounge HD",
                     "Pluto TV Fireplace",
                     "Classic Rock",
                     "Rock Story",
                     "Classic Rock",
                     "Rock TV")

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

# Definir os caminhos dos arquivos
caminho_lista_original <- "minha_lista.m3u8"
caminho_lista_modificada <- "canais_encontrados_modificados.m3u8"
caminho_lista_concatenada <- "minha_lista_concatenada.m3u8"

# Ler os conteúdos dos arquivos
conteudo_lista_original <- readLines(caminho_lista_original)
conteudo_lista_modificada <- readLines(caminho_lista_modificada)

# Concatenar os conteúdos
conteudo_concatenado <- c(conteudo_lista_original, conteudo_lista_modificada)

# Escrever o conteúdo concatenado em um novo arquivo
writeLines(conteudo_concatenado, caminho_lista_concatenada)

cat("Os arquivos foram concatenados com sucesso e o resultado foi salvo em", caminho_lista_concatenada, "\n")

################################################################################
# Finalização e limpeza
################################################################################

# Definir o caminho do arquivo
caminho_do_arquivo <- "minha_lista_concatenada.m3u8"

# Ler o arquivo
linhas <- readLines(caminho_do_arquivo)

# Substituir a URL na primeira linha
if (grepl("^#EXTM3U", linhas[1])) {
  linhas[1] <- gsub('x-tvg-url="[^"]+"', 'x-tvg-url="https://raw.githubusercontent.com/tenorioabs/thestreamremainsthesame/main/minha_lista_concatenada.xml"', linhas[1], perl = TRUE)
}

# Remover as linhas com a tag x-tvg-url, exceto a primeira linha
linhas_para_manter <- c(linhas[1], linhas[!grepl('x-tvg-url=', linhas) | !grepl('^#EXTM3U', linhas)])

# Salvar o arquivo com as modificações
writeLines(linhas_para_manter, caminho_do_arquivo)

# Mensagem de confirmação
cat("O arquivo foi atualizado. A URL na tag 'x-tvg-url' da primeira linha foi substituída conforme solicitado, e as outras linhas com a tag 'x-tvg-url' foram removidas de forma genérica.\n")

################################################################################
################################################################################

#source("02_cria_xml.R")
source("03_funcoes_github.R")
file.remove("canais_encontrados_modificados.m3u8")
file.remove("minha_lista.m3u8")
github_windows("Sobe XML")
#github_linux("Reformulação Geral")

################################################################################
################################################################################


