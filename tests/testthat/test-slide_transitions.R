test_that("Adding slide transitions works", {


  pptx_no_transition <- example_pptx() |>
    add_slide(
      layout = "Title and Content"
    )


  pptx_with_transition <- example_pptx() |>
    add_slide(
      layout = "Title and Content",
      transition = slide_transition_blinds()
    )


  pptx_no_transition$rpptx$slide$get_slide(length(pptx_no_transition))$get() |>
    xml_find_all(".//p:transition") |>
    as.character() |>
    expect_equal(character())

  pptx_with_transition$rpptx$slide$get_slide(length(pptx_with_transition))$get() |>
    xml_find_all(".//p:transition") |>
    as.character() |>
    expect_equal('<p:transition spd="med">\n  <p:blinds dir="horz"/>\n</p:transition>')

})

test_that("Updating a slide with a transition works", {


  pptx <- example_pptx() |>
    add_slide(
      layout = "Title and Content"
    )

  pptx$rpptx$slide$get_slide(length(pptx))$get() |>
    xml_find_all(".//p:transition") |>
    as.character() |>
    expect_equal(character())

  pptx <- pptx |>
    update_slide(
      index = length(pptx),
      transition = slide_transition_blinds()
    )

  pptx$rpptx$slide$get_slide(length(pptx))$get() |>
    xml_find_all(".//p:transition") |>
    as.character() |>
    expect_equal('<p:transition spd="med">\n  <p:blinds dir="horz"/>\n</p:transition>')

})



test_that("Updating a slide with transition to another transition works", {


  pptx <- example_pptx() |>
    add_slide(
      layout = "Title and Content",
      transition = slide_transition_blinds()
    )

  pptx$rpptx$slide$get_slide(length(pptx))$get() |>
    xml_find_all(".//p:transition") |>
    as.character() |>
    expect_equal('<p:transition spd="med">\n  <p:blinds dir="horz"/>\n</p:transition>')

  pptx <- pptx |>
    update_slide(
      index = length(pptx),
      transition = slide_transition_checker()
    )

  pptx$rpptx$slide$get_slide(length(pptx))$get() |>
    xml_find_all(".//p:transition") |>
    as.character() |>
    expect_equal('<p:transition spd="med">\n  <p:checker dir="horz"/>\n</p:transition>')

})


test_that("Removing a slide transitions works", {

  pptx <- example_pptx() |>
    add_slide(
      layout = "Title and Content",
      transition = slide_transition_blinds()
    )

  pptx$rpptx$slide$get_slide(length(pptx))$get() |>
    xml_find_all(".//p:transition") |>
    as.character() |>
    expect_equal('<p:transition spd="med">\n  <p:blinds dir="horz"/>\n</p:transition>')

  pptx <- pptx |>
    update_slide(
      index = length(pptx),
      transition = slide_transition_null()
    )

  pptx$rpptx$slide$get_slide(length(pptx))$get() |>
    xml_find_all(".//p:transition") |>
    as.character() |>
    expect_equal(character())

})


test_that("slide transitions functions work", {

  expect_snapshot(
    list(
      slide_transition_blinds(),
      slide_transition_checker(),
      slide_transition_circle(),
      slide_transition_comb(),
      slide_transition_cover(),
      slide_transition_cut(),
      slide_transition_diamond(),
      slide_transition_dissolve(),
      slide_transition_fade(),
      slide_transition_newsflash(),
      slide_transition_plus(),
      slide_transition_pull(),
      slide_transition_push(),
      slide_transition_random(),
      slide_transition_randomBar(),
      slide_transition_split(),
      slide_transition_wedge(),
      slide_transition_wheel(),
      slide_transition_wipe(),
      slide_transition_zoom(),
      slide_transition_null()
    )
  )

})
