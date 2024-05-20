github_linux <- function(mensagem){
  add_res <- system("git add .", intern = TRUE)
  cat("git add result:", add_res, "\n") # Exibe o resultado do git add
  commit_res <- system(paste0("git commit -m \"", mensagem, "\""), intern = TRUE)
  cat("git commit result:", commit_res, "\n") # Exibe o resultado do git commit
  push_res <- system("git push origin main", intern = TRUE)
  cat("git push result:", push_res, "\n") # Exibe o resultado do git push
}

github_windows <- function(mensagem){
  system("git add .", intern = FALSE)
  system(paste0("git commit -m \"", mensagem, "\""), intern = FALSE)
  system("git push origin main", intern = FALSE) 
}

# função processa_url para incluir a verificação de sucesso
processa_url <- function(url) {
  print(url)
  response <- tryCatch({
    GET(url)
  }, error = function(e) {
    message("Erro ao processar URL: ", url, "; Erro: ", e)
    return(NULL)
  })
  
  if (is.null(response)) return(NULL)
  
  conteudo <- content(response, "text", encoding = "UTF-8")
  return(list(url = url, conteudo = conteudo))
}

processa_url <- function(url, indice, total) {
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

# Função para modificar o arquivo .m3u8
remover_24H_tvg_name <- function() {
  # Ler o conteúdo do arquivo
  linhas <- readLines('minha_lista_concatenada_ativa.m3u8')
  
  # Processar cada linha
  linhas_processadas <- sapply(linhas, function(linha) {
    # Verificar se a linha contém "tvg-name="
    if (grepl("tvg-name=", linha)) {
      # Substituir o padrão "[24H]" e "24H-" por vazio
      gsub("[24H]|-", "", linha, perl = TRUE)
    } else {
      # Retornar a linha original
      linha
    }
  })
  
  # Escrever o conteúdo processado de volta para o arquivo
  writeLines(linhas_processadas, 'minha_lista_concatenada_ativa.m3u8')
}

processa_url <- function(url) {
  print(url)
  response <- tryCatch({
    GET(url)
  }, error = function(e) {
    message("Erro ao processar URL: ", url, "; Erro: ", e)
    return(NULL)
  })
  
  if (is.null(response)) return(NULL)
  
  conteudo <- content(response, "text", encoding = "UTF-8")
  return(list(url = url, conteudo = conteudo))
}

retry <- function(a, max = Inf, init = 0){suppressWarnings( tryCatch({
  if(init<max) a
}, error = function(e){retry(a, max, init = init+1)}))}

tabula_group_title <- function(arquivo_a_ser_tabulado){
  # Define o caminho para o arquivo M3U8 unificado
  arquivo <- arquivo_a_ser_tabulado
  # Lê o conteúdo do arquivo
  conteudo <- readLines(arquivo, warn = FALSE)
  
  # Filtra as linhas que contêm a tag "group-title"
  linhas_com_group_title <- grep("group-title", conteudo, value = TRUE)
  
  # Extrai os valores da tag "group-title"
  valores_group_title <- sapply(linhas_com_group_title, function(linha) {
    matches <- regmatches(linha, regexec('group-title="([^"]+)"', linha))
    if (length(matches[[1]]) > 1) matches[[1]][2] else NA
  })
  
  # Remove possíveis valores NA resultantes de linhas mal formatadas
  valores_group_title <- na.omit(valores_group_title)
  
  # Calcula a frequência de cada valor de "group-title"
  tabulacao <- as.data.frame(table(valores_group_title))
  
  # Exibe a tabulação
  print(tabulacao)
  
  writexl::write_xlsx(tabulacao, "tabulacao_conteudo_final.xlsx")
}

# Função para imprimir mensagens coloridas
imprimirColorido <- function(mensagem, cor = "verde") {
  cores <- c(verde = "\033[32m", vermelho = "\033[31m")
  cor_inicio <- cores[[cor]]
  cor_fim <- "\033[39m"
  cat(paste0(cor_inicio, mensagem, cor_fim, "\n"))
}

# Função para verificar a disponibilidade da URL
verificarURL <- function(url) {
  res <- tryCatch({
    HEAD(url, timeout(10))
  }, error = function(e) {
    return(FALSE)
  })
  return(inherits(res, "response") && status_code(res) %in% 200:299)
}

# Define uma função para processar as URLs com barra de progresso
processarURLs <- function(posicoes) {
  handlers(global = TRUE)
  p <- progressor(along = posicoes)
  
  resultados <- future_lapply(posicoes, function(posicao) {
    p()
    url_atual <- linhas_filtradas[posicao]
    linha_extinf <- linhas_filtradas[posicao - 1]
    if (verificarURL(url_atual)) {
      imprimirColorido(sprintf("URL: Streaming ativo."), "verde")
      return(c(linha_extinf, url_atual))
    } else {
      imprimirColorido(sprintf("URL: Streaming inativo."), "vermelho")
      return(NULL)
    }
  })
  
  return(do.call("c", resultados))
}

# Carregar o conteúdo do arquivo
ler_arquivo <- function(nome_arquivo) {
  readLines(nome_arquivo, warn = FALSE)
}

# Escrever o conteúdo processado em um novo arquivo
escrever_arquivo <- function(nome_arquivo, conteudo) {
  writeLines(conteudo, nome_arquivo)
}

# Processar o conteúdo do arquivo
processar_conteudo <- function(conteudo) {
  # Concatenar todo o conteúdo em uma única string para facilitar a substituição
  conteudo_completo <- paste(conteudo, collapse = "\n")
  
  # Substituir apenas tvg-logo="" (vazio) pela URL do logo do Sepultura
  conteudo_completo <- gsub('tvg-logo=""', 'tvg-logo="https://seeklogo.com/images/S/Sepultura-logo-42D2BAFFB4-seeklogo.com.png"', conteudo_completo)
  
  # Separar novamente em linhas para identificar blocos únicos
  linhas <- unlist(strsplit(conteudo_completo, "\n"))
  
  # Identificar e remover blocos duplicados
  padrao <- "#EXTINF"
  blocos <- split(linhas, cumsum(grepl(padrao, linhas)))
  blocos_unicos <- unique(blocos)
  
  # Juntar os blocos únicos em um único texto
  conteudo_processado <- unlist(lapply(blocos_unicos, function(bloco) paste(bloco, collapse = "\n")))
  
  return(conteudo_processado)
}

# Função para verificar se a pasta existe
folder_exists <- function(bucket, folder_name, region_name) {
  objects <- get_bucket(bucket = bucket, prefix = paste0(folder_name, "/"), region = region_name)
  return(length(objects) > 0)
}

# Função para criar a pasta
create_s3_folder <- function(bucket, folder_name, region_name = "eu-north-1") {
  if (!folder_exists(bucket, folder_name, region_name)) {
    aws.s3::put_object(
      object = paste0(folder_name, "/"), # Nome do objeto termina com "/"
      bucket = bucket,
      body = "",
      region = region_name
    )
    message("Pasta criada: ", folder_name)
  } else {
    message("Pasta já existe: ", folder_name)
  }
}