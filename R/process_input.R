#' Process input parameters and files
#' 
#' This function processes input parameters and files, applying parameter overrides,
#' validating expected keys and files, and ensuring that the provided file paths are valid.
#' 
#' @param opt A list of default options.
#' @param args A character vector of command-line arguments to override defaults.
#' @param keys_to_nullify A character vector of keys that should be nullified.
#' @param expected_files A character vector of keys in `opt` that are expected to be file paths.
#' @param expected_numeric A character vector of keys in `opt` that are expected to be numeric values.
#' @param required_opts A character vector of keys in `opt` that are required and must not be null or empty.
#' @return A list of processed options with overrides applied and validated.
#' @examples
#' \dontrun{
#' default_options <- list(input_file = "test.csv", output_file = "prefix", threshold = 0.5)
#' args <- c("--threshold=0.7")
#' processed_options <- process_input(
#'   default_options, args,
#'   keys_to_nullify = c("input_file", "output_file"),
#'   expected_files = c("input_file"),
#'   expected_numeric = c("threshold"),
#'   required_opts = c("input_file", "threshold")
#' )
#' }
process_input <- function(
  opt, args,
  keys_to_nullify = NULL,
  expected_files = NULL,
  expected_numeric = NULL,
  required_opts = NULL
) {
  # Apply parameter overrides
  args_opt <- parse_args(args)
  for (ao in names(args_opt)) {
    if (! ao %in% names(opt)) {
      stop(paste("Invalid option:", ao))
    } else {
      # Preserve classes from defaults where possible
      if (! is.null(opt[[ao]])) {
        args_opt[[ao]] <- as(args_opt[[ao]], opt_types[[ao]])
      }
      opt[[ao]] <- args_opt[[ao]]
    }
  }

  opt[keys_to_nullify] <- lapply(opt[keys_to_nullify], nullify)

  for (file_input in expected_files) {
    if (! is_valid_string(opt[[file_input]])) {
      stop(paste("Please provide", file_input), call. = FALSE)
    }

    if (! file.exists(opt[[file_input]])) {
      stop(paste0(
        "Value of ", file_input, ": ",
        opt[[file_input]], " is not a valid file"
      ))
    }
  }

  # Check numeric inputs
  for (numeric_input in expected_numeric) {
    if (! is_valid_string(opt[[numeric_input]])) {
      stop(paste("Please provide", numeric_input), call. = FALSE)
    }

    if (! is.numeric(opt[[numeric_input]])) {
      stop(paste0(
        "Value of ", numeric_input, ": ",
        opt[[numeric_input]], " is not a valid number"
      ))
    }
  }

  # Set seed for reproducibility
  if ( ! is.null(opt$seed)){
    set.seed(opt$seed)
  }

  # Check required parameters are not null
  missing <- required_opts[!unlist(lapply(opt[required_opts], is_valid_string)) | !required_opts %in% names(opt)]

  if (length(missing) > 0){
    stop(paste("Missing required options:", paste(missing, collapse=', ')))
  }
}
