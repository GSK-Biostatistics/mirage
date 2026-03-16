add_mirage_slide_transition_to_slide <- function(pptx, index, transition){

  # save the slides before doing anything
  save_slides(pptx)

  # Then attempt to add {transition} to the slide {index}

  slide_xml <- get_presentation_slide(pptx, index)$get()
  slide_sld_xml <- xml_find_first(slide_xml, "//p:sld")

  # remove old transition if it exists
  previous_transition <- xml_find_all(slide_sld_xml,"//p:transition")
  if(length(previous_transition) > 0){
    xml_remove(previous_transition)
  }

  if(!inherits(transition,"slide_transition_null")){
    xml_add_child(slide_sld_xml, as_xml_node(as.character(transition)))
  }

  save_slides(pptx)

  pptx

}

#' Defined Slide Transitions
#'
#' Slide transitions define the transition to show when moving to the slide.
#' [slide_transition_generic()] allows the user to create and pass new types of
#' transitions. Otherwise, most standard transitions are already defined as
#' `slide_transition_*()` to allow the user to easily define a transtion and any
#' other assets the transition may need.
#'
#' @param type string defining the slide transition type
#' @param transition_type_xml string defining the OOXML of the transition type
#' @param speed speed of the slide transition - med, fast, or slow
#' @param orientation specify "horz" or "vert", defining the orientation of a
#'   transition
#' @param direction specify the direction of transition, with possible values of
#'   d (down), l (left), r (right), u (up), ld (left down), lu (left up), rd
#'   (right down), ru (right up). Not every transition allows every direction.
#'   Check the available default values to see what values can be used for every
#'   transition
#' @param black_screen boolean identifying if  the transition starts from a
#'   black screen and then transitions to new slide over black
#' @param zoom,split specify the direction of zoom, "in" or "out"
#' @param spokes specify the number of spokes in the wheel; values are integers.
#'
#' @examples
#'
#' pptx <- example_pptx()
#'
#' ## add a transition to a new slide
#' pptx <- pptx |>
#'    add_slide(
#'      layout = "Title and Content",
#'      transition = slide_transition_checker()
#'    )
#'
#' ## Update/add transition to n existing slide
#' pptx <- pptx |>
#'    update_slide(
#'      index = 1,
#'      transition = slide_transition_dissolve()
#'    )
#'
#'
#' @export
#'
#' @rdname slide_transitions
slide_transition_generic <- function(type, transition_type_xml, speed = c("med","fast","slow")){

  speed <- match.arg(speed)

  transition <- glue("<p:transition spd=\"{speed}\">\n{transition_type_xml}\n</p:transition>")

  structure(
    .Data = transition,
    class = c(paste0("slide_transition_",type), "slide_transition")
  )

}

is_slide_transition <- function(x){
  inherits(x, "slide_transition")
}

#' @rdname slide_transitions
#' @export
slide_transition_blinds <- function(orientation = c("horz","vert"), speed = "med"){
  orientation <- match.arg(orientation)
  transition <- glue("<p:blinds dir=\"{orientation}\"/>")
  slide_transition_generic("blinds", transition, speed = speed)
}

#' @rdname slide_transitions
#' @export
slide_transition_checker <- function(orientation = c("horz","vert"), speed = "med"){
  orientation <- match.arg(orientation)
  transition <- glue("<p:checker dir=\"{orientation}\"/>")
  slide_transition_generic("checker", transition, speed = speed)
}

#' @rdname slide_transitions
#' @export
slide_transition_circle <- function(orientation = c("horz","vert"), speed = "med"){
  orientation <- match.arg(orientation)
  transition <- glue("<p:circle dir=\"{orientation}\"/>")
  slide_transition_generic("circle", transition, speed = speed)
}


#' @rdname slide_transitions
#' @export
slide_transition_comb <- function(orientation = c("horz","vert"), speed = "med"){
  orientation <- match.arg(orientation)
  transition <- glue("<p:comb dir=\"{orientation}\"/>")
  slide_transition_generic("comb", transition, speed = speed)
}

#' @rdname slide_transitions

#' @export
slide_transition_cover <- function(direction = c("d","l","r","u","ld","lu","rd","ru"), speed = "med"){
  direction <- match.arg(direction)
  transition <- glue("<p:cover dir=\"{direction}\"/>")
  slide_transition_generic("cover", transition, speed = speed)
}

#' @rdname slide_transitions
#' @export
slide_transition_cut <- function(black_screen = FALSE, speed = "med"){
  stopifnot(is.logical(black_screen) & length(black_screen) == 1)
  black_screen <- tolower(black_screen)
  transition <- glue("<p:cut thruBlk=\"{black_screen}\"/>")
  slide_transition_generic("cut", transition, speed = speed)
}


#' @rdname slide_transitions
#' @export
slide_transition_diamond <- function(speed = "med"){
  transition <- glue("<p:diamond/>")
  slide_transition_generic("diamond", transition, speed = speed)
}

#' @rdname slide_transitions
#' @export
slide_transition_dissolve <- function(speed = "med"){
  transition <- glue("<p:dissolve/>")
  slide_transition_generic("dissolve", transition, speed = speed)
}


#' @rdname slide_transitions
#' @export
slide_transition_fade <- function(black_screen = FALSE, speed = "med"){
  stopifnot(is.logical(black_screen) & length(black_screen) == 1)
  black_screen <- tolower(black_screen)
  transition <- glue("<p:fade thruBlk=\"{black_screen}\"/>")
  slide_transition_generic("fade", transition, speed = speed)
}

#' @rdname slide_transitions
#' @export
slide_transition_newsflash <- function(speed = "med"){
  transition <- glue("<p:newsflash/>")
  slide_transition_generic("newsflash", transition, speed = speed)
}

#' @rdname slide_transitions
#' @export
slide_transition_plus <- function(speed = "med"){
  transition <- glue("<p:plus/>")
  slide_transition_generic("plus", transition, speed = speed)
}


#' @rdname slide_transitions

#' @export
slide_transition_pull <- function(direction = c("d","l","r","u","ld","lu","rd","ru"), speed = "med"){
  direction <- match.arg(direction)
  transition <- glue("<p:pull dir=\"{direction}\"/>")
  slide_transition_generic("pull", transition, speed = speed)
}

#' @rdname slide_transitions
#' @export
slide_transition_push <- function(direction = c("d","l","r","u"), speed = "med"){
  direction <- match.arg(direction)
  transition <- glue("<p:push dir=\"{direction}\"/>")
  slide_transition_generic("push", transition, speed = speed)
}


#' @rdname slide_transitions
#' @export
slide_transition_random <- function(speed = "med"){
  transition <- glue("<p:random/>")
  slide_transition_generic("random", transition, speed = speed)
}


#' @rdname slide_transitions
#' @export
slide_transition_randomBar <- function(orientation = c("horz","vert"), speed = "med"){
  orientation <- match.arg(orientation)
  transition <- glue("<p:randomBar dir=\"{orientation}\"/>")
  slide_transition_generic("randomBar", transition, speed = speed)
}

#' @rdname slide_transitions
#' @export
slide_transition_split <- function(split = c("in","out"), orientation = c("horz","vert"), speed = "med"){
  split <- match.arg(split)
  orientation <- match.arg(orientation)
  transition <- glue("<p:split dir=\"{split}\", orient = \"{orientation}\"/>")
  slide_transition_generic("split", transition, speed = speed)
}

#' @rdname slide_transitions
#' @export
slide_transition_pull <- function(direction = c("ld","lu","rd","ru"), speed = "med"){
  direction <- match.arg(direction)
  transition <- glue("<p:strips dir=\"{direction}\"/>")
  slide_transition_generic("strips", transition, speed = speed)
}


#' @rdname slide_transitions
#' @export
slide_transition_wedge <- function(speed = "med"){
  transition <- glue("<p:wedge/>")
  slide_transition_generic("wedge", transition, speed = speed)
}

#' @rdname slide_transitions
#' @export
slide_transition_wheel <- function(spokes = 4L, speed = "med"){
  if(!(is_integer(spokes, 1)) | spokes < 1){
    stop("spokes must be a positive integer")
  }
  transition <- glue("<p:wheel spokes=\"{spokes}\"/>")
  slide_transition_generic("strips", transition, speed = speed)
}

#' @rdname slide_transitions
#' @export
slide_transition_wipe <- function(direction = c("d","l","r","u"), speed = "med"){
  direction <- match.arg(direction)
  transition <- glue("<p:wipe dir=\"{direction}\"/>")
  slide_transition_generic("wipe", transition, speed = speed)
}

#' @rdname slide_transitions
#' @export
slide_transition_zoom <- function(zoom = c("in","out"), speed = "med"){
  zoom <- match.arg(zoom)
  transition <- glue("<p:zoom dir=\"{zoom}\"/>")
  slide_transition_generic("zoom", transition, speed = speed)
}

#' @rdname slide_transitions
#' @export
slide_transition_null <- function(){
  structure(
    .Data = "DROP TRANSITION",
    class = c("slide_transition_null", "slide_transition")
  )
}

