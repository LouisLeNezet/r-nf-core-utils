create_version_yml <- function(packages, task_name) {

    version_rbase <- paste(R.version[["major"]], R.version[["minor"]], sep = ".")

    pkg_lst <- list(
        "r-base" = version_rbase,
        "r-nf-core-utils" = packageVersion("nf-core-utils")
    )

    for (pkg in packages) {
        pkg_lst[paste0("r-", pkg)] <- packageVersion(pkg)
    }

    writeLines(c(
        paste0(task_name, ":"),
        paste0("    ", pkg_lst, "\n"),
    ), "versions.yml")
}