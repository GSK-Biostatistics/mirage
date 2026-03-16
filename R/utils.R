first <- function(x) {
  x[1]
}

na_sub <- function(x, value){
  if (any(is.na(x))) {
    x[is.na(x)] <- value
  }
  x
}

check_extension <- function(path, ext, error_call = caller_env()) {
  if (file_ext(path) != ext) {
    cli_abort("{.arg path} must have {ext} extension, not {file_ext(path)}.", call = error_call)
  }
}

to_cm <- function(inch) {
  inch * 2.54
}

to_inch <- function(cm) {
  cm / 2.54
}

#' Try to extract xml_attr(node, name)
#' but return NA if not found
#'
#' @noRd
xml_attr_or_na <- function(node, name) {
  attr <- xml_attr(node, name)
  if (length(attr) == 0L) {
    attr <- NA_character_
  }
  attr
}
