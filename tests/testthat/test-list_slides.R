test_that("list_slides() only return one row per slide", {
  local_options(mirage.verbose = FALSE)

  pptx <- load_pptx() |>
    add_slide(index = 1, layout = 'Title Slide',
      content(
        value = "hello",
        ph = new_placeholder(
         type = "body",
         x_offset = "5%",
         y_offset = "93%",
         width = "44%",
         height = "5%",
         label = "mirage_footer_left_placeholder 1"
        )
      )
    )

  expect_equal(nrow(list_slides(pptx)), 1L)
})

test_that("list_slides() works", {

  pptx <- load_pptx() |> add_slide(layout = "Blank") |> add_slide("Title Slide")

  out <- list_slides(pptx)
  expect_equal(nrow(out), 2)
  expect_equal(out$layout_ph[1], "Date Placeholder (1), Footer Placeholder (2), Slide Number Placeholder (3)")
  expect_equal(out$n_slide_ph, c(0, 0))

  out <- list_slides(pptx, keep_all = TRUE)
  expect_equal(nrow(out), 2)
  expect_true(grepl("Title", out$layout_ph[2]))
  expect_equal(out$n_slide_ph, c(0, 0))

})
