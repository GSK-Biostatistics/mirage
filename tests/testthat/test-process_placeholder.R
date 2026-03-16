test_that("process_placeholder()", {
  pptx <- load_pptx()
  pptx <- make_new_slide(pptx, index = 1, layout = "Title Slide")

  ph <- ph_subtitle()
  placeholder <- process_placeholder(ph, pptx, index = 1)
  expect_equal(placeholder$ph_type, "subTitle")
  expect_true(is.na(placeholder$slide_ph_name))
  expect_true(is.na(placeholder$slide_ph_id))

  placeholder_fallback <- process_placeholder(ph$fallback, pptx, index = 1)

  ph$preferred$label <- "<!!>"
  placeholder <- process_placeholder(ph, pptx, index = 1)
  expect_equal(placeholder, placeholder_fallback)

  expect_snapshot(
    error = TRUE,
    process_placeholder(ph$preferred, pptx, index = 1)
  )
})

test_that("process_placeholder.<existing> :: title", {
  pptx <- example_pptx()

  expected_placeholder <- filter(read_slide_placeholders(pptx, index = 1), ph_type == "title")

  ph <- ref_placeholder(
    label       = "[Tt]itle",
    label_match = "match",
    tie_breaker = "top",
    label_from  = "layout",
    replace     = TRUE
  )
  processed <- process_placeholder(ph, pptx, index = 1)

  expect_equal(expected_placeholder, select(processed, -replace), ignore_attr = TRUE)

  ph <- ref_placeholder(
    label       = "Title 1",
    label_match = "exact",
    tie_breaker = "top",
    label_from  = "layout",
    replace     = TRUE
  )
  processed <- process_placeholder(ph, pptx, index = 1)
  expect_equal(expected_placeholder, select(processed, -replace), ignore_attr = TRUE)
})

test_that("process_placeholder.<existing> :: content", {
  pptx <- example_pptx()

  expected_placeholder <- filter(
    read_slide_placeholders(pptx, index = 2),
    layout_ph_name == "Content Placeholder 2"
  )

  ph <- ref_placeholder(
    label       = "[Cc]ontent",
    label_match = "match",
    tie_breaker = c("top", "left"),
    label_from  = "layout",
    replace     = TRUE
  )
  processed <- process_placeholder(ph, pptx, index = 2)
  expect_equal(expected_placeholder, select(processed, -replace), ignore_attr = TRUE)

  expected_placeholder <- filter(
    read_slide_placeholders(pptx, index = 2),
    layout_ph_name == "Content Placeholder 3"
  )

  ph <- ref_placeholder(
    label       = "[Cc]ontent",
    label_match = "match",
    tie_breaker = c("top", "right"),
    label_from  = "layout",
    replace     = TRUE
  )
  processed <- process_placeholder(ph, pptx, index = 2)
  expect_equal(expected_placeholder, select(processed, -replace), ignore_attr = TRUE)
})

test_that("process_placeholder.<existing> :: body_left + right", {
  pptx <- load_pptx()
  expect_snapshot(
    pptx <- pptx |> add_slide(layout = "Comparison")
  )

  ph_left <- ph_body_left()$preferred
  processed_left <- process_placeholder(ph_left, pptx, index = 1)

  expected_placeholder_left <- filter(
    read_slide_placeholders(pptx, index = 1),
    layout_ph_name == "Content Placeholder 3"
  )
  expect_equal(expected_placeholder_left, select(processed_left, -replace), ignore_attr = TRUE)

  ph_right <- ph_body_right()$preferred
  processed_right <- process_placeholder(ph_right, pptx, index = 1)

  expected_placeholder_right <- filter(
    read_slide_placeholders(pptx, index = 1),
    layout_ph_name == "Content Placeholder 5"
  )
  expect_equal(expected_placeholder_right, select(processed_right, -replace), ignore_attr = TRUE)
})

test_that("process_placeholder(new_placeholder()) gets dimensions right", {
  local_options(mirage.verbose = FALSE)

  pptx <- load_pptx() |>
    add_slide(index = 1, layout = 'Title Slide')

  ph <- new_placeholder(type = "body", x_offset = "0%", y_offset = "0%", width = "100%", height = "100%", label = "New Placeholder")
  processed <- process_placeholder(ph, pptx)

  dims <- officer::slide_size(get_rpptx(pptx))
  expect_equal(processed$offx, 0)
  expect_equal(processed$offy, 0)
  expect_equal(processed$cx, dims$width)
  expect_equal(processed$cy, dims$height)

  ph <- new_placeholder(type = "body", x_offset = "25%", y_offset = "75%", width = "50%", height = "10%", label = "New Placeholder")
  processed <- process_placeholder(ph, pptx)
  expect_equal(processed$offx, dims$width * .25)
  expect_equal(processed$offy, dims$height * .75)
  expect_equal(processed$cx, dims$width * .5)
  expect_equal(processed$cy, dims$height * .1)
})

