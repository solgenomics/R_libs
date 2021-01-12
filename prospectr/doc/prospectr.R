## ----logo, echo = FALSE, out.width = '20%', fig.align = 'right', out.extra='style= "background-color: #FFFFFF; border: 10px solid transparent; padding:0px; display: inline-block; float: right;margin: 50px 0px 0px 20px;"'----
knitr::include_graphics("logo.jpg")

## ----eval = TRUE--------------------------------------------------------------
citation(package = "prospectr")

## ----NIRsoil, tidy = TRUE, message = FALSE------------------------------------
library(prospectr)
data(NIRsoil)
# NIRsoil is a data.frame with 825 obs and 5 variables: 
# Nt (Total Nitrogen), Ciso (Carbon), CEC (Cation Exchange Capacity), 
# train (vector of 0,1 indicating training (1) and validation (0) samples),
# spc (spectral matrix)
str(NIRsoil)

## ----movin, fig.cap = "Effect of a moving average with window size of 11 bands on a raw spectrum", fig.height = 4, fig.width = 6, fig.retina = 1, out.extra='style= "background-color: #FFFFFF; border: 10px solid transparent; padding:0px"'----
# add some noise
noisy <- NIRsoil$spc + rnorm(length(NIRsoil$spc), 0, 0.001) 
# Plot the first spectrum
plot(x = as.numeric(colnames(NIRsoil$spc)),
     y = noisy[1, ],
     type = "l",
     lwd = 1.5,
     xlab = "Wavelength", 
     ylab = "Absorbance") 
X <- movav(X = noisy, w = 11) # window size of 11 bands
# Note that the 5 first and last bands are lost in the process
lines(x = as.numeric(colnames(X)), y = X[1,], lwd = 1.5, col = "red")
grid()
legend("topleft", 
       legend = c("raw", "moving average"), 
       lty = c(1, 1), col = c("black", "red"))

## ----savits, tidy=TRUE--------------------------------------------------------
# p = polynomial order
# w = window size (must be odd)
# m = m-th derivative (0 = smoothing)
# The function accepts vectors, data.frames or matrices.
# For a matrix input, observations should be arranged row-wise
sgvec <- savitzkyGolay(X = NIRsoil$spc[1,], p = 3, w = 11, m = 0) 
sg <- savitzkyGolay(X = NIRsoil$spc, p = 3, w = 11, m = 0) 
# note that bands at the edges of the spectral matrix are lost !
dim(NIRsoil$spc)
dim(sg)

## ----d1,fig.cap="Effect of first derivative and second derivative", fig.height = 4, fig.width = 6, fig.retina = 1, out.extra='style= "background-color: #FFFFFF; border: 10px solid transparent; padding:0px"'----
# X = wavelength
# Y = spectral matrix
# n = order
d1 <- t(diff(t(NIRsoil$spc), differences = 1)) # first derivative
d2 <- t(diff(t(NIRsoil$spc), differences = 2)) # second derivative
plot(as.numeric(colnames(d1)), 
     d1[1,], 
     type = "l", 
     lwd = 1.5, 
     xlab = "Wavelength", 
     ylab = "")
lines(as.numeric(colnames(d2)), d2[1,], lwd = 1.5, col = "red")
grid()
legend("topleft", 
       legend = c("1st der", "2nd der"), 
       lty = c(1, 1),
       col = c("black", "red"))

## ----gapder,fig.cap="Effect of 1st-order gap derivative ", fig.height = 4, fig.width = 6, fig.retina = 1, out.extra='style= "background-color: #FFFFFF; border: 10px solid transparent; padding:0px"'----
# first derivative with a gap of 10 bands
gd1 <- t(diff(t(NIRsoil$spc), differences = 1, lag = 10)) 

## ----gapseg,fig.cap="Effect of 1st-order gap-segment derivative ", fig.height = 4, fig.width = 6, fig.retina = 1, out.extra='style= "background-color: #FFFFFF; border: 10px solid transparent; padding:0px"'----
# m = order of the derivative
# w = window size ( = {2 * gap size} + 1)
# s = segment size
# first derivative with a gap of 10 bands
gsd1 <- gapDer(X = NIRsoil$spc, m = 1, w = 11, s = 10) 
plot(as.numeric(colnames(d1)), 
     d1[1,], 
     type = "l", 
     lwd = 1.5, 
     xlab = "Wavelength", 
     ylab = "")
lines(as.numeric(colnames(gsd1)), gsd1[1,], lwd = 1.5, col = "red")
grid()
legend("topleft",
       legend = c("1st der","gap-segment 1st der"), 
       lty = c(1,1), 
       col = c("black", "red"))

## ----snv, eval=TRUE, fig.cap="Effect of SNV on raw spectra", fig.height = 4, fig.width = 6, fig.retina = 1, out.extra='style= "background-color: #FFFFFF; border: 10px solid transparent; padding:0px"'----
snv <- standardNormalVariate(X = NIRsoil$spc)

## ----msc, fig.cap="Effect of MSC on raw spectra", fig.height = 4, fig.width = 6, fig.retina = 1, out.extra='style= "background-color: #FFFFFF; border: 10px solid transparent; padding:0px"'----
# X = input spectral matrix
msc_spc <- msc(X = NIRsoil$spc, reference_spc = colMeans(NIRsoil$spc))

plot(as.numeric(colnames(NIRsoil$spc)), 
     NIRsoil$spc[1,], 
     type = "l", 
     xlab = "Wavelength, nm", ylab = "Absorbance", 
     lwd = 1.5)
lines(as.numeric(colnames(NIRsoil$spc)), 
      msc_spc[1,], 
      lwd = 1.5, col = "red")
axis(4, col = "red")
grid()
legend("topleft", 
       legend = c("raw", "MSC signal"), 
       lty = c(1, 1),
       col = c("black", "red"))
par(new = FALSE)

## ----eval = FALSE-------------------------------------------------------------
#  # a reference set of spectra
#  Xr <- NIRsoil$spc[NIRsoil$train == 1, ]
#  
#  # an "unseen" set of spectra
#  Xu <- NIRsoil$spc[NIRsoil$train == 0, ]
#  
#  # apply msc to Xr
#  Xr_msc <- msc(Xr)
#  
#  # apply the same msc to Xu
#  attr(Xr_msc,"Reference spectrum") # use this info from the previous object
#  
#  Xu_msc <- msc(Xu, reference_spc = attr(Xr_msc, "Reference spectrum"))

## ----detrend, fig.cap="Effect of SNV-Detrend on raw spectra",fig.height = 4, fig.width = 6, fig.retina = 1, out.extra='style= "background-color: #FFFFFF; border: 10px solid transparent; padding:0px"'----
# X = input spectral matrix
# wav = band centers
dt <- detrend(X = NIRsoil$spc, wav = as.numeric(colnames(NIRsoil$spc)))
plot(as.numeric(colnames(NIRsoil$spc)), 
     NIRsoil$spc[1,], 
     type = "l", 
     xlab = "Wavelength", 
     ylab = "Absorbance", 
     lwd = 1.5)
par(new = TRUE)
plot(dt[1,], 
     xaxt = "n", 
     yaxt = "n",
     xlab = "", 
     ylab = "", 
     lwd = 1.5, 
     col = "red", 
     type = "l")
axis(4, col = "red")
grid()
legend("topleft", 
       legend = c("raw", "detrend signal"), 
       lty = c(1, 1),
       col = c("black", "red"))
par(new = FALSE)

## ----bscale, tidy = TRUE------------------------------------------------------
# X = spectral matrix
# type = "soft" or "hard"
# The ouptut is a list with the scaled matrix (Xscaled) and the divisor (f)
bs <- blockScale(X = NIRsoil$spc, type = "hard")$Xscaled
sum(apply(bs, 2, var)) # this works!

## ----bnorm, tidy = TRUE-------------------------------------------------------
# X = spectral matrix
# targetnorm = desired norm for X
bn <- blockNorm(X = NIRsoil$spc,targetnorm = 1)$Xscaled
sum(bn^2) # this works!

## ----cr, fig.cap = "Absorbance and continuum-removed absorbance spectra", fig.height = 4, fig.width = 6, fig.retina = 1, out.extra='style= "background-color: #FFFFFF; border: 10px solid transparent; padding:0px"'----
# type of data: 'R' for reflectance (default), 'A' for absorbance
cr <- continuumRemoval(X = NIRsoil$spc, type = "A")
# plot of the 10 first abs spectra
matplot(as.numeric(colnames(NIRsoil$spc)),
        t(NIRsoil$spc[1:3,]),
        type = "l",
        lty = 1,
        ylim = c(0,.6),
        xlab="Wavelength /nm", 
        ylab="Absorbance")
matlines(as.numeric(colnames(NIRsoil$spc)), lty = 1, t(cr[1:3, ]))
grid()

## ----naes, fig.cap = "Selection of 5 samples by k-means sampling", fig.height = 4.5, fig.width = 4, fig.retina = 1, fig.align ='center', out.extra='style= "background-color: #FFFFFF; border: 10px solid transparent; padding:0px"'----
# X = the input matrix
# k = number of calibration samples to be selected
# pc = if pc is specified, k-mean is performed in the pc space 
# (here we will use only the two 1st pcs)
# iter.max =  maximum number of iterations allowed for the k-means clustering.
kms <- naes(X = NIRsoil$spc, k = 5, pc = 2, iter.max = 100)
# Plot the pcs scores and clusters
plot(kms$pc, col = rgb(0, 0, 0, 0.3), pch = 19, main = "k-means") 
grid()
# Add the selected points
points(kms$pc[kms$model, ], col = "red", pch = 19)

## ----ken, fig.cap="Selection of 40 calibration samples with the Kennard-Stone algorithm", fig.height = 4.5, fig.width = 4, fig.retina = 1, fig.align ='center', out.extra='style= "background-color: #FFFFFF; border: 10px solid transparent; padding:0px"'----
# Create a dataset for illustrating how the calibration sampling 
# algorithms work
X <- data.frame(x1 = rnorm(1000), x2 = rnorm(1000))
plot(X, col = rgb(0, 0, 0, 0.3), pch = 19, main = "Kennard-Stone (synthetic)") 
grid()
# kenStone produces a list with row index of the points selected for calibration
ken <- kenStone(X, k = 40) 
# plot selected points
points(X[ken$model,], col = "red", pch = 19, cex = 1.4) 

## ----ken2, fig.cap="Kennard-Stone sampling on the NIRsoil dataset", fig.height = 4.5, fig.width = 4, fig.retina = 1, fig.align = 'center', out.extra='style= "background-color: #FFFFFF; border: 10px solid transparent; padding:0px"'----

# Test with the NIRsoil dataset
# one can also use the mahalanobis distance (metric argument)
# computed in the pc space (pc argument)
ken_mahal <- kenStone(X = NIRsoil$spc, k = 20, metric = "mahal", pc= 2)
# The pc components in the output list stores the pc scores
plot(ken_mahal$pc[,1], 
     ken_mahal$pc[,2], 
     col = rgb(0, 0, 0, 0.3), 
     pch = 19, 
     xlab = "PC1",
     ylab = "PC2",
     main = "Kennard-Stone") 
grid()
# This is the selected points in the pc space
points(ken_mahal$pc[ken_mahal$model, 1], 
       ken_mahal$pc[ken_mahal$model,2], 
       pch = 19, col = "red") 

## ----duplex, fig.cap="Selection of 15 calibration and validation samples with the DUPLEX algorithm", fig.height = 4.5, fig.width = 4, fig.retina = 1, fig.align = 'center', out.extra='style= "background-color: #FFFFFF; border: 10px solid transparent; padding:0px"'----
dup <- duplex(X = X, k = 15) # k is the number of selected samples
plot(X, col = rgb(0, 0, 0, 0.3), pch = 19, main = "DUPLEX") 
grid()
# calibration samples
points(X[dup$model, 1], X[dup$model, 2], col = "red", pch = 19) 
# validation samples
points(X[dup$test,1], X[dup$test,2], col = "dodgerblue", pch = 19) 
legend("topright", 
       legend = c("calibration", "validation"), 
       pch = 19, 
       col = c("red", "dodgerblue"))

## ----shenk, fig.cap="Selection of samples with the SELECT algorithm", fig.height = 4.5, fig.width = 4, fig.retina = 1, fig.align = 'center', out.extra='style= "background-color: #FFFFFF; border: 10px solid transparent; padding:0px"'----
shenk <- shenkWest(X = NIRsoil$spc, d.min = 0.6, pc = 2)
plot(shenk$pc, col = rgb(0, 0, 0, 0.3), pch = 19, main = "SELECT") 
grid()
points(shenk$pc[shenk$model,], col = "red", pch = 19)

## ----puchwein, fig.cap="Samples selected by the Puchwein algorithm", fig.height = 4.5, fig.width = 4, fig.retina = 1, fig.align = 'center', out.extra='style= "background-color: #FFFFFF; border: 10px solid transparent; padding:0px"'----
pu <- puchwein(X = NIRsoil$spc, k = 0.2, pc =2)
plot(pu$pc, col = rgb(0, 0, 0, 0.3), pch = 19, main = "puchwein") 
grid()
points(pu$pc[pu$model,],col = "red", pch = 19) # selected samples

## ----puchwein2, fig.cap="How to find the optimal loop", eval = FALSE----------
#  par(mfrow = c(2, 1))
#  plot(pu$leverage$removed,pu$leverage$diff,
#       type = "l",
#       xlab = "# samples removed",
#       ylab="Difference between th. and obs sum of leverages")
#  # This basically shows that the first loop is optimal
#  plot(pu$leverage$loop,nrow(NIRsoil) - pu$leverage$removed,
#       xlab = "# loops",
#       ylab = "# samples kept", type = "l")
#  par(mfrow = c(1, 1))

## ----honigs, fig.cap="Spectra selected with the Honigs algorithm and bands used", fig.height = 4.5, fig.width = 4, fig.retina = 1, fig.align = 'center', out.extra='style= "background-color: #FFFFFF; border: 10px solid transparent; padding:0px"'----
# type = "A" is for absorbance data
ho <- honigs(X = NIRsoil$spc, k = 10, type = "A") 
# plot calibration spectra
matplot(as.numeric(colnames(NIRsoil$spc)),
        t(NIRsoil$spc[ho$model,]),
        type = "l",
        xlab = "Wavelength", ylab = "Absorbance")
# add bands used during the selection process
abline(v = as.numeric(colnames(NIRsoil$spc))[ho$bands], lty = 2)

