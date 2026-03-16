test_that("get_selection_pane_xfrm() error with unknown ph type", {
  pptx <- load_pptx()
  pptx <- make_new_slide(pptx, index = 1, layout = "Title Slide")

  expect_snapshot(error = TRUE, get_selection_pane_xfrm(
    pptx$rpptx, index = 1,
    type = "<unknown ph type>",
    label = "[Tt]itle",
    label_match = "match",
    label_from = c("layout", "slide"),
    tie_breaker = "top",
    replace = TRUE
  ))
})

test_that("get_selection_pane_xfrm() error with pattern not found", {
  pptx <- load_pptx()
  pptx <- make_new_slide(pptx, index = 1, layout = "Title Slide")

  expect_snapshot(error = TRUE, get_selection_pane_xfrm(
    pptx, index = 1,
    type = "ctrTitle",
    label = "<?>",
    label_match = "match",
    label_from = c("layout", "slide"),
    tie_breaker = "top",
    replace = TRUE
  ))

  # TODO: same test with slide placeholder
})

test_that("get_selection_pane_xfrm(Title Slide)", {
  pptx <- load_pptx()
  pptx <- make_new_slide(pptx, index = 1, layout = "Title Slide")

  selected <- get_selection_pane_xfrm(
    pptx, index = 1,
    type = "ctrTitle",
    label = "[Tt]itle",
    label_match = "match",
    label_from = c("layout", "slide"),
    tie_breaker = "top",
    replace = TRUE
  )

  expect_true(grepl("^Title", selected$layout_ph_name))
  expect_equal(selected$ph_type, "ctrTitle")
})

test_that("get_selection_pane_xfrm(Two Content 2)", {
  pptx <- load_pptx()
  pptx <- make_new_slide(pptx, index = 1, layout = "Two Content")

  selected <- get_selection_pane_xfrm(
    pptx, index = 1,
    type = "title",
    label = "[Tt]itle",
    label_match = "match",
    label_from = "layout",
    tie_breaker = "top",
    replace = TRUE
  )

  expect_true(grepl("^Title", selected$layout_ph_name))
  expect_equal(selected$ph_type, "title")

  selected <- get_selection_pane_xfrm(
    pptx, index = 1,
    type = "dt",
    label = "[Dd]ate",
    label_match = "match",
    label_from = "layout",
    tie_breaker = "top",
    replace = TRUE
  )

  expect_true(grepl("^Date", selected$layout_ph_name))
  expect_equal(selected$ph_type, "dt")

})
