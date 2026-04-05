test_that("process_inputs", {
  # Create a temporary file to test file existence
  td <- withr::local_tempdir()
  test_file_path <- file.path(td, "test_file.txt")
  file.create(test_file_path)

  opt <- list(
    tools = "default",
    value = "1234.56",
    value2 = "1234",
    value3 = NULL,
    folder = td,
    files = test_file_path,
    seed = 1234
  )

  expect_equal(
    process_inputs(
      opt,
      keys_to_nullify = c("folder"),
      expected_files = c("files"),
      expected_folder = c("folder"),
      expected_double = c("value"),
      expected_integer = c("value2", "value3"),
      required_opts = c("tools", "value")
    ),
    list(
      tools = "default",
      value = 1234.56,
      value2 = 1234,
      value3 = NULL,
      folder = td,
      files = test_file_path,
      seed = 1234
    )
  )

  # Pass through arguments
  opt <- list(
    tools = "default",
    value = NULL,
    value2 = "1234",
    files = NULL,
    folder = td
  )
  args <- paste0("--value 1234.56 --files ", test_file_path)

  expect_equal(
    process_inputs(
      opt, args = args,
      keys_to_nullify = c("folder"),
      expected_files = c("files"),
      expected_folder = c("folder"),
      expected_double = c("value"),
      expected_integer = c("value2"),
      required_opts = c("tools", "value")
    ),
    list(
      "tools" = "default",
      "value" = 1234.56,
      "value2" = 1234,
      "files" = test_file_path,
      "folder" = td
    )
  )
})

test_that("process_inputs, files/folder error", {
  opt <- list(folder = "test")

  expect_error(
    process_inputs(
      opt,
      expected_folder = c("folder")
    ),
    regexp = ".*is not a valid folder"
  )

  opt <- list(folder = "  ")

  expect_error(
    process_inputs(
      opt,
      expected_folder = c("folder")
    ),
    regexp = "Please provide folder as a valid string"
  )

  opt <- list(files = "test_file2.txt")

  expect_error(
    process_inputs(
      opt,
      expected_files = c("files")
    ),
    regexp = ".*is not a valid file"
  )

  opt <- list(files = "   ")

  expect_error(
    process_inputs(
      opt,
      expected_files = c("files")
    ),
    regexp = "Please provide files as a valid string"
  )
})

test_that("process_inputs, missing key", {
  opt <- list(folder = "test")

  expect_error(
    process_inputs(
      opt,
      expected_folder = c("folder"),
      expected_files = c("files")
    ),
    regexp = "All keys to process should be in the default options"
  )
})

test_that("process_inputs, missing argument", {
  opt <- list(folder = "test")

  expect_error(
    process_inputs(
      opt, args = "--files test_file.txt",
      expected_folder = c("folder")
    ),
    regexp = "Option: files not found in options"
  )
})


test_that("process_inputs, wrong numerical values", {
  opt <- list(value = NULL)

  expect_error(
    process_inputs(
      opt, args = "--value '  '",
      expected_integer = c("value")
    ),
    regexp = "Please provide value as a valid string"
  )

  expect_error(
    process_inputs(
      opt, args = "--value '  '",
      expected_double = c("value")
    ),
    regexp = "Please provide value as a valid string"
  )

  expect_error(
    process_inputs(
      opt, args = "--value '1234.56abc'",
      expected_double = c("value")
    ),
    regexp = "value: 1234.56abc is not a valid double number"
  )

  expect_error(
    process_inputs(
      opt, args = "--value '1234.56'",
      expected_integer = c("value")
    ),
    regexp = "value: 1234.56 is not a valid integer number"
  )

  expect_error(
    process_inputs(
      opt, args = "--value ABC",
      expected_integer = c("value")
    ),
    regexp = "value: ABC is not a valid integer number"
  )

  expect_error(
    process_inputs(
      opt, args = "--value ABC",
      expected_double = c("value")
    ),
    regexp = "value: ABC is not a valid double number"
  )
})
