test_that("preview_pptx returns a browsable HTML object from a pptx_container", {
  pptx <- example_pptx()
  result <- preview_pptx(pptx)

  expect_s3_class(result, "html")
  expect_true(isTRUE(attr(result, "browsable")))
})

test_that("preview_pptx returns a browsable HTML object from a file path", {
  pptx <- example_pptx()
  tmp <- tempfile(fileext = ".pptx")
  on.exit(unlink(tmp))
  save_pptx(pptx, tmp)

  result <- preview_pptx(tmp)

  expect_s3_class(result, "html")
  expect_true(isTRUE(attr(result, "browsable")))
})

test_that("preview_pptx HTML contains bundled JS and base64 PPTX data", {
  pptx <- example_pptx()
  result <- preview_pptx(pptx)
  html  <- as.character(result)

  expect_true(grepl("PptxViewJS", html, fixed = TRUE))
  expect_true(grepl("JSZip",      html, fixed = TRUE))
  expect_true(grepl("data:application/vnd.openxmlformats", html, fixed = TRUE))
})

test_that("preview_pptx errors informatively on bad input", {
  expect_error(preview_pptx("nonexistent.pptx"), class = "rlang_error")
  expect_error(preview_pptx(42),                 class = "rlang_error")
})
