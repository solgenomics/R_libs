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
library(FielDHub)
ENTRY <- 1:12
NAME <- c(c("CHECK1","CHECK2","CHECK3"), paste0("G-", 4:12))
df <- data.frame(ENTRY,NAME)

## ----echo = FALSE, results='asis'---------------------------------------------
library(knitr)
kable(df, format = "html")

## ----echo = TRUE--------------------------------------------------------------
library(FielDHub)

## ----echo = TRUE--------------------------------------------------------------
aug_RCBD <- RCBD_augmented(
  lines = 120,
  checks = 4,
  b = 6, 
  repsExpt = 1, 
  l = 2,
  random = TRUE,
  exptName = "Cassava_2022", 
  plotNumber = c(1001, 2001),
  locationNames = c("FARGO", "CASSELTON"),
  nrows = 12,
  ncols = 12,
  seed = 1987
)

## ----echo=TRUE, eval=FALSE----------------------------------------------------
#  print(aug_RCBD)

## ----echo=FALSE, eval=TRUE----------------------------------------------------
print(aug_RCBD)

## ----echo=TRUE, eval=FALSE----------------------------------------------------
#  field_book <- aug_RCBD$fieldBook
#  head(field_book, 10)

## ----echo=FALSE, eval=TRUE----------------------------------------------------
field_book <- aug_RCBD$fieldBook
head(field_book, 10)

## ----fig.align='center', fig.width=7.2, fig.height=5.5------------------------
plot(aug_RCBD)

## ----fig.align='center', fig.width=7.2, fig.height=5.5------------------------
plot(aug_RCBD, l = 2)

