# Carregar pacotes necessários
if (!requireNamespace("httr", quietly = TRUE)) install.packages("httr")
if (!requireNamespace("XML", quietly = TRUE)) install.packages("XML")

library(httr)
library(XML)

# Inicializa um objeto XML vazio para armazenar o resultado concatenado
doc_final <- newXMLDoc()
root_node <- newXMLNode("tv", doc = doc_final)

# Lista de URLs para baixar
urls <- c("https://i.mjh.nz/Plex/all.xml",
          "https://i.mjh.nz/PlutoTV/all.xml",
          "https://i.mjh.nz/SamsungTVPlus/all.xml")

# Inicializar a barra de progresso
pb <- txtProgressBar(min = 0, max = length(urls), style = 3)

# Loop para processar cada URL
for (i in seq_along(urls)) {
  url <- urls[i]
  cat("Tratando URL:", url, "\n")
  
  # Baixa o conteúdo XML da URL
  response <- GET(url)
  content <- content(response, "text", encoding = "UTF-8")
  
  # Converte o conteúdo para um objeto XML
  doc <- xmlParse(content)
  
  # Extrai os nós de interesse (por exemplo, todos os nós <channel> dentro de <tv>)
  nodes <- getNodeSet(doc, "//tv/channel")  # Ajuste o XPath conforme necessário
  
  # Adiciona os nós extraídos ao documento final
  for (node in nodes) {
    addChildren(root_node, node)
  }
  
  # Atualiza a barra de progresso
  setTxtProgressBar(pb, i)
}

# Finaliza a barra de progresso
close(pb)

# Salva o documento XML concatenado em um arquivo
saveXML(doc_final, file = "minha_lista.xml")

cat("XML concatenado salvo com sucesso em 'minha_lista.xml'.\n")
