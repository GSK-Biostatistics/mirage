# content() asserts ph= is a placeholder

    Code
      content(1, ph = 2)
    Condition
      Error in `content()`:
      ! `ph` must be a placeholder, not a number.
      i Use of the the predefined templated functions `ph_body()`, `ph_body_left()`, `ph_body_right()`, `ph_footer()`, `ph_footer_left()`, `ph_footer_right()`, `ph_subtitle()`, and `ph_title()`.
      i ... or create your own placeholder with `mirage::ref_placeholder()` or `mirage::new_placeholder()`.

# content() is lazy about the class of value=

    Code
      mirage_polish_content(x, ph = ph)
    Condition
      Error in `mirage_polish_content()`:
      ! Cannot polish content for pptx documents.
      Caused by error in `polish_content_pptx()`:
      ! No available method for objects of type <not_polishable>.

# check_mirage_content() checks ...

    Code
      check_mirage_content(1)
    Condition
      Error:
      ! All elements of `...` must be marked as mirage content.
      x Element at position 1 is a number.
      i You can create mirage content with `mirage::content()`.

---

    Code
      check_mirage_content(content(1, ph_body()), mtcars)
    Condition
      Error:
      ! All elements of `...` must be marked as mirage content.
      x Element at position 2 is a data frame.
      i You can create mirage content with `mirage::content()`.

# content() checks metadata=

    Code
      content(metadata = c("foo", "bar"))
    Condition
      Error in `check_metadata()`:
      ! `metadata` must be a named character vector.

---

    Code
      content(metadata = c(foo = 42))
    Condition
      Error in `check_metadata()`:
      ! `metadata` must be a named character vector.

