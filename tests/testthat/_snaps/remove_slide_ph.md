# remove_slide_ph()

    Code
      remove_slide_ph(pptx, index = 3, ph_id = "foo")
    Condition
      Error in `remove_slide_ph()`:
      ! No occupied placeholder on presentation "mirage-example.pptx" / slide 3.

---

    Code
      remove_slide_ph(pptx, index = 1, ph_id = "foo")
    Condition
      Error in `remove_slide_ph()`:
      ! Placeholder with id "foo" not found on presentation "mirage-example.pptx" / slide 1.
      i Occupied placeholder:[..]

# remove_slide_ph(ph_id = NA)

    Code
      remove_slide_ph(pptx, ph_id = NA)
    Condition
      Error in `remove_slide_ph()`:
      ! Cannot remove a placeholder with `ph_id = NA`.

