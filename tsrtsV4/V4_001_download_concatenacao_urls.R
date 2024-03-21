################################################################################
################################################################################
# Bloco 1, recebe a lista de URLs e concatena em um arquivo chamado "minha_lista.m3u8"
# Definir caminho do arquivo e nome da coluna
caminho_arquivo <- "/GitHub/outros_scripts/urls_geral.xlsx"
nome_coluna <- "urls_geral"

url_m3u8 <- read_xlsx(caminho_arquivo)
url_m3u8 <- url_m3u8$urls_geral
url_m3u8 <- unique(url_m3u8)

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
################################################################################
################################################################################

