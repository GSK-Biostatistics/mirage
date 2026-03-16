test_that("add_slide() adds in correct position", {
  pptx <- example_pptx()
  pptx <- add_slide(pptx, index = 1, layout = "Title Only")
  placeholders <- read_one_slide_placeholders(pptx, index = 1)

  expect_true(all(placeholders$layout_name == "Title Only"))
  expect_true(all(placeholders$slide_file == "slide4.xml"))
})

test_that("add_slide() errors with info on wrong layout (#39)", {
  pptx <- example_pptx()
  expect_snapshot(error = TRUE, add_slide(pptx, layout = "foo"))
})

test_that("add_slide() errors with info on wrong index ", {
  pptx <- example_pptx()
  expect_snapshot(error = TRUE, add_slide(pptx, layout = "Title Slide", index = 0))
  expect_snapshot(error = TRUE, add_slide(pptx, layout = "Title Slide", index = 39))
})
