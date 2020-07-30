# script to serve the book in bookdown, *from* the
# bookdown directory
setwd(here::here("bookdown"))
bookdown::serve_book()
#bookdown::render_book("index.Rmd",output_format = bookdown::epub_book())
