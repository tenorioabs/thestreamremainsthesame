library(xml2)
library(magrittr) # Para usar o operador %>%

# URLs dos arquivos XML
urls <- c("https://i.mjh.nz/Plex/all.xml",
          "https://i.mjh.nz/PlutoTV/all.xml",
          "https://i.mjh.nz/SamsungTVPlus/all.xml",
          "https://i.mjh.nz/Stirr/all.xml",
          "https://i.mjh.nz/Roku/epg.xml")

# Função para remover o cabeçalho dos arquivos XML
remove_header <- function(xml_text) {
  xml <- read_xml(xml_text)
  main_content <- xml_find_all(xml, "/*[not(self::xml)]")
  new_xml <- xml_new_document()
  for (node in main_content) {
    xml_add_child(new_xml, node)
  }
  as.character(new_xml)
}

# Função para organizar as tags no arquivo XML
organize_tags <- function(xml_text) {
  xml <- read_xml(xml_text)
  channels <- xml_find_all(xml, ".//channel")
  programmes <- xml_find_all(xml, ".//programme")
  new_xml <- xml_new_document()
  
  for (channel in channels) {
    xml_add_child(new_xml, channel)
  }
  
  for (programme in programmes) {
    xml_add_child(new_xml, programme)
  }
  
  as.character(new_xml)
}

# Função para concatenar os arquivos XML
concatenate_xml <- function(xml_texts) {
  concatenated_xml <- paste(xml_texts, collapse = "")
  concatenated_xml
}

# Função para adicionar o cabeçalho e fechar a tag </tv>
add_header_and_close_tag <- function(xml_text) {
  header <- '<?xml version="1.0" encoding="UTF-8"?><!DOCTYPE tv SYSTEM "xmltv.dtd"><tv generator-info-name="https://raw.githubusercontent.com/tenorioabs/thestreamremainsthesame/main/minha_lista_concatenada.xml.gz" generated-ts="1709226371">'
  xml_text <- paste(header, xml_text, "</tv>", sep = "")
  xml_text
}

# Função para realizar todas as etapas
process_xml_files <- function(urls) {
  xml_texts <- lapply(urls, function(url) {
    xml_text <- readLines(url, warn = FALSE) %>%
      paste(collapse = "\n") %>%
      remove_header %>%
      organize_tags
    xml_text
  })
  
  concatenated_xml <- concatenate_xml(xml_texts)
  final_xml <- add_header_and_close_tag(concatenated_xml)
  
  final_xml
}

# Executando o script para processar os arquivos XML
final_xml <- process_xml_files(urls)

# Compactar e salvar o objeto final como 'minha_lista_concatenada.xml.gz'
writeLines(final_xml, gzfile("minha_lista_concatenada.xml.gz"))

# Mensagem para confirmar a conclusão da tarefa
cat("O arquivo 'minha_lista_concatenada.xml.gz' foi criado com sucesso.\n")