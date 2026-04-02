#' Parse out options from a string without recourse to optparse
#'
#' @param x Long-form argument list like --opt1 val1 --opt2 val2
#'
#' @return named list of options and values similar to optparse
#' @examples
#' parse_arguments("--opt1 val1 --opt2 val2")
#' parse_arguments(' --opt1-extra "value with space" --opt2 val2 ')
#' @export
parse_arguments <- function(x) {
  x <- valid_string(x)

  bad <- grepl("(^| )(-\\w|-{3,}\\w)", x)
  if (any(bad)) {
    stop("arguments should only start with two dash")
  }

  args_list <- unlist(strsplit(x, " ?--")[[1]])[-1]
  args_vals <- lapply(
    args_list,
    function(x) scan(text = x, what = "character", quiet = TRUE)
  )

  # Ensure the option vectors are length 2 (key/ value) to catch empty ones
  args_vals <- lapply(args_vals, function(z) {
    length(z) <- 2
    z
  })

  parsed_args <- structure(
    lapply(args_vals, function(x) x[2]),
    names = lapply(args_vals, function(x) x[1])
  )
  parsed_args <- parsed_args[!is.na(parsed_args)]

  if (length(parsed_args) == 0 && length(x) > 0) {
    stop(x, " is not written as --argument value")
  }

}
