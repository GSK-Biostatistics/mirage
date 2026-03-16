test_that("move_slide() moves to in correct position", {

  pptx <- example_pptx() |>
    add_slide(layout = "Title and Content") |>
    add_slide(layout = "Comparison") |>
    add_slide(layout = "Two Content")

  ## added 3 slides
  expect_equal(
    get_layout_names(pptx),
    c("Title and Content", "Two Content", "Comparison", "Title and Content", "Comparison","Two Content")
  )

  ## move slide 4 to 5,
  pptx <- pptx |>
    move_slide(4,5)

  expect_equal(
    get_layout_names(pptx),
    c("Title and Content", "Two Content", "Comparison", "Comparison", "Title and Content", "Two Content")
  )

  ## move slide 6 to 4,
  pptx <- pptx |>
    move_slide(6,4)

  expect_equal(
    get_layout_names(pptx),
    c("Title and Content", "Two Content",  "Comparison", "Two Content", "Comparison", "Title and Content")
  )

})

test_that("move_slide() moves twice", {

  pptx <- example_pptx() |>
    add_slide(layout = "Title and Content") |>
    add_slide(layout = "Comparison") |>
    add_slide(layout = "Two Content")

  ## added 3 slides
  expect_equal(
    get_layout_names(pptx),
    c("Title and Content", "Two Content",  "Comparison", "Title and Content", "Comparison","Two Content")
  )

  ## move slide 4 to 5,
  pptx <- pptx |>
    move_slide(4,5)

  expect_equal(
    get_layout_names(pptx),
    c("Title and Content", "Two Content", "Comparison", "Comparison", "Title and Content", "Two Content")
  )

  ## move slide 5 to 4,
  pptx <- pptx |>
    move_slide(5,4)

  expect_equal(
    get_layout_names(pptx),
    c("Title and Content", "Two Content", "Comparison", "Title and Content", "Comparison","Two Content")
  )

})


test_that("delete_slide() removes slides in correct position", {

  pptx <- example_pptx() |>
    add_slide(layout = "Title and Content") |>
    add_slide(layout = "Comparison") |>
    add_slide(layout = "Two Content")
  expect_equal(pptx$revision, 3)

  ## added 3 slides
  expect_equal(
    get_layout_names(pptx),
    c("Title and Content", "Two Content", "Comparison", "Title and Content", "Comparison","Two Content")
  )

  ## delete last slide
  pptx <- pptx |> delete_slide(6)
  expect_equal(pptx$revision, 4)

  expect_equal(
    get_layout_names(pptx),
    c("Title and Content", "Two Content", "Comparison", "Title and Content", "Comparison")
  )

  ## delete slide 4
  pptx <- pptx |> delete_slide(4)

  expect_equal(
    get_layout_names(pptx),
    c("Title and Content", "Two Content", "Comparison", "Comparison")
  )

})


test_that("move_slide() and delete_slide() removes slides in correct position", {

  pptx <- example_pptx() |>
    add_slide(layout = "Title and Content") |>
    add_slide(layout = "Comparison") |>
    add_slide(layout = "Two Content")

  ## added 3 slides
  expect_equal(
    get_layout_names(pptx),
    c("Title and Content", "Two Content", "Comparison", "Title and Content", "Comparison","Two Content")
  )

  ## move slide 6 to 4. then delete the new slide 6
  pptx <- pptx |>
    move_slide(6,4) |>
    delete_slide(6)

  expect_equal(
    get_layout_names(pptx),
    c("Title and Content", "Two Content", "Comparison","Two Content", "Title and Content")
  )

})
