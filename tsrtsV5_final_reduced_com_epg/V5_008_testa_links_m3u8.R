# Carrega os pacotes necessários
if (!requireNamespace("httr", quietly = TRUE)) install.packages("httr")
if (!requireNamespace("future", quietly = TRUE)) install.packages("future")
if (!requireNamespace("future.apply", quietly = TRUE)) install.packages("future.apply")
if (!requireNamespace("progressr", quietly = TRUE)) install.packages("progressr")

library(httr)
library(future)
library(future.apply)
library(progressr)

# Configuração inicial para paralelização
future::plan("multisession", workers = 6)

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
caminho_arquivo <- "minha_lista_concatenada_ativa.m3u8"
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
linha_cabecalho <- "#EXTM3U x-tvg-url=\"https://raw.githubusercontent.com/tenorioabs/thestreamremainsthesame/main/minha_lista_concatenada.xml.gz\""

# Inicializa a lista para guardar as URLs ativas
urls_ativas <- c(linha_cabecalho)

# Define uma função para processar as URLs com barra de progresso
processarURLs <- function(posicoes) {
  handlers(global = TRUE)
  p <- progressor(along = posicoes)
  
  resultados <- future_lapply(posicoes, function(posicao) {
    p()
    url_atual <- linhas_filtradas[posicao]
    linha_extinf <- linhas_filtradas[posicao - 1]
    if (verificarURL(url_atual)) {
      imprimirColorido(sprintf("URL: Streaming ativo."), "verde")
      return(c(linha_extinf, url_atual))
    } else {
      imprimirColorido(sprintf("URL: Streaming inativo."), "vermelho")
      return(NULL)
    }
  })
  
  return(do.call("c", resultados))
}

# Processa cada posição embaralhada com barra de progresso
with_progress({
  urls_ativas <- c(urls_ativas, processarURLs(posicoes_urls_embaralhadas))
})

# Caminho para o novo arquivo .m3u8 com as URLs ativas
novo_arquivo <- "minha_lista_concatenada_ativa.m3u8"

# Escreve as URLs ativas no novo arquivo
writeLines(urls_ativas, novo_arquivo)

cat("Arquivo com URLs ativas criado com sucesso:", novo_arquivo, "\n")