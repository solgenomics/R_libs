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

## ----include = FALSE----------------------------------------------------------
wp <- LETTERS[1:5]
sp <-  1:3           
df <- data.frame(list(WHOLEPLOT = wp, SUBPLOT = c(sp, rep("", 2))))

## ----echo = FALSE, results='asis'---------------------------------------------
library(knitr)
kable(df)

## ----echo = TRUE--------------------------------------------------------------
library(FielDHub)

## ----echo=TRUE----------------------------------------------------------------
spd <- split_plot(
  wp = 5,
  sp = 3,
  reps = 4, 
  type = 2, 
  plotNumber = 101, 
  locationNames = "FARGO",
  l = 1,
  seed = 1240
) 

## ----echo=TRUE, eval=FALSE----------------------------------------------------
#  print(spd)

## ----echo=FALSE, eval=TRUE----------------------------------------------------
print(spd)

## ----echo=TRUE, eval=FALSE----------------------------------------------------
#  field_book <- spd$fieldBook
#  head(spd$fieldBook, 10)

## ----echo=FALSE, eval=TRUE----------------------------------------------------
field_book <- spd$fieldBook
head(spd$fieldBook, 10)

## ----fig.align='center', fig.width=7.2, fig.height=5.5------------------------
plot(spd)

