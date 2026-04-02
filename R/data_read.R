#' Flexibly read CSV or TSV files
#'
#' @param file Input file
#' @param header Passed to read.delim()
#' @param row.names Passed to read.delim()
#'
#' @return output Data frame
read_delim_flexible <- function(file, header = TRUE, row.names = NULL, check.names = TRUE){

  ext <- tolower(tail(strsplit(basename(file), split = "\\\\.")[[1]], 1))

  if (ext == "tsv" || ext == "txt") {
    separator <- "\\t"
  } else if (ext == "csv") {
    separator <- ","
  } else {
    stop(paste("Unknown separator for", ext))
  }

  read.delim(
    file,
    sep = separator,
    header = header,
    row.names = row.names,
    check.names = check.names
  )
}