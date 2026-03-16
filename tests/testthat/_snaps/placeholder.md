# ref_placeholder() checks arguments

    Code
      ref_placeholder(label = "label", type = "foo")
    Condition
      Error in `ref_placeholder()`:
      ! `type` must be one of "body", "title", "ctrTitle", "ftr", "subTitle", "tbl", "chart", "img", or "any", not "foo".

---

    Code
      ref_placeholder(label = "label", label_match = "foo")
    Condition
      Error in `ref_placeholder()`:
      ! `label_match` must be one of "match" or "exact", not "foo".

---

    Code
      ref_placeholder(label = "label", label_from = "foo")
    Condition
      Error in `ref_placeholder()`:
      ! `label_from` must be one of "slide" or "layout", not "foo".

---

    Code
      ref_placeholder(label = "label", tie_breaker = "foo")
    Condition
      Error in `ref_placeholder()`:
      ! `tie_breaker` must be one of "largest", "smallest", "left", "right", "top", or "bottom", not "foo".

# new_placeholder() checks arguments

    Code
      new_placeholder(label = "label", type = "foo")
    Condition
      Error in `new_placeholder()`:
      ! `type` must be one of "body", "title", "ctrTitle", "ftr", "subTitle", "tbl", "chart", or "img", not "foo".

# new_placeholder() checks units

    Code
      new_placeholder(label = "label", x_offset = "foo")
    Condition
      Error in `new_placeholder()`:
      ! Invalid value for `x_offset` unit: "foo".
      i Only `%` (percent), `cm` (centimeters), or `in` (inches) are accepted.

---

    Code
      new_placeholder(label = "label", x_offset = "120%")
    Condition
      Error in `new_placeholder()`:
      ! Numeric value for `x_offset` must be between 0 and 100
      x Provided value: 120.

---

    Code
      new_placeholder(label = "label", y_offset = "foo")
    Condition
      Error in `new_placeholder()`:
      ! Invalid value for `y_offset` unit: "foo".
      i Only `%` (percent), `cm` (centimeters), or `in` (inches) are accepted.

---

    Code
      new_placeholder(label = "label", width = "foo")
    Condition
      Error in `new_placeholder()`:
      ! Invalid value for `width` unit: "foo".
      i Only `%` (percent), `cm` (centimeters), or `in` (inches) are accepted.

---

    Code
      new_placeholder(label = "label", height = "foo")
    Condition
      Error in `new_placeholder()`:
      ! Invalid value for `height` unit: "foo".
      i Only `%` (percent), `cm` (centimeters), or `in` (inches) are accepted.

