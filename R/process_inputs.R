#' Process input parameters and files
#' 
#' This function processes input parameters and files, applying parameter overrides,
#' validating expected keys and files, and ensuring that the provided file paths are valid.
#' 
#' @param opt A list of default options.
#' @param args A character vector of command-line arguments to override defaults.
#' @param keys_to_nullify A character vector of keys that should be nullified.
#' @param expected_files A character vector of keys in `opt` that are expected to be file paths.
#' @param expected_folders A character vector of keys in `opt` that are expected to be folder paths.
#' @param expected_double A character vector of keys in `opt` that are expected to be float values.
#' @param expected_integer A character vector of keys in `opt` that are expected to be integer values.
#' @param required_opts A character vector of keys in `opt` that are required and must not be null or empty.
#' @return A list of processed options with overrides applied and validated.
#' @examples
#' td <- withr::local_tempdir()
#' test_file_path <- file.path(td, "test_file.txt")
#' file.create(test_file_path)
#' options <- list(input_file = test_file_path, output_file = "prefix", threshold = 0.5)
#' args <- c("--threshold 0.7")
#' processed_options <- process_inputs(
#'   options, args,
#'   keys_to_nullify = c("input_file", "output_file"),
#'   expected_files = c("input_file"),
#'   expected_double = c("threshold"),
#'   required_opts = c("input_file", "threshold")
#' )
#' @export
process_inputs <- function(
  opt, args = NULL,
  keys_to_nullify = NULL,
  expected_files = NULL,
  expected_folders = NULL,
  expected_double = NULL,
  expected_integer = NULL,
  required_opts = NULL
) {
  # Apply parameter overrides
  args_opt <- parse_arguments(args)

  for (ao in names(args_opt)) {
    if (! ao %in% names(opt)) {
      stop("Option: ", ao, " not found in options.")
    } else {
      opt[[ao]] <- args_opt[[ao]]
    }
  }

  all_keys_to_process <- c(
    keys_to_nullify,
    expected_files, expected_double, expected_integer,
    required_opts
  )

  missing_keys <- all_keys_to_process[!all_keys_to_process %in% names(opt)]
  if (length(missing_keys) > 0) {
    stop(
      "All keys to process should be in the default options.",
      " Missing keys: ",
      paste(missing_keys, collapse = ", ")
    )
  }

  opt[keys_to_nullify] <- lapply(opt[keys_to_nullify], nullify)

  # Check file and folder inputs
  opt[expected_files] <- lapply(expected_files, function(x){validate_file(opt[[x]], x)})
  opt[expected_folders] <- lapply(expected_folders, function(x){validate_folder(opt[[x]], x)})

  # Check numeric inputs
  opt[expected_double] <- lapply(expected_double, function(x){validate_double(opt[[x]], x)})
  opt[expected_integer] <- lapply(expected_integer, function(x){validate_integer(opt[[x]], x)})

  # Set seed for reproducibility
  if (!is.null(opt$seed)){
    set.seed(opt$seed)
  }

  # Check required parameters are not null
  if (!is.null(required_opts)) {
    missing <- required_opts[!unlist(lapply(opt[required_opts], is_valid_string)) | !required_opts %in% names(opt)]

    if (length(missing) > 0){
      stop(paste("Missing required options:", paste(missing, collapse=', ')))
    }
  }

  opt
}
