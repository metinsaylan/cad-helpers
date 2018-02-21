
(defun C:metraj (/ fname areas pf1 nr en tot_area)
  (setq areas nil)

;;;  (if (setq ss1 (ssget '((-4 . "<OR")
;;;                         (0 . "POLYLINE")
;;;                         (0 . "LWPOLYLINE")
;;;                         (0 . "CIRCLE")
;;;                         (0 . "ELLIPSE")
;;;                         (0 . "SPLINE")
;;;                         (0 . "REGION")
;;;                         (-4 . "OR>")
;;;                        )
;;;                )
;;;      )
;;;    (progn
;;;      (setq nr 0)
;;;      (setq tot_area 0.0)
;;;      (setq en (ssname ss1 nr))
;;;      (while en
;;;        (command "._area" "_O" en)
;;;		(setq objarea (getvar "area"))
;;;        (setq tot_area (+ tot_area objarea))
;;;		(setq areas (append areas (list objarea)))
;;;        (setq nr (1+ nr))
;;;        (setq en (ssname ss1 nr))
;;;      )
;;;      (princ "\nTotal Area = ")
;;;      (princ tot_area)
;;;    )
;;;  )
;;;  
  
  (while
	(setq ss1 (ssget '((-4 . "<OR")
                         (0 . "POLYLINE")
                         (0 . "LWPOLYLINE")
                         (0 . "CIRCLE")
                         (0 . "ELLIPSE")
                         (0 . "SPLINE")
                         (0 . "REGION")
                         (-4 . "OR>")
                        )
                )
      )
	  (progn

		  (setq nr 0)
		  (setq tot_area 0.0)
		  (setq en (ssname ss1 nr))
		  (while en
			(command "._area" "_O" en)
			(setq objarea (getvar "area"))
			(setq tot_area (+ tot_area objarea))
			(setq areas (append areas (list objarea)))
			(setq nr (1+ nr))
			(setq en (ssname ss1 nr))
		  )
		  (princ "\nTotal Area = ")
		  (princ tot_area)
		
	  )
     
  )

  (setq fname (getfiled "Save Areas" "" "txt" 1))
  (setq pf1 (open fname "w"))
  (foreach area areas
    (write-line
      (rtos area 2 3)
      pf1
    )
  )
  (close pf1)
  (princ)
)
