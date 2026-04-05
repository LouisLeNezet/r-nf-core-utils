test_that("create_versions_yml", {
    td <- withr::local_tempdir()
    create_versions_yml(
        list(
            "r-stats" = "stats",
            "r-cli" = "cli" 
        ),
        "MY_PROCESS",
        out_dir = td
    )

    # Read produced versions.yml
    yml_path <- file.path(td, "versions.yml")
    expect_true(file.exists(yml_path))

    # Parse YAML and compare as R object for deterministic equality
    got <- yaml::read_yaml(yml_path)
    expected <- list(
        "MY_PROCESS" = list(
            `r-base` = "4.5.3",
            `r-nfcore.utils` = "0.0.1",
            `r-stats` = "4.5.3",
            `r-cli`   = "3.6.5"
        )
    )
    expect_equal(got, expected)
})

test_that("create_versions_yml packages isn't a list", {
    expect_error(create_versions_yml(
        c(
            "r-stats" = "stats",
            "r-cli" = "cli" 
        ),
        "MY_PROCESS"
    ), regexp = "packages should be a named list")
})


test_that("create_versions_yml wrong outdir", {
    expect_error(create_versions_yml(
        list(
            "r-stats" = "stats",
            "r-cli" = "cli" 
        ),
        "MY_PROCESS",
        out_dir = "wrong_path"
    ), regexp = "wrong_path folder provided does not exist")
})


test_that("create_versions_yml package not present", {
    expect_error(create_versions_yml(
        list(
            "r-stats" = "stats",
            "r-cli" = "not_a_present_pkg" 
        ),
        "MY_PROCESS"
    ), regexp = "not_a_present_pkg not present in packages available")
})

test_that("create_versions_yml package not a valid string", {
    expect_error(create_versions_yml(
        list(
            "  " = "stats",
            "r-cli" = "not_a_present_pkg" 
        ),
        "MY_PROCESS"
    ), regexp = ".*is not a valid string")

    expect_error(create_versions_yml(
        list(
            "r-stats" = NULL,
            "r-cli" = "not_a_present_pkg" 
        ),
        "MY_PROCESS"
    ), regexp = ".*is not a valid string")
})

test_that("create_log_session_info", {
    td <- withr::local_tempdir()
    create_log_session_info(td)
    log_path <- file.path(td, "R_sessionInfo.log")
    expect_true(file.exists(log_path))

    expect_error(create_log_session_info(
        out_dir = "wrong_path"
    ), regexp = "wrong_path folder provided does not exist")
})

test_that("process_end", {
    td <- withr::local_tempdir()
    process_end(
        list(
            "r-stats" = "stats",
            "r-cli" = "cli" 
        ), "MY_PROCESS", out_dir = td
    )
    log_path <- file.path(td, "R_sessionInfo.log")
    expect_true(file.exists(log_path))
    yml_path <- file.path(td, "versions.yml")
    expect_true(file.exists(yml_path))
})
