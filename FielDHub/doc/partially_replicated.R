## ----include = FALSE----------------------------------------------------------
options(rmarkdown.html_vignette.check_title = FALSE)
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = NA,
  warning = FALSE, 
  message = FALSE
)

## ----echo=FALSE, eval=TRUE----------------------------------------------------
set.seed(123)
X <- matrix(sample(c(rep(1:10, 2), 11:50), replace = FALSE), ncol = 10)
X[2,2] <- 5
X[2,3] <- 33
print(X)

## ----echo=FALSE, eval=TRUE----------------------------------------------------
dist_X <- FielDHub:::pairs_distance(X = X)
print(dist_X)

## -----------------------------------------------------------------------------
library(FielDHub)
B <- swap_pairs(X, starting_dist = 3)

## -----------------------------------------------------------------------------
print(B$optim_design)

## -----------------------------------------------------------------------------
print(B$pairwise_distance)

## ----eval=FALSE---------------------------------------------------------------
#  FielDHub::run_app()

## ----eval=FALSE---------------------------------------------------------------
#  library(FielDHub)
#  run_app()

## ----include=FALSE------------------------------------------------------------
ENTRY <- 1:12
NAME <- c(paste0("Genotype", LETTERS[1:12]))
REPS <- c(rep(2,4),rep(1,8))
df <- data.frame(ENTRY,NAME,REPS)

## ----echo = FALSE, results='asis'---------------------------------------------
library(knitr)
kable(df)

## ----echo = TRUE--------------------------------------------------------------
library(FielDHub)

## ----echo = TRUE--------------------------------------------------------------
prep <- partially_replicated(
  nrows = 15,
  ncols = 20, 
  repGens = c(75,150),
  repUnits = c(2,1), 
  planter = "serpentine", 
  plotNumber = 101,
  l = 1, 
  exptName = "Expt1",
  locationNames = "PALMIRA",
  seed = 1245, 
)

## ----echo=TRUE, eval=FALSE----------------------------------------------------
#  print(prep)

## ----echo=FALSE, eval=TRUE----------------------------------------------------
print(prep)

## ----echo=TRUE, eval=FALSE----------------------------------------------------
#  field_book <- prep$fieldBook
#  head(field_book, 10)

## ----echo=FALSE, eval=TRUE----------------------------------------------------
field_book <- prep$fieldBook
head(field_book, 10)

## ----fig.align='center', fig.width=7.2, fig.height=5.5------------------------
plot(prep)

