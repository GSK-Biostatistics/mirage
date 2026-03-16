test_that("extract_dimensions()", {
  local_options(mirage.verbose = FALSE)
  withr::local_package("ggplot2")

  pptx <- load_pptx() |>
    add_slide(index = 1, layout = 'Title Slide') |>
    update_slide(
      index = 1,
      content(
        value = 42,
        ph = new_placeholder(x_offset = "3%", y_offset = "5%", width = "54%", height = "88%", label = "number")
      ),

      content(
        value = head(iris, 2),
        ph = new_placeholder(x_offset = "3%", y_offset = "5%", width = "54%", height = "88%", label = "table")
      ),

      content(
        value = ggplot(mtcars, aes(x = mpg, y = cyl)) + geom_point(),
        ph = new_placeholder(x_offset = "3%", y_offset = "5%", width = "54%", height = "88%", label = "plot")
      )
    )
  dims <- officer::slide_size(pptx$rpptx)

  data <- read_slide_placeholders(pptx, index = 1, only_slide = TRUE)
  expect_equal(nrow(data), 3)

  expect_equal(data$offx, rep(dims$width * .03, 3))
  expect_equal(data$offy, rep(dims$height * .05, 3))

  expect_equal(data$cx, rep(dims$width * .54, 3))
  expect_equal(data$cy, rep(dims$height * .88, 3))

  pptx <- pptx |>
    update_slide(
      index = 1,
      content(
        value = "hello",
        ph = ref_placeholder(label = "table", label_match = "exact", label_from = "slide")
      )
    )

  data <- read_slide_placeholders(pptx, index = 1, only_slide = TRUE)
  expect_equal(nrow(data), 3)

  expect_equal(data$offx, rep(dims$width * .03, 3))
  expect_equal(data$offy, rep(dims$height * .05, 3))

  expect_equal(data$cx, rep(dims$width * .54, 3))
  expect_equal(data$cy, rep(dims$height * .88, 3))

})
