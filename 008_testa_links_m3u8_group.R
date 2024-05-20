
# Configuração inicial para paralelização
if (valor_numerico==1) {
  future::plan("multisession", workers = 1)  
} else if (valor_numerico==2) {
  future::plan("multisession", workers = 8)
}


# Lê o arquivo m3u8
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

# Encontra as posições das URLs que terminam com .m3u ou .m3u8
posicoes_urls <- grep("^.+\\.m3u8?$", linhas_filtradas, value = FALSE)
set.seed(123) # Para reprodutibilidade do shuffle
posicoes_urls_embaralhadas <- sample(posicoes_urls)

# Prepara a linha de cabeçalho para o novo arquivo
if (grepl("^#EXTM3U", linhas[1])) {
  if (valor_numerico==1) {
    linha_cabecalho <- "#EXTM3U x-tvg-url=\"https://github.com/tenorioabs/thestreamremainsthesame/raw/main/reduced.xml.gz\""
  } else {
    linha_cabecalho <- "#EXTM3U x-tvg-url=\"https://github.com/tenorioabs/thestreamremainsthesame/raw/main/reduced.xml.gz\""
  }
}

# Inicializa a lista para guardar as URLs ativas
urls_ativas <- c(linha_cabecalho)

# Processa cada posição embaralhada com barra de progresso
#with_progress({
urls_ativas <- c(urls_ativas, processarURLs(posicoes_urls_embaralhadas))
#})

# Caminho para o novo arquivo .m3u8 com as URLs ativas
novo_arquivo <- nome_coluna

# Escreve as URLs ativas no novo arquivo
writeLines(urls_ativas, novo_arquivo)

cat("Arquivo com URLs ativas criado com sucesso:", novo_arquivo, "\n")

