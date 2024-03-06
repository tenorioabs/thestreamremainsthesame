################################################################################
################################################################################
source("09_instala_carrega_pacotes.R")
################################################################################
################################################################################
# Bloco 1, recebe a lista de URLs e concatena em um arquivo chamado "minha_lista.m3u8"
# Lista de URLs
url_m3u8 <- c("https://i.mjh.nz/Plex/all.m3u8",
              "https://i.mjh.nz/PlutoTV/all.m3u8",
              "https://i.mjh.nz/SamsungTVPlus/all.m3u8",
              "https://i.mjh.nz/Stirr/all.m3u8",
              "https://i.mjh.nz/Roku/all.m3u8",
              "https://www.apsattv.com/localnow.m3u")

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
                     "AXS TV Now")

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
  writeLines(canais_encontrados, "canais_encontrados_modificados.m3u8")
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

################################################################################
################################################################################
# Bloco 3, Insere novos canais manualmente e concatena listas
# Definir os caminhos dos arquivos
caminho_lista_original <- "minha_lista.m3u8"
caminho_lista_modificada <- "canais_encontrados_modificados.m3u8"
caminho_lista_concatenada <- "minha_lista_concatenada.m3u8"

# Ler os conteúdos dos arquivos
conteudo_lista_original <- readLines(caminho_lista_original)
conteudo_lista_modificada <- readLines(caminho_lista_modificada)

# Concatenar os conteúdos
conteudo_concatenado <- c(conteudo_lista_original, conteudo_lista_modificada)

# Adicionar os dois novos canais ao conteúdo concatenado
novos_canais <- c("#EXTINF:-1 tvg-id=\"MTV.jp\" tvg-logo=\"https://upload.wikimedia.org/wikipedia/commons/thumb/0/0d/MTV-2021.svg/512px-MTV-2021.svg.png\" group-title=\"Music\",MTV Japan\nhttp://jp.vthanhnetwork.com/MTV/index.m3u8",
                  "#EXTINF:-1 tvg-id=\"MusicJapanTV.jp\" tvg-logo=\"https://pbs.twimg.com/profile_images/875521212432003073/jTDObCPJ_200x200.jpg\" group-title=\"Music\",Music Japan TV\nhttp://cdns.jp-primehome.com:8000/zhongying/live/playlist.m3u8?cid=cs06")

conteudo_concatenado <- c(conteudo_concatenado, novos_canais)

# Escrever o conteúdo concatenado em um novo arquivo
writeLines(conteudo_concatenado, caminho_lista_concatenada)

cat("Os arquivos foram concatenados com sucesso e os novos canais foram adicionados. O resultado foi salvo em", caminho_lista_concatenada, "\n")
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
# Bloco 5, substitui nomes de grupos e atualiza o arquivo "minha_lista_concatenada.m3u8"
# Define o caminho do arquivo de entrada e de saída
arquivo_entrada <- "minha_lista_concatenada.m3u8"
arquivo_saida <- "minha_lista_concatenada.m3u8"

# Lê o conteúdo do arquivo de entrada
conteudo <- readLines(arquivo_entrada, warn = FALSE)

# Lista de títulos de grupos que devem ser mantidos
titulos_mantidos <- c("Australia",
                      "Brazil",
                      "Canada",
                      "Great Britain",
                      "Music",
                      "United States")

# Função para verificar e substituir os títulos dos grupos
substituir_titulos <- function(linha) {
  # Verifica se a linha é um canal
  if (grepl("^#EXTINF:", linha)) {
    # Transforma "USA" em "United States" antes de qualquer coisa
    if (grepl('group-title="USA"', linha)) {
      linha <- sub('group-title="USA"', 'group-title="United States"', linha)
    }
    
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

# Aplica a função de substituição ao conteúdo
conteudo_modificado <- sapply(conteudo, substituir_titulos, USE.NAMES = FALSE)

# Salva o conteúdo modificado no arquivo de saída
writeLines(conteudo_modificado, arquivo_saida)

# Mensagem de conclusão
cat("O arquivo", arquivo_saida, "foi atualizado com sucesso.")
################################################################################
################################################################################
# Bloco 6, atualiza GitHub
source("02_cria_xml.R")
file.remove("canais_encontrados_modificados.m3u8")
file.remove("minha_lista.m3u8")
file.remove("minha_lista_concatenada.xml")
#source("03_funcoes_github.R")
#github_windows(paste0("corrige_script_02_", str_replace_all(format(x = Sys.time(), "%Y-%m-%d"), "-", "_")))
#github_linux("Reformulação Geral")
source("00_tabula_group_title.R")
file.remove("tabulacao_conteudo_final.xlsx")
################################################################################
################################################################################
