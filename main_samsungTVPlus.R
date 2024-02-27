# Carregar a biblioteca necessária
if (!require("httr")) install.packages("httr")
library(httr)

# Lista de URLs e seus respectivos nomes a serem usados como "group-title"
url_m3u8 <- list("https://www.apsattv.com/ssungnz.m3u" = "New Zealand",
                 "https://www.apsattv.com/ssungaus.m3u" = "Australia",
                 "https://www.apsattv.com/ssungita.m3u" = "Italy",
                 "https://www.apsattv.com/ssungspa.m3u" = "Spain",
                 "https://www.apsattv.com/ssungcan.m3u" = "Canada",
                 "https://www.apsattv.com/ssungbra.m3u" = "Brazil",
                 "https://www.apsattv.com/ssungmex.m3u" = "Mexico",
                 "https://www.apsattv.com/ssungind.m3u" = "India",
                 "https://www.apsattv.com/ssungnor.m3u" = "Norway",
                 "https://www.apsattv.com/ssungfin.m3u" = "Finland",
                 "https://www.apsattv.com/ssungden.m3u" = "Denmark",
                 "https://www.apsattv.com/ssungswe.m3u" = "Sweden",
                 "https://www.apsattv.com/ssungpor.m3u" = "Portugal",
                 "https://www.apsattv.com/ssunglux.m3u" = "Luxembourg",
                 "https://www.apsattv.com/ssungbelg.m3u" = "Belgium",
                 "https://www.apsattv.com/ssungire.m3u" = "Ireland",
                 "https://www.apsattv.com/ssungneth.m3u" = "Netherland")

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


url_nova <- "https://i.mjh.nz/SamsungTVPlus/all.m3u8"

# Fazendo a requisição GET para a URL e extraindo o conteúdo como texto
conteudo_novo <- content(GET(url_nova), "text", encoding = "UTF-8")

# Concatenamos o novo conteúdo ao final do objeto 'final'
final <- paste(final, conteudo_novo, sep = "\n")

# Opcional: Salva o conteúdo final em um arquivo
writeLines(final, "conteudo_final_samsungTVPlus.m3u8")
