# Carregar a biblioteca necessária
if (!require("httr")) install.packages("httr")
library(httr)

# Lista de URLs e seus respectivos nomes a serem usados como "group-title"
url_m3u8 <- list("https://i.mjh.nz/PlutoTV/br.m3u8"="Brasil - Pluto",
                 "https://i.mjh.nz/PBS/all.m3u8"="PBS",
                 "https://i.mjh.nz/Plex/all.m3u8"="Plex",
                 "https://i.mjh.nz/PlutoTV/all.m3u8"="PlutoTV",
                 "https://i.mjh.nz/Roku/all.m3u8"="Roku",
                 "https://i.mjh.nz/SamsungTVPlus/all.m3u8"="SamsungTVPlus",
                 "https://i.mjh.nz/Stirr/all.m3u8"="Stirr")

final <- ""

# Loop para processar cada URL na lista
for (url in names(url_m3u8)) {
  # Faz o download do conteúdo da URL
  response <- GET(url)
  conteudo <- content(response, "text", encoding = "UTF-8")
  
  # Verifica se a tag "group-title" já existe no conteúdo
  if (!grepl('group-title="', conteudo)) {
    # Se "group-title" não existe, insere a tag antes de cada "#EXTINF:"
    nome_grupo <- url_m3u8[[url]]
    conteudo <- gsub("#EXTINF:-1,", sprintf("#EXTINF:-1 group-title=\"%s\",", nome_grupo), conteudo)
  }
  
  # Armazena o conteúdo modificado em uma variável com o nome do grupo
  assign(url_m3u8[[url]], conteudo, envir = .GlobalEnv)
  
  # Adiciona o conteúdo modificado ao conteúdo final
  final <- paste(final, conteudo, sep = "\n")
}

# Opcional: Salva o conteúdo final em um arquivo
writeLines(final, "conteudo_final_mjh.m3u8")

# Carregar pacotes necessários
library(xml2)
library(httr)
library(pbapply)

# Vetor de URLs para ler o conteúdo XML
urls <- c(
  "https://i.mjh.nz/PlutoTV/br.xml",
  "https://i.mjh.nz/PBS/all.xml",
  "https://i.mjh.nz/Plex/all.xml",
  "https://i.mjh.nz/PlutoTV/all.xml",
  "https://i.mjh.nz/Roku/epg.xml",
  "https://i.mjh.nz/SamsungTVPlus/all.xml",
  "https://i.mjh.nz/Stirr/all.xml"
)

# Função para ler e salvar o conteúdo XML de uma URL
read_and_save_xml <- function(url) {
  # Tenta fazer o download do conteúdo
  tryCatch({
    content <- GET(url)
    xml_content <- content(content, "text")
    xml_object <- read_xml(xml_content)
    return(xml_object)
  }, error = function(e) {
    cat("Erro ao processar a URL:", url, "\nErro:", e$message, "\n")
    return(NULL)
  })
}

# Lista para armazenar os objetos XML
xml_objects <- list()

# Inicializa a barra de progresso
progress_bar <- txtProgressBar(min = 0, max = length(urls), style = 3)

# Processa cada URL, atualizando a barra de progresso
for (i in seq_along(urls)) {
  cat("Processando URL:", urls[i], "\n")
  xml_objects[[i]] <- read_and_save_xml(urls[i])
  setTxtProgressBar(progress_bar, i)
}

# Fecha a barra de progresso
close(progress_bar)

# Inicializa uma string vazia para armazenar o resultado final
all_xml_text <- ""

# Itera sobre a lista de objetos XML
for (xml_object in xml_objects) {
  # Converte o objeto XML em string
  xml_text <- as.character(xml_object)
  # Concatena ao objeto final, adicionando uma quebra de linha para separar os conteúdos
  all_xml_text <- paste(all_xml_text, xml_text, sep = "\n")
}

# Define o caminho do arquivo de destino
file_path <- "combined_epg.xml"

# Usa writeLines para escrever o texto combinado no arquivo
writeLines(all_xml_text, file_path)

# Mensagem de confirmação
cat("Arquivo 'combined_epg.xml' salvo com sucesso.")
