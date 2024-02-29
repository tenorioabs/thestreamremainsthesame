library(xml2)
library(httr)

# URLs dos arquivos XML
urls <- c("https://i.mjh.nz/Plex/all.xml",
          "https://i.mjh.nz/PlutoTV/all.xml",
          "https://i.mjh.nz/SamsungTVPlus/all.xml")

# Download e remoção do cabeçalho para cada URL
xml_texts <- lapply(urls, function(url) {
  xml_content <- readLines(url)
  xml_content <- xml_content[-1]  # Remove a primeira linha do cabeçalho
  paste(xml_content, collapse = "\n")  # Concatena as linhas em um único texto
})

# Organizar as tags no arquivo concatenado
channel_tags <- character(0)
programme_tags <- character(0)

for (xml_text in xml_texts) {
  # Extrair as tags de channel e programme
  channel_start <- grep("<channel", xml_text)
  channel_end <- grep("</channel>", xml_text)
  programme_start <- grep("<programme", xml_text)
  programme_end <- grep("</programme>", xml_text)
  
  # Concatenar as tags de channel e programme
  channel_tags <- c(channel_tags, xml_text[channel_start:channel_end])
  programme_tags <- c(programme_tags, xml_text[programme_start:programme_end])
}

# Criação do arquivo XML final
final_xml <- c("<?xml version=\"1.0\" encoding=\"UTF-8\"?><!DOCTYPE tv SYSTEM \"xmltv.dtd\"><tv generator-info-name=\"www.matthuisman.nz\" generated-ts=\"1709226371\">",
               paste(channel_tags, collapse = "\n"),
               paste(programme_tags, collapse = "\n"),
               "</tv>")

# Salvar o arquivo XML final
writeLines(final_xml, "minha_lista_concatenada.xml")