library(Mus.musculus)
library(dplyr)
library(tibble)
library(readr)

m_musculus <- Mus.musculus::Mus.musculus
genes <-  AnnotationDbi::keys(m_musculus, "GENEID")
exon_data <- AnnotationDbi::select(
    m_musculus,
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

readr::write_tsv(exon_tibble, "mus_musculus_exons.tsv.gz")
