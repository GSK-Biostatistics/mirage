
#' Placeholder Templates
#'
#' @description
#'
#' Included standard template locations to put standard contents when
#' constructing a slide.
#'
#' These are all "templated_placeholder" objects, which allows the user to
#' specify two potential placeholders, allowing passing a `existing_placeholder`
#' object( `ref_placeholder()`), which tries to use an existing placeholder
#' either in the slide or defined in the layout, and the fallback must be a
#' `new_placeholder` object (`new_placeholder()`), which defines a placeholder
#' into the slide without needing there to be a pre-defined placeholder in the
#' slide layout.
#'
#' @param preferred placeholder object of class `existing placeholder`
#' @param fallback placeholder object of class `new_placeholder`
#' @inheritParams rlang::args_error_context
#'
#' @rdname ph_templates
#'
#' @export
templated_placeholder <- function(preferred, fallback, error_call = current_env()){
  check_existing_placeholder(preferred, error_call = error_call)
  check_fallback_placeholder(fallback, error_call = error_call)

  structure(
    list(
      preferred = preferred,
      fallback  = fallback
    ),
    class = c("templated_placeholder","placeholder")
  )
}

#' @export
print.new_placeholder <- function(x, ...) {
  cli_rule("new placeholder with settings: ")
  str(unclass(x))
  invisible(x)
}

#' @export
print.existing_placeholder <- function(x, ...) {
  cli_rule("reference placeholder with settings: ")
  str(unclass(x))
  invisible(x)
}

#' @export
print.templated_placeholder <- function(x, ...) {
  print(x$preferred)
  print(x$fallback)

  invisible(x)
}

#' @param replace Identify whether to replace the existing placeholder if
#'   it exists on the slide. Defaults to TRUE.
#' @rdname ph_templates
#' @export
ph_title <- function(replace = TRUE) {
  templated_placeholder(
    ref_placeholder(
      label       = "[Tt]itle",
      type        = c("title", "ctrTitle"),
      tie_breaker = "top",
      label_from  = c("layout","slide"),
      replace     = replace
    ),
    new_placeholder(
      type        = "title",
      x_offset    = "5%",
      width       = "90%",
      y_offset    = "5%",
      height      = "12.5%",
      label       = "mirage_title_placeholder"
    )
  )
}

#' @rdname ph_templates
#' @export
ph_subtitle <- function(replace = TRUE) {
  templated_placeholder(
    ref_placeholder(
      label       = "[Ss]ubtitle",
      type        = "subTitle",
      tie_breaker = "top",
      label_from  = c("layout","slide"),
      replace     = replace
    ),
    new_placeholder(
      type        = "body",
      x_offset    = "5%",
      width       = "90%",
      y_offset    = "17.5%",
      height      = "7.5%",
      label       = "mirage_subtitle_placeholder"
    )
  )
}

#' @rdname ph_templates
#' @export
ph_body <- function(replace = TRUE) {
  templated_placeholder(
    ref_placeholder(
      label       = "(([Cc]ontent)|([Tt]ext)) [Pp]laceholder",
      type        = c("body", "img"),
      tie_breaker = "largest",
      label_from  = c("layout","slide"),
      replace     = replace
    ),
    new_placeholder(
      type        = "body",
      x_offset    = "5%",
      width       = "90%",
      y_offset    = "27.5%",
      height      = "67.5%",
      label       = "mirage_body_placeholder"
    )
  )
}

#' @rdname ph_templates
#' @export
ph_body_left <- function(replace = TRUE) {
  templated_placeholder(
    ref_placeholder(
      label       = "(([Cc]ontent)|([Tt]ext)|([Tt]able)) [Pp]laceholder",
      type        = c("body", "img"),
      tie_breaker = c("left", "largest", "top"),
      label_from  = c("layout","slide"),
      replace     = replace
    ),
    new_placeholder(
      type        = "body",
      x_offset    = "5%",
      width       = "43.75%",
      y_offset    = "27.5%",
      height      = "67.5%",
      label       = "mirage_body_left_placeholder"
    )
  )
}

#' @rdname ph_templates
#' @export
ph_body_right <- function(replace = TRUE) {
  templated_placeholder(
    ref_placeholder(
      label       = "(([Cc]ontent)|([Tt]ext)|([Tt]able)) [Pp]laceholder",
      type        = c("body", "img"),
      tie_breaker = c("right", "largest", "top"),
      label_from  = c("layout","slide"),
      replace     = replace
    ),
    new_placeholder(
      type        = "body",
      x_offset    = "51.25%",
      width       = "43.75%",
      y_offset    = "27.5%",
      height      = "67.5%",
      label       = "mirage_body_right_placeholder"
    )
  )
}

#' @rdname ph_templates
#' @export
ph_footer <- function(replace = TRUE) {
  templated_placeholder(
    ref_placeholder(
      label       = "(([Tt]ext)|([Ff]ooter)) [Pp]laceholder",
      type        = c("body", "ftr"),
      tie_breaker = "bottom",
      label_from  = c("layout","slide"),
      replace     = replace
    ),
    new_placeholder(
      type        = "body",
      x_offset    = "5%",
      width       = "43.75%",
      y_offset    = "92.5%",
      height      = "5%",
      label       = "mirage_footer_left_placeholder"
    )
  )
}

#' @rdname ph_templates
#' @export
ph_footer_left <- function(replace = TRUE) {
  templated_placeholder(
    ref_placeholder(
      label       = "(([Cc]ontent)|([Tt]ext)|([Tt]able)) [Pp]laceholder",
      type        = c("body","ftr"),
      tie_breaker = c("smallest", "left", "bottom"),
      label_from  = c("layout","slide"),
      replace     = replace
    ),
    new_placeholder(
      type        = "body",
      x_offset    = "5%",
      width       = "43.75%",
      y_offset    = "92.5%",
      height      = "5%",
      label       = "mirage_footer_left_placeholder"
    )
  )
}

#' @rdname ph_templates
#' @export
ph_footer_right <- function(replace = TRUE) {
  templated_placeholder(
    ref_placeholder(
      label        = "(([Cc]ontent)|([Tt]ext)|([Tt]able)) [Pp]laceholder",
      type         = c("body","ftr"),
      tie_breaker  = c("smallest", "left", "bottom"),
      label_from  = c("layout","slide"),
      replace      = replace
    ),
    new_placeholder(
      type         = "body",
      x_offset     = "51.25%",
      width        = "43.75%",
      y_offset     = "92.5%",
      height       = "5%",
      label        = "mirage_footer_right_placeholder"
    )
  )
}

check_existing_placeholder <- function(preferred, error_call = caller_env()) {
  if (!inherits(preferred, "existing_placeholder")) {
    cli_abort("{.arg preferred} must be an `existing_placeholder`, not {.obj_type_friendly {preferred}}.", call = error_call)
  }
}

check_fallback_placeholder <- function(fallback, error_call = caller_env()) {
  if (!inherits(fallback, "new_placeholder")) {
    cli_abort("{.arg fallback} must be an `new_placeholder`, not {.obj_type_friendly {fallback}}.", call = error_call)
  }
}

