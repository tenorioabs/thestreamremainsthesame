# Carregar a biblioteca necessária
if (!require("httr")) install.packages("httr")
library(httr)

# Lista de URLs e seus respectivos nomes a serem usados como "group-title"
url_m3u8 <- list("https://i.mjh.nz/PlutoTV/br.m3u8"="Brasil - Pluto",
                 "https://i.mjh.nz/PBS/all.m3u8"="PBS",
                 "https://i.mjh.nz/Plex/all.m3u8"="Plex",
                 "https://i.mjh.nz/PlutoTV/all.m3u8"="PlutoTV",
                 #"https://i.mjh.nz/Roku/all.m3u8"="Roku",
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

# Carregar o pacote necessário
library(xml2)

# URLs dos arquivos XML
url_xml <- c("https://i.mjh.nz/PlutoTV/br.xml",
             "https://i.mjh.nz/PBS/all.xml",
             "https://i.mjh.nz/Plex/all.xml",
             "https://i.mjh.nz/PlutoTV/all.xml",
             #"https://i.mjh.nz/Roku/all.xml",
             "https://i.mjh.nz/SamsungTVPlus/all.xml",
             "https://i.mjh.nz/Stirr/all.xml")

# Inicializar uma lista para armazenar o conteúdo de cada arquivo XML
xml_contents <- list()

# Loop para ler cada URL XML
for (url in url_xml) {
  # Ler o conteúdo do XML da URL
  xml_data <- read_xml(url)
  
  # Adicionar o conteúdo do XML à lista
  xml_contents <- c(xml_contents, list(xml_data))
}

# Criar um novo documento XML para armazenar a combinação
combined_xml <- xml_new_root("CombinedXML")

# Loop para adicionar cada XML lido ao documento combinado
for (xml_content in xml_contents) {
  # Extrair os nós filhos do XML
  child_nodes <- xml_children(xml_content)
  
  # Adicionar cada nó filho ao documento combinado
  for (node in child_nodes) {
    xml_add_child(combined_xml, node)
  }
  print(xml_content)
}

# Salvar o XML combinado em um arquivo
write_xml(combined_xml, "combined_xml.xml")

# Mensagem de conclusão
cat("Os arquivos XML foram combinados com sucesso em 'combined_xml.xml'.\n")
