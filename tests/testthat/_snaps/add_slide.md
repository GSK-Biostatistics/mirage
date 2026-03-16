# add_slide() errors with info on wrong layout (#39)

    Code
      add_slide(pptx, layout = "foo")
    Condition
      Error in `add_slide()`:
      ! Layout "foo" not found in presentation "mirage-example.pptx".
      i `layout` must be one of "Title Slide", "Title and Content", "Section Header", "Two Content", "Comparison", "Title Only", and "Blank".
      i Run `mirage::list_layouts()` for more information about each available layout.

# add_slide() errors with info on wrong index 

    Code
      add_slide(pptx, layout = "Title Slide", index = 0)
    Condition
      Error in `check_new_slide_index()`:
      ! Invalid `index` (0) for new slide in "mirage-example.pptx" presentation.
      i `index` must be between 1 and 4.

---

    Code
      add_slide(pptx, layout = "Title Slide", index = 39)
    Condition
      Error in `check_new_slide_index()`:
      ! Invalid `index` (39) for new slide in "mirage-example.pptx" presentation.
      i `index` must be between 1 and 4.

