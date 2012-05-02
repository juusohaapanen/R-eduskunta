#Eduskuntadatan hakemiseen kirjoitettu R-sovellus, jolla saa helposti R:ään data frameksi XML-muotoista dataa. 
#
#
# getEdustajat
#     - Hakee eduskunta-aineistoista halutun äänestyksen tiedot kansanedustajaittain (kaikki kansanedustajat).
# getPuolueet 
#     - Hakee eduskunta-aineistoista halutun äänestyksen tulokset puolueittain (kaikki puolueet, myös ne joita ei ole tällä hetkellä eduskunnassa)
#

getEdustajaData <- function(aanestys)
{
  #Hakee äänestyksen tulokset ehdokkaittain
  #input aanestys Äänestyksen numero
  #output data.frame
  # colnames(output) == c('nimi','valinta','puolue') == TRUE
  
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


