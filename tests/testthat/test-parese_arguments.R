test_that("is_valid_string", {
    expect_equal(is_valid_string("Hello World"), TRUE)
    expect_equal(is_valid_string("   "), FALSE)
    expect_equal(is_valid_string(NULL), FALSE)
})
