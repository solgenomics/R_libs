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
rcd <- row_column(
  t = 45,
  nrows = 5,
  r = 3,
  l = 1, 
  plotNumber = 101, 
  locationNames = "FARGO",
  seed = 1244
)

## ----echo=TRUE, eval=FALSE----------------------------------------------------
#  print(rcd)

## ----echo=FALSE, eval=TRUE----------------------------------------------------
print(rcd)

## ----echo=TRUE, eval=FALSE----------------------------------------------------
#  field_book <- rcd$fieldBook
#  head(rcd$fieldBook, 10)

## ----echo=FALSE, eval=TRUE----------------------------------------------------
field_book <- rcd$fieldBook
head(rcd$fieldBook, 10)

## ----fig.align='center', fig.width=7.2, fig.height=5.5------------------------
plot(rcd)

