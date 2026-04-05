#' @importFrom utils read.delim
NULL

#' Flexibly read CSV or TSV files
#'
#' The following rules are applied:
#' - extension == txt or tsv, then separator is set to tabulation
#' - extension == csv, then separator is set to comma
#'
#' @param file Input file
#' @inheritDotParams utils::read.delim -file -sep
#'
#' @return output Data frame
read_delim_flexible <- function(file, ...) {

  ext <- tolower(tail(strsplit(basename(file), split = "\\.")[[1]], 1))

  if (ext == "tsv" || ext == "txt") {
    separator <- "\t"
  } else if (ext == "csv") {
    separator <- ","
  } else {
    stop("Unknown separator for ", ext)
  }

  read.delim(
    file,
    sep = separator,
    ...
  )
}
