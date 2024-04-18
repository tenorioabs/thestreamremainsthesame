# Obtendo informações do sistema
info_so <- Sys.info()

  pacotes <- c("beepr",
               "dplyr",
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

# Verificando se o sistema é Windows ou Linux
if(sum(as.numeric(!pacotes %in% installed.packages())) != 0){
    instalador <- pacotes[!pacotes %in% installed.packages()]
    for(i in 1:length(instalador)) {
      install.packages(instalador, dependencies = T)
      break()}
    sapply(pacotes, require, character = T) 
  } else {
    sapply(pacotes, require, character = T) 
  }
