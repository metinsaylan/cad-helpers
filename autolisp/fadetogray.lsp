;;;
;;; FadeToGray lisp routine by Metin Saylan (http://metinsaylan.com)
;;;

; This routine cleans up all xref attachments, fixes block properties
; And turns everything gray. So the drawing can be used as a background 
; layout in another drawing.

(defun C:fadetogray()
  (setq OLD_CMDECHO (getvar "CMDECHO"))
  (setvar "CMDECHO" 1)
    (C:bindall)
    (C:FixBlock)
	(command "grips" "0")
	(setq mySel (ssget "X" (list (cons 410 (getvar "ctab")))))
	(sssetfirst Nil mySel)
	(setq mySel Nil)
	(command "change" "properties" "color" "253" "")
	(sssetfirst Nil mySel)
  (setvar "CMDECHO" OLD_CMDECHO)
)

; Removes connections to all XREF items
(defun C:bindall()
  (setq OLD_CMDECHO (getvar "CMDECHO"))
  (setvar "CMDECHO" 1)
    (command "-xref" "reload" "*")
    (command "-xref" "bind" "*")
  (setvar "CMDECHO" OLD_CMDECHO)
)

; Fixes all blocks so that all entities are on layer 0 with color BYBLOCK
(defun C:fixblock (/ ss cnt idx blkname donelist Grp Update)
  (defun Grp (gc el) (cdr (assoc gc el)))
  (defun Update (bname / ename elist)
    (setq ename (tblobjname "BLOCK" bname))
    (if
      (and ename (zerop (logand 52 (Grp 70 (entget ename '("*"))))))
      (progn
        (while ename
          (setq elist (entget ename '("*"))
                elist (subst '(8 . "0") (assoc 8 elist) elist)
                elist (if (assoc 62 elist)
                        (subst '(62 . 0) (assoc 62 elist) elist)
                        (append elist '((62 . 0)))))
          (entmake elist)
          (setq ename (entnext ename)))
        (if (/= "ENDBLK" (Grp 0 elist))
          (entmake '((0 . "ENDBLK") (8 . "0") (62 . 0))))
        'T))
  )
  (if (> (logand (Grp 70 (tblsearch "layer" "0")) 1) 0)
    (princ "\nLayer 0 must be thawed before running FIXBLOCK!\n")
    (progn
      (if
        (progn
          (princ "\nPress <Enter> to fix all defined blocks\n")
          (setq cnt 0
                ss (ssget '((0 . "INSERT")))))
        (progn
          (setq idx (sslength ss))
          (while (>= (setq idx (1- idx)) 0)
            (if (not (member (setq blkname (Grp 2 (entget (ssname ss idx)))) donelist))
              (progn
                (if (Update blkname) (setq cnt (1+ cnt)))
                (setq donelist (cons blkname donelist))))))
        (while (setq blkname (Grp 2 (tblnext "BLOCK" (not blkname))))
          (if (Update blkname) (setq cnt (1+ cnt)))))
      (princ (strcat "\n" (itoa cnt) " block" (if (= cnt 1) "" "s") " redefined\n"))))
  (princ)
)