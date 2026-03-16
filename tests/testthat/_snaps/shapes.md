# Polishing preset shapes to pptx works

    Code
      polish_content_pptx(shape("bentArrow"))
    Output
      <p:sp>
        <p:ph/>
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
            <a:endParaRPr/>
          </a:p>
        </p:txBody>
      </p:sp>

---

    Code
      polish_content_pptx(shape("bentArrow", fill = "red", outline = "green"))
    Output
      <p:sp>
        <p:ph/>
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
            <a:endParaRPr/>
          </a:p>
        </p:txBody>
      </p:sp>

# creating preset shapes expected errors

    Code
      shape("INVALID SHAPE")
    Condition
      Error in `match.arg()`:
      ! 'arg' should be one of "accentBorderCallout1", "accentBorderCallout2", "accentBorderCallout3", "accentCallout1", "accentCallout2", "accentCallout3", "actionButtonBackPrevious", "actionButtonBeginning", "actionButtonBlank", "actionButtonDocument", "actionButtonEnd", "actionButtonForwardNext", "actionButtonHelp", "actionButtonHome", "actionButtonInformation", "actionButtonMovie", "actionButtonReturn", "actionButtonSound", "arc", "bentArrow", "bentConnector2", "bentConnector3", "bentConnector4", "bentConnector5", "bentUpArrow", "bevel", "blockArc", "borderCallout1", "borderCallout2", "borderCallout3", "bracePair", "bracketPair", "callout1", "callout2", "callout3", "can", "chartPlus", "chartStar", "chartX", "chevron", "chord", "circularArrow", "cloud", "cloudCallout", "corner", "cornerTabs", "cube", "curvedConnector2", "curvedConnector3", "curvedConnector4", "curvedConnector5", "curvedDownArrow", "curvedLeftArrow", "curvedRightArrow", "curvedUpArrow", "decagon", "diagStripe", "diamond", "dodecagon", "donut", "doubleWave", "downArrow", "downArrowCallout", "ellipse", "ellipseRibbon", "ellipseRibbon2", "flowChartAlternateProcess", "flowChartCollate", "flowChartConnector", "flowChartDecision", "flowChartDelay", "flowChartDisplay", "flowChartDocument", "flowChartExtract", "flowChartInputOutput", "flowChartInternalStorage", "flowChartMagneticDisk", "flowChartMagneticDrum", "flowChartMagneticTape", "flowChartManualInput", "flowChartManualOperation", "flowChartMerge", "flowChartMultidocument", "flowChartOfflineStorage", "flowChartOffpageConnector", "flowChartOnlineStorage", "flowChartOr", "flowChartPredefinedProcess", "flowChartPreparation", "flowChartProcess", "flowChartPunchedCard", "flowChartPunchedTape", "flowChartSort", "flowChartSummingJunction", "flowChartTerminator", "folderCorner", "frame", "funnel", "gear6", "gear9", "halfFrame", "heart", "heptagon", "hexagon", "homePlate", "horizontalScroll", "irregularSeal1", "irregularSeal2", "leftArrow", "leftArrowCallout", "leftBrace", "leftBracket", "leftCircularArrow", "leftRightArrow", "leftRightArrowCallout", "leftRightCircularArrow", "leftRightRibbon", "leftRightUpArrow", "leftUpArrow", "lightningBolt", "line", "lineInv", "mathDivide", "mathEqual", "mathMinus", "mathMultiply", "mathNotEqual", "mathPlus", "moon", "nonIsoscelesTrapezoid", "noSmoking", "notchedRightArrow", "octagon", "parallelogram", "pentagon", "pie", "pieWedge", "plaque", "plaqueTabs", "plus", "quadArrow", "quadArrowCallout", "rect", "ribbon", "ribbon2", "rightArrow", "rightArrowCallout", "rightBrace", "rightBracket", "round1Rect", "round2DiagRect", "round2SameRect", "roundRect", "rtTriangle", "smileyFace", "snip1Rect", "snip2DiagRect", "snip2SameRect", "snipRoundRect", "squareTabs", "star10", "star12", "star16", "star24", "star32", "star4", "star5", "star6", "star7", "star8", "straightConnector1", "stripedRightArrow", "sun", "swooshArrow", "teardrop", "trapezoid", "triangle", "upArrow", "upArrowCallout", "upDownArrow", "upDownArrowCallout", "uturnArrow", "verticalScroll", "wave", "wedgeEllipseCallout", "wedgeRectCallout", "wedgeRoundRectCallout"

