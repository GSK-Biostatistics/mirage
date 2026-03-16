#' Define a shape to add
#'
#' Programmatically define a shape by its type, fill, effect. Will fill the
#' ph it is dropped into.
#'
#' @param x type of preset shape. See details for list of optional shapes
#' @param fill,outline hex code defining shape fill and outline colors. To use
#'   the default colors, put "default". To make the fill or outline see through,
#'   use `NULL`.
#' @param ... unused, for future expansion of options.
#'
#' @details
#'
#' List of available shapes:
#'
#' accentBorderCallout1, accentBorderCallout2,
#' accentBorderCallout3, accentCallout1, accentCallout2, accentCallout3,
#' actionButtonBackPrevious, actionButtonBeginning, actionButtonBlank,
#' actionButtonDocument, actionButtonEnd, actionButtonForwardNext,
#' actionButtonHelp, actionButtonHome, actionButtonInformation,
#' actionButtonMovie, actionButtonReturn, actionButtonSound, arc, bentArrow,
#' bentConnector2, bentConnector3, bentConnector4, bentConnector5, bentUpArrow,
#' bevel, blockArc, borderCallout1, borderCallout2, borderCallout3, bracePair,
#' bracketPair, callout1, callout2, callout3, can, chartPlus, chartStar, chartX,
#' chevron, chord, circularArrow, cloud, cloudCallout, corner, cornerTabs, cube,
#' curvedConnector2, curvedConnector3, curvedConnector4, curvedConnector5,
#' curvedDownArrow, curvedLeftArrow, curvedRightArrow, curvedUpArrow, decagon,
#' diagStripe, diamond, dodecagon, donut, doubleWave, downArrow,
#' downArrowCallout, ellipse, ellipseRibbon, ellipseRibbon2,
#' flowChartAlternateProcess, flowChartCollate, flowChartConnector,
#' flowChartDecision, flowChartDelay, flowChartDisplay, flowChartDocument,
#' flowChartExtract, flowChartInputOutput, flowChartInternalStorage,
#' flowChartMagneticDisk, flowChartMagneticDrum, flowChartMagneticTape,
#' flowChartManualInput, flowChartManualOperation, flowChartMerge,
#' flowChartMultidocument, flowChartOfflineStorage, flowChartOffpageConnector,
#' flowChartOnlineStorage, flowChartOr, flowChartPredefinedProcess,
#' flowChartPreparation, flowChartProcess, flowChartPunchedCard,
#' flowChartPunchedTape, flowChartSort, flowChartSummingJunction,
#' flowChartTerminator, folderCorner, frame, funnel, gear6, gear9, halfFrame,
#' heart, heptagon, hexagon, homePlate, horizontalScroll, irregularSeal1,
#' irregularSeal2, leftArrow, leftArrowCallout, leftBrace, leftBracket,
#' leftCircularArrow, leftRightArrow, leftRightArrowCallout,
#' leftRightCircularArrow, leftRightRibbon, irregularSeal1, leftRightUpArrow,
#' leftUpArrow, lightningBolt, line, lineInv, mathDivide, mathEqual, mathMinus,
#' mathMultiply, mathNotEqual, mathPlus, moon, nonIsoscelesTrapezoid, noSmoking,
#' notchedRightArrow, octagon, parallelogram, pentagon, pie, pieWedge, plaque,
#' plaqueTabs, plus, quadArrow, quadArrowCallout, rect, ribbon, ribbon2,
#' rightArrow, rightArrowCallout, rightBrace, rightBracket, round1Rect,
#' round2DiagRect, round2SameRect, roundRect, rtTriangle, smileyFace, snip1Rect,
#' snip2DiagRect, snip2SameRect, snipRoundRect, squareTabs, star10, star12,
#' star16, star24, star32, star4, star5, star6, star7, star8,
#' straightConnector1, stripedRightArrow, sun, swooshArrow, teardrop, trapezoid,
#' triangle, upArrow, upArrowCallout, upDownArrow, upDownArrowCallout,
#' uturnArrow, verticalScroll, wave, wedgeEllipseCallout, wedgeRectCallout,
#' wedgeRoundRectCallout
#'
#'
#' @examples
#'
#' shape("rightArrow", fill = "#000000", outline = "#ffffff")
#' shape("heart", fill = "orange", outline = "grey")
#'
#' @importFrom rlang check_dots_empty
#' @export
shape <- function(x, fill="default", outline="default", ...){

  rlang::check_dots_empty()

  x <- match.arg(x, preset_shapes)

  if(!is.null(fill) & !identical(fill, "default")){
    fill <- as_hex_codes(fill)
  }
  if(!is.null(outline) & !identical(outline, "default")){
    outline <- as_hex_codes(outline)
  }

  structure(
    list(
      shape = x,
      fill = fill,
      outline = outline
    ),
    class = "preset_shape"
  )

}

#' Polish fit models
#'
#' @param x preset_shape object to polish
#' @inheritParams polish::polish_content_pptx
#'
#' @examples
#'
#' pptx <- example_pptx() |>
#'  add_slide(
#'   layout = "Title and Content",
#'   content(shape("rightArrow", fill = "#000000", outline = "#ffffff"), ph = ph_title()),
#'   content(shape("heart", fill = "#ffffff", outline = "#000000"), ph = ph_body()),
#'   content(
#'     shape("funnel"),
#'     ph = new_placeholder(x_offset = "10%",y_offset="20%", height = "20%",width="22%")
#'    )
#'  )
#'
#' file <- tempfile(fileext = ".pptx")
#' pptx |> save_pptx(file)
#'
#' @importFrom polish polish_content_pptx as_xml_nodeset as_xml_pptx
#' @importFrom xml2 xml_find_first xml_add_child xml_add_sibling
#' @importFrom glue glue
#' @export
polish_content_pptx.preset_shape <- function(x, ph = "<p:ph/>", pptx, ..., error_call = current_env()){

  ph_node <- as_xml_nodeset(ph, ns = "pptx")

  spPr_node <- ph_node |>
    xml_find_first("//p:spPr") |>
    (\(x)x[[1]])()

  preset_geom <- glue('
        <a:prstGeom prst="{x$shape}">
          <a:avLst>
          </a:avLst>
        </a:prstGeom>') |>
    as_xml_node()

  spPr_node |>
    xml_add_child(preset_geom)

  if(!identical(x$fill, "default")){

    if(is.null(x$fill)){
      fill_node <- "<a:noFill/>"
    }else{
      fill_node <- glue('<a:solidFill> <a:srgbClr val="{x$fill}"/> </a:solidFill>')
    }

    spPr_node |>
      xml_add_child(as_xml_node(fill_node))
  }

  if(!identical(x$outline, "default")){
    if(is.null(x$outline)){
      line_fill <- "<a:noFill/>"
    }else{
      line_fill <- glue('<a:solidFill> <a:srgbClr val="{x$outline}"/> </a:solidFill>')
    }

    outline_node <- glue('<a:ln>	{line_fill} </a:ln>') |>
      as_xml_node()
    spPr_node |>
      xml_add_child(outline_node)
  }

  ph <- as.character(ph_node) |>
    paste0(collapse = "")

  xml_content <- glue('
        <p:sp>
          {ph}
          <p:style>
			     <a:lnRef idx="2">
						<a:schemeClr val="accent1">
							<a:shade val="15000"/>
						</a:schemeClr>
					</a:lnRef>
					<a:fillRef idx="1">
						<a:schemeClr val="accent1"/>
					</a:fillRef>
					<a:effectRef idx="0">
						<a:schemeClr val="accent1"/>
					</a:effectRef>
					<a:fontRef idx="minor">
						<a:schemeClr val="lt1"/>
					</a:fontRef>
				</p:style>
          <p:txBody>
					<a:bodyPr rtlCol="0" anchor="ctr"/>
					  <a:lstStyle/>
					  <a:p>
						  <a:pPr algn="ctr"/>
						  <a:endParaRPr />
					  </a:p>
				  </p:txBody>
				</p:sp>
        ')

  as_xml_pptx(xml_content, error_call = error_call)



}



preset_shapes <- c(
    "accentBorderCallout1",
    "accentBorderCallout2",
    "accentBorderCallout3",
    "accentCallout1",
    "accentCallout2",
    "accentCallout3",
    "actionButtonBackPrevious",
    "actionButtonBeginning",
    "actionButtonBlank",
    "actionButtonDocument",
    "actionButtonEnd",
    "actionButtonForwardNext",
    "actionButtonHelp",
    "actionButtonHome",
    "actionButtonInformation",
    "actionButtonMovie",
    "actionButtonReturn",
    "actionButtonSound",
    "arc",
    "bentArrow",
    "bentConnector2",
    "bentConnector3",
    "bentConnector4",
    "bentConnector5",
    "bentUpArrow",
    "bevel",
    "blockArc",
    "borderCallout1",
    "borderCallout2",
    "borderCallout3",
    "bracePair",
    "bracketPair",
    "callout1",
    "callout2",
    "callout3",
    "can",
    "chartPlus",
    "chartStar",
    "chartX",
    "chevron",
    "chord",
    "circularArrow",
    "cloud",
    "cloudCallout",
    "corner",
    "cornerTabs",
    "cube",
    "curvedConnector2",
    "curvedConnector3",
    "curvedConnector4",
    "curvedConnector5",
    "curvedDownArrow",
    "curvedLeftArrow",
    "curvedRightArrow",
    "curvedUpArrow",
    "decagon",
    "diagStripe",
    "diamond",
    "dodecagon",
    "donut",
    "doubleWave",
    "downArrow",
    "downArrowCallout",
    "ellipse",
    "ellipseRibbon",
    "ellipseRibbon2",
    "flowChartAlternateProcess",
    "flowChartCollate",
    "flowChartConnector",
    "flowChartDecision",
    "flowChartDelay",
    "flowChartDisplay",
    "flowChartDocument",
    "flowChartExtract",
    "flowChartInputOutput",
    "flowChartInternalStorage",
    "flowChartMagneticDisk",
    "flowChartMagneticDrum",
    "flowChartMagneticTape",
    "flowChartManualInput",
    "flowChartManualOperation",
    "flowChartMerge",
    "flowChartMultidocument",
    "flowChartOfflineStorage",
    "flowChartOffpageConnector",
    "flowChartOnlineStorage",
    "flowChartOr",
    "flowChartPredefinedProcess",
    "flowChartPreparation",
    "flowChartProcess",
    "flowChartPunchedCard",
    "flowChartPunchedTape",
    "flowChartSort",
    "flowChartSummingJunction",
    "flowChartTerminator",
    "folderCorner",
    "frame",
    "funnel",
    "gear6",
    "gear9",
    "halfFrame",
    "heart",
    "heptagon",
    "hexagon",
    "homePlate",
    "horizontalScroll",
    "irregularSeal1",
    "irregularSeal2",
    "leftArrow",
    "leftArrowCallout",
    "leftBrace",
    "leftBracket",
    "leftCircularArrow",
    "leftRightArrow",
    "leftRightArrowCallout",
    "leftRightCircularArrow",
    "leftRightRibbon",
    "irregularSeal1",
    "leftRightUpArrow",
    "leftUpArrow",
    "lightningBolt",
    "line",
    "lineInv",
    "mathDivide",
    "mathEqual",
    "mathMinus",
    "mathMultiply",
    "mathNotEqual",
    "mathPlus",
    "moon",
    "nonIsoscelesTrapezoid",
    "noSmoking",
    "notchedRightArrow",
    "octagon",
    "parallelogram",
    "pentagon",
    "pie",
    "pieWedge",
    "plaque",
    "plaqueTabs",
    "plus",
    "quadArrow",
    "quadArrowCallout",
    "rect",
    "ribbon",
    "ribbon2",
    "rightArrow",
    "rightArrowCallout",
    "rightBrace",
    "rightBracket",
    "round1Rect",
    "round2DiagRect",
    "round2SameRect",
    "roundRect",
    "rtTriangle",
    "smileyFace",
    "snip1Rect",
    "snip2DiagRect",
    "snip2SameRect",
    "snipRoundRect",
    "squareTabs",
    "star10",
    "star12",
    "star16",
    "star24",
    "star32",
    "star4",
    "star5",
    "star6",
    "star7",
    "star8",
    "straightConnector1",
    "stripedRightArrow",
    "sun",
    "swooshArrow",
    "teardrop",
    "trapezoid",
    "triangle",
    "upArrow",
    "upArrowCallout",
    "upDownArrow",
    "upDownArrowCallout",
    "uturnArrow",
    "verticalScroll",
    "wave",
    "wedgeEllipseCallout",
    "wedgeRectCallout",
    "wedgeRoundRectCallout"
    )
