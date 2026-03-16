test_that("list_placeholders()", {
  pptx <- load_pptx()

  expect_snapshot(error = TRUE, list_placeholders(pptx))
  expect_snapshot(error = TRUE, list_placeholders(pptx, layout = "fdfadfa"))

  expect_snapshot(
    list_placeholders(pptx, layout = "Title Slide")
  )

  pptx <- make_new_slide(pptx, index = 1, layout = "Title Slide")
  expect_snapshot(list_placeholders(pptx, index = 1))
})

test_that("list_placeholders() with new ppt", {
  pptx <- example_pptx()

  expect_snapshot(list_placeholders(pptx, index = 1))
  expect_snapshot(list_placeholders(pptx, index = 2))
  expect_snapshot(list_placeholders(pptx, index = 3))
})

test_that("list_placeholders() with a grpSp", {
  rlang::local_options(mirage.verbose = FALSE)

  local_methods(
    polish_content_pptx.foo = function(x, ph = '<p:ph/>', ..., error_call = current_env()) {
      map(x, polish::polish_content_pptx, ph = ph, ..., error_call = error_call) |>
        map_chr(~as.character(.x)) |>
        paste0(collapse = "\n") |>
        polish::as_xml_nodeset(ns = "pptx")
    }
  )

  foo <- structure(c("test","grouping"), class = "foo")

  pptx <- example_pptx() |>
    add_slide(
      layout = "Title Slide",
      content(
        foo,
        ph = new_placeholder(
          label = "my content",
          x_offset = "5%",
          y_offset = "50%",
          width = "90%",
          height = "10%"
        )
      )
    )

  expect_snapshot({
    list_placeholders(pptx, index = 1)
  })

})


