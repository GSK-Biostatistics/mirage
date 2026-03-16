transform_remove_slide_ph <- function(x) {
  x <- gsub('Occupied placeholder:.*$', 'Occupied placeholder:[..]', x)
  x
}

test_that("remove_slide_ph()", {
  pptx <- example_pptx()

  expect_snapshot(error = TRUE, remove_slide_ph(pptx, index = 3, ph_id = "foo"))

  ph_slide1 <- read_slide_placeholders(pptx, index = 1, only_slide = TRUE)
  expect_equal(nrow(ph_slide1), 1L)

  id <- ph_slide1$slide_ph_id
  expect_snapshot(
    error = TRUE, transform = transform_remove_slide_ph,
    remove_slide_ph(pptx, index = 1, ph_id = "foo")
  )
  pptx <- remove_slide_ph(pptx, index = 1, ph_id = id)
  ph_slide1 <- read_slide_placeholders(pptx, index = 1, only_slide = TRUE)
  expect_equal(nrow(ph_slide1), 0L)

  ph_slide2 <- read_slide_placeholders(pptx, index = 2, only_slide = TRUE)
  id <- ph_slide2$slide_ph_id
  expect_equal(nrow(ph_slide2), 2L)
  pptx <- remove_slide_ph(pptx, index = 2, ph_id = id[1])
  expect_equal(nrow(read_slide_placeholders(pptx, index = 2, only_slide = TRUE)), 1L)
  pptx <- remove_slide_ph(pptx, index = 2, ph_id = id[2])
  expect_equal(nrow(read_slide_placeholders(pptx, index = 2, only_slide = TRUE)), 0L)

})

test_that("remove_slide_ph() w/ table", {
  local_options(mirage.verbose = FALSE)

  pptx <- load_pptx() |>
    add_slide(index = 1, layout = 'Title Slide') |>
    update_slide(
      index = 1,
      content(
        value = head(mtcars, 2),
        ph = new_placeholder(type = "body", x_offset = "60%", y_offset = "10%", width = "38%", height = "77%", label = "New Placeholder 24")
      )
    )


  data <- read_slide_placeholders(pptx, only_slide = TRUE, index = 1)
  expect_equal(nrow(data), 1)

  pptx <- pptx |>
    update_slide(
      index = 1,
      content(
        value = "hello",
        ph = ref_placeholder(label = "New Placeholder 24", label_match = "exact", label_from = "slide")
      )
    )

  data2 <- read_slide_placeholders(pptx, only_slide = TRUE, index = 1)
  expect_equal(data$slide_ph_id, data2$slide_ph_id)
})

test_that("remove_slide_ph(ph_id = NA)", {
  local_options(mirage.verbose = FALSE)

  pptx <- load_pptx()

  expect_snapshot(error = TRUE, remove_slide_ph(pptx, ph_id = NA))
})
