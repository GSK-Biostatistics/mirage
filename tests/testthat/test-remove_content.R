test_that("Simple add and remove content to a slide", {
  local_options(mirage.verbose = FALSE)

  pptx <- example_pptx() |>
    add_slide(
      layout = "Title and Content",
      content("TEST VALUE", ph = ph_body())
    )

  with_content_slide_ph <- list_slide_placeholders(pptx, index = length(pptx)) |>
    filter(origin == "slide")

  expect_equal(nrow(with_content_slide_ph), 1)

  pptx <- pptx |>
    update_slide(
      index = length(pptx),
      remove_content(ph = ph_body())
    )

  content_removed_slide_ph <- list_slide_placeholders(pptx, index = length(pptx)) |>
    filter(origin == "slide")

  expect_equal(nrow(content_removed_slide_ph), 0)


})

transform_revision <- function(x) {
  x <- gsub('Updated revision to.*$', 'Updated revision to [...]', x)
  x
}

test_that("Add content twice and remove a specific ph", {
  local_options(mirage.verbose = FALSE)

  pptx <- example_pptx() |>
    add_slide(
      layout = "Title and Content",
      content("TEST VALUE 1", ph = new_placeholder(label = "placeholder 1")),
      content("TEST VALUE 2", ph = new_placeholder(label = "placeholder 2"))
    )

  with_content_slide_ph <- list_slide_placeholders(pptx, index = length(pptx)) |>
    filter(origin == "slide")

  expect_equal(nrow(with_content_slide_ph), 2)
  expect_equal(with_content_slide_ph$ph_label, c("placeholder 1","placeholder 2"))

  pptx <- pptx |>
    update_slide(
      index = length(pptx),
      remove_content(ph = ref_placeholder("placeholder 1"))
    )

  content_removed_slide_ph <- list_slide_placeholders(pptx, index = length(pptx)) |>
    filter(origin == "slide")

  expect_equal(nrow(content_removed_slide_ph), 1)
  expect_equal(content_removed_slide_ph$ph_label, c("placeholder 2"))

  ## cannot remove same snapshot again
  local_options(mirage.verbose = TRUE)
  expect_snapshot(transform = transform_revision,
    pptx <- pptx |>
      update_slide(
        index = length(pptx),
        remove_content(ph = ref_placeholder("placeholder 1"))
      )
  )

})


test_that("Attempting to remove new_placeholder causes error", {
  expect_snapshot(
    error = TRUE,
    remove_content(new_placeholder(label = "my new placeholder")),
  )

})
