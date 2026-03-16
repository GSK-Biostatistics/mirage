local_methods <- function(..., .frame = caller_env()) {
  rlang::local_bindings(..., .env = global_env(), .frame = .frame)
}
