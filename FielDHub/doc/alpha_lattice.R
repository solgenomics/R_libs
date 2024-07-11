## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = NA,
  warning = FALSE, 
  message = FALSE
)

## ----eval=FALSE---------------------------------------------------------------
#  FielDHub::run_app()

## ----eval=FALSE---------------------------------------------------------------
#  library(FielDHub)
#  run_app()

## ----include=FALSE------------------------------------------------------------
ENTRY <- 1:12
NAME <- c(paste0("Genotype", LETTERS[1:12]))
df <- data.frame(ENTRY,NAME)

## ----echo = FALSE, results='asis'---------------------------------------------
library(knitr)
kable(df)

## ----echo = TRUE--------------------------------------------------------------
library(FielDHub)

## ----echo=TRUE----------------------------------------------------------------
alpha <- alpha_lattice(
  t = 55,
  r = 3,  
  k = 5, 
  l = 1,      
  plotNumber = 101, 
  locationNames = "FARGO", 
  seed = 1235
)

## ----echo=TRUE, eval=FALSE----------------------------------------------------
#  print(alpha)

## ----echo=FALSE, eval=TRUE----------------------------------------------------
print(alpha)

## ----echo=TRUE, eval=FALSE----------------------------------------------------
#  field_book <- alpha$fieldBook
#  head(alpha$fieldBook, 10)

## ----echo=FALSE, eval=TRUE----------------------------------------------------
field_book <- alpha$fieldBook
head(alpha$fieldBook, 10)

## ----fig.align='center', fig.width=7.2, fig.height=5.5------------------------
plot(alpha)

