# read_slide_placeholders()

    Code
      read_slide_placeholders(pptx, 4)
    Condition
      Error in `read_slide_placeholders()`:
      ! Error getting placeholders for slide 4.
      Caused by error in `read_slide_layout()`:
      ! `index` is out of bounds: 4.
      i Presentation has 3 slides.

# slide_ph_df()

    Code
      slide_ph_df(ppt, index = 4)
    Condition
      Error:
      ! `index` is out of bounds: 4.
      i Presentation has 3 slides.

# layout_ph_df()

    Code
      layout_ph_df(ppt, index = 4)
    Condition
      Error in `read_slide_layout()`:
      ! `index` is out of bounds: 4.
      i Presentation has 3 slides.

