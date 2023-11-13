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
NAME <- c(c("CHECK1","CHECK2","CHECK3"), paste0("G-", 4:12))
REPS <- c(rep(10,3),rep(1,9))
df <- data.frame(ENTRY,NAME,REPS)

## ----echo = FALSE, results='asis'---------------------------------------------
library(knitr)
kable(df)

## ----echo = TRUE--------------------------------------------------------------
library(FielDHub)

## ----echo = TRUE--------------------------------------------------------------
optim_expt <- optimized_arrangement(
  nrows = 29,
  ncols = 15,
  lines = 401, 
  amountChecks = c(12,11,11),
  checks = 3, 
  l = 3,
  plotNumber = c(1001,2001,3001),
  exptName = "WINTER_WHEAT_22", 
  locationNames = c("FARGO", "CASSELTON", "MINOT"),
  seed = 130
)

## ----echo=TRUE, eval=FALSE----------------------------------------------------
#  print(optim_expt)

## ----echo=FALSE, eval=TRUE----------------------------------------------------
print(optim_expt)

## ----echo=TRUE, eval=FALSE----------------------------------------------------
#  field_book <- optim_expt$fieldBook
#  head(field_book, 10)

## ----echo=FALSE, eval=TRUE----------------------------------------------------
field_book <- optim_expt$fieldBook
head(field_book, 10)

## ----fig.align='center', fig.width=7.2, fig.height=5.9------------------------
plot(optim_expt)

## ----fig.align='center', fig.width=7.2, fig.height=5.9------------------------
plot(optim_expt, l = 2)

