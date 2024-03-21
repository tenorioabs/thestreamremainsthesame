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
