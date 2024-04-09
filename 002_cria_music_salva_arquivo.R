################################################################################
################################################################################
# Bloco 2, carrega o arquivo "minha_lista.m3u8", aplica Regex e cria novo grupo
# chamado "Music" e salva no arquivo "canais_encontrados_modificados.m3u8"

# Ler o arquivo com os dados dos canais
caminho_do_arquivo <- nome_coluna
linhas <- readLines(caminho_do_arquivo)

canais_buscados <- read_xlsx("urls_geral.xlsx", sheet = 'canais')
canais_buscados <- unique(canais_buscados$canais)
canais_buscados <- as.list(canais_buscados)

# Inicializar uma lista para armazenar os resultados da busca
resultados_busca <- list()

# Definir o novo valor para "group-title"
novo_group_title <- "Music"

# Inicializar os elementos da lista para cada canal buscado
for (canal in canais_buscados) {
  print(canal)
  resultados_busca[[canal]] <- c()
}

# Buscar os canais e modificar a tag "group-title"
canais_encontrados <- c()
capturar_proxima_linha <- FALSE

for (linha in linhas) {
  #print(linha)
  if (capturar_proxima_linha) {
    # Adiciona a URL do canal encontrado na lista
    canais_encontrados <- c(canais_encontrados, linha)
    capturar_proxima_linha <- FALSE # Reseta o indicador para captura da próxima linha
    next
  }
  
  for (canal in canais_buscados) {
    #print(canal)
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
  print(canal)
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