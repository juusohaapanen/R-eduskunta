#Eduskuntadatan hakemiseen kirjoitettu R-skripti
# 
# getEdustajaData -funktio hakee per äänestys kunkin edustajan nimen, puolueen sekä valinnan
#
#
# 

getEdustajaData <- function(aanestys)
{  
  library(XML)
  baseurl <- "http://www.biomi.org/eduskunta/?haku=aanestys&id="
  if(is.na(aanestys)) {
     stop('Error ')
  }
  else {
    search_url <- paste(baseurl,aanestys,sep="")
    ekdat.tree <- xmlParse(search_url)
    ekdat.edustajat <- getNodeSet(ekdat.tree, path="//edustajat/edustaja")
    if(length(ekdat.edustajat) == 0) {
      stop('Virheellinen Äänestys-id')
    }
    df <- xmlToDataFrame(ekdat.edustajat)
    df$valinta <- as.factor(df$valinta)
    df$puolue <- as.factor(df$puolue)
    df$nimi <- as.character(df$nimi)
  }
  return(df)
}


