


(defun C:pdfA3()
	(setvar "CMDECHO" 0)
	(command "_.plot" "Yes" "" "DWG to PDF.pc3" "ISO A3 (420.00 x 297.00 MM)" "Millimeters" "Landscape" "No" "Extents" "1:1" "6, 7" "Yes" "" "Yes" "No" "" "" (getfiled "Save PDF as.." "" "pdf" 1) "No" "Yes" )
	(setvar "CMDECHO" 0)
	(princ)
)

(defun C:pdfA4()
	(setvar "CMDECHO" 0)
	(command "_.plot" "Yes" "" "DWG to PDF.pc3" "ISO A4 (210.00 x 297.00 MM)" "Millimeters" "Portrait" "No" "Extents" "1:1" "6, 7" "Yes" "" "Yes" "No" "" "" (getfiled "Save PDF as.." "" "pdf" 1) "No" "Yes" )
	(setvar "CMDECHO" 0)
	(princ)
)