#우리말샘 사전 전처리 위한 코드




library(data.table)
library(stringi)
library(stringr)
library(KoNLP)


opendic_00 <- read.table("woorimalsam_161020/utf8/OPENDICT_00.txt",sep='\t', header=T, colClasses='character',fileEncoding='utf-8', fill=T)


opendic_00 <- data.table(opendic_00)

opendic_00 <- opendic_00[!(is.na(`어휘`) | is.na(`품사`))]

names(opendic_00)

setnames(opendic_00, c("term", "kind", "tag", "cate"))

opendic_00_term <- opendic_00[kind %chin% '어휘',]

opendic_00_term[, cl_term:=stri_replace_all_regex(str_trim(term),"(\\^|-)","")]

opendic_00_term[,cl_tag:=str_trim(tag)]

opendic_00_term <- opendic_00_term[!(cl_term %like% "\\?")]


opendic_00_term[,.N, cate][order(-N)]

opendic_00_term[!is.jamo(cl_term),.(cl_term, cl_tag)]


rbl <- list()
for(i in 0:18){
  pi <- str_pad(i, pad="0", width=2)
  opendic_00 <- read.table(sprintf("woorimalsam_161020/utf8/OPENDICT_%s.txt", pi),sep='\t', header=T, colClasses='character',fileEncoding='utf-8', fill=T)


  opendic_00 <- data.table(opendic_00)

  opendic_00 <- opendic_00[!(is.na(`어휘`) | is.na(`품사`))]


  setnames(opendic_00, c("term", "kind", "tag", "cate"))

  opendic_00_term <- opendic_00[kind %chin% '어휘',]

  opendic_00_term[, cl_term:=stri_replace_all_regex(str_trim(term),"(\\^|-)","")]

  opendic_00_term[,cl_tag:=str_trim(tag)]

  opendic_00_term <- opendic_00_term[!(cl_term %like% "\\?")]


  opendic_00_term[,.N, cate][order(-N)]

  opendic_00_term_cl <- opendic_00_term[sapply(cl_term, function(x){all(!is.jamo(str_split(x, "")[[1]]))}),.(cl_term, cl_tag,category=str_trim(cate))]
  print(pi)
  rbl[[pi]] <-opendic_00_term_cl
}

total_dt <- unique(rbindlist(rbl))

save(total_dt, file='total_dt.RData')



total_dt[category %chin% '체육'][order(cl_term)] %>% View


total_dt[,.N,category][order(-N)] %>% View
