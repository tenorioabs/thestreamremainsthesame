



library(archive)

arquivo_xz <- "epg-pt.xml.xz"
arquivo_xz_descompactado <- "epg-pt.xml"
download.file("https://raw.githubusercontent.com/LITUATUI/M3UPT/main/EPG/epg-pt.xml.xz", arquivo_xz)
# Função para descompactar arquivos .xz usando xzfile
descompactar_xz <- function(arquivo_xz, arquivo_xz_descompactado) {
  con_in <- xzfile(arquivo_xz, open = "rb")
  con_out <- file(arquivo_xz_descompactado, open = "wb")
  while (length(buffer <- readBin(con_in, what = raw(), n = 1024)) > 0) {
    writeBin(buffer, con_out)
  }
  close(con_in)
  close(con_out)
}
# Descompactando o arquivo
descompactar_xz(arquivo_xz, arquivo_xz_descompactado)
file.remove("epg-pt.xml.xz")
