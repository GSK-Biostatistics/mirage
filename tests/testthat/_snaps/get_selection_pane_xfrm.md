# get_selection_pane_xfrm() error with unknown ph type

    Code
      get_selection_pane_xfrm(pptx$rpptx, index = 1, type = "<unknown ph type>",
      label = "[Tt]itle", label_match = "match", label_from = c("layout", "slide"),
      tie_breaker = "top", replace = TRUE)
    Condition
      Error in `get_selection_pane_xfrm()`:
      ! `type` must be one of "body", "title", "ctrTitle", "ftr", "subTitle", "tbl", "chart", "img", "dt", or "any", not "<unknown ph type>".

# get_selection_pane_xfrm() error with pattern not found

    Code
      get_selection_pane_xfrm(pptx, index = 1, type = "ctrTitle", label = "<?>",
        label_match = "match", label_from = c("layout", "slide"), tie_breaker = "top",
        replace = TRUE)
    Condition
      Error in `get_selection_pane_xfrm()`:
      ! Unable to identify selection labels using the pattern `<?>`.
      i Valid layout placeholder labels: "Title 1", "Subtitle 2", "Date Placeholder 3", "Footer Placeholder 4", and "Slide Number Placeholder 5".

