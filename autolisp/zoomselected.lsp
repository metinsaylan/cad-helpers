;
;	zs.lsp
;
;	zooms to selected object using command zs
;

(defun C:zs()
  (setq OLD_CMDECHO (getvar "CMDECHO"))
  (setvar "CMDECHO" 1)
  (command "zoom" "Object")
  (setvar "CMDECHO" OLD_CMDECHO)
  (princ)
)