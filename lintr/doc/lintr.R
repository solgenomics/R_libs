## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ---- echo = FALSE------------------------------------------------------------
default_settings <- lintr::default_settings
default_settings$linters <- "`lintr::default_linters`"
default_settings$comment_token <- "(lintr-bot comment token for automatic GitHub comments)"
default_settings$exclusions <- "(empty)"

make_string <- function(x) {
  if (inherits(x, "regex")) {
    paste0("regex: `", x, "`")
  } else {
    as.character(x)
  }
}

defaults_table <- data.frame(
  default = vapply(default_settings, make_string, character(1L)),
  stringsAsFactors = FALSE
)

knitr::kable(defaults_table)

## ---- echo = FALSE------------------------------------------------------------
default_linters <- lintr::default_linters
linters_with_args <- lapply(
  setNames(nm = intersect(names(default_linters), lintr::available_linters(tags = "configurable")$linter)),
  function(linter_name) {
    names(formals(get(linter_name, envir = asNamespace("lintr"))))
  }
)

make_setting_string <- function(linter_name) {
  args <- linters_with_args[[linter_name]]
  if (is.null(args)) return("")

  arglist <- vapply(args, function(arg) {
    env <- environment(default_linters[[linter_name]])
    deparse(env[[arg]])
  }, character(1L))

  paste0(args, " = ", arglist, collapse = ", ")
}

defaults_table <- data.frame(
  row.names = names(default_linters),
  settings = vapply(names(default_linters), make_setting_string, character(1L)),
  stringsAsFactors = FALSE
)

knitr::kable(defaults_table)

## ----programmatic_lintr-------------------------------------------------------
library(lintr)
linter_name <- "assignment_linter"

withr::with_tempfile("tmp", {
  writeLines("a = 1", tmp)

  # linter column is just 'get'
  print(as.data.frame(lint(tmp, linters = get(linter_name)())))

  this_linter <- get(linter_name)()
  attr(this_linter, "name") <- linter_name
  # linter column is 'assignment_linter'
  print(as.data.frame(lint(tmp, linters = this_linter)))

  # more concise alternative: use eval(call(.))
  print(as.data.frame(lint(tmp, linters = eval(call(linter_name)))))
})

## ---- echo = FALSE------------------------------------------------------------
lintr::lint("X = 42L # -------------- this comment overflows the default 80 chars line length.\n",
            parse_settings = FALSE)

## ---- echo = FALSE------------------------------------------------------------
lintr::lint("X = 42L # nolint ------ this comment overflows the default 80 chars line length.\n",
            parse_settings = FALSE)

## ---- echo = FALSE------------------------------------------------------------
lintr::lint("X = 42L # nolint: object_name_linter. this comment overflows the default 80 chars line length.\n",
            parse_settings = FALSE)

## ---- echo = FALSE------------------------------------------------------------
lintr::lint(
  paste(
    "X = 42L",
    "# nolint: object_name_linter, line_length_linter. this comment overflows the default 80 chars line length.\n"
  ),
  parse_settings = FALSE
)

## ---- echo = FALSE------------------------------------------------------------
lintr::lint(
  paste(
    "X = 42L",
    "# nolint: object_name, line_len. this comment still overflows the default 80 chars line length.\n"
  ),
  parse_settings = FALSE
)

## ---- echo = FALSE------------------------------------------------------------
lintr::lint("# x <- 42L\n# print(x)\n", parse_settings = FALSE)

## ---- echo = FALSE------------------------------------------------------------
lintr::lint("# nolint start: commented_code_linter.\n# x <- 42L\n# print(x)\n# nolint end\n",
            parse_settings = FALSE)

