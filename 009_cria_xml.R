
if (valor_numerico==1) {
  # URLs dos arquivos XML
  urls <- read_excel("urls_geral.xlsx", sheet = "xml_reduced")
  urls <- urls$xml_full
  urls <- unique(urls)
} else {
  # URLs dos arquivos XML
  urls <- read_excel("urls_geral.xlsx", sheet = "xml_full")
  urls <- urls$xml_full
  urls <- unique(urls)
}

# Inicializa um objeto para armazenar o conteúdo concatenado
conteudo_concatenado <- ""

# Loop para processar cada URL
for (url in urls) {
  print(url)
  # Faz o download do conteúdo da URL
  conteudo <- readLines(url, warn = FALSE)
  
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
if (valor_numerico==1) {
  cabecalho <- '<?xml version="1.0" encoding="UTF-8"?><!DOCTYPE tv SYSTEM "xmltv.dtd"><tv generator-info-name="https://github.com/tenorioabs/thestreamremainsthesame/raw/main/reduced.xml">'
  rodape <- "</tv>"
} else {
    cabecalho <- '<?xml version="1.0" encoding="UTF-8"?><!DOCTYPE tv SYSTEM "xmltv.dtd"><tv generator-info-name="https://github.com/tenorioabs/thestreamremainsthesame/raw/main/full.xml.gz">'
    rodape <- "</tv>"
}

# Adiciona o cabeçalho e o rodapé ao conteúdo concatenado de forma que não haja linha em branco entre eles
conteudo_final <- paste(cabecalho, conteudo_concatenado, rodape, sep="\n")

# Remove possíveis linhas em branco adicionais entre o cabeçalho e o corpo
conteudo_final <- gsub("\n\n", "\n", conteudo_final)

if (valor_numerico==1) {
  # Salva o conteúdo final no arquivo XML
  writeLines(conteudo_final, "reduced.xml")
} else {
  writeLines(conteudo_final, gzip("full.xml", destname = arquivo_gz, remove = FALSE))
}

