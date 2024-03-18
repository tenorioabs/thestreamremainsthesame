source("V5_099_instala_carrega_pacotes.R")
source("V5_098_funcoes.R")
source("V5_001_download_concatenacao_urls.R")
tabula_group_title("minha_lista.m3u8")
source("V5_002_cria_music_salva_arquivo.R")
source("V5_003_insere_canais_manualmente_concatena_resultados_buscados.R")
source("V5_004_cria_index_epg_no_m3u8.R")
source("V5_005_cria_grupos.R")
tabula_group_title("minha_lista_concatenada.m3u8")
#source("V5_006_double_check_canais.R")
source("V5_007_atribui_logo_remove_repetidos.R")
#source("V5_008_testa_links_m3u8.R")
source("V5_009_cria_xml.R")

tabula_group_title("minha_lista_concatenada_ativa.m3u8")

file.remove("minha_lista_concatenada.xml")
file.remove("canais_encontrados_modificados.m3u8")
file.remove("minha_lista.m3u8")
file.remove("tabulacao_conteudo_final.xlsx")

# Define o nome atual do arquivo e o novo nome
nome_atual <- "minha_lista_concatenada.xml.gz"
novo_nome <- "minha_lista_concatenada_ativa.xml.gz"

# Usa a função file.rename() para alterar o nome do arquivo
resultado <- file.rename(nome_atual, novo_nome)

dia_hora <- Sys.time()
dia_hora <- str_replace_all(string = dia_hora, pattern = "-", replacement = "")
dia_hora <- str_replace_all(string = dia_hora, pattern = ":", replacement = "")
dia_hora <- str_replace_all(string = dia_hora, pattern = " ", replacement = "")
github_windows(paste0("atualizacao_", dia_hora))
