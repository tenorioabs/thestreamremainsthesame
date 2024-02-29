library(XML)
library(httr)

# Inicializa um objeto XML vazio
doc_final <- newXMLDoc()
root_node <- newXMLNode("tv", attrs = c("generator-info-name" = "https://github.com/tenorioabs"), doc = doc_final)

# Lista de URLs para baixardata:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABIAAAASCAYAAABWzo5XAAAAWElEQVR42mNgGPTAxsZmJsVqQApgmGw1yApwKcQiT7phRBuCzzCSDSHGMKINIeDNmWQlA2IigKJwIssQkHdINgxfmBBtGDEBS3KCxBc7pMQgMYE5c/AXPwAwSX4lV3pTWwAAAABJRU5ErkJggg==
urls <- c("https://i.mjh.nz/Plex/all.xml",
          "https://i.mjh.nz/PlutoTV/all.xml",
          "https://i.mjh.nz/SamsungTVPlus/all.xml")

# Loop para processar cada URL
for (url in urls) {
  cat("Tratando URL:", url, "\n")
  
  # Baixa o conteúdo XML da URL
  response <- GET(url)
  content <- content(response, "text", encoding = "UTF-8")
  
  # Converte o conteúdo para um objeto XML
  doc <- xmlParse(content)
  
  # Extrai os nós de interesse
  nodes <- getNodeSet(doc, "//tv/channel")
  
  # Adiciona os nós extraídos ao documento final
  for (node in nodes) {
    newNode <- newXMLNode("channel", attrs = xmlAttrs(node), parent = root_node)
    for(child in xmlChildren(node)){
      addChildren(newNode, newXMLNode(xmlName(child), xmlAttrs(child), xmlValue(child)))
    }
  }
}

# Salva o documento XML concatenado em um arquivo, incluindo a declaração e DOCTYPE manualmente
xmlString <- saveXML(doc_final, prefix = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<!DOCTYPE tv SYSTEM \"xmltv.dtd\">\n")
writeLines(xmlString, con = "minha_lista_concatenada.xml")

cat("XML concatenado salvo com sucesso em 'minha_lista_concatenada.xml'.\n")