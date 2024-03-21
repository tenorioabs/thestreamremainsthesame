################################################################################
################################################################################
# Bloco 4, apenas modifica a primeira linha indicado xml (epg) default
# Definir o caminho do arquivo
caminho_do_arquivo <- "minha_lista_concatenada.m3u8"

# Ler o arquivo
linhas <- readLines(caminho_do_arquivo)

# Substituir a URL na primeira linha
if (grepl("^#EXTM3U", linhas[1])) {
  linhas[1] <- gsub('x-tvg-url="[^"]+"', 'x-tvg-url="https://raw.githubusercontent.com/tenorioabs/thestreamremainsthesame/main/minha_lista_concatenada.xml.gz"', linhas[1], perl = TRUE)
}

# Remover as linhas com a tag x-tvg-url, exceto a primeira linha
linhas_para_manter <- c(linhas[1], linhas[!grepl('x-tvg-url=', linhas) | !grepl('^#EXTM3U', linhas)])

# Salvar o arquivo com as modificações
writeLines(linhas_para_manter, caminho_do_arquivo)

# Mensagem de confirmação
cat("O arquivo foi atualizado. A URL na tag 'x-tvg-url' da primeira linha foi substituída.\n")
################################################################################
################################################################################