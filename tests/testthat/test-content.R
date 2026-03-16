test_that("content() asserts ph= is a placeholder", {
  expect_snapshot(
    error = TRUE,
    content(1, ph = 2)
  )
})

test_that("content() makes <content>", {
  x <- content(mtcars, ph = ph_body())
  expect_s3_class(x, "mirage_content")
})

test_that("content() is lazy about the class of value=", {
  value <- structure(list(), class = "not_polishable")
  ph <- ph_body()

  # first we test that we can wrap a <not_polishable> into a content
  x <- content(value, ph = ph)
  expect_s3_class(x, "mirage_content")

  # and make sure it would not pass mirage_polish_content()
  expect_snapshot(error = TRUE, mirage_polish_content(x, ph = ph))
})

test_that("check_mirage_content() checks ...", {
  expect_snapshot(error = TRUE, check_mirage_content(1))
  expect_snapshot(error = TRUE,
    check_mirage_content(
      content(1, ph_body()),
      mtcars
    )
  )

 contents <- check_mirage_content(
   content(1, ph_body()),
   content(2, ph_body_left())
 )
 expect_equal(contents[[1L]]$value, 1)
 expect_equal(contents[[2L]]$value, 2)
})

test_that("content() checks metadata=", {
  expect_snapshot(error = TRUE, content(metadata = c("foo", "bar")))
  expect_snapshot(error = TRUE, content(metadata = c(foo = 42)))
})
