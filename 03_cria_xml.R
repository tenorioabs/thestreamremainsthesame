# Carregar a biblioteca httr para fazer requisições HTTP
library(httr)

# Lista de URLs para baixar
urls <- c(
  "https://i.mjh.nz/Plex/ca.xml",
  "https://i.mjh.nz/Plex/us.xml",
  "https://i.mjh.nz/PlutoTV/br.xml",
  "https://i.mjh.nz/PlutoTV/ca.xml",
  "https://i.mjh.nz/PlutoTV/us.xml",
  "https://i.mjh.nz/PlutoTV/gb.xml",
  "https://i.mjh.nz/SamsungTVPlus/ca.xml",
  "https://i.mjh.nz/SamsungTVPlus/gb.xml",
  "https://i.mjh.nz/SamsungTVPlus/us.xml",
  "https://i.mjh.nz/PlutoTV/de.xml",
  "https://i.mjh.nz/PlutoTV/it.xml"
)

# Variável para armazenar o conteúdo concatenado
conteudo_concatenado <- ""

# Função para baixar e concatenar o conteúdo de cada URL
for (url in urls) {
  response <- GET(url)
  if (status_code(response) == 200) {
    # Adiciona o conteúdo do arquivo ao texto concatenado
    conteudo_concatenado <- paste0(conteudo_concatenado, content(response, "text"), "\n")
  } else {
    warning(paste("Não foi possível baixar o conteúdo de:", url))
  }
}

# Caminho do arquivo onde o conteúdo concatenado será salvo
caminho_arquivo <- "minha_lista.xml"

# Salvar o conteúdo concatenado em um arquivo
writeLines(conteudo_concatenado, caminho_arquivo)

# Informar ao usuário que o processo foi concluído
cat("O conteúdo foi baixado e concatenado com sucesso em", caminho_arquivo, "\n")

# # GitHub Linux
# system("git add .")
# system("git commit -m 'Teste de Commit'")
# system("git push origin main")

# GitHub Windows
system("git add .", intern = FALSE)
system("git commit -m \"Cria Script 03\"", intern = FALSE)
system("git push origin main", intern = FALSE)
