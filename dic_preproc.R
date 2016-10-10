library(data.table)
library(stringr)
library(dplyr)
library(readxl)



library(readxl)

brand_name <- read_excel("사전.xlsx",sheet=1, col_names=T)

brand_name <- brand_name %>% data.table

brand_name[,1:2, with=F]

brand_name[,tag:=str_trim(str_to_lower(`품사`))]

brand_name[,term:=str_trim(str_to_lower(`단어`))]

brand_name <- na.omit(brand_name[,.(term,tag)])





general_prod <- read_excel("사전.xlsx",sheet=2, col_names=T) %>% data.table

general_prod[,1:2, with=F]

general_prod[,tag:=str_trim(str_to_lower(`품사`))]

general_prod[,term:=str_trim(str_to_lower(`단어`))]

general_prod <- na.omit(general_prod[,.(term,tag)])


people_name <- read_excel("사전.xlsx",sheet=3, col_names=T) %>% data.table

people_name[,1:2, with=F]

people_name[,tag:=str_trim(str_to_lower(`품사`))]

people_name[,term:=str_trim(str_to_lower(`단어`))]

people_name <- na.omit(people_name[,.(term,tag)])



people_general <- read_excel("사전.xlsx",sheet=4, col_names=T) %>% data.table

people_general[,1:2, with=F]

people_general[,tag:=str_trim(str_to_lower(`품사`))]

people_general[,term:=str_trim(str_to_lower(`단어`))]

people_general <- na.omit(people_general[,.(term,tag)])


proper_noun <- read_excel("사전.xlsx",sheet=5, col_names=T) %>% data.table

proper_noun[,1:2, with=F]

proper_noun[,tag:=str_trim(str_to_lower(`품사`))]

proper_noun[,term:=str_trim(str_to_lower(`단어`))]

proper_noun <- na.omit(proper_noun[,.(term,tag)])


place_name <- read_excel("사전.xlsx",sheet=6, col_names=T) %>% data.table

place_name[,1:2, with=F]

place_name[,tag:=str_trim(str_to_lower(`품사`))]

place_name[,term:=str_trim(str_to_lower(`단어`))]

place_name <- na.omit(place_name[,.(term,tag)])


place_general <- read_excel("사전.xlsx",sheet=7, col_names=T) %>% data.table

place_general[,1:2, with=F]

place_general[,tag:=str_trim(str_to_lower(`품사`))]

place_general[,term:=str_trim(str_to_lower(`단어`))]

place_general <- na.omit(place_general[,.(term,tag)])


verb <- read_excel("사전.xlsx",sheet=8, col_names=T) %>% data.table

verb[,1:2, with=F]

verb[,tag:=str_trim(str_to_lower(`품사`))]

verb[,term:=str_trim(str_to_lower(`단어`))]

verb <- na.omit(verb[,.(term,tag)])


etc <- read_excel("사전.xlsx",sheet=9, col_names=T) %>% data.table

etc[,1:2, with=F]

etc[,tag:=str_trim(str_to_lower(`품사`))]

etc[,term:=str_trim(str_to_lower(`단어`))]

etc <- na.omit(etc[,.(term,tag)])

special <- read_excel("사전.xlsx",sheet=10, col_names=T) %>% data.table

special[,1:2, with=F]

special[,tag:=str_trim(str_to_lower(`품사`))]

special[,term:=str_trim(str_to_lower(`단어`))]

special <- na.omit(special[,.(term,tag)])


total <- rbind(brand_name,
               general_prod,
               people_name,
               people_general,
               proper_noun,
               place_name,
               place_general,
               verb,
               etc, special) # general_tag_collect.tsv


total[, term:=str_replace_all(term, pattern="[:blank:]", replacement="")]

unique(total)

write.table(unique(total),file="total.tsv",sep="\t",col.names=F,fileEncoding="UTF-8",row.names=F)


#개별 사전 저장
brand_name[, term_trimed:=str_replace_all(term, pattern="[:blank:]", replacement="")]

write.table(brand_name, file="NIADic/inst/dics/brand_name_raw.tsv",sep="\t",col.names=F,
            fileEncoding="UTF-8",row.names=F,quote=F, eol="\n")

write.table(unique(brand_name[,.(term_trimed,tag)]),
            file="NIADic/inst/dics/brand_name.tsv",sep="\t",col.names=F,
            fileEncoding="UTF-8",row.names=F, quote=F, eol="\n")





general_prod[, term_trimed:=str_replace_all(term, pattern="[:blank:]", replacement="")]

write.table(general_prod, file="NIADic/inst/dics/general_product_raw.tsv",sep="\t",col.names=F,
            fileEncoding="UTF-8",row.names=F,quote=F, eol="\n")

write.table(unique(general_prod[,.(term_trimed,tag)]),
            file="NIADic/inst/dics/general_product.tsv",sep="\t",col.names=F,
            fileEncoding="UTF-8",row.names=F, quote=F, eol="\n")





people_name[, term_trimed:=str_replace_all(term, pattern="[:blank:]", replacement="")]

write.table(people_name, file="NIADic/inst/dics/people_names_raw.tsv",sep="\t",col.names=F,
            fileEncoding="UTF-8",row.names=F,quote=F, eol="\n")

write.table(unique(people_name[,.(term_trimed,tag)]),
            file="NIADic/inst/dics/people_names.tsv",sep="\t",col.names=F,
            fileEncoding="UTF-8",row.names=F, quote=F, eol="\n")





people_general[, term_trimed:=str_replace_all(term, pattern="[:blank:]", replacement="")]

write.table(people_general, file="NIADic/inst/dics/people_general_raw.tsv",sep="\t",col.names=F,
            fileEncoding="UTF-8",row.names=F,quote=F, eol="\n")

write.table(unique(people_general[,.(term_trimed,tag)]),
            file="NIADic/inst/dics/people_general.tsv",sep="\t",col.names=F,
            fileEncoding="UTF-8" ,row.names=F, quote=F, eol="\n")




proper_noun[, term_trimed:=str_replace_all(term, pattern="[:blank:]", replacement="")]

write.table(proper_noun, file="NIADic/inst/dics/proper_noun_raw.tsv",sep="\t",col.names=F,
            fileEncoding="UTF-8",row.names=F,quote=F, eol="\n")

write.table(unique(proper_noun[,.(term_trimed,tag)]),
            file="NIADic/inst/dics/proper_noun.tsv",sep="\t",col.names=F,
            fileEncoding="UTF-8",row.names=F, quote=F, eol="\n")



place_name[, term_trimed:=str_replace_all(term, pattern="[:blank:]", replacement="")]

write.table(place_name, file="NIADic/inst/dics/place_name_raw.tsv",sep="\t",col.names=F,
            fileEncoding="UTF-8",row.names=F,quote=F, eol="\n")

write.table(unique(place_name[,.(term_trimed,tag)]),
            file="NIADic/inst/dics/place_name.tsv",sep="\t",col.names=F,
            fileEncoding="UTF-8",row.names=F, quote=F, eol="\n")




place_general[, term_trimed:=str_replace_all(term, pattern="[:blank:]", replacement="")]

write.table(place_general, file="NIADic/inst/dics/place_general_raw.tsv",sep="\t",col.names=F,
            fileEncoding="UTF-8",row.names=F,quote=F, eol="\n")

write.table(unique(place_general[,.(term_trimed,tag)]),
            file="NIADic/inst/dics/place_general.tsv",sep="\t",col.names=F,
            fileEncoding="UTF-8",row.names=F, quote=F, eol="\n")






verb[, term_trimed:=str_replace_all(term, pattern="[:blank:]", replacement="")]

write.table(verb, file="NIADic/inst/dics/verb_raw.tsv",sep="\t",col.names=F,
            fileEncoding="UTF-8",row.names=F,quote=F, eol="\n")

write.table(unique(verb[,.(term_trimed,tag)]),
            file="NIADic/inst/dics/verb.tsv",sep="\t",col.names=F,
            fileEncoding="UTF-8",row.names=F, quote=F, eol="\n")



etc[, term_trimed:=str_replace_all(term, pattern="[:blank:]", replacement="")]

write.table(etc, file="NIADic/inst/dics/general_tag_collect_raw.tsv",sep="\t",col.names=F,
            fileEncoding="UTF-8",row.names=F,quote=F, eol="\n")

write.table(unique(etc[,.(term_trimed,tag)]),
            file="NIADic/inst/dics/general_tag_collect.tsv",sep="\t",col.names=F,
            fileEncoding="UTF-8",row.names=F, quote=F, eol="\n")





special[, term_trimed:=str_replace_all(term, pattern="[:blank:]", replacement="")]

write.table(special, file="NIADic/inst/dics/special_characters_raw.tsv",sep="\t",col.names=F,
            fileEncoding="UTF-8",row.names=F,quote=F, eol="\n")

write.table(unique(special[,.(term_trimed,tag)]),
            file="NIADic/inst/dics/special_characters.tsv",sep="\t",col.names=F,
            fileEncoding="UTF-8",row.names=F, quote=F,eol="\n")




