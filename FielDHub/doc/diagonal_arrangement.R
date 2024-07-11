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
NAME <- c(c("CH1","CH2","CH3","CH4"), paste0("ND-", 5:12))
df <- data.frame(ENTRY,NAME)

## ----echo = FALSE, results='asis'---------------------------------------------
library(knitr)
kable(df)

## ----echo = TRUE--------------------------------------------------------------
library(FielDHub)

## ----echo = TRUE, warning=FALSE, comment=''-----------------------------------
single_diag <- diagonal_arrangement(
  nrows = 15,
  ncols = 22,
  lines = 300,
  checks = 5,
  l = 1,
  plotNumber = 1,
  exptName = "PYT_BARLEY_2022",
  locationNames = "FARGO",
  seed = 16,
)

## ----echo=TRUE, eval=FALSE----------------------------------------------------
#  print(single_diag)

## ----echo=FALSE, eval=TRUE----------------------------------------------------
print(single_diag)

## ----echo=TRUE, eval=FALSE----------------------------------------------------
#  field_book <- single_diag$fieldBook
#  head(field_book, 10)

## ----echo=FALSE, eval=TRUE----------------------------------------------------
field_book <- single_diag$fieldBook
head(field_book, 10)

## ----fig.align='center', fig.width=7.2, fig.height=5--------------------------
plot(single_diag)

## ----include=FALSE------------------------------------------------------------
ENTRY <- 1:12
NAME <- c(c("CH1","CH2","CH3","CH4"), paste0("ND-", 5:12))
df <- data.frame(ENTRY,NAME)

## ----echo = FALSE, results='asis'---------------------------------------------
library(knitr)
kable(df)

## ----echo=TRUE----------------------------------------------------------------
multi_diag <- diagonal_arrangement(
  nrows = 15,
  ncols = 22,
  lines = 300,
  kindExpt = "DBUDC", 
  blocks = c(100,120,80),
  checks = 5,
  l = 1,
  plotNumber = c(1, 1001, 2001),
  exptName = c("MATURITY1", "MATURITY2", "MATURITY3"),
  locationNames = "FARGO",
  seed = 17
)

## ----echo=TRUE, eval=FALSE----------------------------------------------------
#  print(multi_diag)

## ----echo=FALSE, eval=TRUE----------------------------------------------------
print(multi_diag)

## ----echo=TRUE, eval=FALSE----------------------------------------------------
#  field_book <- multi_diag$fieldBook
#  head(field_book, 10)

## ----echo=FALSE, eval=TRUE----------------------------------------------------
field_book <- multi_diag$fieldBook
head(field_book, 10)

## ----fig.align='center', fig.width=7.2, fig.height=5--------------------------
plot(multi_diag)

