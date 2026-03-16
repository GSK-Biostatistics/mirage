test_that("get_slide_file_name() works", {
  pptx <- load_pptx()

  pptx <- pptx |>
    add_slide(layout = "Title Slide") |>
    add_slide(layout = "Comparison", index = 1)

  expect_equal(basename(get_slide_file_name(pptx, index = 1)), "slide2.xml")
  expect_equal(basename(get_slide_file_name(pptx, index = 2)), "slide1.xml")

  expect_snapshot(error = TRUE, get_slide_file_name(pptx, index = 0))
  expect_snapshot(error = TRUE, get_slide_file_name(pptx, index = 3))

})
