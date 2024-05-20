################################################################################
################################################################################
# Bloco 1, recebe a lista de URLs e concatena em um arquivo chamado "minha_lista.m3u8"
# Definir caminho do arquivo e nome da coluna

caminho_arquivo <- "urls_geral.xlsx"

if (valor_numerico == 1) {
  nome_coluna <- "reduced.m3u8"
  url_m3u8 <- read_xlsx(caminho_arquivo, sheet ='reduced.m3u8')
  url_m3u8 <- url_m3u8$reduced.m3u8
  url_m3u8 <- unique(url_m3u8)
} else if (valor_numerico == 2) {
  nome_coluna <- "full.m3u8"
  url_m3u8 <- read_xlsx(caminho_arquivo, sheet ='full.m3u8')
  url_m3u8 <- url_m3u8$full.m3u8
  url_m3u8 <- unique(url_m3u8)
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
writeLines(conteudo_final, nome_coluna)
message("Arquivo salvo com sucesso.")
################################################################################
################################################################################