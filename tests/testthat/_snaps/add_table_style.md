# Creating new table styles works

    Code
      tab_style
    Output
      {xml_node}
      <a:tblStyle styleId="{9C371F8A-172E-2738-4F72-E6245D391BAC}" styleName="My Style">
      [1] <a:wholeTbl>\n  <a:tcTxStyle>\n    <a:fontRef idx="minor">\n      <a:srgb ...
      [2] <a:band1H>\n  <a:tcStyle>\n    <a:tcBdr/>\n    <a:fill>\n      <a:solidFi ...
      [3] <a:band2H>\n  <a:tcStyle>\n    <a:tcBdr/>\n  </a:tcStyle>\n</a:band2H>
      [4] <a:band1V>\n  <a:tcStyle>\n    <a:tcBdr/>\n    <a:fill>\n      <a:solidFi ...
      [5] <a:band2V>\n  <a:tcStyle>\n    <a:tcBdr/>\n  </a:tcStyle>\n</a:band2V>
      [6] <a:lastCol>\n  <a:tcTxStyle b="on">\n    <a:fontRef idx="minor">\n      < ...
      [7] <a:firstCol>\n  <a:tcTxStyle b="on">\n    <a:fontRef idx="minor">\n       ...
      [8] <a:lastRow>\n  <a:tcTxStyle b="on">\n    <a:srgbClr val="FFC0CB"/>\n  </a ...
      [9] <a:firstRow>\n  <a:tcTxStyle b="on">\n    <a:srgbClr val="FFC0CB"/>\n  </ ...

# Creating new table styles - invalid contents

    Invalid style id. Format must be {[0-9A-F]{8}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{12}}

---

    invalid color name 'ABC'

---

    invalid color name 'A Color'

---

    `tint` must be a value between 0 and 1

---

    Argument `border_style` must be a valid border style.
    i Valid Border Styles: `sng` `dbl` `thickThin` `thinThick` `tri`
    x Provided value: `Invalid`

---

    Argument `border_style` can only be of length 1

