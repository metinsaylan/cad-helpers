;;; shailan standards

(setq OLD_CMDECHO (getvar "CMDECHO"))
(setvar "CMDECHO" 0)

(defun st:makelayer(layername)
    (if (not (tblsearch "Layer" layername))
    (command "-layer" "m" layername "")
    );if
)

;;; START STANDARDS

;;; Create layers
(st:makelayer "CL")
(st:makelayer "ANTET")
(st:makelayer "DIM")
(st:makelayer "REV")
(st:makelayer "TEXT")
(st:makelayer "Defpoints")

(command "-layer" "Plot" "No" "Defpoints" "")

;;; Line weights
(command "-Layer" "LWeight" "0.0" "DIM" "")
(command "-Layer" "LWeight" "0.0" "TEXT" "")
(command "-Layer" "LWeight" "0.0" "CL" "")
(command "-Layer" "LWeight" "0.3" "REV" "")

;;; Layer colors
(command "-Layer" "Color" "6" "REV" "")
(command "-Layer" "Color" "4" "CL" "")
(command "-Layer" "Color" "7" "TEXT" "")
(command "-Layer" "Color" "7" "ANTET" "")
(command "-Layer" "Color" "6" "Defpoints" "")
(command "-Layer" "Color" "5" "DIM" "")

;;; Cloud settings
(command "REVCLOUD" "Arc" "5" "7" *cancel* )

;;; Variable settings

(command "LWDISPLAY" "ON")
(command "LWDEFAULT" "20")
(setvar "LAYEREVAL" 0)
(setvar "LAYERNOTIFY" 0)
(setvar "OSMODE" 695)

(setvar "TOOLTIPS" 0) ;; Ara� ipu�lar� g�sterilmesi
(setvar "ROLLOVERTIPS" 0) ;; Mouse gelince g�sterilen ipu�lar�
(setvar "REPORTERROR" 0) ;; Autocad istenmeyen �ekilde kapan�rsa bildirim
(setvar "QPMODE" 1) ;; Quick properties a��k
(setvar "QPLOCATION" 1) ;; Quick properties yeri sabit

;;(setvar "XDWGFADECTL" 70) ;; XREF Fade de�eri
(setvar "LAYLOCKFADECTL" 50) ;; Kitlenmi� layer fade de�eri

(setvar "ISAVEBAK" 0) ; bak dosyas� olu�turma

;SAVEFILE
;SAVEFILEPATH
;SAVENAME
;SAVETIME

; AREA ; en son hesaplanan alan de�eri
; PERIMETER ; en son �evre

(setvar "HPDRAWORDER" 1) ; Hatch taramalar�n� geri yolla

;LOGINNAME ; Giri� verisi
;MYDOCUMENTSPREFIX ; Belgelerim

(setvar "FRAME" 0) ; resim, dwf, pdf ve xclip �er�evelerini g�sterme
(setvar "SELECTIONPREVIEW" 0) ; se�imleri g�sterme ayarlar�
(setvar "TRAYNOTIFY" 0) ; servis notifikasyonlar�

;;; Current Text Style
(command "_.style" "Design" "isocpeur.ttf" "" "" "" "" "" )
;;; Current Layer
(command "clayer" "0")



;; UTILITIES

(defun c:custfiles ()
  (command "shell" 
    (strcat "explorer \"" (getvar "roamablerootprefix") "\"")
  )
  (princ)
)

(defun c:standartlar()
	(princ "custfiles : Autocad klas�r�n� a�ar")
	(princ)
)

(princ "Standart komutlar� g�rmek i�in Standartlar yaz�n.")

;;; END OF STANDARDS
(setvar "CMDECHO" OLD_CMDECHO)
(princ)