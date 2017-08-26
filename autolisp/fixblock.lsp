 ;FixBlock.lsp  [June 30, 1998]
 ;
 ; Copyright 1996 - 1998 ManuSoft
 ;
 ; Freeware from:
 ;   ManuSoft
 ;   http://www.manusoft.com
 ;
 ; Load function, then enter FIXBLOCK to redefine selected blocks
 ;  so that all entities are on layer '0', color 'BYBLOCK'.
 ;


(defun C:FixBlock (/ ss cnt idx blkname donelist Grp Update)
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
;End-of-file
