test_that("Listing existing table styles works", {

  pptx <- example_pptx()

  ## define a basic table style in the pptx
  cat(
    '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
      <a:tblStyleLst xmlns:a="http://schemas.openxmlformats.org/drawingml/2006/main">
      <a:tblStyle styleId="{291DBC07-340B-ACF5-F4C7-67FE120D59C4}" styleName="My Style"/>
      </a:tblStyleLst>
      ',
    file = file.path(pptx$rpptx$package_dir, "ppt/tableStyles.xml")
  )

  tab_styles <- get_table_styles(pptx)

  expect_equal(
    tab_styles,
    tibble(style_id = "{291DBC07-340B-ACF5-F4C7-67FE120D59C4}", style_name = "My Style")
  )

})


test_that("Adding table styles works", {

  pptx <- example_pptx()

  original_styles <- get_table_styles(pptx)

  pptx |>
    add_table_style(
      table_style = new_table_style(
        style_name = "My Style",
        style_id = "{9C371F8A-172E-2738-4F72-E6245D391BAC}",
        text_color = "pink")
    )

  updated_styles <- get_table_styles(pptx)

  new_styles <- updated_styles |>
    dplyr::filter(!style_id %in% original_styles$style_id)

  expect_equal(
    new_styles,
    tibble(style_id = "{9C371F8A-172E-2738-4F72-E6245D391BAC}", style_name = "My Style")
  )

})



test_that("Creating new table styles works", {

  pptx <- example_pptx()

  tab_style <- new_table_style(
        style_name = "My Style",
        style_id = "{9C371F8A-172E-2738-4F72-E6245D391BAC}",
        text_color = "pink",
        cell_color = "yellow"
    )

  expect_snapshot(tab_style)

})



test_that("Creating new table styles - invalid contents", {

  ## Bad style ID
  expect_snapshot_error(
    new_table_style(
      style_name = "My Style",
      style_id = "123456",
    )
  )

  ## Bad color Hex
  expect_snapshot_error(
    new_table_style(
      style_name = "My Style",
      style_id = "{9C371F8A-172E-2738-4F72-E6245D391BAC}",
      text_color = "ABC"
    )
  )

  ## Bad color Name
  expect_snapshot_error(
    new_table_style(
      style_name = "My Style",
      style_id = "{9C371F8A-172E-2738-4F72-E6245D391BAC}",
      text_color = "A Color"
    )
  )

  ## Bad tint
  expect_snapshot_error(
    new_table_style(
      style_name = "My Style",
      style_id = "{9C371F8A-172E-2738-4F72-E6245D391BAC}",
      text_color = tint_color("pink", tint = 1.5)
    )
  )

  ## Bad border style
  expect_snapshot_error(
    new_table_style(
      style_name = "My Style",
      style_id = "{9C371F8A-172E-2738-4F72-E6245D391BAC}",
      border_style = "Invalid"
    )
  )
  expect_snapshot_error(
    new_table_style(
      style_name = "My Style",
      style_id = "{9C371F8A-172E-2738-4F72-E6245D391BAC}",
      border_style = c("Invalid","twice")
    )
  )


})
