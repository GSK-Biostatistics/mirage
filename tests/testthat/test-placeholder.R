test_that("ref_placeholder", {
  ph <- ref_placeholder(
    label = "[Tt]itle",
    type = "title",
    tie_breaker = "top",
    label_from = c("slide","layout"),
    replace = TRUE
  )

  expect_equal(ph$label, "[Tt]itle")
  expect_equal(ph$type, "title")
  expect_equal(ph$tie_breaker, "top")
  expect_equal(ph$label_from, c("slide", "layout"))
  expect_equal(ph$label_match, "match")
  expect_equal(ph$replace, TRUE)
})


test_that("ref_placeholder() checks arguments", {
  expect_snapshot(error = TRUE, ref_placeholder(label = "label", type = "foo"))
  expect_snapshot(error = TRUE, ref_placeholder(label = "label", label_match = "foo"))
  expect_snapshot(error = TRUE, ref_placeholder(label = "label", label_from = "foo"))
  expect_snapshot(error = TRUE, ref_placeholder(label = "label", tie_breaker = "foo"))
})

test_that("new_placeholder() checks arguments", {
  expect_snapshot(error = TRUE, new_placeholder(label = "label", type = "foo"))
})

test_that("new_placeholder() checks units", {
  expect_snapshot(error = TRUE, new_placeholder(label = "label", x_offset = "foo"))
  expect_snapshot(error = TRUE, new_placeholder(label = "label", x_offset = "120%"))
  expect_snapshot(error = TRUE, new_placeholder(label = "label", y_offset = "foo"))
  expect_snapshot(error = TRUE, new_placeholder(label = "label", width = "foo"))
  expect_snapshot(error = TRUE, new_placeholder(label = "label", height = "foo"))
})

