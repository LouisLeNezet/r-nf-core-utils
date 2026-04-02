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
#' is_valid_string(" Hello World ") # Returns TRUE
#' is_valid_string("   ")         # Returns FALSE
#' is_valid_string(NULL)          # Returns FALSE
is_valid_string <- function(input) {
  !is.null(input) && nzchar(trimws(input))
}

#' Check for Non-Empty, Non-Whitespace String
#'
#' This function checks if the input is non-NULL and contains more than
#' just whitespace.
#'
#' @param input A variable to check.
#' @return `input` with whitespace trimmed or throw error if not a valid string
#' @examples
#' valid_string("Hello World") # Returns "Hello World"
#' valid_string("  Hello World ") # Returns "Hello World"
#' valid_string("   ")         # Error
#' valid_string(NULL)          # Error
valid_string <- function(input) {
    if (is_valid_string(input)) {
        trimws(input)
    } else {
        stop(input, "is not a valid string")
    }
}

#' Turn “null” or empty strings into actual NULL
#'
#' @param x Input option
#'
#' @return NULL or x
#'
nullify <- function(x) {
  if (is.character(x) && (tolower(x) %in% "null" || trimws(x) == "")) {
    NULL
  } else if(is.null(x) || is.na(x)) {
    NULL
  } else {
    x
  }
}
