## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = NA,
  warning = FALSE, 
  message = FALSE
)

## ----include=FALSE------------------------------------------------------------
ENTRY <- 1:12
NAME <- c(paste0("Genotype", LETTERS[1:12]))
df <- data.frame(ENTRY,NAME)

## ----echo = FALSE, results='asis'---------------------------------------------
library(knitr)
kable(df)

## ----echo = TRUE--------------------------------------------------------------
library(FielDHub)

## ----echo = TRUE--------------------------------------------------------------
square <- square_lattice(
  t = 64,
  r = 3, 
  k = 8,      
  l = 1,     
  plotNumber = 101, 
  locationNames = "FARGO", 
  seed = 1233
)

## ----echo=TRUE, eval=FALSE----------------------------------------------------
#  print(square)

## ----echo=FALSE, eval=TRUE----------------------------------------------------
print(square)

## ----echo=TRUE, eval=FALSE----------------------------------------------------
#  field_book <- square$fieldBook
#  head(square$fieldBook, 10)

## ----echo=FALSE, eval=TRUE----------------------------------------------------
field_book <- square$fieldBook
head(square$fieldBook, 10)

## ----fig.align='center', fig.width=7.2, fig.height=5.5------------------------
plot(square)

