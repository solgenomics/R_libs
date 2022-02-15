### R code from vignette source 'filterVcf.Rnw'

###################################################
### code chunk number 1: style-Sweave
###################################################
BiocStyle::latex()


###################################################
### code chunk number 2: prefilters
###################################################
isGermlinePrefilter <- function(x) {
    grepl("Germline", x, fixed=TRUE)
}

notInDbsnpPrefilter <- function(x) {
    !(grepl("dbsnp", x, fixed=TRUE))
}


###################################################
### code chunk number 3: filters
###################################################
## We will use isSNV() to filter only SNVs

allelicDepth <- function(x) {
    ##  ratio of AD of the "alternate allele" for the tumor sample
    ##  OR "reference allele" for normal samples to total reads for
    ##  the sample should be greater than some threshold (say 0.1,
    ##  that is: at least 10% of the sample should have the allele
    ##  of interest)
    ad <- geno(x)$AD
    tumorPct <- ad[,1,2,drop=FALSE] / rowSums(ad[,1,,drop=FALSE])
    normPct <- ad[,2,1, drop=FALSE] / rowSums(ad[,2,,drop=FALSE])
    test <- (tumorPct > 0.1) | (normPct > 0.1)
    as.vector(!is.na(test) & test)
}


###################################################
### code chunk number 4: createFilterRules
###################################################
library(VariantAnnotation)
prefilters <- FilterRules(list(germline=isGermlinePrefilter, 
                               dbsnp=notInDbsnpPrefilter))
filters <- FilterRules(list(isSNV=isSNV, AD=allelicDepth))


###################################################
### code chunk number 5: createFilteredFile
###################################################
file.gz     <- system.file("extdata", "chr7-sub.vcf.gz", 
                           package="VariantAnnotation")
file.gz.tbi <- system.file("extdata", "chr7-sub.vcf.gz.tbi", 
                           package="VariantAnnotation")
destination.file <- tempfile()
tabix.file <- TabixFile(file.gz, yieldSize=10000)
filterVcf(tabix.file,  "hg19", destination.file,
          prefilters=prefilters, filters=filters, verbose=TRUE)


###################################################
### code chunk number 6: mcf7regulatoryRegions
###################################################
library(AnnotationHub)
hub <- AnnotationHub()
id <- names(query(hub, "wgEncodeUwTfbsMcf7CtcfStdPkRep1.narrowPeak"))
mcf7.gr <- hub[[tail(id, 1)]]


###################################################
### code chunk number 7: findOverlaps
###################################################
vcf <- readVcf(destination.file, "hg19")
seqlevels(vcf) <- paste("chr", seqlevels(vcf), sep="")
ov.mcf7 <- findOverlaps(vcf, mcf7.gr)


###################################################
### code chunk number 8: locateVariant
###################################################
library(TxDb.Hsapiens.UCSC.hg19.knownGene)
txdb <- TxDb.Hsapiens.UCSC.hg19.knownGene 
locateVariants(vcf[6,], txdb, AllVariants())


