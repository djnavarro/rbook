# get the default output hook
hook_output <- knitr::knit_hooks$get("output")

knitr::knit_hooks$set(output = function(x, options) {
  lines <- options$output.lines
  if (is.null(lines)) {
    hook_output(x, options)  # pass to default hook
  }
  else {
    x <- unlist(stringr::str_split(x, "\n"))
    if (length(x) > lines) {
      # truncate the output, but add ....
      x <- c(head(x, lines), "\nBLAH BLAH BLAH\n")
    }
    # paste these lines together
    x <- paste(x, collapse = "\n")
    hook_output(x, options)
  }
})
