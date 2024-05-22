# Defina o diretório de pacotes
#

# Lista de pacotes necessários
pacotes <- c("archive",
             "dplyr",
             "httr",
             "R.utils",
             "stringr",
             "writexl",
             "xml2",
             "readxl",
             "future",
             "future.apply",
             "progressr")

# Instalação e Carregamento de Todos os Pacotes
if(sum(as.numeric(!pacotes %in% installed.packages(lib.loc = "pacotes"))) != 0){
  instalador <- pacotes[!pacotes %in% installed.packages(lib.loc = "pacotes")]
  for(i in 1:length(instalador)) {
    install.packages(instalador, lib = "pacotes", dependencies = TRUE)
  }
  sapply(pacotes, require, character.only = TRUE, lib.loc = "pacotes")
} else {
  sapply(pacotes, require, character.only = TRUE, lib.loc = "pacotes")
}
