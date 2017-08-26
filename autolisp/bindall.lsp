;
;	bindall.lsp
;
;	binds all xref attachments on drawing
;


(defun C:bindall()
  (setq OLD_CMDECHO (getvar "CMDECHO"))
  (setvar "CMDECHO" 1)
    (command "-xref" "reload" "*")
    (command "-xref" "bind" "*")
  (setvar "CMDECHO" OLD_CMDECHO)
)