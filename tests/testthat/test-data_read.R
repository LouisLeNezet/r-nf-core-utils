test_that("read_delim_flexible", {
  file <- paste0(testthat::test_path(), "/testdata/sampleped.TsV")
  expect_equal(
    dim(read_delim_flexible(file)),
    c(9, 7)
  )

  file <- paste0(testthat::test_path(), "/testdata/sampleped.csv")
  expect_equal(
    dim(read_delim_flexible(file, header = FALSE, row.names = 1)),
    c(9, 7)
  )

  file <- paste0(testthat::test_path(), "/testdata/sampleped.tab")
  expect_error(
    read_delim_flexible(file),
    regexp = "Unknown separator for tab"
  )

})
