conn <- unz("NIADic/inst/dics/dics.zip", "verb.tsv")


read.table(conn, sep="\t", header=FALSE, fileEncoding="UTF-8", stringsAsFactors=FALSE)

a <- read.table("NIADic/inst/dics/ext/verb.tsv", sep='\t', fileEncoding='UTF-8', header=FALSE)


a <- fread("NIADic/inst/dics/people_general.tsv",sep='\t',encoding='UTF-8', header=F)

unzip("NIADic/inst/dics/dics.zip",list=F, exdir="NIADic/inst/dics/ext")
