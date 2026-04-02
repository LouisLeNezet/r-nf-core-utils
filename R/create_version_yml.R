#' Create versions.yml file
#' 
#' This function allows to automatically create the
#' versions.yml file used to store the packages used.
#' `r-base` as well as `r-nfcore_utils` versions will
#' automatically be added.
#' 
#' @param packages Named list of packages to add to  the
#' versions.yml. The items names should be the conda package
#' name, while the items value should be the package name
#' used in R.
#' @param task_name Name of the nextflow process.
#' Typically `${task.process}`
#' @param out_dir Output directory where the versions.yml will
#' be written to. Default is the current directory.
#' 
#' @return versions.yml file
#' 
#' @examples
#' create_versions_yml(list("r-stats" = "stats"), "MY_PROCESS")
#' @export
create_versions_yml <- function(packages, task_name, out_dir = ".") {

    if(!is.list(packages)) {
        stop("packages should be a named list")
    }

    if(!dir.exists(out_dir)){
        stop(out_dir, " folder provided does not exist")
    }

    version_rbase <- paste(R.version[["major"]], R.version[["minor"]], sep = ".")
    pkg_lst <- list(
        "r-base" = version_rbase,
        "r-nfcore.utils" = as.character(packageVersion("nfcore.utils"))
    )

    pkg_available <- rownames(installed.packages())
    for (pkg in names(packages)) {
        conda_name <- valid_string(pkg)
        pkg_name <- valid_string(packages[[pkg]])
        if(! pkg_name %in% pkg_available) {
            stop(pkg_name, " not present in packages available")
        }
        pkg_version <- as.character(packageVersion(pkg_name))
        pkg_lst[conda_name] <- pkg_version
    }

    writeLines(c(
        paste0(task_name, ":"),
        paste0("    ", names(pkg_lst), ": ", pkg_lst)
    ), file.path(out_dir, "versions.yml"))
}

#' Log R session info
#' 
#' This function logs the R session info to a file named `R_sessionInfo.log`
#' in the specified output directory.
#' 
#' @param out_dir Output directory where the R session info log will be
#' written to. Default is the current directory.
#' 
#' @return R session info log
#' @examples
#' create_log_session_info("output_dir")
#' @export
create_log_session_info <- function(out_dir = ".") {
    sink(file.path(out_dir, "R_sessionInfo.log", sep = '.'))
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
#' process_end(list("r-stats" = "stats"), "MY_PROCESS", "output_dir")
#' @export
process_end <- function(packages, task_name, output_prefix, out_dir = ".") {
    create_log_session_info(out_dir)
    create_versions_yml(packages, task_name, out_dir)
}
