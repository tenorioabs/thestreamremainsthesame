################################################################################
################################################################################
# Bloco 5, substitui nomes de grupos e atualiza o arquivo "minha_lista_concatenada.m3u8"
# Define o caminho do arquivo de entrada e de saída
arquivo_entrada <- nome_coluna
arquivo_saida <- nome_coluna

# Lê o conteúdo do arquivo de entrada
conteudo <- readLines(arquivo_entrada, warn = FALSE)

# Lista de títulos de grupos que devem ser mantidos
titulos_mantidos <- c("Australia",
                      "Brazil",
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
                      "NBA LEAGUE PASS",
                      "UFC",
                      "PREMIERE")

# Função para verificar e substituir os títulos dos grupos
substituir_titulos <- function(linha) {
  # Verifica se a linha é um canal
  if (grepl("^#EXTINF:", linha)) {
    if (grepl('group-title="Anthym TV"', linha)) { linha <- sub('group-title="Anthym TV"', 'group-title="United States"', linha) }
    if (grepl('group-title="DistroTV: Business"', linha)) { linha <- sub('group-title="DistroTV: Business"', 'group-title="United States"', linha) }
    if (grepl('group-title="DistroTV: Education"', linha)) { linha <- sub('group-title="DistroTV: Education"', 'group-title="United States"', linha) }
    if (grepl('group-title="DistroTV: Entertainment"', linha)) { linha <- sub('group-title="DistroTV: Entertainment"', 'group-title="United States"', linha) }
    if (grepl('group-title="DistroTV: Finance"', linha)) { linha <- sub('group-title="DistroTV: Finance"', 'group-title="United States"', linha) }
    if (grepl('group-title="DistroTV: Fun & Games"', linha)) { linha <- sub('group-title="DistroTV: Fun & Games"', 'group-title="United States"', linha) }
    if (grepl('group-title="DistroTV: Lifestyle"', linha)) { linha <- sub('group-title="DistroTV: Lifestyle"', 'group-title="United States"', linha) }
    if (grepl('group-title="DistroTV: Music"', linha)) { linha <- sub('group-title="DistroTV: Music"', 'group-title="United States"', linha) }
    if (grepl('group-title="DistroTV: News"', linha)) { linha <- sub('group-title="DistroTV: News"', 'group-title="United States"', linha) }
    if (grepl('group-title="DistroTV: Sports"', linha)) { linha <- sub('group-title="DistroTV: Sports"', 'group-title="United States"', linha) }
    if (grepl('group-title="DistroTV: Technology"', linha)) { linha <- sub('group-title="DistroTV: Technology"', 'group-title="United States"', linha) }
    if (grepl('group-title="DistroTV: Travel"', linha)) { linha <- sub('group-title="DistroTV: Travel"', 'group-title="United States"', linha) }
    if (grepl('group-title="Herogo TV"', linha)) { linha <- sub('group-title="Herogo TV"', 'group-title="United States"', linha) }
    if (grepl('group-title="IGOCast Kansas"', linha)) { linha <- sub('group-title="IGOCast Kansas"', 'group-title="United States"', linha) }
    if (grepl('group-title="LocalNow: Action"', linha)) { linha <- sub('group-title="LocalNow: Action"', 'group-title="United States"', linha) }
    if (grepl('group-title="LocalNow: Comedy"', linha)) { linha <- sub('group-title="LocalNow: Comedy"', 'group-title="United States"', linha) }
    if (grepl('group-title="LocalNow: Drama"', linha)) { linha <- sub('group-title="LocalNow: Drama"', 'group-title="United States"', linha) }
    if (grepl('group-title="LocalNow: En Espanol"', linha)) { linha <- sub('group-title="LocalNow: En Espanol"', 'group-title="Spain"', linha) }
    if (grepl('group-title="LocalNow: Entertainment"', linha)) { linha <- sub('group-title="LocalNow: Entertainment"', 'group-title="United States"', linha) }
    if (grepl('group-title="LocalNow: Explore"', linha)) { linha <- sub('group-title="LocalNow: Explore"', 'group-title="United States"', linha) }
    if (grepl('group-title="LocalNow: Family And Faith"', linha)) { linha <- sub('group-title="LocalNow: Family And Faith"', 'group-title="United States"', linha) }
    if (grepl('group-title="LocalNow: Gaming And More"', linha)) { linha <- sub('group-title="LocalNow: Gaming And More"', 'group-title="United States"', linha) }
    if (grepl('group-title="LocalNow: Horror And SciFi"', linha)) { linha <- sub('group-title="LocalNow: Horror And SciFi"', 'group-title="United States"', linha) }
    if (grepl('group-title="LocalNow: Lifestyle"', linha)) { linha <- sub('group-title="LocalNow: Lifestyle"', 'group-title="United States"', linha) }
    if (grepl('group-title="LocalNow: Local"', linha)) { linha <- sub('group-title="LocalNow: Local"', 'group-title="United States"', linha) }
    if (grepl('group-title="LocalNow: More Cities"', linha)) { linha <- sub('group-title="LocalNow: More Cities"', 'group-title="United States"', linha) }
    if (grepl('group-title="LocalNow: Movies And TV"', linha)) { linha <- sub('group-title="LocalNow: Movies And TV"', 'group-title="United States"', linha) }
    if (grepl('group-title="LocalNow: Music And Arts"', linha)) { linha <- sub('group-title="LocalNow: Music And Arts"', 'group-title="United States"', linha) }
    if (grepl('group-title="LocalNow: News And Opinion"', linha)) { linha <- sub('group-title="LocalNow: News And Opinion"', 'group-title="United States"', linha) }
    if (grepl('group-title="LocalNow: Reality"', linha)) { linha <- sub('group-title="LocalNow: Reality"', 'group-title="United States"', linha) }
    if (grepl('group-title="LocalNow: Recommended"', linha)) { linha <- sub('group-title="LocalNow: Recommended"', 'group-title="United States"', linha) }
    if (grepl('group-title="LocalNow: Relaxation"', linha)) { linha <- sub('group-title="LocalNow: Relaxation"', 'group-title="United States"', linha) }
    if (grepl('group-title="LocalNow: Sports"', linha)) { linha <- sub('group-title="LocalNow: Sports"', 'group-title="United States"', linha) }
    if (grepl('group-title="LocalNow: World Interest"', linha)) { linha <- sub('group-title="LocalNow: World Interest"', 'group-title="United States"', linha) }
    if (grepl('group-title="RedBox: Action Sci-Fi & Horror"', linha)) { linha <- sub('group-title="RedBox: Action Sci-Fi & Horror"', 'group-title="United States"', linha) }
    if (grepl('group-title="RedBox: Classics & Nostalgia"', linha)) { linha <- sub('group-title="RedBox: Classics & Nostalgia"', 'group-title="United States"', linha) }
    if (grepl('group-title="RedBox: Comedy"', linha)) { linha <- sub('group-title="RedBox: Comedy"', 'group-title="United States"', linha) }
    if (grepl('group-title="RedBox: Crime & Scandal"', linha)) { linha <- sub('group-title="RedBox: Crime & Scandal"', 'group-title="United States"', linha) }
    if (grepl('group-title="RedBox: En Espanol"', linha)) { linha <- sub('group-title="RedBox: En Espanol"', 'group-title="Spain"', linha) }
    if (grepl('group-title="RedBox: Food & Home"', linha)) { linha <- sub('group-title="RedBox: Food & Home"', 'group-title="United States"', linha) }
    if (grepl('group-title="RedBox: Kids & Family"', linha)) { linha <- sub('group-title="RedBox: Kids & Family"', 'group-title="United States"', linha) }
    if (grepl('group-title="RedBox: Movies"', linha)) { linha <- sub('group-title="RedBox: Movies"', 'group-title="United States"', linha) }
    if (grepl('group-title="RedBox: Music"', linha)) { linha <- sub('group-title="RedBox: Music"', 'group-title="United States"', linha) }
    if (grepl('group-title="RedBox: News & Weather"', linha)) { linha <- sub('group-title="RedBox: News & Weather"', 'group-title="United States"', linha) }
    if (grepl('group-title="RedBox: Reality & Game Shows"', linha)) { linha <- sub('group-title="RedBox: Reality & Game Shows"', 'group-title="United States"', linha) }
    if (grepl('group-title="RedBox: Sports & Gaming"', linha)) { linha <- sub('group-title="RedBox: Sports & Gaming"', 'group-title="United States"', linha) }
    if (grepl('group-title="RedBox: Summer Movies Showcase"', linha)) { linha <- sub('group-title="RedBox: Summer Movies Showcase"', 'group-title="United States"', linha) }
    if (grepl('group-title="RedBox: Travel & Lifestyle"', linha)) { linha <- sub('group-title="RedBox: Travel & Lifestyle"', 'group-title="United States"', linha) }
    if (grepl('group-title="RedBox: Westerns"', linha)) { linha <- sub('group-title="RedBox: Westerns"', 'group-title="United States"', linha) }
    if (grepl('group-title="Veely"', linha)) { linha <- sub('group-title="Veely"', 'group-title="United States"', linha) }
    
    
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
