#' Wrapper around [polish::polish_content]
#'
#' For internal use to mark all polish failures as "mirage_polish_failure"
#' to allow for selectively failing when the polish fails
#'
#'
#' @noRd
mirage_polish_content <- function(content, ph, pptx = load_pptx(), error_call = current_env()) {
  dots <- content$polishing_args
  if(!is.null(content$value)){
    rlang::exec(polish_content,
      x = content$value, type = "pptx", ph = ph, pptx = pptx,
      !!!dots,
      error_class = "mirage_polish_failure",
      error_call = error_call
    )
  }else{
    NULL
  }
}
