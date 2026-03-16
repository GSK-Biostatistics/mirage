# Add content twice and remove a specific ph

    Code
      pptx <- update_slide(pptx, index = length(pptx), remove_content(ph = ref_placeholder(
        "placeholder 1")))
    Message
      > mirage to remove 1 content at slide 4.
      x Failed to get placeholder for content on slide 4.
      i Placeholder Label: placeholder 1.
      Caused by error in `update_slide()`:
      ! Failed to process placeholder.
      Caused by error in `process_placeholder()`:
      ! Unable to identify selection labels using the pattern `placeholder 1`.
      i Valid slide placeholder labels: "placeholder 2".
      i Valid layout placeholder labels: "Title 1", "Content Placeholder 2", "Date Placeholder 3", "Footer Placeholder 4", and "Slide Number Placeholder 5".
      v Updated revision to [...]

# Attempting to remove new_placeholder causes error

    Code
      remove_content(new_placeholder(label = "my new placeholder"))
    Condition
      Error in `remove_content()`:
      ! Attempting to remove a new placeholder is not valid.
      i Only use `mirage::remove_content()` to remove existing placeholders on the slide.
      i Use of the the predefined templated functions `ph_body()`, `ph_body_left()`, `ph_body_right()`, `ph_footer()`, `ph_footer_left()`, `ph_footer_right()`, `ph_subtitle()`, and `ph_title()`.
      i ... or create a reference to an exising placeholder with `mirage::ref_placeholder(label = 'placeholder label')`.

