;;;
;;; Pts2file.lsp - navalsuite.com
;;;
;;;--------------------------------------------------------------
;;; Available commands
;;;==============================================================
;;; pts2file	: Writes (x, y) distances from origin to a file
;;; vWrite		: Writes points of a polyline to a file
;;;--------------------------------------------------------------

(defun C:pts2file (/ pfilename1 pts origin pt distx disty pf1 cpt)

  (setq pts nil)

  (setq origin (getpoint "\nPick origin: "))

  (while
    (setq pt (getpoint))
     (setq distx (- (car pt) (car origin)))
     (setq disty (- (cadr pt) (cadr origin)))
     (print (strcat "distX: "
		    (rtos distx 2 3)
		    ", distY: "
		    (rtos disty 2 3)
	    )
     )
     (setq pts (append pts (list (list distx disty))))
  )

  (setq pfilename1 (getfiled "Save points" "" "txt" 1))

  (setq pf1 (open pfilename1 "w"))	; Open file
					; Write items
  (foreach cpt pts
    (write-line
      (strcat (rtos (car cpt) 2 3) "	" (rtos (cadr cpt) 2 3))
      pf1
    )
  )
					; Close file
  (close pf1)

  (princ)
)

;;;
;;; Polyline'dan koordinatlarını alır
;;; 

(defun getCoord	(pl / pl)
  (vl-load-com)

  (or (eq 'VLA-OBJECT (type pl))
      (setq pl (vlax-ename->vla-object pl))
  )

  (if (eq "AcDbPolyline" (vla-get-ObjectName pl))
    (vlax-list->2D-point
      (vlax-get pl 'Coordinates)
    )
    nil
  )
)

(defun vlax-list->2D-point (lst)
  (if lst
    (cons (list (car lst) (cadr lst))
	  (vlax-list->2D-point (cddr lst))
    )
  )
)

;;;
;;; vWrite komutu ile disari atar
;;;
(defun c:vWrite	(/ oFile en)

  (setq	oFile (open
		(strcat	(getvar "DWGPREFIX")
			(substr	(getvar "DWGNAME")
				1
				(- (strlen (getvar "DWGNAME")) 4)
			)
			".txt"
		)
		"w"
	      )
  )

  (while (setq en (car (entsel "\nSelect Polyline: ")))
    (foreach x (getCoord en)
      (write-line
	(strcat (rtos (car x)) (chr 44) (rtos (cadr x)))
	oFile
      )
    )
    (write-line "" oFile)
  )

  (close oFile)
  (princ)
)