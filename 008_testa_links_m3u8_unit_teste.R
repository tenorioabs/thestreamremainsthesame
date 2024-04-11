# Lê o arquivo m3u8 e remove blocos com group-title="Omitir"
caminho_arquivo <- nome_coluna
linhas <- readLines(caminho_arquivo, warn = FALSE)

# Identifica e remove blocos com "group-title="Omitir""
linhas_filtradas <- c()
omitir <- FALSE
for (linha in linhas) {
  if (grepl("^#EXTINF", linha)) {
    omitir <- grepl('group-title="Omitir"', linha)
  }
  if (!omitir) {
    linhas_filtradas <- c(linhas_filtradas, linha)
  }
}

# Caminho para o novo arquivo .m3u8 com as URLs ativas
novo_arquivo <- nome_coluna

# Escreve as URLs ativas no novo arquivo
writeLines(linhas_filtradas, novo_arquivo)

cat("Arquivo com URLs ativas criado com sucesso:", novo_arquivo, "\n")