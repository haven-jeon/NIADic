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



#' @importFrom RSQLite dbConnect dbWriteTable dbDisconnect SQLite
.onAttach <- function(libname, pkgname){
  han_db_path <- file.path(system.file(package=pkgname), "hangul.db")
  dic_rda_path <- file.path(system.file(package=pkgname), "dics.RData")
  if(!file.exists(han_db_path)){
    load(dic_rda_path, envir=.NIADicEnv)
    #make database
    conn <- dbConnect(SQLite(), han_db_path)
    on.exit({dbDisconnect(conn)})
    packageStartupMessage("Building dictionary database...")
    dbWriteTable(conn,"woorimalsam",  get("woorimalsam", envir=.NIADicEnv))
    dbWriteTable(conn,"insighter",    get("insighter", envir=.NIADicEnv))
    dbWriteTable(conn,"sejong", get("sejong", envir=.NIADicEnv))
    rm(list=c('woorimalsam', 'insighter', 'sejong'),envir = .NIADicEnv)
    if( all(c('woorimalsam', 'insighter', 'sejong') %in% dbListTables(conn)) ){
      packageStartupMessage("Database building completed.")
    }else{
      stop("Building dictionary database was failed.")
    }
  }

  assign("dic_rda_path", dic_rda_path, .NIADicEnv)
  assign("hangul_db_path", han_db_path, .NIADicEnv)
  packageStartupMessage("Successfully Loaded NIADic Package.")
}


