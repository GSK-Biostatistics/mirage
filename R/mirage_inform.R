powerup_inform <- function(message, ..., .envir = parent.frame(), target = getOption("powerup.inform", default = "console")) {
  fmt <- cli::format_message(message, .envir = .envir)
  if (target == "console") {
    rlang::inform(fmt, ...)
  } else {
    shiny::showNotification(fmt, type = "message")
  }
}
