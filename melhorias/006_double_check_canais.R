# Carrega as bibliotecas necessárias
if (!requireNamespace("stringr", quietly = TRUE)) install.packages("stringr")
library(stringr)

# Define o caminho para o arquivo m3u8
caminho_arquivo <- nome_coluna

# Lê o arquivo linha por linha
linhas_arquivo <- readLines(caminho_arquivo, warn = FALSE)

# Inicializa variáveis para construir os blocos
blocos_canais <- list()
bloco_atual <- ""
inicio_novo_bloco <- TRUE

# Constrói os blocos de canais manualmente
for (linha in linhas_arquivo) {
  #print(linha)
  if (str_detect(linha, "^#EXTINF")) {
    if (!inicio_novo_bloco) {
      blocos_canais <- c(blocos_canais, list(bloco_atual))
      bloco_atual <- ""
    }
    inicio_novo_bloco <- FALSE
  }
  bloco_atual <- paste(bloco_atual, linha, sep = "\n")
}

# Adiciona o último bloco se não estiver vazio
if (bloco_atual != "") {
  blocos_canais <- c(blocos_canais, list(bloco_atual))
}

# Padrões regex
padrao_brasil <- "(Brasil|Brazil|brasil|brazil|bra|Bra|br:|BR:|\\(br\\)|\\(BR\\)|BR_)"
padrao_group_title <- "group-title=\"[^\"]*\""

# Inicializa a barra de progresso
pb <- txtProgressBar(min = 0, max = length(blocos_canais), style = 3)

# Processa cada bloco
for (i in seq_along(blocos_canais)) {
  print(i)
  bloco <- blocos_canais[[i]]
  
  # Verifica se contém menção ao Brasil
  if (str_detect(bloco, padrao_brasil)) {
    # Substitui o valor de group-title por "Brazil"
    bloco <- str_replace_all(bloco, padrao_group_title, 'group-title="Brazil"')
    blocos_canais[[i]] <- bloco
  }
  
  # Atualiza a barra de progresso
  setTxtProgressBar(pb, i)
}

# Fecha a barra de progresso
close(pb)

# Combina os blocos ajustados de volta em uma única string
conteudo_ajustado <- paste(unlist(blocos_canais), collapse = "\n")

# Escreve o conteúdo ajustado de volta no arquivo
writeLines(conteudo_ajustado, nome_coluna)

cat("O arquivo foi ajustado com sucesso. Os 'group-title' foram modificados para 'Brazil' onde foram encontradas menções ao país.\n")