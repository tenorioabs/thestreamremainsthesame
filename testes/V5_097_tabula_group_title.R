
tabula_group_title <- function(arquivo_a_ser_tabulado){
# Define o caminho para o arquivo M3U8 unificado
arquivo <- arquivo_a_ser_tabulado
  # Lê o conteúdo do arquivo
  conteudo <- readLines(arquivo, warn = FALSE)
  
  # Filtra as linhas que contêm a tag "group-title"
  linhas_com_group_title <- grep("group-title", conteudo, value = TRUE)
  
  # Extrai os valores da tag "group-title"
  valores_group_title <- sapply(linhas_com_group_title, function(linha) {
    matches <- regmatches(linha, regexec('group-title="([^"]+)"', linha))
    if (length(matches[[1]]) > 1) matches[[1]][2] else NA
  })
  
  # Remove possíveis valores NA resultantes de linhas mal formatadas
  valores_group_title <- na.omit(valores_group_title)
  
  # Calcula a frequência de cada valor de "group-title"
  tabulacao <- as.data.frame(table(valores_group_title))
  
  # Exibe a tabulação
  print(tabulacao)
  
  writexl::write_xlsx(tabulacao, "tabulacao_conteudo_final.xlsx")
}