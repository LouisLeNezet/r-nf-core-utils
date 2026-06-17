#' @importFrom utils packageVersion sessionInfo tail
NULL

#' Create versions.yml file
#'
#' This function allows to automatically create the
#' versions.yml file used to store the packages used.
#' `r-base` as well as `r-nfcore.utils` versions will
#' automatically be added.
#'
#' @param packages Named list of packages to add to  the
#' versions.yml. The items names should be the conda package
#' name, while the items value should be the package name
#' used in R.
#' @param task_name Name of the nextflow process.
#' Typically `${task.process}`
#' @param versions_path Path to the yml file where the versions will
#' be written to. Default is the in the current directory as
#' `versions.yml`
#'
#' @return versions.yml file
#'
#' @examples
#' td <- withr::local_tempdir()
#' create_versions_yml(
#'   list("r-stats" = "stats"), "MY_PROCESS",
#'   file.path(td, "my_versions.yml")
#' )
#' @export
create_versions_yml <- function(
  packages, task_name,
  versions_path = "versions.yml"
) {

  if (!is.list(packages)) {
    stop("packages should be a named list")
  }

  if (!dir.exists(dirname(versions_path))) {
    stop(dirname(versions_path), " folder provided does not exist")
  }

  version_rbase <- paste(R.version[["major"]], R.version[["minor"]], sep = ".")
  pkg_lst <- list(
    "r-base" = version_rbase,
    "r-nfcore.utils" = as.character(packageVersion("nfcore.utils"))
  )

  for (pkg in names(packages)) {
    conda_name <- valid_string(pkg)
    pkg_name <- valid_string(packages[[pkg]])
    pkg_presence <- requireNamespace(pkg_name)
    if (!pkg_presence) {
      stop(pkg_name, " not present in packages available")
    }
    pkg_version <- as.character(packageVersion(pkg_name))
    pkg_lst[conda_name] <- pkg_version
  }

  writeLines(c(
    paste0(task_name, ":"),
    paste0("    ", names(pkg_lst), ": ", pkg_lst)
  ), versions_path)
}

#' Log R session info
#'
#' This function logs the R session info to a file named `R_sessionInfo.log`
#' in the specified output directory.
#'
#' @param log_path Path to the file where the R session info log will
#' be written to. Default is the in the current directory as
#' `R_sessionInfo.log`.
#'
#' @return R session info log
#' @examples
#' td <- withr::local_tempdir()
#' create_log_session_info(file.path(td, "session.log"))
#' @export
create_log_session_info <- function(log_path = "R_sessionInfo.log") {
  if (!dir.exists(dirname(log_path))) {
    stop(dirname(log_path), " folder provided does not exist")
  }
  sink(log_path)
  print(sessionInfo())
  sink()
}

#' Process end of the workflow
#'
#' Create the versions.yml file and log session info at the end of the process.
#'
#' @inheritParams create_versions_yml
#' @inheritParams create_log_session_info
#'
#' @return versions.yml file and R session info log
#' @examples
#' td <- withr::local_tempdir()
#' process_end(
#'   list("r-stats" = "stats"),
#'   "MY_PROCESS",
#'   file.path(td, "my_versions.yml"),
#'   file.path(td, "session.log")
#' )
#' @export
process_end <- function(
  packages, task_name,
  versions_path = "versions.yml",
  log_path = "R_sessionInfo.log"
) {
  create_log_session_info(log_path)
  create_versions_yml(packages, task_name, versions_path)
}
