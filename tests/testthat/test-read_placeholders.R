test_that("read_slide_placeholders()", {
  pptx <- example_pptx()

  expect_snapshot(error = TRUE, read_slide_placeholders(pptx, 4))
})

test_that("read_slide_placeholders(only_=)", {
  pptx <- example_pptx()

  expect_equal(nrow(read_slide_placeholders(pptx, index = 1, only_slide = TRUE)), 1L)
  expect_equal(nrow(read_slide_placeholders(pptx, index = 1, only_layout = TRUE)), 4L)
  expect_equal(nrow(read_slide_placeholders(pptx, index = 1)), 5L)
})

test_that("read_one_slide_placeholders()", {
  pptx <- load_pptx()
  pptx <- make_new_slide(pptx, index = 1, layout = "Title Slide")

  xfrm_data <- read_one_slide_placeholders(pptx, index = 1)

  # no placeholder from slide
  expect_true(all(is.na(xfrm_data$slide_ph_name)))
  expect_true(all(is.na(xfrm_data$slide_ph_id)))
})

test_that("slide_ph_df()", {
  ppt <- example_pptx()
  df <- slide_ph_df(ppt, index = 1)
  expect_equal(nrow(df), 1)
  expect_equal(names(df), names(slide_ph_ptype()))
  expect_equal(df$slide_ph_name, "Content Placeholder 2")
  expect_equal(df$ph_id, "1")

  df <- slide_ph_df(ppt, index = 2)
  expect_equal(nrow(df), 2)
  expect_equal(df$slide_ph_name, c("my new left label", "my new right label"))
  expect_equal(names(df), names(slide_ph_ptype()))
  expect_equal(df$ph_id, c("1", "2"))

  df <- slide_ph_df(ppt, index = 3)
  expect_equal(nrow(df), 0)
  expect_equal(names(df), names(slide_ph_ptype()))

  expect_snapshot(error = TRUE,
    slide_ph_df(ppt, index = 4)
  )

})

test_that("layout_ph_df()", {
  ppt <- example_pptx()

  df <- layout_ph_df(ppt, index = 1)
  expect_equal(nrow(df), 5)
  expect_equal(names(df), names(layout_ph_ptype()))
  expect_equal(df$layout_ph_name, c(
    "Title 1", "Content Placeholder 2", "Date Placeholder 3",
    "Footer Placeholder 4", "Slide Number Placeholder 5"
  ))

  df <- layout_ph_df(ppt, index = 2)
  expect_equal(nrow(df), 6)
  expect_equal(names(df), names(layout_ph_ptype()))
  expect_equal(df$layout_ph_name, c(
    "Title 1", "Content Placeholder 2", "Content Placeholder 3",
    "Date Placeholder 4", "Footer Placeholder 5", "Slide Number Placeholder 6"
  ))

  df <- layout_ph_df(ppt, index = 3)
  expect_equal(nrow(df), 8)
  expect_equal(names(df), names(layout_ph_ptype()))
  expect_equal(df$layout_ph_name, c(
    "Title 1", "Text Placeholder 2", "Content Placeholder 3", "Text Placeholder 4",
    "Content Placeholder 5", "Date Placeholder 6", "Footer Placeholder 7",
    "Slide Number Placeholder 8"
  ))

  expect_snapshot(error = TRUE,
    layout_ph_df(ppt, index = 4)
  )

})

test_that("layout_ph_df() x layouts from template", {

  pptx <- load_pptx()
  layouts <- pptx$rpptx$slideLayouts$names()

  walk(layouts, function(layout) {
    pptx <- make_new_slide(pptx, index = 1, layout = layout)

    slide_xfrm <- get_presentation_slide(pptx, 1)$get_xfrm()

    df <- layout_ph_df(pptx, index = 1)
    expect_true(
      all(df$layout_ph_name %in% slide_xfrm$ph_label)
    )
  })

})

test_that("read_one_slide_placeholders() handle ph_id=NA (#51)", {
  rlang::local_options(mirage.verbose = FALSE)
  pptx <- load_pptx() |> add_slide(index = 1, layout = "Title Slide") |>
    update_slide(
      index = 1,
      content("", ph = new_placeholder(
        type = "body",
        x_offset = "5%",
        y_offset = "28%",
        width = "44%",
        height = "67%",
        label = "mirage_body_left_placeholder 1"
      ))
    )

  expect_equal(
    nrow(read_slide_placeholders(pptx, index = 1, only_slide = TRUE)),
    1
  )

})


test_that("read_one_slide_placeholders() handle content(metadata=)", {
  rlang::local_options(mirage.verbose = FALSE)
  pptx <- load_pptx() |> add_slide(index = 1, layout = "Title Slide") |>
    update_slide(
      index = 1,
      content("", metadata = c(foo = "abc", bar = "def"), ph = new_placeholder(
        type = "body",
        x_offset = "5%",
        y_offset = "28%",
        width = "44%",
        height = "67%",
        label = "mirage_body_left_placeholder 1"
      ))
    )

  expect_equal(
    read_slide_placeholders(pptx, index = 1, only_slide = TRUE)$metadata[[1]][c("foo", "bar")],
    c(foo = "abc", bar = "def")
  )

  pptx <- load_pptx() |>
    add_slide(index = 1, layout = "Title Slide") |>
    update_slide(
      index = 1,
      content("", metadata = c(foo = "abc", bar = "def"), ph = ref_placeholder(label = "Title 1", label_match = "exact"))
    )
  expect_equal(
    read_slide_placeholders(pptx, index = 1, only_slide = TRUE)$metadata[[1]][c("foo", "bar")],
    c(foo = "abc", bar = "def")
  )

})

