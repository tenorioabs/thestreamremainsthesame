################################################################################
################################################################################
source("V4_09_instala_carrega_pacotes.R")
source("V4_03_funcoes.R")
################################################################################
################################################################################
# Bloco 1, recebe a lista de URLs e concatena em um arquivo chamado "minha_lista.m3u8"
# Definir caminho do arquivo e nome da coluna
caminho_arquivo <- "F:/GitHub/outros_scripts/urls_geral.xlsx"
nome_coluna <- "urls_geral"

# Função para carregar URLs do arquivo Excel
carrega_urls_geral <- function(caminho_arquivo, nome_coluna) {
  urls <- read_excel(caminho_arquivo, col_types = "text")
  if (nome_coluna %in% colnames(urls)) {
    return(urls[[nome_coluna]])
  } else {
    stop("Coluna não encontrada no arquivo.")
  }
}

# Chamar a função e salvar o resultado
url_m3u8 <- carrega_urls_geral(caminho_arquivo, nome_coluna)
url_m3u8 <- unique(url_m3u8)

# Verificar o resultado
if (!is.null(url_m3u8)) {
  print(url_m3u8)
} else {
  cat("Falha ao carregar os dados.\n")
}

# Modificar a função processa_url para incluir a verificação de sucesso
processa_url <- function(url) {
  print(url)
  response <- tryCatch({
    GET(url)
  }, error = function(e) {
    message("Erro ao processar URL: ", url, "; Erro: ", e)
    return(NULL)
  })
  
  if (is.null(response)) return(NULL)
  
  conteudo <- content(response, "text", encoding = "UTF-8")
  return(list(url = url, conteudo = conteudo))
}

# Processar URLs e coletar o conteúdo para cada uma
conteudos <- lapply(url_m3u8, processa_url)

# Inicializar o DataFrame para armazenar URLs bem-sucedidas
urls_funcionando <- data.frame(urls_geral = character(), stringsAsFactors = FALSE)

# Filtrar linhas em branco para cada conteúdo e então unlist
conteudos_filtrados <- lapply(conteudos, function(x) {
  if (!is.null(x)) {
    urls_funcionando <<- rbind(urls_funcionando, data.frame(urls_geral = x$url))
    grep("^\\S", x$conteudo, value = TRUE)
  }
})

conteudo_final_sem_filtro <- paste(unlist(conteudos_filtrados), collapse = "\n")
conteudo_final <- gsub("\n{2,}", "\n", conteudo_final_sem_filtro)

# Salvar o conteúdo final no arquivo "minha_lista.m3u8", eliminando linhas em branco
writeLines(conteudo_final, "minha_lista.m3u8")
message("Arquivo 'minha_lista.m3u8' salvo com sucesso, sem linhas em branco.")

# Salvar o DataFrame de URLs bem-sucedidas no arquivo Excel, sobrescrevendo o existente
write_xlsx(urls_funcionando, caminho_arquivo)
message("Arquivo 'urls_geral.xlsx' atualizado com sucesso, contendo apenas as URLs que funcionaram.")

################################################################################
################################################################################

