#' extended properties metadata
#'
#' @param data Named character vector used as name= and value= for the `custom:property` nodes.
#' @param uri uri, used in the `p:ext` node
#' @inheritParams rlang::args_error_context
#'
#' @return a `p:extLst` tag
#'
#' @examples
#' metadata(c(foo = "abc", bar = "def"))
#'
#' @export
metadata <- function(data, uri = "r://package/mirage", error_call = current_env()) {
  properties <- as_properties(data, error_call = error_call)

  tags <- p$extLst(
    p$ext(uri = uri, custom$meta(!!!properties))
  )
  polish::as_xml_nodeset(as.character(tags), ns = "pptx")
}

#' Extract metadata element
#'
#' @param metadata named character vector
#' @param name name of element to extract
#' @param empty synonyms for ""
#'
#' @export
extract_metadata_element <- function(metadata, name = "name", empty = "<display>") {
  if (name %in% names(metadata)) {
    out <- metadata[[name]]
    if (out %in% empty) {
      out <- ""
    }
  } else {
    out <- ""
  }
  out
}

as_properties <- function(data, error_call = caller_env()) {
  data <- check_named_character(data)

  tryCatch(
    imap(data, custom$property) |> set_names(NULL),
    error = function(e) {
      cli::cli_abort("Error creating {.emph <custom:property>} node.", parent = e, call = error_call)
    }
  )
}

p <- list(
  extLst = function(...) {
    tag("p:extLst", dots_list(...))
  },

  ext = function(..., uri = "r://package/mirage", error_call = caller_env()) {
    check_is_scalar_string(uri, error_call = error_call)
    tag("p:ext", list2(uri = uri, ...))
  }

)

custom <- list(
  meta = function(...) {
    args <- list2("xmlns:custom" = "urn:schemas-microsoft-com:office:custom-properties", ...)
    tag("custom:meta", args)
  },

  property = function(value, name, error_call = caller_env()) {
    tag("custom:property", list(name = name, value = value))
  }
)

check_is_scalar_string <- function(x, error_call = caller_env(), arg = caller_arg(x)) {
  if (!is.null(x) && !is_scalar_character(x)) {
    cli::cli_abort("{.arg {arg}} must be a single string.", arg = arg, call = error_call)
  }
}
