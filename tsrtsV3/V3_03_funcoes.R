github_linux <- function(mensagem){
  system("git add .")
  system(paste0("git commit -m ", mensagem))
  system("git push origin main")
}

github_windows <- function(mensagem){
  system("git add .", intern = FALSE)
  system(paste0("git commit -m \"", mensagem, "\""), intern = FALSE)
  system("git push origin main", intern = FALSE) 
}

# Definir a função para ler uma coluna específica de um arquivo Excel e converter para vetor
carrega_urls_geral <- function(caminho_arquivo, nome_coluna) {
  # Carregar o pacote readxl
  if (!requireNamespace("readxl", quietly = TRUE)) {
    install.packages("readxl")
    library(readxl)
  }
  
  # Tentar ler os dados do arquivo Excel
  tryCatch({
    dados <- read_excel(caminho_arquivo)
    
    # Verificar se a coluna especificada existe no dataframe
    if(nome_coluna %in% colnames(dados)) {
      # Extrair os dados da coluna especificada e salvar em um vetor
      vetor_resultante <- as.vector(dados[[nome_coluna]])
      
      # Retornar o vetor
      return(vetor_resultante)
    } else {
      # Se a coluna não for encontrada, retornar NULL com uma mensagem de erro
      cat("Erro: A coluna '", nome_coluna, "' não foi encontrada no arquivo.\n", sep = "")
      return(NULL)
    }
  }, error = function(e) {
    # Capturar e retornar erros durante a leitura do arquivo
    cat("Erro ao ler o arquivo: ", e$message, "\n")
    return(NULL)
  })
}

# Exemplo de uso da função
caminho_arquivo <- "C:/Users/tenor/OneDrive/GitHub/outros_scripts/urls_geral.xlsx"
nome_coluna <- "urls_geral"

# Chamar a função e salvar o resultado
url_m3u8 <- carrega_urls_geral(caminho_arquivo, nome_coluna)

# Verificar o resultado
if (!is.null(url_m3u8)) {
  print(url_m3u8)
} else {
  cat("Falha ao carregar os dados.\n")
}

processa_url <- function(url, indice, total) {
  cat(sprintf("Processando URL %d de %d: %s\n", indice, total, url))
  
  response <- tryCatch({
    GET(url)
  }, error = function(e) {
    message("Erro ao processar URL: ", url, "; Erro: ", e$message)
    return(NULL)
  })
  
  if (is.null(response)) return(NULL)
  
  conteudo <- content(response, "text", encoding = "UTF-8")
  return(conteudo)
}