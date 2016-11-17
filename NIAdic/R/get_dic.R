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



#' Get Dictionary
#'
#' @param dic_name one of dictionary name(character), \strong{woorimalsam}, \strong{insighter}, \strong{sejong}
#'
#' @return The \code{data.frame} object contains tags and terms
#' @export
#'
#' @examples
#' \dontrun{
#'    dic_df <-get_dic('sejong')
#' }
#' @import RSQLite
get_dic <- function(dic_name){

  dic_path <- file.path(system.file(package='NIADic'), "hangul.db")
  conn <- dbConnect(SQLite(), dic_path)
  on.exit({dbDisconnect(conn)})
  if(!(dic_name %in% dbListTables(conn))){
    stop(sprintf("NIADic does not contain '%s' dictionary!", dic_name))
  }
  dic <- dbGetQuery(conn, sprintf("select * from %s", dic_name))
  Encoding(dic$term) <- 'UTF-8'
  if(dic_name == 'woorimalsam'){
    Encoding(dic$category) <- 'UTF-8'
  }
  return(dic)
}


