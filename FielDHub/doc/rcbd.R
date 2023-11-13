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
TREATMENT <- c(paste0("TRT_", LETTERS[1:10]))
df <- data.frame(TREATMENT)

## ----echo = FALSE, results='asis'---------------------------------------------
library(knitr)
kable(df)

## ----echo = TRUE--------------------------------------------------------------
library(FielDHub)

## ----echo = TRUE--------------------------------------------------------------
rcbd <- RCBD(
  t = 24, 
  reps = 4,
  l = 1,
  plotNumber = 101,
  locationNames = "FARGO",
  seed = 1237
)

## ----echo=TRUE, eval=FALSE----------------------------------------------------
#  print(rcbd)

## ----echo=FALSE, eval=TRUE----------------------------------------------------
print(rcbd)

## ----echo=TRUE, eval=FALSE----------------------------------------------------
#  field_book <- rcbd$fieldBook
#  head(rcbd$fieldBook, 10)

## ----echo=FALSE, eval=TRUE----------------------------------------------------
field_book <- rcbd$fieldBook
head(rcbd$fieldBook, 10)

## ----fig.align='center', fig.width=7.2, fig.height=5.5------------------------
plot(rcbd)

