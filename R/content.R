#' Add or remove content from a slide
#'
#' [content()] lets a user specify a value to add to a slide, and the location
#' on the slide to add it through the ph argument. ph defines the placeholder,
#' or height, width, x and y offset of the bounding box where the content should
#' be added.
#'
#' [remove_content()] on the other hand, lets users specify a placeholder with
#' content that should be removed from the slide using the same placeholder
#' nomenclature. The placeholder must exist in the slide to be removed.
#'
#' @param value value to be polished and then added at the placeholder defined
#' @param ph Defining where values should be added to or removed from. Must be a
#'   placeholder object
#' @param metadata named character vector of metadata to store in the
#'   `p:extLst/p:ext/custom:meta/custom:metadata` nodes
#' @param group_contents boolean indicating if the polished value should be
#'   shown in the powerpoint as a grouped Sp. The default, and for most cases,
#'   TRUE.
#' @param ... arguments to include when polishing `value`
#' @inheritParams rlang::args_error_context
#'
#' @examples
#'
#' content("My Title 2", ph = ph_title())
#' content(mtcars      , ph = ph_body())
#'
#' remove_content(ph = ph_title())
#' remove_content(ph = ref_placeholder(label = "An Existing Placeholder"))
#'
#' @export
#' @rdname content

content <- function(value, ph = ph_body(), metadata = NULL, ..., group_contents = TRUE, error_call = current_env()){
  check_placeholder(ph, error_call = error_call)
  metadata <- check_metadata(metadata, error_call = error_call)
  check_group_contents(group_contents, error_call = error_call)

  structure(
    list(
      value          = value,
      ph             = ph,
      polishing_args = list2(...),
      metadata       = metadata,
      group_contents = group_contents
    ),
    class = "mirage_content"
  )
}

#' @export
#' @rdname content
remove_content <- function(ph, error_call = current_env()){
  if(inherits(ph,"new_placeholder")){

    ph_funs <- ls(pattern = "^ph_", asNamespace("mirage"))

    cli_abort(c(
        "Attempting to remove a new placeholder is not valid.",
        i = "Only use {.fn mirage::remove_content} to remove existing placeholders on the slide.",
        i = "Use of the the predefined templated functions {.fn {ph_funs}}.",
        i = "... or create a reference to an exising placeholder with {.code mirage::ref_placeholder(label = 'placeholder label')}."
      ),call = error_call)
  }
  x <- content(NULL, ph, replace = TRUE, error_call = error_call)
  class(x) <- c("remove_mirage_content", "mirage_content")
  x
}


check_metadata <- function(metadata, error_call = caller_env()) {
  if (is.null(metadata) || length(metadata) == 0L) {
    return(NULL)
  }

  check_named_character(metadata)
}

check_placeholder <- function(ph, error_call = caller_env()) {
  if (!inherits(ph, "placeholder")) {
    ph_funs <- ls(pattern = "^ph_", asNamespace("mirage"))

    cli_abort(c(
      "{.arg ph} must be a placeholder, not {.obj_type_friendly {ph}}.",
      i = "Use of the the predefined templated functions {.fn {ph_funs}}.",
      i = "... or create your own placeholder with {.fn mirage::ref_placeholder} or {.fn mirage::new_placeholder}."
    ), call = error_call)
  }
}

check_group_contents <- function(group, error_call = caller_env()){
  if(!is_logical(group, 1)){
    cli_abort(c(
      "{.arg group} must be a boolean TRUE or FALSE, not {.obj_type_friendly {ph}}."
    ), call = error_call)
  }
}

check_mirage_content <- function(..., error_call = caller_env()) {
  content_list <- withCallingHandlers(list2(...), error = function(e) {
    cli_abort(c(
        "All elements of {.arg ...} must be marked as mirage content."
      ), call = error_call, parent = e)
  })

  for (i in seq_along(content_list)) {
    x <- content_list[[i]]
    if (!inherits(x, "mirage_content")) {
      cli_abort(c(
        "All elements of {.arg ...} must be marked as mirage content.",
        x = "Element at position {i} is {.obj_type_friendly {x}}.",
        i = "You can create mirage content with {.fn mirage::content}."
      ), call = error_call)
    }
  }

  content_list
}

check_named_character <- function(x, error_call = caller_env(), arg = caller_arg(x)) {
  if (!is.character(x) || is.null(nms <- names(x)) || any(nms == "")) {
    cli::cli_abort("{.arg {arg}} must be a named character vector.", call = error_call)
  }
  x
}
