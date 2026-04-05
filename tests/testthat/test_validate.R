test_that("is_null_or_invalid", {
  expect_true(is_null_or_invalid(NULL, "value"))
  expect_error(
    is_null_or_invalid(" ", "value"),
    regexp = "Please provide value as a valid string"
  )
  expect_false(is_null_or_invalid("valid string", "value"))
})

test_that("validate_integer", {
  expect_equal(validate_integer("1234", "value"), 1234)
  expect_equal(validate_integer("1234.0", "value"), 1234)
  expect_equal(validate_integer(NULL, "value"), NULL)

  expect_error(
    validate_integer(" ", "value"),
    regexp = "Please provide value as a valid string"
  )

  expect_error(
    validate_integer("1234.56", "value"),
    regexp = "value: 1234.56 is not a valid integer number"
  )

  expect_error(
    validate_integer("ABC", "value"),
    regexp = "value: ABC is not a valid integer number"
  )
})

test_that("validate_double", {
  expect_equal(validate_double(NULL, "value"), NULL)
  expect_equal(validate_double("1234.56", "value"), 1234.56)
  expect_equal(validate_double("1234.0", "value"), 1234.0)
  expect_equal(validate_double("1234", "value"), 1234.0)

  expect_error(
    validate_double("ABC", "value"),
    regexp = "value: ABC is not a valid double number"
  )

  expect_error(
    validate_double("1234.56abc", "value"),
    regexp = "value: 1234.56abc is not a valid double number"
  )

  expect_error(
    validate_double(" ", "value"),
    regexp = "Please provide value as a valid string"
  )
})

test_that("validate_file", {
  expect_equal(validate_file(NULL, "value"), NULL)
  expect_error(
    validate_file("file.txt", "value"),
    regexp = "value: file.txt is not a valid file"
  )

  td <- withr::local_tempdir()
  test_file_path <- file.path(td, "test_file.txt")
  file.create(test_file_path)
  expect_equal(
    validate_file(test_file_path, "value"),
    test_file_path
  )
})

test_that("validate_folder", {
  expect_equal(validate_folder(NULL, "value"), NULL)
  expect_error(
    validate_folder("folder", "value"),
    regexp = "value: folder is not a valid folder"
  )

  td <- withr::local_tempdir()
  expect_equal(
    validate_folder(td, "value"),
    td
  )
})

test_that("validate_folder", {
  expect_equal(validate_boolean(NULL, "value"), NULL)
  expect_error(
    validate_boolean(" "),
    regexp = "Please provide  as a valid string"
  )

  expect_true(validate_boolean(1))
  expect_true(validate_boolean("YES"))
  expect_true(validate_boolean("TrUe"))
  expect_true(validate_boolean(TRUE))

  expect_false(validate_boolean(0))
  expect_false(validate_boolean("No"))
  expect_false(validate_boolean("FalSe"))
  expect_false(validate_boolean(FALSE))

  expect_error(
    validate_boolean("folder", "test"),
    regexp = "Value of test: folder is not a valid boolean"
  )
})
