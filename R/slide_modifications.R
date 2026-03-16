#' @rdname add_slide
#' @export
delete_slide <- function(pptx, index, error_call = current_env()){

  if(index < 0 | index > length(pptx$rpptx)){
    cli_abort(c(
      "Invalid {.arg index} ({index}) for slide to be deleted from {.val {pptx$name}} presentation.",
      i = "{.arg index} must be between 1 and {length(pptx$rpptx)}."
    ))
  }

  tryCatch({
    pptx$rpptx <- officer::remove_slide(pptx$rpptx, index)
  }, error = function(e) {
    cli_abort("Failed to delete slide {index}.", parent = e, call = error_call)
  })

  pptx <- increment_revision(pptx)
  save_slides(pptx)
}


#' @rdname add_slide
#' @export
move_slide <- function(pptx, index, to, error_call = current_env()){

  if(index < 0 | index > length(pptx$rpptx)){
    cli_abort(c(
      "Invalid {.arg index} ({index}) for slide to be moved from in {.val {pptx$name}} presentation.",
      i = "{.arg index} must be between 1 and {length(pptx$rpptx)}."
    ))
  }

  if(to < 0 | to > length(pptx$rpptx)){
    cli_abort(c(
      "Invalid {.arg index} ({index}) for slide to be moved to in {.val {pptx$name}} presentation.",
      i = "{.arg index} must be between 1 and {length(pptx$rpptx)}."
    ))
  }

  tryCatch({
    pptx$rpptx <- officer::move_slide(pptx$rpptx, index = index, to = to)
  }, error = function(e) {
    cli_abort("Failed to move slide from {index} to {to}.", parent = e, call = error_call)
  })

  pptx <- increment_revision(pptx)
  save_slides(pptx)
}
