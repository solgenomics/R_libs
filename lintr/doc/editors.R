## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

maybe_still <- function(url) {
  if (pkgdown::in_pkgdown()) {
    url
  } else {
    gsub("\\.gif$", "-still.gif", url)
  }
}

## ---- echo = FALSE, results = 'asis'------------------------------------------
if (!pkgdown::in_pkgdown()) {
  cat(
    "Note: This vignette is best viewed [online](https://lintr.r-lib.org/articles/editors.html),",
    "where we can render full animations of editor flows.\n"
  )
}

