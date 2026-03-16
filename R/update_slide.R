#' @rdname add_slide
#' @export
update_slide <- function(pptx, index, ..., transition = NULL, polish_error_continue = TRUE, error_call = current_env(), verbose = getOption("mirage.verbose", default = TRUE)){
  # Check initial values ---
  check_slidenum(pptx, index, error_call = error_call)
  pptx <- remove_pptx_error(pptx = pptx, index = index)

  n <- ...length()
  if (n) {

    content_list <- tryCatch(
      check_mirage_content(..., error_call = error_call),
      error = function(e) {
        add_pptx_error(pptx, index = index, error = e)

        if (!isTRUE(polish_error_continue)) {
          cnd_signal(e)
        }
      }
    )

    if (!is.null(content_list)) {
      if (isTRUE(verbose)) {
        n_remove <- sum(sapply(content_list, inherits, "remove_mirage_content"))

        if (n_remove == 0) {
          action <- "add"
        } else if( n_remove < n) {
          action <- "modify"
        } else if( n_remove == n) {
          action <- "remove"
        }

        if (verbose) {
          mirage_inform(
            c(">" = "mirage to {action} {n} content{?s} at slide {index}."),
            class = "mirage_slide_inform"
          )
        }
      }

      for (content in content_list){
        pptx <- add_mirage_content_to_slide(
          pptx = pptx,
          index = index,
          content = content,
          polish_error_continue = polish_error_continue,
          error_call = error_call,
          verbose = verbose
        )
      }

      pptx <- increment_revision(pptx)
      save_slides(pptx)
    }
  }

  if (is_slide_transition(transition)){
    pptx <- add_mirage_slide_transition_to_slide(
      pptx, index, transition
    )
    save_slides(pptx)
  }

  pptx
}

#' Checks the given (`index=`) slide number
#'
#' @param ppt PowerPoint document
#' @param index Slide number
#' @inheritParams rlang::args_error_context
#'
#' @noRd
check_slidenum <- function(pptx, index, error_call = current_env()) {
  sldlen <- length(pptx)

  if (sldlen < 1) {
    cli_abort("Presentation contains no slides.",
      class = "mirage_invalid_slide_index", call = error_call
    )
  }

  if (index < 1 || index > sldlen) {
    cli_abort(c(
      "Invalid slide index: {index}.",
      i = "The document has {sldlen} slide{?s}."
    ), class = "mirage_invalid_slide_index", call = error_call)
  }
}

add_mirage_content_to_slide <- function(pptx, index, content, polish_error_continue = TRUE, error_call = current_env(), verbose = getOption("mirage.verbose", default = TRUE)){
  # save the slides before doing anything
  save_slides(pptx)

  # Then attempt to add {content} to the slide {index} if the {pptx} document
  #
  # Two things need to happen
  #   - creating the placeholder based on content$ph
  #   - polish the content$value and add it to the slide
  #
  # Each might fail with a specific error class
  #
  # polish_error_continue governs what happens in case of failure, if TRUE
  # then we get some information about what failed, but the process continues.
  # If FALSE, or we get a different class of errors, the process stops.
  tryCatch({
    # find/process the placeholder
    processed_ph <- try_process_placeholder(ph = content$ph, pptx = pptx, index = index, error_call = error_call)

    # make the xml structure to add to the slide
    ph_xml <- make_ph_shape(processed_ph, pptx = pptx)

    # add metadata
    metadata <- c(character(), content$metadata)
    xfrm <- xml_find_all(as_xml_pptx(ph_xml), ".//a:xfrm")
    if (length(xfrm)) {
      metadata <- c(
        metadata,
        "a:xfrm/a:off/@x"  = xml_attr(xml_find_all(xfrm, "a:off"), "x"),
        "a:xfrm/a:off/@y"  = xml_attr(xml_find_all(xfrm, "a:off"), "y"),
        "a:xfrm/a:ext/@cx" = xml_attr(xml_find_all(xfrm, "a:ext"), "cx"),
        "a:xfrm/a:ext/@cy" = xml_attr(xml_find_all(xfrm, "a:ext"), "cy")
      )
    }

    # polish it
    polished <- mirage_polish_content(content, ph = ph_xml, pptx = pptx)

    if(!is.null(polished)){
      if(content$group_content & length(polished) > 1){
        polished <- grp_content(
            polished,
            ph_xml
          )
      }

      xml_add_child(polished, metadata(metadata))
    }

    # remove existing content if need be
    if (isTRUE(processed_ph$replace) | is.null(polished)) {
      slide_ph_id <- processed_ph$slide_ph_id
      if (!is.na(slide_ph_id)) {
        pptx <- remove_slide_ph(pptx, ph_id = slide_ph_id, index = index)
      }

      if(!is.null(polished)){
        # replace generated id with slide_ph_id
        node <- xml_find_all(polished, ".//p:cNvPr")
        xml_attr(node, "id") <- slide_ph_id

        ## idx is not a viable attribute to ph, and needs to be removed before saving
        ## is remnant from loading and needing the ph_id
        ph <- xml_find_all(polished, ".//p:ph")
        xml_attr(ph, "idx") <- NULL
        if(identical(xml_attr(ph, "type"),"ph_group")){
          xml_attr(ph, "type") <- NULL
        }
      }
    } else {
      current_phs <- list_placeholders(pptx, index = index)$ph_label
      slide_ph_name <- processed_ph$slide_ph_name
      if (slide_ph_name %in% current_phs) {
        cli_abort(c(
          "Cannot create a new placeholder with the existing label {.val {slide_ph_name}}.",
          i = "Choose a label that is not already in use."
        ),call = error_call, class = "mirage_ph_unique_error")
      }
    }

    # add polished content
    if(!is.null(polished)){
      add_polished_content_to_slide(pptx, index, polished)
    }

    pptx <- increment_revision(pptx)
    label <- get_placeholder_label(ph_xml)

    if (isTRUE(verbose)) {

      if (is.null(polished)){
        success_text <- "Successfully removed content from placeholder {.val {label}}."
      } else{
        success_text <- "Successfully added content to placeholder {.val {label}}."
      }

      mirage_inform(
        c("v" = success_text),
        class = "mirage_adding_content_message"
      )
    }
  }, error = function(e) {
    add_pptx_error(pptx, index = index, error = e)

    if (inherits(content$ph,"templated_placeholder")) {
      bullets_placeholder <- c(
        "i" = "Preferred placeholder: {content$ph$preferred$label}. ",
        "i" = "Fallback placeholder: {content$ph$fallback$label}."
      )
    } else {
      bullets_placeholder <- c(
        "i" = "Placeholder Label: {content$ph$label}. "
      )
    }

    if (inherits(e, "mirage_polish_failure") && polish_error_continue) {
      if (isTRUE(verbose)) {
        bullets <- c(
          x = "Failed to {.emph polish} content of class {.cls {class(content$value)}} for slide {index}."
        )
        mirage_inform(bullets, class = "mirage_polish_inform", parent = e)
      }
    } else if (inherits(e, "mirage_polish_ph_failure") && polish_error_continue) {
      if (isTRUE(verbose)) {
        bullets <- c(
          x = "Failed to {.emph get placeholder} for content on slide {index}.",
          bullets_placeholder
        )
        mirage_inform(bullets, class = "mirage_polished_ph_inform", parent = e)
      }
    } else if (inherits(e, "mirage_ph_unique_error")) {
      cnd_signal(e)
    } else {

      if (is.null(content$value)) {
        error_context <- "Failed to remove content from slide {index}."
      } else {
        error_context <- "Failed to add content of class {.cls {class(content$value)}} to slide {index}."
      }

      bullets <- c(
        x = error_context,
        bullets_placeholder
      )
      cli_abort(bullets, call = error_call, parent = e)
    }
  })

  # Finally save the slides again after
  save_slides(pptx)
}

add_polished_content_to_slide <- function(pptx, index, polished){
  slide <- get_presentation_slide(pptx, index)$get()
  slide_spTree <- xml_find_first(slide, "//p:spTree")

  purrr::walk(polished, \(node) {
    xml_add_child(slide_spTree, node)
  })
}

get_placeholder_label <- function(ph_xml){
  cNvPr <- xml_find_first(sp_shell(ph_xml), ".//p:cNvPr")
  xml_attr(cNvPr, "name")
}
