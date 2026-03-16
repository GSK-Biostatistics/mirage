#' check package versions
#'
#' check package versions and inform if they don't match
#' the version specified
#'
#' @param pkg package
#' @param version version that is expected
#'
#' @importFrom utils packageVersion
#' @export
check_pkg_version <- function(pkg, version) {
  if (packageVersion(pkg) < version) {
    cli::cli_inform(c(
      "This script was generated assuming version {.val {version}} of {.val {pkg}}. ",
      i = "You have version {.val {packageVersion(pkg)}} installed. ",
      i = "Things might still work, but if it doesn't this might be worth exploring."
    ))
  }
}
