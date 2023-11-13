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

## ----echo = TRUE--------------------------------------------------------------
ibd <- incomplete_blocks(
  t = 28,
  r = 4,
  k = 4, 
  l = 1,
  seed = 1243
)

## ----echo=TRUE, eval=FALSE----------------------------------------------------
#  print(ibd)

## ----echo=FALSE, eval=TRUE----------------------------------------------------
print(ibd)

## ----echo=TRUE, eval=FALSE----------------------------------------------------
#  field_book <- ibd$fieldBook
#  head(ibd$fieldBook, 10)

## ----echo=FALSE, eval=TRUE----------------------------------------------------
field_book <- ibd$fieldBook
head(ibd$fieldBook, 10)

## ----fig.align='center', fig.width=7.2, fig.height=5.5------------------------
plot(ibd)


