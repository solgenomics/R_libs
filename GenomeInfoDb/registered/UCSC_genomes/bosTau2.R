GENOME <- "bosTau2"
ORGANISM <- "Bos taurus"
ASSEMBLED_MOLECULES <- paste0("chr", c(1:29, "X", "M"))
CIRC_SEQS <- "chrM"

library(GenomeInfoDb)  # for fetch_chrom_sizes_from_UCSC()

.order_seqlevels <- function(seqlevels)
{
    scaffolds <- paste0("scaffold", 1:98058)
    ordered_seqlevels <- c(ASSEMBLED_MOLECULES, scaffolds, "chrBin0")
    stopifnot(length(seqlevels) == length(ordered_seqlevels))
    idx <- match(ordered_seqlevels, seqlevels)
    stopifnot(!anyNA(idx))
    idx
}

FETCH_ORDERED_CHROM_SIZES <-
    function(goldenPath.url=getOption("UCSC.goldenPath.url"))
{
    chrom_sizes <- GenomeInfoDb:::fetch_chrom_sizes_from_UCSC(GENOME,
                                              goldenPath.url=goldenPath.url)
    oo <- .order_seqlevels(chrom_sizes[ , "chrom"])
    S4Vectors:::extract_data_frame_rows(chrom_sizes, oo)
}

