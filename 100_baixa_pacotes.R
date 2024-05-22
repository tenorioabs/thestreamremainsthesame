# Crie a pasta "pacotes" se ela não existir
if (!dir.exists("pacotes")) {
  dir.create("pacotes")
}

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

# Instale e baixe os pacotes na pasta "pacotes"
for (pkg in pacotes) {
  if (!require(pkg, character.only = TRUE, lib.loc = "pacotes")) {
    install.packages(pkg, lib = "pacotes", dependencies = TRUE)
  }
}

# Confirme que os pacotes foram instalados na pasta "pacotes"
installed.packages(lib.loc = "pacotes")
