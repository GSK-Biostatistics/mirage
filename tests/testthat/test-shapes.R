test_that("Creating preset shapes works", {

  defined_shape <- shape("bentArrow")

  expect_s3_class(defined_shape, "preset_shape")
  expect_equal(defined_shape$shape, "bentArrow")
  expect_equal(defined_shape$fill, "default")
  expect_equal(defined_shape$outline, "default")


  defined_shape_colors <- shape("bentArrow", fill = "red", outline = "green")
  expect_s3_class(defined_shape_colors, "preset_shape")
  expect_equal(defined_shape_colors$shape, "bentArrow")
  expect_equal(defined_shape_colors$fill, "FF0000")
  expect_equal(defined_shape_colors$outline, "00FF00")

  defined_shape_colors_hex <- shape("bentArrow", fill = "#FFFFFF", outline = "#FFFF00")
  expect_s3_class(defined_shape_colors_hex, "preset_shape")
  expect_equal(defined_shape_colors_hex$shape, "bentArrow")
  expect_equal(defined_shape_colors_hex$fill, "FFFFFF")
  expect_equal(defined_shape_colors_hex$outline, "FFFF00")

})

test_that("Polishing preset shapes to pptx works", {

  expect_snapshot(
    polish_content_pptx(shape("bentArrow"))
  )

  expect_snapshot(
    polish_content_pptx(shape("bentArrow", fill = "red", outline = "green"))
  )

})



test_that("creating preset shapes expected errors", {

  expect_snapshot(
    shape("INVALID SHAPE"),
    error = TRUE
  )

})
