# NIA(National Information Society Agency)Dic

This R package contains Hangul resources for [KoNLP][konlp] package to do Hangul text mining and  corpus linguistics.

Main purposes are...
 
* To make any resercher can use high quality dictionary without any restriction.
* Preserve static resources for [KoNLP][konlp].


To install from GitHub, use

    install.packages('devtools')
    library(devtools)
    install_github('haven-jeon/NIADic/NIAdic', build_vignettes = TRUE)


To download each dictionary with text format.

    install.packages('devtools')
    library(devtools)
    install_github('haven-jeon/NIADic/NIAdic', build_vignettes = TRUE)
    library(NIAdic)
    woorimalsam <- get_dic('woorimalsam')
    insighter <- get_dic('insighter')
    sejong <- get_dic('sejong')
    


We will provide this package from [NIA package repository]() after development.

- [NIA_Dic Dictionary status fro KoNLP](https://htmlpreview.github.io/?https://github.com/haven-jeon/NIADic/blob/master/NIAdic/vignettes/insighter-dic.html)

- [WooRiMalSam Dictionary status for KoNLP](https://htmlpreview.github.io/?https://github.com/haven-jeon/NIADic/blob/master/NIAdic/vignettes/woorimalsam-dic.html)
  + [About WooRiMalSam Dictionary](https://ko.wikipedia.org/wiki/%EC%9A%B0%EB%A6%AC%EB%A7%90_%EC%83%98)


[konlp]:http://cran.r-project.org/web/packages/KoNLP/index.html


