#' Check if is `NULL` or invalid
#'
#' @param x String to check
#' @param variable_name Name of the variable to print if error occurs
#'
#' @return TRUE if is null, ERROR if invalid and FALSE otherwise
#' @examples
#' is_null_or_invalid(NULL) # TRUE
#' try(is_null_or_invalid(" ")) # ERROR
#' is_null_or_invalid("Hello World !") # FALSE
#' @export
is_null_or_invalid <- function(x, variable_name = NULL) {
  if (is.null(x)) {
    return(TRUE)
  }
  if (!is_valid_string(x)) {
    stop(
      "Please provide ", variable_name,
      " as a valid string", call. = FALSE
    )
  }
  FALSE
}

#' Check if value is an integer
#'
#' @param x String to check and convert
#' @param variable_name Name of the variable to print if error occurs
#'
#' @return x as integer, or NULL if is null and ERROR if x
#' isn't convertable to an integer
#' @examples
#' validate_integer(NULL) # NULL
#' try(validate_integer(" ")) # ERROR
#' try(validate_integer("Hello World !")) # ERROR
#' try(validate_integer("12.4")) # ERROR
#' validate_integer("12") # 12
#' @export
validate_integer <- function(x, variable_name = NULL) {
  if (is_null_or_invalid(x, variable_name)) {
    return(NULL)
  }
  double_value <- suppressWarnings(as.double(x))
  if (is.na(double_value)) {
    stop(
      "Value of ", variable_name, ": ",
      x, " is not a valid integer number"
    )
  } else {
    integer_value <- as.integer(double_value)
    if (is.na(integer_value) || integer_value != double_value) {
      stop(
        "Value of ", variable_name, ": ",
        x, " is not a valid integer number"
      )
    }
  }
  integer_value
}

#' Check if value is double number
#'
#' @param x String to check and convert
#' @param variable_name Name of the variable to print if error occurs
#'
#' @return x as double, or NULL if is null and ERROR if x
#' isn't convertable to a double
#' @examples
#' validate_double(NULL) # NULL
#' try(validate_double(" ")) # ERROR
#' try(validate_double("Hello World !")) # ERROR
#' validate_double("12.4") # 12.4
#' validate_double("12") # 12.0
#' @export
validate_double <- function(x, variable_name = NULL) {
  if (is_null_or_invalid(x, variable_name)) {
    return(NULL)
  }
  double_value <- suppressWarnings(as.double(x))
  if (is.na(double_value)) {
    stop(
      "Value of ", variable_name, ": ",
      x, " is not a valid double number"
    )
  }
  double_value
}

#' Check if value is an existing folder
#'
#' @param x String to check
#' @param variable_name Name of the variable to print if error occurs
#'
#' @return x, or NULL if is null and ERROR if x
#' isn't an existing folder
#' @examples
#' try(validate_folder("test")) # ERROR
#' @export
validate_folder <- function(x, variable_name = NULL) {
  if (is_null_or_invalid(x, variable_name)) {
    return(NULL)
  }

  if (! dir.exists(x)) {
    stop(
      "Value of ", variable_name, ": ",
      x, " is not a valid folder"
    )
  }
  x
}

#' Check if value is an existing file
#'
#' @param x String to check
#' @param variable_name Name of the variable to print if error occurs
#'
#' @return x, or NULL if is null and ERROR if x
#' isn't an existing file
#' @examples
#' try(validate_file("test")) # ERROR
#' @export
validate_file <- function(x, variable_name = NULL) {
  if (is_null_or_invalid(x, variable_name)) {
    return(NULL)
  }

  if (!file.exists(x)) {
    stop(
      "Value of ", variable_name, ": ",
      x, " is not a valid file"
    )
  }
  x
}
