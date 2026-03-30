#' Check for Non-Empty, Non-Whitespace String
#'
#' This function checks if the input is non-NULL and contains more than
#' just whitespace.
#' It returns TRUE if the input is a non-empty, non-whitespace string,
#' and FALSE otherwise.
#'
#' @param input A variable to check.
#' @return A logical value: TRUE if the input is a valid, non-empty,
#' non-whitespace string; FALSE otherwise.
#' @examples
#' is_valid_string("Hello World") # Returns TRUE
#' is_valid_string("   ")         # Returns FALSE
#' is_valid_string(NULL)          # Returns FALSE
is_valid_string <- function(input) {
  !is.null(input) && nzchar(trimws(input))
}


#' Parse out options from a string without recourse to optparse
#'
#' @param x Long-form argument list like --opt1 val1 --opt2 val2
#'
#' @return named list of options and values similar to optparse
parse_args <- function(x) {
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
  parsed_args[! is.na(parsed_args)]
}


#' Turn “null” or empty strings into actual NULL
#'
#' @param x Input option
#'
#' @return NULL or x
#'
nullify <- function(x) {
  if (is.character(x) && (tolower(x) == "null" || x == "")) NULL else x
}

