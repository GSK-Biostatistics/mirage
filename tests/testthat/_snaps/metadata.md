# metadata

    Code
      metadata(42)
    Condition
      Error in `as_properties()`:
      ! `data` must be a named character vector.

---

    Code
      metadata(letters)
    Condition
      Error in `as_properties()`:
      ! `data` must be a named character vector.

---

    Code
      metadata(c(a = 42))
    Condition
      Error in `as_properties()`:
      ! `data` must be a named character vector.

---

    Code
      metadata(c(a = "ok", "not named"))
    Condition
      Error in `as_properties()`:
      ! `data` must be a named character vector.

