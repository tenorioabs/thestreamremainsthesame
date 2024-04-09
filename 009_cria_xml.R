
if (valor_numerico==1) {
  # URLs dos arquivos XML
  urls <- read_excel("urls_geral.xlsx", sheet = "xml_reduced")
  urls <- urls$xml_reduced
  urls <- unique(urls)
} else if (valor_numerico==2) {
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
cabecalho <- '<?xml version="1.0" encoding="UTF-8"?>'
rodape <- "</tv>"


# Adiciona o cabeçalho e o rodapé ao conteúdo concatenado de forma que não haja linha em branco entre eles
conteudo_final <- paste(cabecalho, conteudo_concatenado, rodape, sep="\n")

# Remove possíveis linhas em branco adicionais entre o cabeçalho e o corpo
conteudo_final <- gsub("\n\n", "\n", conteudo_final)

if (valor_numerico==1) {
  try(file.remove("reduced.xml.gz"), silent = T)
  writeLines(conteudo_final, "reduced.xml")
  gzip("reduced.xml", destname = "reduced.xml.gz", remove = FALSE)
  file.remove("reduced.xml")
} else if (valor_numerico==2) {
  try(file.remove("full.xml.gz"), silent = T)
  writeLines(conteudo_final, "full.xml")
  gzip("full.xml", destname = "full.xml.gz", remove = FALSE)
  file.remove("full.xml")
}

