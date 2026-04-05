test_that("parse_arguments", {
  expect_equal(
    parse_arguments("--tools test --value 1234"),
    list("tools" = "test", "value" = "1234")
  )

  expect_equal(
    parse_arguments('--tools test --test-value "value with space"'),
    list("tools" = "test", "test-value" = "value with space")
  )

  expect_equal(
    parse_arguments('--tools test --test-value "value with--dash"'),
    list("tools" = "test", "test-value" = "value with--dash")
  )

  expect_equal(
    parse_arguments(NULL),
    list()
  )
})

test_that("parse_arguments errors", {
  expect_error(
    parse_arguments("   "),
    regexp = ".*is not a valid string"
  )

  expect_error(
    parse_arguments("--good arg ---bad test"),
    regexp = "arguments should only start with two dash"
  )

  expect_error(
    parse_arguments("--good arg -bad test"),
    regexp = "arguments should only start with two dash"
  )

  expect_error(
    parse_arguments("--good arg bad test"),
    regexp = "arguments should only be in the form --argument value"
  )

  expect_error(
    parse_arguments("bad test"),
    regexp = ".*is not written as --argument value"
  )
})
