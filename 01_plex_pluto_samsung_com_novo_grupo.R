# Carregar pacotes necessários
if (!requireNamespace("httr", quietly = TRUE)) install.packages("httr")
library(httr)
if (!requireNamespace("dplyr", quietly = TRUE)) install.packages("dplyr")
library(dplyr)
if (!requireNamespace("stringr", quietly = TRUE)) install.packages("stringr")
library(stringr)

# Função para processar as URLs e retornar o conteúdo
processa_url <- function(url) {
  response <- tryCatch({
    GET(url)
  }, error = function(e) {
    message("Erro ao processar URL: ", url, "; Erro: ", e)
    return(NULL)
  })
  
  if (is.null(response)) return(NULL)
  
  conteudo <- content(response, "text", encoding = "UTF-8")
  # Remover cabeçalhos #EXTM3U exceto no primeiro arquivo
  if (url != url_m3u8[1]) {
    conteudo <- sub("#EXTM3U.*\n", "", conteudo, perl = TRUE)
  }
  return(conteudo)
}

# Lista de URLs
url_m3u8 <- c("https://i.mjh.nz/Plex/all.m3u8",
              "https://i.mjh.nz/PlutoTV/all.m3u8",
              "https://i.mjh.nz/SamsungTVPlus/all.m3u8")

# Processar URLs e coletar o conteúdo para cada uma
conteudos <- lapply(url_m3u8, processa_url)

# Concatenar todos os conteúdos
conteudo_final <- paste(unlist(conteudos), collapse = "\n")

# Salvar o conteúdo final no arquivo "minha_lista.m3u8"
writeLines(conteudo_final, "minha_lista.m3u8")

message("Arquivo 'minha_lista.m3u8' salvo com sucesso.")

################################################################################
# O restante do código para processar, buscar e modificar os canais
################################################################################

# Ler o arquivo com os dados dos canais
caminho_do_arquivo <- "minha_lista.m3u8"
linhas <- readLines(caminho_do_arquivo)

# Especificar os nomes dos canais buscados
canais_buscados <- c("VH1", "MTV")

# Inicializar uma lista para armazenar os resultados da busca
resultados_busca <- list()

# Inicializar os elementos da lista para cada canal buscado
for (canal in canais_buscados) {
  resultados_busca[[canal]] <- c()
}

# Buscar os canais e modificar a tag "group-title"
canais_encontrados <- ""
for (linha in linhas) {
  for (canal in canais_buscados) {
    if (str_detect(linha, fixed(canal))) {
      # Substituir o valor da tag "group-title" por "Music"
      linha_modificada <- str_replace(linha, pattern = "group-title=\"[^\"]*\"", replacement = "group-title=\"Music\"")
      
      # Extrair o nome do canal e armazenar na lista de resultados
      nome_canal <- str_extract(linha, "(?<=,).*$") # Supondo que o nome do canal esteja após a última vírgula
      resultados_busca[[canal]] <- c(resultados_busca[[canal]], nome_canal)
      
      # Salvar a linha modificada em um vetor temporário para posterior salvamento
      canais_encontrados <- c(canais_encontrados, linha_modificada)
      
      break # Interrompe o loop interno uma vez que o canal foi encontrado e modificado
    }
  }
}

# Verificar se algum canal foi encontrado e salvar os canais modificados em um novo arquivo
if (length(canais_encontrados) > 0) {
  writeLines(canais_encontrados, "canais_encontrados_modificados.m3u8")
  cat("Canais encontrados com a tag 'group-title' modificada para 'Music' foram salvos em 'canais_encontrados_modificados.m3u8'.\n")
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
# Definir os caminhos dos arquivos para a concatenação final
################################################################################

caminho_lista_original <- "minha_lista.m3u8"
caminho_lista_modificada <- "canais_encontrados_modificados.m3u8"

# Ler os conteúdos dos arquivos
conteudo_lista_original <- readLines(caminho_lista_original)
conteudo_lista_modificada <- readLines(caminho_lista_modificada)

# Concatenar os conteúdos
conteudo_concatenado <- c(conteudo_lista_original, conteudo_lista_modificada)

# Escrever o conteúdo concatenado em um novo arquivo
writeLines(conteudo_concatenado, caminho_lista_original)

cat("Os arquivos foram concatenados com sucesso e o resultado foi salvo em", caminho_lista_original, "\n")

################################################################################
# Finalização e limpeza
################################################################################

# Definir o caminho do arquivo
caminho_do_arquivo <- "minha_lista.m3u8"

# Ler o arquivo
linhas <- readLines(caminho_do_arquivo)

# Verificar se a primeira linha contém a tag e substituir a URL
if (grepl("^#EXTM3U", linhas[1])) {
  linhas[1] <- gsub('x-tvg-url="[^"]+"', 'x-tvg-url="https://raw.githubusercontent.com/tenorioabs/thestreamremainsthesame/main/minha_lista.xml"', linhas[1])
}

# Salvar o arquivo com a modificação
writeLines(linhas, caminho_do_arquivo)

# Mensagem de confirmação
cat("A URL na tag 'x-tvg-url' foi atualizada com sucesso no arquivo", caminho_do_arquivo, "\n")

source("02_cria_xml.R")
source("03_funcoes_github.R")
file.remove("canais_encontrados_modificados.m3u8")
github_windows("Reformulação Geral")
#github_linux("Reformulação Geral")

################################################################################
################################################################################


