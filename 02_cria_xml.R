# Carregar os pacotes necessários
if (!require("xml2")) install.packages("xml2")
if (!require("httr")) install.packages("httr")

library(xml2)
library(httr)

# URLs fornecidas
urls <- c("https://i.mjh.nz/Plex/all.xml",
          "https://i.mjh.nz/PlutoTV/all.xml",
          "https://i.mjh.nz/SamsungTVPlus/all.xml")

# Função para processar cada URL
processar_xml <- function(url) {
  print(paste("Iniciando o download e processamento de:", url))
  
  # Fazendo o download do conteúdo
  conteudo <- GET(url)
  texto <- content(conteudo, "text", encoding = "UTF-8")
  
  # Lendo o conteúdo como um documento XML
  doc <- read_xml(texto, options = "NOBLANKS")
  
  # Removendo o cabeçalho e focando nas tags <channel> e <programme>
  channels <- xml_find_all(doc, ".//channel")
  programmes <- xml_find_all(doc, ".//programme")
  
  print(paste("Processamento concluído para:", url))
  
  list(channels = channels, programmes = programmes)
}

# Criando um novo documento XML para o conteúdo concatenado
doc_final <- read_xml('<?xml version="1.0" encoding="UTF-8"?><!DOCTYPE tv SYSTEM "xmltv.dtd"><tv generator-info-name="www.matthuisman.nz" generated-ts="1709226371"></tv>')

# Processando URLs com barra de progresso
pb <- txtProgressBar(min = 0, max = length(urls), style = 3)
resultados <- list()
for (i in seq_along(urls)) {
  resultados[[i]] <- processar_xml(urls[i])
  setTxtProgressBar(pb, i)
}
close(pb)

# Adicionando os elementos <channel> e <programme> ao novo documento com barra de progresso
print("Iniciando a adição de elementos ao documento XML final.")
pb <- txtProgressBar(min = 0, max = length(resultados) * 2, style = 3) # Estimativa de progresso
progress <- 0
for (res in resultados) {
  for (channel in res$channels) {
    node <- read_xml(as.character(channel))
    xml_add_child(doc_final, node)
    progress <- progress + 1
    setTxtProgressBar(pb, progress)
  }
}

for (res in resultados) {
  for (programme in res$programmes) {
    node <- read_xml(as.character(programme))
    xml_add_child(doc_final, node)
    progress <- progress + 1
    setTxtProgressBar(pb, progress)
  }
}
close(pb)
print("Todos os elementos foram adicionados ao documento XML final.")

# Salvando o documento final
write_xml(doc_final, "minha_lista_concatenada.xml")
print("Documento XML final salvo como 'minha_lista_concatenada.xml'.")