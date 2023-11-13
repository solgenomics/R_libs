## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = NA,
  warning = FALSE, 
  message = FALSE
)

## ----include=FALSE------------------------------------------------------------
library(FielDHub)
ENTRY <- 1:12
NAME <- c(paste0("Genotype", LETTERS[1:12]))
df <- data.frame(ENTRY,NAME)

## ----echo = FALSE, results='asis'---------------------------------------------
library(knitr)
kable(df)

## ----echo = TRUE--------------------------------------------------------------
library(FielDHub)

## ----echo = TRUE--------------------------------------------------------------
rect <- rectangular_lattice(
  t = 56,
  r = 3, 
  k = 7, 
  l = 1, 
  plotNumber = 101,
  locationNames = "FARGO", 
  seed = 1235
)

## ----echo=TRUE, eval=FALSE----------------------------------------------------
#  print(rect)

## ----echo=FALSE, eval=TRUE----------------------------------------------------
print(rect)

## ----echo=TRUE, eval=FALSE----------------------------------------------------
#  field_book <- rect$fieldBook
#  head(rect$fieldBook, 10)

## ----echo=FALSE, eval=TRUE----------------------------------------------------
field_book <- rect$fieldBook
head(rect$fieldBook, 10)

## ----fig.align='center', fig.width=7.2, fig.height=5.5------------------------
plot(rect)

