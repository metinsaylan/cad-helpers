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

(setvar "TOOLTIPS" 0) ;; Araç ipuçlarý gösterilmesi
(setvar "ROLLOVERTIPS" 0) ;; Mouse gelince gösterilen ipuçlarý
(setvar "REPORTERROR" 0) ;; Autocad istenmeyen þekilde kapanýrsa bildirim
(setvar "QPMODE" 1) ;; Quick properties açýk
(setvar "QPLOCATION" 1) ;; Quick properties yeri sabit

;;(setvar "XDWGFADECTL" 70) ;; XREF Fade deðeri
(setvar "LAYLOCKFADECTL" 50) ;; Kitlenmiþ layer fade deðeri

(setvar "ISAVEBAK" 0) ; bak dosyasý oluþturma

;SAVEFILE
;SAVEFILEPATH
;SAVENAME
;SAVETIME

; AREA ; en son hesaplanan alan deðeri
; PERIMETER ; en son çevre

(setvar "HPDRAWORDER" 1) ; Hatch taramalarýný geri yolla

;LOGINNAME ; Giriþ verisi
;MYDOCUMENTSPREFIX ; Belgelerim

(setvar "FRAME" 0) ; resim, dwf, pdf ve xclip çerçevelerini gösterme
(setvar "SELECTIONPREVIEW" 0) ; seçimleri gösterme ayarlarý
(setvar "TRAYNOTIFY" 0) ; servis notifikasyonlarý

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
	(princ "custfiles : Autocad klasörünü açar")
	(princ)
)

(princ "Standart komutlarý görmek için Standartlar yazýn.")

;;; END OF STANDARDS
(setvar "CMDECHO" OLD_CMDECHO)
(princ)