## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(collapse = TRUE, comment = "#>", out.width = "75%", fig.width = 8, fig.height = 8)
op <- options()
options(show.signif.stars = FALSE, warn = -1, continue = "+    ")
library("equate")

## ----typesmethods, echo = FALSE-----------------------------------------------
knitr::kable(data.frame(type = c("mean", "linear", "general linear", "equipercentile", "circle-arc", "multiple anchors"),
  nominal = c("X", "", "X", "", "X", "X"),
  tucker = c("X", "X", "X", "", "X", "X"),
  levine = c("X", "X", "X", "", "X", ""),
  braun = c("X", "X", "X", "", "X", "X"),
  frequency = c("", "", "", "X", "", "X"),
  chained = c("X", "X", "", "X", "X", "")),
  caption = "Applicable equating types and methods.")

## -----------------------------------------------------------------------------
library("equate")
act.x <- as.freqtab(ACTmath[, 1:2])
act.y <- as.freqtab(ACTmath[, c(1, 3)])

## -----------------------------------------------------------------------------
head(act.x)
rbind(x = summary(act.x), y = summary(act.y))

## -----------------------------------------------------------------------------
neat.x <- freqtab(KBneat$x, scales = list(0:36, 0:12))
neat.y <- freqtab(KBneat$y, scales = list(0:36, 0:12))

## -----------------------------------------------------------------------------
attach(PISA)
r3items <- paste(items$itemid[items$clusterid == "r3a"])
r6items <- paste(items$itemid[items$clusterid == "r6"])
r5items <- paste(items$itemid[items$clusterid == "r5"])
r7items <- paste(items$itemid[items$clusterid == "r7"])
pisa <- freqtab(students[students$book == 6, ],
items = list(c(r3items, r6items), c(r5items, r7items)),
scales = list(0:31, 0:29), design = "sg")
round(data.frame(summary(pisa),
row.names = c("r3r6", "r5r7")), 2)

## ----plotunivar, fig.cap = "Univariate plot of ACTmath total scores for form X."----
plot(x = act.x, lwd = 2, xlab = "Score", ylab = "Count")

## ----plotbivar, fig.cap = "Bivariate plot of KBneat total and anchor distributions."----
plot(neat.x)

## ---- eval = FALSE------------------------------------------------------------
#  presmoothing(~ poly(total, 3, raw = T) + poly(anchor, 3, raw = T) +
#  total:anchor, data = neat.x)

## ---- eval = FALSE------------------------------------------------------------
#  neat.xsf <- with(as.data.frame(neat.x), cbind(total, total^2,
#  total^3, anchor, anchor^2, anchor^3, total*anchor))
#  presmoothing(neat.x, smooth = "loglinear", scorefun = neat.xsf)

## -----------------------------------------------------------------------------
neat.xs <- presmoothing(neat.x, smooth = "log", degrees = list(3, 1))

## ----plotbivarsmooth1, fig.cap = "Bivariate plot of smoothed KBneat total and anchor distributions."----
neat.xsmat <- presmoothing(neat.x, smooth = "loglinear",
degrees = list(3, 1), stepup = TRUE)
plot(neat.xs)

## ----plotbivarsmooth2, fig.cap = "Bivariate plot of KBneat total and anchor distributions with smoothed frequencies superimposed."----
plot(neat.x, neat.xsmat, ylty = 1:5)
round(rbind(x = summary(neat.x), xs = summary(neat.xs)), 2)

## -----------------------------------------------------------------------------
presmoothing(neat.x, smooth = "loglinear",
degrees = list(c(3, 3), c(1, 1)), compare = TRUE)

## -----------------------------------------------------------------------------
equate(act.x, act.y, type = "mean")

## -----------------------------------------------------------------------------
neat.ef <- equate(neat.x, neat.y, type = "equip",
method = "frequency estimation", smoothmethod = "log")

## -----------------------------------------------------------------------------
summary(neat.ef)

## -----------------------------------------------------------------------------
cbind(newx = c(3, 29, 8, 7, 13),
yx = equate(c(3, 29, 8, 7, 13), y = neat.ef))

## -----------------------------------------------------------------------------
head(neat.ef$concordance)

## ----plotcomposite, fig.cap = "Identity, Tucker linear, and a composite of the two functions for equating KBneat."----
neat.i <- equate(neat.x, neat.y, type = "ident")
neat.lt <- equate(neat.x, neat.y, type = "linear",
method = "tucker")
neat.comp <- composite(list(neat.i, neat.lt), wc = .5,
symmetric = TRUE)
plot(neat.comp, addident = FALSE)

## ----plotstudy2, fig.cap = "Five functions linking R3R6 to R5R7."-------------
pisa.i <- equate(pisa, type = "ident", lowp = c(3.5, 2))
pisa.m <- equate(pisa, type = "mean", lowp = c(3.5, 2))
pisa.l <- equate(pisa, type = "linear", lowp = c(3.5, 2))
pisa.c <- equate(pisa, type = "circ", lowp = c(3.5, 2))
pisa.e <- equate(pisa, type = "equip", smooth = "log",
lowp = c(3.5, 2))
plot(pisa.i, pisa.m, pisa.l, pisa.c, pisa.e, addident = FALSE,
xpoints = pisa, morepars = list(ylim = c(0, 31)))

## -----------------------------------------------------------------------------
pisa.x <- freqtab(totals$b4[1:200, c("r3a", "r2", "s2")],
scales = list(0:15, 0:17, 0:18))
pisa.y <- freqtab(totals$b4[201:400, c("r4a", "r2", "s2")],
scales = list(0:16, 0:17, 0:18))

## -----------------------------------------------------------------------------
pisa.mnom <- equate(pisa.x, pisa.y, type = "mean",
method = "nom")
pisa.mtuck <- equate(pisa.x, pisa.y, type = "linear",
method = "tuck")
pisa.mfreq <- equate(pisa.x, pisa.y, type = "equip",
method = "freq", smooth = "loglin")

## -----------------------------------------------------------------------------
pisa.snom <- equate(margin(pisa.x, 1:2), margin(pisa.y, 1:2),
type = "mean", method = "nom")
pisa.stuck <- equate(margin(pisa.x, 1:2), margin(pisa.y, 1:2),
type = "linear", method = "tuck")
pisa.sfreq <- equate(margin(pisa.x, 1:2), margin(pisa.y, 1:2),
type = "equip", method = "freq", smooth = "loglin")

## ----plotstudy3, fig.cap = "Comparing single-anchor and covariate linking with PISA."----
plot(pisa.snom, pisa.stuck, pisa.sfreq,
pisa.mnom, pisa.mtuck, pisa.mfreq,
col = rep(rainbow(3), 2), lty = rep(1:2, each = 3))

## -----------------------------------------------------------------------------
neat.xp <- presmoothing(neat.x, "loglinear", degrees = list(4, 2))
neat.xpmat <- presmoothing(neat.x, "loglinear", degrees = list(4, 2),
stepup = TRUE)
neat.yp <- presmoothing(neat.y, "loglinear", degrees = list(4, 2))
neat.ypmat <- presmoothing(neat.y, "loglinear", degrees = list(4, 2),
stepup = TRUE)

## ----plotstudy1x, fig.cap = "Smoothed population distributions for $X$ used in parametric bootstrapping."----
plot(neat.x, neat.xpmat)

## ----plotstudy1y, fig.cap = "Smoothed population distributions for $Y$ used in parametric bootstrapping."----
plot(neat.y, neat.ypmat)

## -----------------------------------------------------------------------------
set.seed(131031)
reps <- 100
xn <- 100
yn <- 100
crit <- equate(neat.xp, neat.yp, "e", "c")$conc$yx

## -----------------------------------------------------------------------------
neat.args <- list(i = list(type = "i"),
mt = list(type = "mean", method = "t"),
mc = list(type = "mean", method = "c"),
lt = list(type = "lin", method = "t"),
lc = list(type = "lin", method = "c"),
ef = list(type = "equip", method = "f", smooth = "log"),
ec = list(type = "equip", method = "c", smooth = "log"),
ct = list(type = "circ", method = "t"),
cc = list(type = "circ", method = "c", chainmidp = "lin"))
bootout <- bootstrap(x = neat.xp, y = neat.yp, xn = xn, yn = yn,
reps = reps, crit = crit, args = neat.args)

## ----plotstudy1means, fig.cap = "Parametric bootstrapped mean equated scores for eight methods."----
plot(bootout, addident = FALSE, col = c(1, rainbow(8)))

## ----plotstudy1se, fig.cap = "Parametric bootstrapped $SE$ for eight methods."----
plot(bootout, out = "se", addident = FALSE,
col = c(1, rainbow(8)), legendplace = "top")

## ----plotstudy1bias, fig.cap = "Parametric bootstrapped $bias$ for eight methods."----
plot(bootout, out = "bias", addident = FALSE, legendplace = "top",
col = c(1, rainbow(8)), morepars = list(ylim = c(-.9, 3)))

## ----plotstudy1rmse, fig.cap = "Parametric bootstrapped $RMSE$ for eight methods."----
plot(bootout, out = "rmse", addident = FALSE, legendplace = "top",
col = c(1, rainbow(8)), morepars = list(ylim = c(0, 3)))

## -----------------------------------------------------------------------------
round(summary(bootout), 2)

## ---- echo = FALSE------------------------------------------------------------
detach(PISA)
options(op)

