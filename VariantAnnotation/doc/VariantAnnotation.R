### R code from vignette source 'VariantAnnotation.Rnw'

###################################################
### code chunk number 1: style
###################################################
BiocStyle::latex()


###################################################
### code chunk number 2: options
###################################################
options(width=72)


###################################################
### code chunk number 3: readVcf
###################################################
library(VariantAnnotation)
fl <- system.file("extdata", "chr22.vcf.gz", package="VariantAnnotation")
vcf <- readVcf(fl, "hg19")
vcf


###################################################
### code chunk number 4: readVcf_showheader
###################################################
header(vcf)


###################################################
### code chunk number 5: headeraccessors
###################################################
samples(header(vcf))
geno(header(vcf))


###################################################
### code chunk number 6: readVcf_rowRanges
###################################################
head(rowRanges(vcf), 3)


###################################################
### code chunk number 7: readVcf_fixed
###################################################
ref(vcf)[1:5]
qual(vcf)[1:5]


###################################################
### code chunk number 8: readVcf_ALT
###################################################
alt(vcf)[1:5]


###################################################
### code chunk number 9: geno_hdr
###################################################
geno(vcf)
sapply(geno(vcf), class)


###################################################
### code chunk number 10: explore_geno
###################################################
geno(header(vcf))["DS",]


###################################################
### code chunk number 11: dim_geno
###################################################
DS <-geno(vcf)$DS
dim(DS)
DS[1:3,]


###################################################
### code chunk number 12: fivenum
###################################################
fivenum(DS)


###################################################
### code chunk number 13: DS_zero
###################################################
length(which(DS==0))/length(DS)


###################################################
### code chunk number 14: DS_hist
###################################################
hist(DS[DS != 0], breaks=seq(0, 2, by=0.05), 
    main="DS non-zero values", xlab="DS")


###################################################
### code chunk number 15: info
###################################################
info(vcf)[1:4, 1:5]


###################################################
### code chunk number 16: examine_dbSNP
###################################################
library(SNPlocs.Hsapiens.dbSNP.20101109)
rd <- rowRanges(vcf)
seqlevels(rd) <- "ch22"
ch22snps <- getSNPlocs("ch22")
dbsnpchr22 <- sub("rs", "", names(rd)) %in% ch22snps$RefSNP_id
table(dbsnpchr22)


###################################################
### code chunk number 17: header_info
###################################################
info(header(vcf))[c("VT", "LDAF", "RSQ"),]


###################################################
### code chunk number 18: examine_quality
###################################################
metrics <- data.frame(QUAL=qual(vcf), inDbSNP=dbsnpchr22,
    VT=info(vcf)$VT, LDAF=info(vcf)$LDAF, RSQ=info(vcf)$RSQ)


###################################################
### code chunk number 19: examine_ggplot2
###################################################
library(ggplot2)
ggplot(metrics, aes(x=RSQ, fill=inDbSNP)) +
    geom_density(alpha=0.5) +
    scale_x_continuous(name="MaCH / Thunder Imputation Quality") +
    scale_y_continuous(name="Density") +
    theme(legend.position="top")


###################################################
### code chunk number 20: subset_ranges
###################################################
rng <- GRanges(seqnames="22", ranges=IRanges(
           start=c(50301422, 50989541), 
           end=c(50312106, 51001328),
           names=c("gene_79087", "gene_644186")))


###################################################
### code chunk number 21: subset_TabixFile
###################################################
tab <- TabixFile(fl)
vcf_rng <- readVcf(tab, "hg19", param=rng)


###################################################
### code chunk number 22: VariantAnnotation.Rnw:211-212
###################################################
head(rowRanges(vcf_rng), 3)


###################################################
### code chunk number 23: subset_scanVcfHeader
###################################################
hdr <- scanVcfHeader(fl)
## e.g., INFO and GENO fields
head(info(hdr), 3)
head(geno(hdr), 3)


###################################################
### code chunk number 24: subset_ScanVcfParam
###################################################
## Return all 'fixed' fields, "LAF" from 'info' and "GT" from 'geno'
svp <- ScanVcfParam(info="LDAF", geno="GT")
vcf1 <- readVcf(fl, "hg19", svp)
names(geno(vcf1))


###################################################
### code chunk number 25: subset_ScanVcfParam_new
###################################################
svp_all <- ScanVcfParam(info="LDAF", geno="GT", which=rng) 
svp_all


###################################################
### code chunk number 26: locate_rename_seqlevels
###################################################
library(TxDb.Hsapiens.UCSC.hg19.knownGene)
txdb <- TxDb.Hsapiens.UCSC.hg19.knownGene
seqlevels(vcf) <- "chr22"
rd <- rowRanges(vcf)
loc <- locateVariants(rd, txdb, CodingVariants())
head(loc, 3)


###################################################
### code chunk number 27: AllVariants (eval = FALSE)
###################################################
## allvar <- locateVariants(rd, txdb, AllVariants())


###################################################
### code chunk number 28: locate_gene_centric
###################################################
## Did any coding variants match more than one gene?
splt <- split(mcols(loc)$GENEID, mcols(loc)$QUERYID) 
table(sapply(splt, function(x) length(unique(x)) > 1))

## Summarize the number of coding variants by gene ID.
splt <- split(mcols(loc)$QUERYID, mcols(loc)$GENEID)
head(sapply(splt, function(x) length(unique(x))), 3)


###################################################
### code chunk number 29: predictCoding
###################################################
library(BSgenome.Hsapiens.UCSC.hg19)
coding <- predictCoding(vcf, txdb, seqSource=Hsapiens)
coding[5:7]


###################################################
### code chunk number 30: predictCoding_frameshift
###################################################
## CONSEQUENCE is 'frameshift' where translation is not possible
coding[mcols(coding)$CONSEQUENCE == "frameshift"]


###################################################
### code chunk number 31: nonsynonymous
###################################################
nms <- names(coding)
idx <- mcols(coding)$CONSEQUENCE == "nonsynonymous"
nonsyn <- coding[idx]
names(nonsyn) <- nms[idx]
rsids <- unique(names(nonsyn)[grep("rs", names(nonsyn), fixed=TRUE)])


###################################################
### code chunk number 32: polyphen
###################################################
library(PolyPhen.Hsapiens.dbSNP131)

pp <- select(PolyPhen.Hsapiens.dbSNP131, keys=rsids,
          cols=c("TRAININGSET", "PREDICTION", "PPH2PROB"))
head(pp[!is.na(pp$PREDICTION), ])


###################################################
### code chunk number 33: snpMatrix
###################################################
res <- genotypeToSnpMatrix(vcf)
res


###################################################
### code chunk number 34: snpMatrix_ALT
###################################################
allele2 <- res$map[["allele.2"]]
## number of alternate alleles per variant
unique(elementNROWS(allele2))


###################################################
### code chunk number 35: VariantAnnotation.Rnw:449-464
###################################################
fl.gl <- system.file("extdata", "gl_chr1.vcf", package="VariantAnnotation") 
vcf.gl <- readVcf(fl.gl, "hg19")
geno(vcf.gl)

## Convert the "GL" FORMAT field to a SnpMatrix
res <- genotypeToSnpMatrix(vcf.gl, uncertain=TRUE)
res
t(as(res$genotype, "character"))[c(1,3,7), 1:5]

## Compare to a SnpMatrix created from the "GT" field
res.gt <- genotypeToSnpMatrix(vcf.gl, uncertain=FALSE)
t(as(res.gt$genotype, "character"))[c(1,3,7), 1:5]

## What are the original likelihoods for rs58108140?
geno(vcf.gl)$GL["rs58108140", 1:5]


###################################################
### code chunk number 36: writeVcf
###################################################
fl <- system.file("extdata", "ex2.vcf", package="VariantAnnotation")

out1.vcf <- tempfile()
out2.vcf <- tempfile()
in1 <- readVcf(fl, "hg19")
writeVcf(in1, out1.vcf)
in2 <- readVcf(out1.vcf, "hg19")
writeVcf(in2, out2.vcf)
in3 <- readVcf(out2.vcf, "hg19")

identical(rowRanges(in1), rowRanges(in3))
identical(geno(in1), geno(in2))


###################################################
### code chunk number 37: sessionInfo
###################################################
sessionInfo()


