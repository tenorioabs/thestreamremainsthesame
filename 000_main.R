source("099_instala_carrega_pacotes.R")
source("098_funcoes.R")
options(warn = -1)
# Solicitar ao usuário que insira um valor
# opcoes <- as.numeric(readline("Escolha 1 = Reduced ou 2 = Full:"))

opcoes <- c(1, 2)

for (i in 1:length(opcoes)) {
  valor_numerico <- i
  source("001_download_concatenacao_urls.R")
  tabula_group_title(nome_coluna)
  source("002_cria_music_salva_arquivo.R")
  source("003_insere_canais_manualmente_concatena_resultados_buscados.R")
  source("004_cria_index_epg_no_m3u8.R")
  source("005_cria_grupos.R")
  #source("006_double_check_canais.R")
  source("007_atribui_logo_remove_repetidos.R")
  source("010_remove_grupo_omitir.R")
  
  tabula_group_title(nome_coluna)

  # if (valor_numerico == 2) {
  #   source("008_testa_links_m3u8_group.R")
  #   tabula_group_title(nome_coluna)
  # }
  
  if (valor_numerico==1) {
    retry(source("009_cria_xml.R"), max = Inf)
    #try(source("010_remove_grupo_omitir.R"), silent = T)
  }
  
  try(file.remove("canais_encontrados_modificados.m3u8"), silent = T)
}

source("C:/Users/tenor/OneDrive/ciencia_de_dados/R/iptv/thestreamremainsthesame/011_seta_credencias_s3.R")

info_so <- Sys.info()

dia_hora <- Sys.time()
dia_hora <- str_replace_all(string = dia_hora, pattern = "-", replacement = "")
dia_hora <- str_replace_all(string = dia_hora, pattern = ":", replacement = "")
dia_hora <- str_replace_all(string = dia_hora, pattern = " ", replacement = "")

# sobe arquivos no github
if (info_so['sysname'] == 'Windows') {
  github_windows(paste0("atualizacao_", dia_hora))
} else if (info_so['sysname'] == 'Linux') {
  github_linux(paste0("atualizacao_", dia_hora))
}

