#Eduskuntadatan hakemiseen kirjoitettu R-sovellus, jolla saa helposti R:ään data frameksi XML-muotoista dataa. 
#
#
<<<<<<< HEAD

GetAllAanestykset <- function() {
  #Hakee kaikki äänestykset
  library(XML)
  url <- "http://www.biomi.org/eduskunta/"
  kaikki.tree <- xmlParse(url)
  tunnisteet <- getNodeSet(kaikki.tree, path='//luettelo/aanestys/tunniste')
  out <- xmlToDataFrame(tunnisteet)
  out <- as.character(out$text)
  return(out)
  
}


GetEdustajaData <- function(aanestys)
{
  #Hakee kaikkien edustajien äänestystulokset tietystä äänestyksestä. 
  #@input: äänestyksen tunniste
  #@output: data.frame 
=======
# getEdustajat
#     - Hakee eduskunta-aineistoista halutun äänestyksen tiedot kansanedustajaittain (kaikki kansanedustajat).
# getPuolueet 
#     - Hakee eduskunta-aineistoista halutun äänestyksen tulokset puolueittain (kaikki puolueet, myös ne joita ei ole tällä hetkellä eduskunnassa)
#
GetAllAanestykset <- function() {
  library(XML)
  url <- "http://www.biomi.org/eduskunta/"
  kaikki.tree <- xmlParse(url)
  tunnisteet <- getNodeSet(kaikki.tree, path='//luettelo/aanestys/tunniste')
  out <- xmlToDataFrame(tunnisteet)
  out <- as.character(out$text)
  return(out)
  
}


GetEdustajaData <- function(aanestys)
{

>>>>>>> Muutoksia
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

GetEdustajanAanestykset <- function(edustaja) {
<<<<<<< HEAD
  #Hakee tietyn edustajan kaikkien äänestysten tiedot
  #@input: Kansanedustajan nimi muodossa Sukunimi Etunimi 
  #@output: data.frame
  #Toistaiseksi täysin toimimaton funktio ;)

=======
>>>>>>> Muutoksia
  edustaja <- URLencode(edustaja)
  url <- "http://www.biomi.org/eduskunta/?haku=edustaja&id"
  url.haku <- paste(url, edustaja, sep="=")
  edustaja.puu <- xmlParse(url.haku)
  aanestykset <- getNodeSet(edustaja.puu, path='//edustaja/aanestys/tiedot')
  df <- xmlToDataFrame(aanestykset)
  return(df)
}

haeHakuSanalla <- function(hakusana) {
<<<<<<< HEAD
  #Hakee hakusanalla 20 äänestystä
  #@input: hakusana
  #@output: data frame, jossa on tuloksena haettavien äänestysten tiedot
=======
>>>>>>> Muutoksia
  hakusana <- URLencode(hakusana)
  url <- "http://www.biomi.org/eduskunta/?haku=sanahaku&id"
  url.haku <- paste(url, hakusana, sep="=")
  aanestykset.puu <- xmlParse(url.haku)
  aanestykset <- getNodeSet(aanestykset.puu, path="//aanestykset/aanestys/tiedot")
  df <- xmlToDataFrame(aanestykset)
  return(df)
}


