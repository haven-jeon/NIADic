#Copyright 2016 Heewon Jeon(madjakarta@gmail.com)
#
#This file is part of NIADic.
#
#NIADic is free software: you can redistribute it and/or modify
#it under the terms of the GNU General Public License as published by
#the Free Software Foundation, either version 3 of the License, or
#(at your option) any later version.

#NIADic is distributed in the hope that it will be useful,
#but WITHOUT ANY WARRANTY; without even the implied warranty of
#MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#GNU General Public License for more details.


.NIADicEnv <- new.env()



#' @import RSQLite
.onAttach <- function(libname, pkgname){
  han_db_path <- file.path(system.file(package=pkgname), "hangul.db")
  dic_rda_path <- file.path(system.file(package=pkgname), "dics.RData")
  if(!file.exists(han_db_path)){
    load(dic_rda_path)
    #make database
    conn <- dbConnect(SQLite(), han_db_path)
    dbWriteTable(conn,"woorimalsam", woorimalsam)
    dbWriteTable(conn,"insighter", insighter)
    dbWriteTable(conn,"sejong", sejong)
    dbDisconnect(conn)
    rm(woorimalsam, insighter, sejong)
  }

  assign("dic_rda_path", dic_rda_path, NIADic:::.NIADicEnv)
  assign("hangul_db_path", han_db_path, NIADic:::.NIADicEnv)
  packageStartupMessage("Successfully Loaded NIADic Package.")
}


