################################################################################
################################################################################
# Bloco 4, apenas modifica a primeira linha indicado xml (epg) default
# Definir o caminho do arquivo
caminho_do_arquivo <- nome_coluna

# Ler o arquivo
linhas <- readLines(caminho_do_arquivo)

# Substituir a URL na primeira linha
if (grepl("^#EXTM3U", linhas[1])) {
  linhas[1] <- gsub('x-tvg-url="[^"]+"', 'x-tvg-url="https://github.com/tenorioabs/thestreamremainsthesame/raw/main/reduced.xml.gz"', linhas[1], perl = TRUE)
}

# Remover as linhas com a tag x-tvg-url, exceto a primeira linha
linhas_para_manter <- c(linhas[1], linhas[!grepl('x-tvg-url=', linhas) | !grepl('^#EXTM3U', linhas)])

# Salvar o arquivo com as modificações
writeLines(linhas_para_manter, caminho_do_arquivo)

# Mensagem de confirmação
cat("O arquivo foi atualizado. A URL na tag 'x-tvg-url' da primeira linha foi substituída.\n")
################################################################################
################################################################################