test_that("process_inputs", {
    opt <- list(
        tools = "default",
        value = "1234",
        folder = "test_folder",
        files = "test_file.txt"
    )
    expect_equal(
        process_inputs(
            opt,
            keys_to_nullify = c("folder"),
            expected_files = c("files"),
            expected_numeric = c("value"),
            required_opts = c("tools", "value")
        ),
        list("tools" = "test", "value" = "1234")
    )
})
