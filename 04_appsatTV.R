################################################################################
################################################################################
source("09_instala_carrega_pacotes.R")
################################################################################
################################################################################
# Bloco 1, recebe a lista de URLs e concatena em um arquivo chamado "minha_lista.m3u8"
# Lista de URLs
url_m3u8 <- c("https://www.apsattv.com/redbox.m3u", 
              "https://www.apsattv.com/xiaomi.m3u", 
              "https://www.apsattv.com/bumblebeetv.m3u", 
              "https://www.apsattv.com/veely.m3u", 
              "https://www.apsattv.com/anthymtv.m3u",
              "https://www.apsattv.com/localnow.m3u",
              "https://www.apsattv.com/lg.m3u", 
              "https://www.apsattv.com/herogotv.m3u",
              "https://www.apsattv.com/rok.m3u",
              "https://www.apsattv.com/vizio.m3u", 
              "https://www.apsattv.com/tcl.m3u",
              "https://www.apsattv.com/tubi.m3u",
              "https://www.apsattv.com/galxytv.m3u",
              "https://www.apsattv.com/rakuten.m3u",
              "https://www.apsattv.com/rakuten-jp.m3u",
              "https://www.apsattv.com/rakuten-uk.m3u",
              "https://www.apsattv.com/klowd.m3u",
              "https://www.apsattv.com/ssungnz.m3u",
              "https://www.apsattv.com/ssungaus.m3u",
              "https://www.apsattv.com/ssungita.m3u",
              "https://www.apsattv.com/ssungspa.m3u",
              "https://www.apsattv.com/ssungcan.m3u", 
              "https://www.apsattv.com/ssungbra.m3u", 
              "https://www.apsattv.com/ssungmex.m3u",
              "https://www.apsattv.com/ssungind.m3u",
              "https://www.apsattv.com/ssungnor.m3u",
              "https://www.apsattv.com/ssungfin.m3u", 
              "https://www.apsattv.com/ssungden.m3u", 
              "https://www.apsattv.com/ssungswe.m3u", 
              "https://www.apsattv.com/ssungpor.m3u",
              "https://www.apsattv.com/ssunglux.m3u", 
              "https://www.apsattv.com/ssungbelg.m3u",
              "https://www.apsattv.com/ssungire.m3u", 
              "https://www.apsattv.com/ssungneth.m3u")

library(httr)

processa_url <- function(url) {
  response <- tryCatch({
    GET(url)
  }, error = function(e) {
    message("Erro ao processar URL: ", url, "; Erro: ", e)
    return(NULL)
  })
  
  if (is.null(response)) return(NULL)
  
  conteudo <- content(response, "text", encoding = "UTF-8")
  return(conteudo)
}

# Processar URLs e coletar o conteúdo para cada uma
conteudos <- lapply(url_m3u8, processa_url)

# Filtrar linhas em branco para cada conteúdo e então unlist
# Aqui, ajustamos para garantir que mesmo após a concatenação, linhas completamente vazias sejam removidas
conteudos_filtrados <- lapply(conteudos, function(x) grep("^\\S", x, value = TRUE))
conteudo_final_sem_filtro <- paste(unlist(conteudos_filtrados), collapse = "\n")

# Novo passo: remover linhas completamente vazias após a concatenação
conteudo_final <- gsub("\n{2,}", "\n", conteudo_final_sem_filtro)

# Salvar o conteúdo final no arquivo "minha_lista.m3u8", eliminando linhas em branco
writeLines(conteudo_final, "minha_lista.m3u8")

message("Arquivo 'minha_lista.m3u8' salvo com sucesso, sem linhas em branco.")
################################################################################
################################################################################
# Bloco 2, carrega o arquivo "minha_lista.m3u8", aplica Regex e cria novo grupo
# chamado "Music" e salva no arquivo "canais_encontrados_modificados.m3u8"
# Ler o arquivo com os dados dos canais
caminho_do_arquivo <- "minha_lista.m3u8"
linhas <- readLines(caminho_do_arquivo)

# Especificar os nomes dos canais buscados
canais_buscados <- c("VH1",
                     "Best of MTV", 
                     "MTV Approved Hip Hop", 
                     "MTV Biggest Pop", 
                     "MTV Classic", 
                     "MTV en español", 
                     "MTV Flow Latino", 
                     "MTV Frauen Power", 
                     "MTV German Music", 
                     "MTV Just Tattoo of Us", 
                     "MTV Love", 
                     "MTV Movie Hits", 
                     "MTV Music", 
                     "MTV Original Version", 
                     "MTV Party", 
                     "MTV Pluto TV", 
                     "MTV Rocks", 
                     "MTV RockZone", 
                     "MTV Summer Hits", 
                     "MTV Tattoo a dos", 
                     "MTV Unplugged", 
                     "MTV Urban Music", 
                     "MTV Vergüenza ajena", 
                     "MTV: Best of", 
                     "Yo! MTV Raps Classic", 
                     "BMTV ", 
                     "IFM TV", 
                     "KMTV", 
                     "Littoral FM", 
                     "MTV Beats", 
                     "MTV Hits France", 
                     "Pluto TV MTV", 
                     "Stingray",
                     "Live Music Replay",
                     "CMT",
                     "Vevo",
                     "XITE",
                     "Classica",
                     "Qello",
                     "CMusic",
                     "Djazz",
                     "Naturescape",
                     "Now 80's",
                     "Now Rock",
                     "Now 80s",
                     "Deluxe Lounge HD",
                     "Pluto TV Fireplace",
                     "Classic Rock",
                     "Rock Story",
                     "Classic Rock",
                     "Rock TV",
                     "WMX",
                     "Trace",
                     "Vivaldi TV",
                     "Qwest",
                     "Xite",
                     "OFIVE",
                     "AMusic Channel",
                     "Music Legends Network",
                     "OurVinyl TV",
                     "DittyTV",
                     "Broadway On Demand",
                     "Loupe Art",
                     "AXS TV Now",
                     "Our Vinyl")

# Inicializar uma lista para armazenar os resultados da busca
resultados_busca <- list()

# Definir o novo valor para "group-title"
novo_group_title <- "Music"

# Inicializar os elementos da lista para cada canal buscado
for (canal in canais_buscados) {
  resultados_busca[[canal]] <- c()
}

# Buscar os canais e modificar a tag "group-title"
canais_encontrados <- c()
capturar_proxima_linha <- FALSE

for (linha in linhas) {
  if (capturar_proxima_linha) {
    # Adiciona a URL do canal encontrado na lista
    canais_encontrados <- c(canais_encontrados, linha)
    capturar_proxima_linha <- FALSE # Reseta o indicador para captura da próxima linha
    next
  }
  
  for (canal in canais_buscados) {
    if (str_detect(linha, fixed(canal))) {
      # Substituir o valor da tag "group-title" pelo valor especificado
      linha_modificada <- str_replace(linha, pattern = "group-title=\"[^\"]*\"", replacement = sprintf("group-title=\"%s\"", novo_group_title))
      
      # Extrair o nome do canal e armazenar na lista de resultados
      nome_canal <- str_extract(linha, "(?<=,).*$")
      resultados_busca[[canal]] <- c(resultados_busca[[canal]], nome_canal)
      
      # Salvar a linha modificada em um vetor temporário para posterior salvamento
      canais_encontrados <- c(canais_encontrados, linha_modificada)
      capturar_proxima_linha <- TRUE # Seta o indicador para capturar a próxima linha (URL)
      
      break # Interrompe o loop interno uma vez que o canal foi encontrado e modificado
    }
  }
}

# Verificar se algum canal foi encontrado e salvar os canais modificados em um novo arquivo
if (length(canais_encontrados) > 0) {
  writeLines(canais_encontrados, "canais_encontrados_appsattvmodificados.m3u8")
  cat("Canais encontrados com a tag 'group-title' modificada para '", novo_group_title, "' e suas URLs foram salvos em 'canais_encontrados_modificados.m3u8'.\n", sep="")
}

# Imprime os resultados
for (canal in names(resultados_busca)) {
  if (length(resultados_busca[[canal]]) > 0) {
    cat("Canal:", canal, "\n")
    cat("Quantidade encontrada:", length(resultados_busca[[canal]]), "\n")
    cat("Nomes dos canais:\n", paste(resultados_busca[[canal]], collapse = "\n"), "\n\n")
  } else {
    cat("Nenhum canal encontrado para:", canal, "\n\n")
  }
}
file.remove("minha_lista.m3u8")
