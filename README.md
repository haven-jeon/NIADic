# NIA(National Information Society Agency) Dictionary

[![License: CC BY SA](https://img.shields.io/badge/License-CC%20BY%20SA%202.0-lightgrey.svg)](https://creativecommons.org/licenses/by-sa/2.0/)

The Korean dictionary for morphological analysis, NIADic, was compiled as an enhancement of the original [KoNLP][konlp], to help users get more accurate and stable result from text analysis. With the unstinted support from MSIP(Ministry of  Science, ICT and Future Planning), NIADic was developed by [NIA (National Information Society Agency)](http://eng.nia.or.kr/english/eng_nia.asp) with the leading contribution from the original developer, [Heewon Jeon](http://freesearch.pe.kr).  NIA also greatly acknowledges National Institute of the Korean Language (NIKL) as providing generously the source of Korean word dictionary.



To install from GitHub, use

    install.packages('devtools')
    library(devtools)
    install_github('haven-jeon/NIADic/NIADic', build_vignettes = TRUE)


To download each dictionary with text format.

    install.packages('devtools')
    devtools::install_github('haven-jeon/NIADic/NIADic', build_vignettes = TRUE)
    library(NIADic)
    #insighter <- get_dic('insighter')
    #sejong <- get_dic('sejong')
    woorimal <- get_dic('woorimalsam')
    head(woorimal)
    write.csv(woorimal, file='woorimaldic.csv', fileEncoding='UTF-8', row.names=F)

We will provide this package from [NIA package repository]() after development.

- NIADic Status
  - [Insighter Dictionary](https://htmlpreview.github.io/?https://github.com/haven-jeon/NIADic/blob/master/NIADic/vignettes/insighter-dic.html)
  - [WooRiMalSam Dictionary](https://htmlpreview.github.io/?https://github.com/haven-jeon/NIADic/blob/master/NIADic/vignettes/woorimalsam-dic.html)
 

[konlp]:http://cran.r-project.org/web/packages/KoNLP/index.html


