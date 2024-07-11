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
FACTORS <- rep(c("A", "B", "C"), c(3,3,2))
LEVELS <- c("a0", "a1", "a2", "b0", "b1", "b2", "c0", "c1")
df <- data.frame(list(FACTOR = FACTORS, LEVEL = LEVELS))

## ----echo = FALSE, results='asis'---------------------------------------------
library(knitr)
kable(df)

## ----echo = TRUE--------------------------------------------------------------
library(FielDHub)

## ----echo = TRUE--------------------------------------------------------------
factorial <- full_factorial(
  setfactors = c(3,3,2), 
  reps = 3, 
  l = 1, 
  type = 2, 
  plotNumber = 101,
  planter = "serpentine",
  locationNames = "FARGO",
  seed = 1239
)

## ----echo=TRUE, eval=FALSE----------------------------------------------------
#  print(factorial)

## ----echo=FALSE, eval=TRUE----------------------------------------------------
print(factorial)

## ----echo=TRUE, eval=FALSE----------------------------------------------------
#  field_book <- factorial$fieldBook
#  head(factorial$fieldBook, 10)

## ----echo=FALSE, eval=TRUE----------------------------------------------------
field_book <- factorial$fieldBook
head(factorial$fieldBook, 10)

## ----fig.align='center', fig.width=7.2, fig.height=5.5------------------------
plot(factorial)

