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
