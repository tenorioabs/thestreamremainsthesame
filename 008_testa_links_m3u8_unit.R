# Carrega os pacotes necessários
if (!requireNamespace("httr", quietly = TRUE)) install.packages("httr")
library(httr)

# Função para imprimir mensagens coloridas
imprimirColorido <- function(mensagem, cor = "verde") {
  cores <- c(verde = "\033[32m", vermelho = "\033[31m")
  cor_inicio <- cores[[cor]]
  cor_fim <- "\033[39m"
  cat(paste0(cor_inicio, mensagem, cor_fim, "\n"))
}

# Função para verificar a disponibilidade da URL
verificarURL <- function(url) {
  res <- tryCatch({
    HEAD(url, timeout(10))
  }, error = function(e) {
    return(FALSE)
  })
  return(inherits(res, "response") && status_code(res) %in% 200:299)
}

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

# Encontra as posições das URLs que terminam com .m3u ou .m3u8
posicoes_urls <- grep("^.+\\.m3u8?$", linhas_filtradas, value = FALSE)
set.seed(123) # Para reprodutibilidade do shuffle
posicoes_urls_embaralhadas <- sample(posicoes_urls)

# Prepara a linha de cabeçalho para o novo arquivo
if (valor_numerico==1) {
  linha_cabecalho <- "#EXTM3U x-tvg-url=\"https://raw.githubusercontent.com/tenorioabs/thestreamremainsthesame/main/reduced.xml\""
} else {
  linha_cabecalho <- "#EXTM3U x-tvg-url=\"https://raw.githubusercontent.com/tenorioabs/thestreamremainsthesame/main/full.xml.gz\""
}

# Inicializa a lista para guardar as URLs ativas
urls_ativas <- c(linha_cabecalho)

# Processa cada posição embaralhada
total_urls <- length(posicoes_urls_embaralhadas)
for (i in seq_along(posicoes_urls_embaralhadas)) {
  posicao_atual <- posicoes_urls_embaralhadas[i]
  url_atual <- linhas_filtradas[posicao_atual]
  linha_extinf <- linhas_filtradas[posicao_atual - 1]
  
  cat(sprintf("Verificando URL %d de %d: %s\n", i, total_urls, substr(url_atual, 1, 50)))
  
  if (verificarURL(url_atual)) {
    imprimirColorido(sprintf("URL %d/%d: Streaming ativo.", i, total_urls), "verde")
    urls_ativas <- c(urls_ativas, linha_extinf, url_atual)
  } else {
    imprimirColorido(sprintf("URL %d/%d: Streaming inativo.", i, total_urls), "vermelho")
  }
}

# Caminho para o novo arquivo .m3u8 com as URLs ativas
novo_arquivo <- nome_coluna

# Escreve as URLs ativas no novo arquivo
writeLines(urls_ativas, novo_arquivo)

cat("Arquivo com URLs ativas criado com sucesso:", novo_arquivo, "\n")