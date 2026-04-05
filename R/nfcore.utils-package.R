## Created: 05/04/2026 Author: Louis Le Nezet

#' The nf-core utils R package for Nextflow processes
#'
#' This package aims to ease the link between Nextflow inputs and
#' outputs to the R variable needed in the script.
#'
#' @section Functions:
#' Below are listed some of the main functions available:
#'
#' [process_inputs()]: Given a list of expected options with their
#' default this function will parse the arguments given and validate
#' their value based on the expected rules.
#'
#' [process_end()]: Create a `versions.yml` and `R_sessionInfo.log`
#' file in the directory provided. The version file will be populated
#' with the R version, the version of nfcore.utils and the version of
#' the additional packages given.
#'
#' @examples
#' library(nfcore.utils)
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
#' \dontrun{
#' process_end(
#'   packages = list(
#'     "r-stats" = "stats"
#'   ),
#'   task_name = 'MY_PROCESS'
#' )
#' }
#' @docType package
#' @rdname nfcore.utils_package
"_PACKAGE"
