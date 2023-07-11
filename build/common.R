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



# status note -------------------------------------------------------------

status <- function(type) {
  status <- switch(type,
                   polishing = "should be readable but is currently undergoing final polishing",
                   restructuring = "is undergoing heavy restructuring and may be confusing or incomplete",
                   drafting = "is currently a mess, and I don't recommend reading it",
                   complete = "is largely complete and just needs final proof reading",
                   stop("Invalid `type`", call. = FALSE)
  )
  
  class <- switch(type,
                  polishing = "note",
                  restructuring = "important",
                  drafting = "important",
                  complete = "note"
  )
  
  callout <- paste0(
    "\n",
    "::: {.callout-", class, "} \n",
    "You are, I'm sorry to inform you, reading the work-in-progress revision of \"Learning Statistics with R\". ",
    "This chapter ", status, ". \n",
    "::: \n"
  )
  
  cat(callout)
}
