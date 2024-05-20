################################################################################
################################################################################
# Bloco 5, substitui nomes de grupos e atualiza o arquivo "minha_lista_concatenada.m3u8"
# Define o caminho do arquivo de entrada e de saída
arquivo_entrada <- nome_coluna
arquivo_saida <- nome_coluna

# Lê o conteúdo do arquivo de entrada
conteudo <- readLines(arquivo_entrada, warn = FALSE)

# Lista de títulos de grupos que devem ser mantidos
titulos_mantidos <- c("Brazil",
                      "Canada",
                      "EFL",
                      "EPL",
                      "Great Britain",
                      "MLB",
                      "Music",
                      "NFL",
                      "NHL",
                      "Portugal",
                      "United States",
                      "NBA",
                      "UFC",
                      "Sports")

# Função para verificar e substituir os títulos dos grupos
substituir_titulos <- function(linha) {
  # Verifica se a linha é um canal
  if (grepl("^#EXTINF:", linha)) {
    if (grepl('group-title="Nz"', linha)) { linha <- sub('group-title="Nz"', 'group-title="New Zealand"', linha) }
    if (grepl('group-title="Au"', linha)) { linha <- sub('group-title="Au"', 'group-title="Australia"', linha) }
    if (grepl('group-title="Adelaide"', linha)) { linha <- sub('group-title="Adelaide"', 'group-title="Australia"', linha) }
    if (grepl('group-title="Brisbane"', linha)) { linha <- sub('group-title="Brisbane"', 'group-title="Australia"', linha) }
    if (grepl('group-title="Canberra"', linha)) { linha <- sub('group-title="Canberra"', 'group-title="Australia"', linha) }
    if (grepl('group-title="Darwin"', linha)) { linha <- sub('group-title="Darwin"', 'group-title="Australia"', linha) }
    if (grepl('group-title="Hobart"', linha)) { linha <- sub('group-title="Hobart"', 'group-title="Australia"', linha) }
    if (grepl('group-title="Melbourne"', linha)) { linha <- sub('group-title="Melbourne"', 'group-title="Australia"', linha) }
    if (grepl('group-title="Perth"', linha)) { linha <- sub('group-title="Perth"', 'group-title="Australia"', linha) }
    if (grepl('group-title="Sydney"', linha)) { linha <- sub('group-title="Sydney"', 'group-title="Australia"', linha) }
    
    # Verifica se a linha contém algum dos títulos de grupos mantidos
    mantido <- FALSE
    for (titulo in titulos_mantidos) {
      if (grepl(sprintf('group-title="%s"', titulo), linha)) {
        mantido <- TRUE
        break
      }
    }
    
    # Se não for um título mantido, substitui por "Omitir"
    if (!mantido) {
      # Verifica se já existe um group-title para substituição
      if (grepl("group-title=", linha)) {
        linha <- sub('group-title="[^"]*"', 'group-title="Omitir"', linha)
      } else {
        # Caso não exista um group-title, adiciona um novo com "Omitir"
        linha <- sub("^#EXTINF:", '#EXTINF: group-title="Omitir",', linha)
      }
    }
  }
  return(linha)
}
# 
# Aplica a função de substituição ao conteúdo
conteudo_modificado <- sapply(conteudo, substituir_titulos, USE.NAMES = FALSE)

# Salva o conteúdo modificado no arquivo de saída
writeLines(conteudo_modificado, arquivo_saida)

# Mensagem de conclusão
cat("O arquivo", arquivo_saida, "foi atualizado com sucesso.")
