#우리말샘 사전 전처리 위한 코드




library(data.table)
library(stringi)
library(stringr)
library(KoNLP)
library(dplyr)


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



#load(file = "total_dt.RData")

total_dt[,.N,cl_tag][order(-N)]

cl_tag <-
  c("명사","동사", "형용사" , "부사", "관형사·명사", "관형사·명사",
    "감탄사", "어미", "의존 명사", "대명사", "접사", "관형사", "수사·관형사","수사·관형사",
    "조사", "수사", "명사·부사", "명사·부사",
    "감탄사·명사", "감탄사·명사",
    "보조 동사", "관형사·감탄사","관형사·감탄사",
    "의존 명사·조사","의존 명사·조사",
    "대명사·감탄사", "대명사·감탄사",
    "수사·관형사·명사","수사·관형사·명사","수사·관형사·명사",
    "대명사·관형사",  "대명사·관형사",
    "부사·감탄사",  "부사·감탄사",
    "동사·형용사","동사·형용사",
    "대명사·부사", "대명사·부사"
    )

k_tag <- c("nc", "pv", "pa",  "ma",  "mm", "nc",
    "ii", "e", "nb", "np", "x", "mm", "mm", "nn",
    "j", "nn", "ma", "nc",
    "nc", "ii",
    "pv", "mm", "ii",
    "nb", "j",
    "np", 'ii',
    "nn", 'mm', 'nc',
    "np", 'mm',
    "ii", 'ma',
    "pv", 'pa',
    "np", 'ma')


tag_cnv_tbl <- data.table(cl_tag, k_tag)

tag_cnv_tbl[,cl_tag:=iconv(cl_tag, from='euc-kr', to='utf-8')]

Encoding(tag_cnv_tbl$cl_tag) <- 'UTF-8'

total_dt_kaist_tag <- total_dt %>% inner_join(tag_cnv_tbl, by="cl_tag") %>% data.table


total_dt_kaist_tag[cl_tag %chin%  "관형사·감탄사"]


object.size(total_dt_kaist_tag)

library(RSQLite)

con <- dbConnect(SQLite(), "hangul.db")

dbWriteTable(con, "woorimalsam", total_dt_kaist_tag[,.(term=cl_term, tag=k_tag, category)])

woorimalsam <- total_dt_kaist_tag[,.(term=cl_term, tag=k_tag, category)]

dbListTables(con)

dbGetQuery(con, "select * from woorimalsam limit 10")

tbls <- dbGetQuery(con, iconv("select * from woorimalsam where category = '의학'", to='utf-8'))

Encoding(tbls) <- 'UTF-8'


dbDisconnect(con)


load("insighter_dic.RData")

con <- dbConnect(SQLite(), "nia_dic.db")

dbWriteTable(con, "insighter", j_one_dic[,.(term,tag, in_category=insight_cate)])

insighter <- j_one_dic[,.(term,tag, in_category=insight_cate)]


dbDisconnect(con)


dbListTables(con)

Sejong <- fread("c:/Users/gogamza/Documents/work/Sejong/inst/dics/handic/data/kE/dic_user2.txt",sep='\t', encoding="UTF-8", header=F,stringsAsFactors=F)
Sejong

glimpse(Sejong)

setnames(Sejong, c("term", 'tag'))

dbWriteTable(con, "sejong", Sejong)

dbDisconnect(con)

sejong <- Sejong

woorimalsam <- as.data.frame(woorimalsam)
insighter <- as.data.frame(insighter)
sejong <- as.data.frame(sejong)



han_cate=c('','가톨릭','건설','경영','경제','고유명 일반','공업','공예','공학 일반','광업','교육','교통','군사','기계','기독교','농업','동물','매체','무용','문학','물리','미술','민속','법률','보건 일반','복식','복지','불교','사회 일반','산업 일반','생명','서비스업','수산업','수의','수학','식물','식품','심리','약학','언어','역사','연기','영상','예체능 일반','음악','의학','인명','인문 일반','임업','자연 일반','재료','전기·전자','정보·통신','정치','종교 일반','지구','지리','지명','책명','천문','천연자원','철학','체육','한의','해양','행정',
                                         '화학',
                                         '환경')

eng_cate=c('general', 'Catholic', 'construction', 'Business', 'economic', 'proper names General', 'Industry',
           'craft', 'Engineering General', 'mining', 'education', 'transport', 'military', 'machinery',
           'Christian', 'Agriculture', 'animal', 'medium', 'useless',' literature ','physical ','art',
           'folk ',' law ',' Health General ',' doubles', 'welfare', 'Buddhism', 'society in general',
           'industry General', 'life', 'service', 'fishing', 'veterinary science', 'math', 'plant' ,'Food','hearing', 'pharmacy', 'language', 'history', 'smoke', 'video', 'The purpose of the general', 'music', 'medicine', 'life', 'Humanities General' ,'forestry', 'natural plain', 'material', 'electrical and electronic', 'information and communication', 'political', 'religion normal', 'Earth', 'Geography', 'named', 'chaekmyeong', 'astronomy', 'natural resources', 'philosophy', 'Sports', 'Han', 'Ocean',
           'Administration', 'chemical', 'environment')


cate_mapping <- data.table(han_cate=han_cate, eng_cate=str_trim(eng_cate))


cate_mapping$han_cate <- iconv(cate_mapping$han_cate, to='UTF-8')


Encoding(cate_mapping$han_cate) <- 'UTF-8'

cate_mapping

setnames(cate_mapping, c("han_cate"), c("category"))

woorimalsam <- data.table(woorimalsam) %>% inner_join(cate_mapping, by='category') %>% data.table

woorimalsam <- as.data.frame(woorimalsam)

save(woorimalsam, insighter, sejong, file="NIADic/inst/dics.RData",compress='xz')


insighter <- data.table(insighter)

insighter_cl <- insighter[!(term %like% '디에고로페스로드리게스')]

"people_names"

insighter_cl


names(res) <- c('term', 'tag')

res$in_category <- 'people_names'

res$term <- as.character(res$term)

res$tag <- as.character(res$tag)

res[462,]$tag <- 'nc'
tail(res)


insighter <- rbind(insighter_cl, res)


insighter <- as.data.frame(insighter)

save(woorimalsam, insighter, sejong, file="NIADic/inst/dics.RData",compress='xz')


summary(data.table(sejong)[,nchar(term)])


data.table(sejong)[nchar(term) >= 16]



#nc -> ncn


library(data.table)


woorimalsam <- data.table(woorimalsam)
insighter <- data.table(insighter)
sejong <- data.table(sejong)



woorimalsam[,.N,tag]

woorimalsam[, tag:=ifelse(tag == 'pv', 'pvg',tag)]
woorimalsam[, tag:=ifelse(tag == 'nc', 'ncn', tag)]
woorimalsam[, tag:=ifelse(tag == 'ec', 'ecc', tag)]
woorimalsam[, tag:=ifelse(tag == 'ma', 'mag', tag)]
woorimalsam[, tag:=ifelse(tag == 'j', 'jc', tag)]
woorimalsam[, tag:=ifelse(tag == 'pa', 'pad', tag)]
woorimalsam[, tag:=ifelse(tag == 'nn', 'nnc', tag)]
woorimalsam[, tag:=ifelse(tag == 'nb', 'nbu', tag)]
woorimalsam[, tag:=ifelse(tag == 'x', 'xp', tag)]
woorimalsam[, tag:=ifelse(tag == 'np', 'npp', tag)]
woorimalsam[, tag:=ifelse(tag == 'mm', 'mmd', tag)]
woorimalsam[, tag:=ifelse(tag == 'jc', 'jcs', tag)]

insighter[, tag:=ifelse(tag == 'pv', 'pvg',tag)]
insighter[, tag:=ifelse(tag == 'nc', 'ncn', tag)]
insighter[, tag:=ifelse(tag == 'ec', 'ecc', tag)]
insighter[, tag:=ifelse(tag == 'ma', 'mag', tag)]
insighter[, tag:=ifelse(tag == 'j', 'jc', tag)]
insighter[, tag:=ifelse(tag == 'pa', 'pad', tag)]
insighter[, tag:=ifelse(tag == 'nn', 'nnc', tag)]
insighter[, tag:=ifelse(tag == 'nb', 'nbu', tag)]
insighter[, tag:=ifelse(tag == 'x', 'xp', tag)]
insighter[, tag:=ifelse(tag == 'np', 'npp', tag)]
insighter[, tag:=ifelse(tag == 'mm', 'mmd', tag)]
insighter[, tag:=ifelse(tag == 'jc', 'jcs', tag)]


insighter[,.N,tag]


sejong[,.N,tag]

