#' Create a local copy of the happiness data
#'
#' This function will attempt to create a local copy of the happiness data sets
#' for practical 2.
#'
#' @usage get_happiness()
#' @return logical TRUE if the operation was successful
#' @export
get_happiness = function() {
  fpath = system.file("happiness", package = "jrTidyverse2")
  if (!nchar(fpath)) {
    stop("Something wen't wrong, package internal csv file could not be found.
         Let me know and I will send you a copy manually")
  }
  if (!file.copy(from = fpath, to = getwd(),
                 recursive = TRUE, overwrite = TRUE)) {
    stop("Couldn't copy the file, you may not have permission to write to this
          directory. Try changing the working directory, either through the
          setwd() function or under Session in RStudio. If you still can't get
         it  working let me know and I will send you a copy manually.")
  }
  message("Files have been copied successfully!
          Check your current working directory.")
  TRUE
}
