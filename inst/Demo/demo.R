

pptx <- load_pptx() |>
  add_slide(
    layout = "Title and Content",
    content("Hello World!", ph = ph_title()),
    content("THis is body text", ph = ph_body())
  ) |>
  add_slide(
    layout = "Comparison",
    content("Compare this!", ph = ph_title()),
    content("Left Side", ph = ph_body_left())
  )|>
  add_slide(
    layout = "Comparison",
    content("Compare this! 2 - the comparening", ph = ph_title()),
    content("Right Side", ph = ph_body_right())
  ) |>
  add_slide(
    layout = "Title and Content",
    content("what this?!", ph = ph_title()),
    content("This is body text", ph = ph_body()),
    content("footer text", ph = ph_footer())
  ) |>
  add_slide(
    layout = "Comparison",
    content("what this2?!", ph = ph_title()),
    content(polish::as_file(system.file("man/figures/logo.png", package = "mirage")), ph = ph_body_left()),
    content(flextable::flextable(head(mtcars)), ph = ph_body_right()),
    content("footer text", ph = ph_footer())
  )

temp_pptx <- tempfile(fileext = ".pptx")

pptx |> save_pptx(temp_pptx)
shell.exec(temp_pptx)



pptx <- load_pptx() |>
  add_slide(
    layout = "Title and Content",
    content("Hello World!", ph = ph_title()),
    content("Test Text", ph = ph_body()),
    content("my new placeholder", ph = new_placeholder(label = "my new ph", type = "body"))
  )

temp_pptx2 <- tempfile(fileext = ".pptx")

pptx |> save_pptx(temp_pptx2)
shell.exec(temp_pptx2)


## embedding ft

ft <- flextable::flextable(mtcars)

temp_pptx3 <- tempfile(fileext = ".pptx")

load_pptx() |>
  add_slide(
    layout = "Title and Content",
    content(ft, full_width = TRUE, ph = ph_body())
  ) |>
  save_pptx(temp_pptx3) |>
  shell.exec()


### embedding external files

tmp_html <- tempfile(fileext = ".html")

cat(
  c("<!DOCTYPE html>",
    "<html>",
    "<head>",
    "<title>Basic HTML Page</title>",
    "</head>",
    "<body>",
    "<p>This is basic <span style=\"color:pink;\">HTML</span> text</p>",
    "</body>",
    "</html>"),
  sep = "\n",
  file = tmp_html
)

tmp_rtf <- tempfile(fileext = ".rtf")

cat(
  "{\\rtf1\\ansi\\deff0\nHello, \\b world\\b0! This is \\i basic\\i0  RTF text.\n}",
  file = tmp_rtf
)


temp_pptx4 <- tempfile(fileext = ".pptx")

test <- load_pptx() |>
  add_slide(
    layout = "Title and Content",
    content(as_file(tmp_html), ph = ph_body())
  ) |>
  add_slide(
    layout = "Title and Content",
    content(as_file(tmp_rtf), ph = ph_body())
  ) |>
  save_pptx(temp_pptx4) |>
  shell.exec()


