### R code from vignette source 'using_tinytest.Rnw'

###################################################
### code chunk number 1: using_tinytest.Rnw:79-83
###################################################
options(prompt="R>  ",
        continue = "    ",
        width=75,
        tt.pr.color=FALSE)


###################################################
### code chunk number 2: using_tinytest.Rnw:108-114
###################################################
lbs2kg <- function(x){
  if ( x < 0 ){
    stop(sprintf("Expected nonnegative weight, got %g",x))
  }
  x/2.20
}


###################################################
### code chunk number 3: using_tinytest.Rnw:117-120
###################################################
library(tinytest)
expect_equal(lbs2kg(1), 1/2.2046)
expect_error(lbs2kg(-3))


###################################################
### code chunk number 4: using_tinytest.Rnw:126-127
###################################################
isTRUE( expect_true(2 == 1 + 1) )


###################################################
### code chunk number 5: using_tinytest.Rnw:152-154
###################################################
expect_error(lbs2kg(-3), pattern="nonnegative")
expect_error(lbs2kg(-3), pattern="foo")


###################################################
### code chunk number 6: using_tinytest.Rnw:168-169
###################################################
expect_false( 1 + 1 == 2, info="My personal message to the tester" )


###################################################
### code chunk number 7: using_tinytest.Rnw:200-201
###################################################
print(expect_equal(1+1, 3), type="short")


###################################################
### code chunk number 8: eval
###################################################
run_test_file("test_addOne.R", verbose=0)


###################################################
### code chunk number 9: using_tinytest.Rnw:247-249
###################################################
test_results <- run_test_file("test_addOne.R", verbose=0)
print(test_results, passes=TRUE)


###################################################
### code chunk number 10: using_tinytest.Rnw:252-253 (eval = FALSE)
###################################################
## options(tt.pr.passes=TRUE)


###################################################
### code chunk number 11: using_tinytest.Rnw:259-260 (eval = FALSE)
###################################################
## run_test_dir("/path/to/your/test/directory")


###################################################
### code chunk number 12: using_tinytest.Rnw:267-269
###################################################
out <- run_test_dir(system.file("tinytest", package="tinytest")
       , verbose=0)


###################################################
### code chunk number 13: using_tinytest.Rnw:273-274
###################################################
head(as.data.frame(out), 3)


###################################################
### code chunk number 14: using_tinytest.Rnw:280-281
###################################################
summary(out)


###################################################
### code chunk number 15: using_tinytest.Rnw:291-294 (eval = FALSE)
###################################################
## if ( expect_equal(1 + 1, 2) ){
##     expect_true( 2 > 0)
## }


###################################################
### code chunk number 16: using_tinytest.Rnw:304-307
###################################################
if ( ignore(expect_equal)(1+1, 2) ){
  expect_true(2>0)
}


###################################################
### code chunk number 17: using_tinytest.Rnw:315-318
###################################################
if ( Sys.info()[['sysname']] == "Windows"){
  exit_file("Cannot test this on Windows")
}


###################################################
### code chunk number 18: using_tinytest.Rnw:344-350 (eval = FALSE)
###################################################
## run_test_dir("/path/to/my/testdir"
##            , remove_side_effects = FALSE)
## test_all("/path/to/my/testdir"
##            , remove_side_effects = FALSE)
## # Only in tests/tinytest.R:
## test_package("PACKAGENAME", remove_side_effects=FALSE)


###################################################
### code chunk number 19: using_tinytest.Rnw:357-358 (eval = FALSE)
###################################################
## options(tt.collate="C")


###################################################
### code chunk number 20: using_tinytest.Rnw:374-375 (eval = FALSE)
###################################################
## test_package("pkg", side_effects=TRUE)


###################################################
### code chunk number 21: using_tinytest.Rnw:379-380 (eval = FALSE)
###################################################
## test_package("pkg", side_effects=list(pwd=FALSE))


###################################################
### code chunk number 22: using_tinytest.Rnw:409-410
###################################################
run_test_file("test_se.R", verbose=1)


###################################################
### code chunk number 23: using_tinytest.Rnw:456-457 (eval = FALSE)
###################################################
## setup_tinytest("/path/to/your/package")


###################################################
### code chunk number 24: using_tinytest.Rnw:470-471 (eval = FALSE)
###################################################
## test_all("/path/to/your/package")


###################################################
### code chunk number 25: using_tinytest.Rnw:482-483 (eval = FALSE)
###################################################
##   build_install_test("/path/to/your/package")


###################################################
### code chunk number 26: using_tinytest.Rnw:503-505 (eval = FALSE)
###################################################
## output = pkg:::some_internal_function(1)
## expect_equal(output, 2)


###################################################
### code chunk number 27: using_tinytest.Rnw:555-557 (eval = FALSE)
###################################################
## dat <- read.csv("women.csv")
## expect_equal(dat, women)


###################################################
### code chunk number 28: using_tinytest.Rnw:569-570
###################################################
options(prompt="  ", continue="  ")


###################################################
### code chunk number 29: using_tinytest.Rnw:572-577 (eval = FALSE)
###################################################
## # contents of pkgdir/tests/tinytest.R
## if ( requireNamespace("tinytest", quietly=TRUE) ){
##    home <- identical( Sys.info()["nodename"], "YOURHOSTNAME" )
##    tinytest::test_package("PKGNAME", at_home = home)
## }


###################################################
### code chunk number 30: using_tinytest.Rnw:582-583
###################################################
home <- identical( Sys.getenv("HONEYIMHOME"), "TRUE" )


###################################################
### code chunk number 31: using_tinytest.Rnw:587-588 (eval = FALSE)
###################################################
## home <- length(unclass(packageVersion("PKGNAME"))[[1]]) == 4


###################################################
### code chunk number 32: using_tinytest.Rnw:592-593
###################################################
options(prompt="R> ", continue="   ")


###################################################
### code chunk number 33: using_tinytest.Rnw:600-602
###################################################
run_test_file("test_hehe.R", verbose=0)
run_test_file("test_hehe.R", verbose=0, at_home=FALSE)


###################################################
### code chunk number 34: using_tinytest.Rnw:626-627 (eval = FALSE)
###################################################
## tinytest::test_package("hehe")


###################################################
### code chunk number 35: using_tinytest.Rnw:669-676 (eval = FALSE)
###################################################
## require(dittodb)
## with_mock_path(
##     system.file("<path-to-your-mocks>", package = "myPackage"),
##     with_mock_db({
##     # <unit tests which rely on database connections>
##     })
## )


###################################################
### code chunk number 36: using_tinytest.Rnw:687-688 (eval = FALSE)
###################################################
## test_package("tinytest", set_env = list(WA_BABALOOBA="BA_LA_BAMBOO"))


###################################################
### code chunk number 37: using_tinytest.Rnw:718-719 (eval = FALSE)
###################################################
## build_install_test("/path/to/your/package", ncpu=2)


###################################################
### code chunk number 38: using_tinytest.Rnw:730-731 (eval = FALSE)
###################################################
## test_package("PACKAGENAME", ncpu=2)


###################################################
### code chunk number 39: using_tinytest.Rnw:753-756 (eval = FALSE)
###################################################
## cl <- parallel::makeCluster(4, outfile="")
## parallel::clusterCall(cl, source, "R/myfunctions.R")
## run_test_dir("inst/tinytest", cluster=cl)


###################################################
### code chunk number 40: using_tinytest.Rnw:763-766 (eval = FALSE)
###################################################
## parallel::clusterCall(cl, source, "R/myfunctions.R")
## test_all(cluster=cl)
## stopCluster(cl)


###################################################
### code chunk number 41: using_tinytest.Rnw:801-810
###################################################
# exported, user-visible function
inch2cm <- function(x){
  x*conversion_factor("inch")
}
# not exported function, package-internal
conversion_factor <- function(unit){
  confac <- c(inch=2.54, pound=1/2.2056)
  confac[unit]
}


###################################################
### code chunk number 42: using_tinytest.Rnw:853-861
###################################################
pound2kg <- function(x){
  stopifnot( is.numeric(x) )
  if ( any(x < 0) ){
    warning("Found negative input, converting to positive")
    x <- abs(x)
  }
  x/2.2046
}


###################################################
### code chunk number 43: using_tinytest.Rnw:880-886 (eval = FALSE)
###################################################
##     expect_equal(pound2kg(1), 1/2.2046  )
##     # test for expected warning, store output
##     expect_warning( out <- pound2kg(-1) )
##     # test the output
##     expect_equal( out, 1/2.2046)
##     expect_error(pound2kg("foo"))


###################################################
### code chunk number 44: using_tinytest.Rnw:931-937
###################################################
bad_function <- function(file){
  oldwd <- getwd()
  setwd(dirname(file))
  source(basename(file))
  setwd(oldwd)
}


###################################################
### code chunk number 45: using_tinytest.Rnw:944-950
###################################################
good_function <- function(file){
  oldwd <- getwd()
  on.exit(setwd(oldwd))
  setwd(dirname(file))
  source(basename(file))
}


