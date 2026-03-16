test_that("metadata", {
  xml <- metadata(c(foo = "abc", bar = "def"))
  expect_equal(
    xml_find_all(xml, "//custom:property") |> xml_attr("name"),
    c("foo", "bar")
  )

  expect_snapshot(error = TRUE, metadata(42))
  expect_snapshot(error = TRUE, metadata(letters))
  expect_snapshot(error = TRUE, metadata(c(a = 42)))
  expect_snapshot(error = TRUE, metadata(c(a = "ok", "not named")))
})

test_that("extract_metadata()", {
  metadata <- c("name" = "Taylor")
  expect_equal(extract_metadata_element(metadata), "Taylor")
  expect_equal(extract_metadata_element(metadata, "foo"), "")

  metadata <- c("name" = "<display>")
  expect_equal(extract_metadata_element(metadata), "")

  metadata <- c("abc" = "Swift")
  expect_equal(extract_metadata_element(metadata), "")
  expect_equal(extract_metadata_element(metadata, "abc"), "Swift")

  metadata <- c()
  expect_equal(extract_metadata_element(metadata), "")

  metadata <- NULL
  expect_equal(extract_metadata_element(metadata), "")
})
