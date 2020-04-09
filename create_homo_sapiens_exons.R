library(Homo.sapiens)
library(dplyr)
library(tibble)
library(readr)

h_sapiens <- Homo.sapiens::Homo.sapiens
genes <-  AnnotationDbi::keys(h_sapiens, "GENEID")
exon_data <- AnnotationDbi::select(
    h_sapiens,
    keys = genes,
    keytype = "GENEID",
    columns = c(
        "GENEID",
        "TXID",
        "EXONCHROM",
        "EXONSTRAND",
        "EXONSTART",
        "EXONEND",
        "SYMBOL"
    )
)

exon_tibble <- tibble::as_tibble(exon_data) %>%
    dplyr::rename(
        gene_id = GENEID,
        chr = EXONCHROM,
        strand = EXONSTRAND,
        start = EXONSTART,
        end = EXONEND,
        transcript_id = TXID,
        symbol = SYMBOL
    )

readr::write_tsv(exon_tibble, "homo_sapiens_exons.tsv.gz")
