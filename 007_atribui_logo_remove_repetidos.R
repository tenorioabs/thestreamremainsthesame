# Nomes dos arquivos de entrada e saída
nome_arquivo_entrada <- nome_coluna
nome_arquivo_saida <- nome_coluna

# Ler, processar e escrever o arquivo
conteudo <- ler_arquivo(nome_arquivo_entrada)
conteudo_processado <- processar_conteudo(conteudo)
escrever_arquivo(nome_arquivo_saida, conteudo_processado)

cat("Processamento concluído. Verifique o arquivo de saída.")