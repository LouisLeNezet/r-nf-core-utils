test_that("is_valid_string", {
  expect_true(is_valid_string("Hello World"))
  expect_true(is_valid_string("  Hello World "))
  expect_false(is_valid_string("   "))
  expect_false(is_valid_string(NULL))
})

test_that("valid_string", {
  expect_equal(valid_string("Hello World"), "Hello World")
  expect_equal(valid_string("  Hello World "), "Hello World")
  expect_error(valid_string("   "), regexp = ".*is not a valid string")
  expect_error(valid_string(NULL), regexp = ".*is not a valid string")
})

test_that("nullify", {
  expect_equal(nullify("Hello World"), "Hello World")
  expect_equal(nullify("  Hello World "), "  Hello World ")
  expect_equal(nullify(1234), 1234)
  expect_equal(nullify("   "), NULL)
  expect_equal(nullify(NULL), NULL)
  expect_equal(nullify(NA), NULL)
})
