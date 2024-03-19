# Carregar pacotes necessários
library(httr)
library(xml2)
library(R.utils)

# URLs dos arquivos XML
urls <- c("https://i.mjh.nz/Plex/all.xml",
          "https://i.mjh.nz/PlutoTV/all.xml",
          "https://i.mjh.nz/SamsungTVPlus/all.xml",
          "https://i.mjh.nz/Stirr/all.xml",
          "https://i.mjh.nz/Roku/epg.xml",
          "https://i.mjh.nz/PBS/all.xml")

# Inicializa um objeto para armazenar o conteúdo concatenado
conteudo_concatenado <- ""

# Loop para processar cada URL
for (url in urls) {
  print(url)
  # Faz o download do conteúdo da URL
  conteudo <- readLines(url, warn = FALSE, timeout=240)
  
  # Remove a primeira e a última linha
  conteudo <- conteudo[-1]
  conteudo <- conteudo[-length(conteudo)]
  
  # Remove linhas em branco do conteúdo
  conteudo <- conteudo[conteudo != ""]
  
  # Concatena o conteúdo, excluindo a primeira e a última linha e as linhas em branco
  if (conteudo_concatenado != "") {
    conteudo_concatenado <- paste(conteudo_concatenado, paste(conteudo, collapse="\n"), sep="\n")
  } else {
    conteudo_concatenado <- paste(conteudo, collapse="\n")
  }
}

# Preparar cabeçalho e rodapé
cabecalho <- '<?xml version="1.0" encoding="UTF-8"?><!DOCTYPE tv SYSTEM "xmltv.dtd"><tv generator-info-name="https://raw.githubusercontent.com/tenorioabs/thestreamremainsthesame/main/minha_lista_concatenada.xml.gz">'
rodape <- "</tv>"

# Adiciona o cabeçalho e o rodapé ao conteúdo concatenado de forma que não haja linha em branco entre eles
conteudo_final <- paste(cabecalho, conteudo_concatenado, rodape, sep="\n")

# Remove possíveis linhas em branco adicionais entre o cabeçalho e o corpo
conteudo_final <- gsub("\n\n", "\n", conteudo_final)

# Salva o conteúdo final no arquivo XML
writeLines(conteudo_final, "minha_lista_concatenada.xml")

# Verifica se o arquivo compactado já existe e o remove, se necessário
arquivo_gz <- "minha_lista_concatenada.xml.gz"
if (file.exists(arquivo_gz)) {
  file.remove(arquivo_gz)
}

# Compacta o arquivo XML para o formato GZ
gzip("minha_lista_concatenada.xml", destname = arquivo_gz, remove = FALSE)
