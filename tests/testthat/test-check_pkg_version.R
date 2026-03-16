version_transform <- function(x) {
  gsub(
    "assuming version ([0-9]+)[.]([0-9]+)[.]([0-9]+)([.]?.*) of ",
    "assuming version Y.Y.Y of ",
    gsub(
      "version ([0-9]+)[.]([0-9]+)[.]([0-9]+)([.]?.*) installed",
      "version X.X.X installed",
      x
    )
  )
}

test_that("check_pkg_version()", {
  expect_null(check_pkg_version("mirage", "0.1.0"))

  ref_version <- packageVersion("mirage")
  ## version is always one major version further
  larger_ref_version <- ref_version
  larger_ref_version[1,1] <- as.numeric(larger_ref_version[1,1])+1

  expect_snapshot(
    check_pkg_version("mirage", larger_ref_version),
    transform = version_transform
    )
})
