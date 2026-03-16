#' Group multiple contents together when a polished object has multiple components
#' @noRd
grp_content <- function(content, ph_xml){

  content <- paste0(content, collapse = "\n")

  ph_xmlnode <- as_xml_nodeset(ph_xml, ns = "pptx")

  ph_id <- ph_xmlnode |> xml_find_all(".//p:cNvPr") |> xml2::xml_attr("id")
  ph_label <- ph_xmlnode |> xml_find_all(".//p:cNvPr") |> xml2::xml_attr("name")
  ph_offsets <- unlist(xml_attrs(xml_find_all(ph_xmlnode, ".//a:off")))
  ph_dims <-  unlist(xml_attrs(xml_find_all(ph_xmlnode, ".//a:ext")))

  grpSp_xml <- grpSp_shell(
    content = content,
    ph_id = ph_id,
    label = ph_label,
    left = ph_offsets["x"],
    top = ph_offsets["y"],
    width = ph_dims["cx"],
    height = ph_dims["cy"]
  )

  as_xml_nodeset(grpSp_xml, ns = "pptx")

}



grpSp_shell <- function(content, ph_id, label, left, top, width, height ){

  glue::glue('
			<p:grpSp>
				<p:nvGrpSpPr>
					<p:cNvPr id="{ph_id}" name="{label}">
					</p:cNvPr>
					<p:cNvGrpSpPr/>
					<p:nvPr/>
				</p:nvGrpSpPr>
				<p:grpSpPr>
					<a:xfrm>
						<a:off x="{left}"
						       y="{top}"/>
						<a:ext cx="{width}"
						       cy="{height}"/>
						<a:chOff x="{left}"
						         y="{top}"/>
						<a:chExt cx="{width}"
						         cy="{height}"/>
					</a:xfrm>
				</p:grpSpPr>
        {content}
      </p:grpSp>'
  )

}



