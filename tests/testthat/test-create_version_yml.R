test_that("create_versions_yml", {
  testthat::skip_if_not_installed("yaml")
  td <- withr::local_tempdir()
  yml_path <- file.path(td, "versions.yml")

  create_versions_yml(
    list(
      "r-stats" = "stats"
    ),
    "MY_PROCESS",
    versions_path = yml_path
  )

  # Read produced versions.yml
  expect_true(file.exists(yml_path))

  # Parse YAML and compare as R object for deterministic equality
  got <- yaml::read_yaml(yml_path)
  r_versions <- paste(R.version[["major"]], R.version[["minor"]], sep = ".")
  expected <- list(
    "MY_PROCESS" = list(
      `r-base` = r_versions,
      `r-nfcore.utils` = "0.0.3",
      `r-stats` = r_versions
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
    versions_path = "wrong_path/yml"
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
  log_path <- file.path(td, "R_sessionInfo.log")
  create_log_session_info(log_path)
  expect_true(file.exists(log_path))

  expect_error(create_log_session_info(
    log_path = "wrong_path/log"
  ), regexp = "wrong_path folder provided does not exist")
})

test_that("process_end", {
  td <- withr::local_tempdir()
  log_path <- file.path(td, "R_sessionInfo.log")
  yml_path <- file.path(td, "versions.yml")
  process_end(
    list(
      "r-stats" = "stats",
      "r-cli" = "cli"
    ), "MY_PROCESS",
    versions_path = yml_path,
    log_path = log_path
  )
  expect_true(file.exists(log_path))
  expect_true(file.exists(yml_path))
})
