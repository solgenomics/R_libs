## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = NA,
  warning = FALSE, 
  message = FALSE
)

## ----echo = FALSE-------------------------------------------------------------
library(FielDHub)
library(magrittr)
library(knitr)
library(kableExtra)

## ----include = FALSE----------------------------------------------------------
allocation <- data.frame(
  ENV1 = c(1, 0, 1, 1, 1, 1, 1, 0, 1, 1),
  ENV2 = c(1, 1, 1, 1, 1, 1, 0, 1, 1, 1),
  ENV3 = c(1, 1, 0, 1, 1, 0, 1, 1, 1, 1),
  ENV4 = c(1, 1, 1, 1, 1, 1, 1, 1, 0, 0),
  ENV5 = c(0, 1, 1, 0, 0, 1, 1, 1, 1, 1)
  )
 rownames(allocation) <- paste0("Gen-", 1:10)

## ----echo = FALSE-------------------------------------------------------------
allocation %>%
  kbl() %>%
  kable_styling()

## ----eval=FALSE---------------------------------------------------------------
#  FielDHub::run_app()

## ----eval=FALSE---------------------------------------------------------------
#  library(FielDHub)
#  run_app()

## ----include=FALSE------------------------------------------------------------
ENTRY <- 1:9
NAME <- c(c("CHECK1","CHECK2","CHECK3"), c(paste0("Genotype", LETTERS[1:6])))
df <- data.frame(ENTRY,NAME)

## ----echo = FALSE, results='asis'---------------------------------------------
df %>%
  kbl() %>%
  kable_styling()

## ----echo = TRUE--------------------------------------------------------------
library(FielDHub)

## ----echo = TRUE, warning=FALSE, comment=''-----------------------------------
sparse_example <- sparse_allocation(
   lines = 260, 
   l = 5, 
   copies_per_entry = 4, 
   checks = 4, 
   plotNumber = c(1, 1001, 2001, 3001, 4001),
   locationNames = c("FARGO", "CASSELTON", "MINOT", "PROSPER", "WILLISTON"), 
   exptName = "SparseTest2023",
   seed = 16
)

## ----echo=TRUE, eval=FALSE----------------------------------------------------
#  print(head(sparse_example$allocation, 10))

## ----echo=FALSE, eval=TRUE----------------------------------------------------
print(head(sparse_example$allocation, 10))

## ----echo=TRUE, eval=FALSE----------------------------------------------------
#  print(sparse_example)

## ----echo=FALSE, eval=TRUE----------------------------------------------------
print(sparse_example)

## ----echo=TRUE, eval=FALSE----------------------------------------------------
#  field_book <- sparse_example$fieldBook
#  head(field_book, 10)

## ----echo=FALSE, eval=TRUE----------------------------------------------------
field_book <- sparse_example$fieldBook
head(field_book, 10)

## ----fig.align='center', fig.width=7.2, fig.height=5--------------------------
plot(sparse_example, l = 1)

## ----fig.align='center', fig.width=7.2, fig.height=5--------------------------
plot(sparse_example, l = 2)

