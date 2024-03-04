library(xml2)
library(httr)

# URLs dos arquivos XML
cria_xml <- function(urls){
  
  # Função para transformar as URLs
  transformar_urls <- function(urls) {
    # Usar sapply para aplicar a função de substituição em cada URL
    urls_transformadas <- sapply(urls, function(url) {
      # Verificar se a URL termina com .m3u8 ou .m3u
      if(grepl(".m3u8$", url) | grepl(".m3u$", url)) {
        # Substituir .m3u8 ou .m3u por .xml
        sub(".m3u8$", ".xml", sub(".m3u$", ".xml", url))
      } else {
        # Se a URL não terminar com .m3u8 ou .m3u, deixá-la inalterada
        url
      }
    })
    
    return(urls_transformadas)
  }
  
  # Aplicando a função às URLs originais
  urls <- transformar_urls(urls)
  
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
}

# Função para compactar um arquivo para .gz
compactar_para_gz <- function(nome_arquivo) {
  # Define o nome do arquivo de saída adicionando a extensão .gz
  nome_arquivo_saida <- paste0(nome_arquivo, ".gz")
  
  # Abre uma conexão para leitura do arquivo original
  con_origem <- file(nome_arquivo, "rb")
  
  # Abre uma conexão para escrita no arquivo .gz
  con_destino <- gzfile(nome_arquivo_saida, "wb")
  
  # Lê o conteúdo do arquivo original
  conteudo <- readBin(con_origem, "raw", file.info(nome_arquivo)$size)
  
  # Escreve o conteúdo no arquivo .gz
  writeBin(conteudo, con_destino)
  
  # Fecha as conexões
  close(con_origem)
  close(con_destino)
  
  # Retorna o nome do arquivo .gz criado
  return(nome_arquivo_saida)
}