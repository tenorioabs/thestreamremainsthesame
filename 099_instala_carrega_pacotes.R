
# Instalação e Carregamento de Todos os Pacotes ---------------------------

pacotes <- c("dplyr",
             "httr",
             "R.utils",
             "stringr",
             "writexl",
             "xml2",
             "readxl",
             "future",
             "future.apply",
             "progressr",
             "xml2",
             "R.utils")

if(sum(as.numeric(!pacotes %in% installed.packages())) != 0){
  instalador <- pacotes[!pacotes %in% installed.packages()]
  for(i in 1:length(instalador)) {
    install.packages(instalador, dependencies = T)
    break()}
  sapply(pacotes, require, character = T) 
} else {
  sapply(pacotes, require, character = T) 
}
