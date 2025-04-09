## ----include = FALSE----------------------------------------------------------
options(rmarkdown.html_vignette.check_title = FALSE)
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = NA,
  warning = FALSE, 
  message = FALSE
)

## ----echo = FALSE-------------------------------------------------------------
library(FielDHub)
library(dplyr)
library(knitr)
library(kableExtra)

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
ENTRY <- 1:10
NAME <- c(paste0("Genotype", 1:10))
df <- data.frame(ENTRY,NAME)

## ----echo = FALSE, results='asis'---------------------------------------------
df |>
  kbl() |>
  kable_styling()

## ----echo = TRUE--------------------------------------------------------------
library(FielDHub)

## ----echo = TRUE--------------------------------------------------------------
optim_multi_prep <- multi_location_prep(
  lines = 150, 
  l = 5, 
  copies_per_entry = 7, 
  checks = 3,
  rep_checks = c(6,6,6),
  plotNumber = c(1,1001,2001,3001,4001),
  locationNames = c("LOC1", "LOC2", "LOC3", "LOC4", "LOC5"),
  seed = 2456
)

## ----echo=TRUE, eval=FALSE----------------------------------------------------
#  print(head(optim_multi_prep$allocation, 10))

## ----echo=FALSE, eval=TRUE----------------------------------------------------
print(head(optim_multi_prep$allocation, 10))

## ----echo=FALSE, eval=TRUE----------------------------------------------------
optim_multi_prep$allocation |>
  dplyr::mutate(
    Copies = rowSums(across(everything())),
    Avg = Copies / 5
  ) |>
    head(10) |>
    `rownames<-`(paste0("Gen-", 1:10)) |>
    kbl() |>
    kable_styling()

## ----echo=TRUE, eval=FALSE----------------------------------------------------
#  print(optim_multi_prep)

## ----echo=FALSE, eval=TRUE----------------------------------------------------
print(optim_multi_prep)

## ----echo=TRUE, eval=FALSE----------------------------------------------------
#  field_book <- optim_multi_prep$fieldBook
#  head(field_book, 10)

## ----echo=FALSE, eval=TRUE----------------------------------------------------
field_book <- optim_multi_prep$fieldBook
head(field_book, 10)

## ----fig.align='center', fig.width=7.2, fig.height=5.5------------------------
plot(optim_multi_prep, l = 1)

## ----fig.align='center', fig.width=7.2, fig.height=5.5------------------------
plot(optim_multi_prep, l = 5)

