# Carregar o conteúdo do arquivo
ler_arquivo <- function(nome_arquivo) {
  readLines(nome_arquivo, warn = FALSE)
}

# Escrever o conteúdo processado em um novo arquivo
escrever_arquivo <- function(nome_arquivo, conteudo) {
  writeLines(conteudo, nome_arquivo)
}

# Processar o conteúdo do arquivo
processar_conteudo <- function(conteudo) {
  # Concatenar todo o conteúdo em uma única string para facilitar a substituição
  conteudo_completo <- paste(conteudo, collapse = "\n")
  
  # Substituir apenas tvg-logo="" (vazio) pela URL do logo do Sepultura
  conteudo_completo <- gsub('tvg-logo=""', 'tvg-logo="https://seeklogo.com/images/S/Sepultura-logo-42D2BAFFB4-seeklogo.com.png"', conteudo_completo)
  
  # Separar novamente em linhas para identificar blocos únicos
  linhas <- unlist(strsplit(conteudo_completo, "\n"))
  
  # Identificar e remover blocos duplicados
  padrao <- "#EXTINF"
  blocos <- split(linhas, cumsum(grepl(padrao, linhas)))
  blocos_unicos <- unique(blocos)
  
  # Juntar os blocos únicos em um único texto
  conteudo_processado <- unlist(lapply(blocos_unicos, function(bloco) paste(bloco, collapse = "\n")))
  
  return(conteudo_processado)
}

# Nomes dos arquivos de entrada e saída
nome_arquivo_entrada <- "minha_lista_concatenada_ativa.m3u8"
nome_arquivo_saida <- "minha_lista_concatenada_ativa.m3u8"

# Ler, processar e escrever o arquivo
conteudo <- ler_arquivo(nome_arquivo_entrada)
conteudo_processado <- processar_conteudo(conteudo)
escrever_arquivo(nome_arquivo_saida, conteudo_processado)

cat("Processamento concluído. Verifique o arquivo de saída.")