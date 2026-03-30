process_input <- function(
    input, args,
    expected_keys = NULL,
    expected_files = NULL
) {
    # Apply parameter overrides
    args_opt <- parse_args(args)
    for (ao in names(args_opt)) {
    if (! ao %in% names(opt)) {
        stop(paste("Invalid option:", ao))
    } else {
        # Preserve classes from defaults where possible
        if (! is.null(opt[[ao]])) {
        args_opt[[ao]] <- as(args_opt[[ao]], opt_types[[ao]])
        }
        opt[[ao]] <- args_opt[[ao]]
    }
    }

    opt[expected_keys] <- lapply(opt[expected_keys], nullify)

    for (file_input in expected_files) {
    if (! is_valid_string(opt[[file_input]])) {
        stop(paste("Please provide", file_input), call. = FALSE)
    }

    if (! file.exists(opt[[file_input]])) {
        stop(paste0(
        "Value of ", file_input, ": ",
        opt[[file_input]], " is not a valid file"
        ))
    }
    }
}