# Define os canais a serem buscados em uma lista
canais_a_buscar <- c("VH1", "MTV", "CNN") # Exemplo de canais

# Lê o conteúdo do arquivo
conteudo <- readLines("minha_lista.m3u8", warn = FALSE)

# Filtra as linhas que contêm a tag "tvg-name"
linhas_com_tvg_name <- grep("tvg-name", conteudo, value = TRUE)

# Extrai os nomes dos canais da tag "tvg-name"
nomes_canais <- sapply(linhas_com_tvg_name, function(linha) {
  matches <- regmatches(linha, regexec('tvg-name="([^"]*)"', linha))
  if (length(matches[[1]]) > 1) matches[[1]][2] else NA
})

# Remove possíveis valores NA resultantes de linhas mal formatadas
nomes_canais <- na.omit(nomes_canais)

# Prepara uma função para buscar os canais desejados de forma case insensitive
busca_canais <- function(lista_canais, nomes_canais) {
  resultados <- list()
  for (canal in lista_canais) {
    # Usa expressão regular para busca case insensitive
    padrao <- tolower(canal)
    canais_encontrados <- nomes_canais[grepl(padrao, tolower(nomes_canais))]
    resultados[[canal]] <- canais_encontrados
  }
  return(resultados)
}

# Executa a busca pelos canais desejados
resultados_busca <- busca_canais(canais_a_buscar, nomes_canais)

# Imprime os resultados
for (canal in names(resultados_busca)) {
  cat("Canal:", canal, "\n")
  cat("Quantidade encontrada:", length(resultados_busca[[canal]]), "\n")
  cat("Nomes dos canais:\n", paste(resultados_busca[[canal]], collapse = "\n"), "\n\n")
}