;; text-upper.lsp - Change selected text to UPPERCASE
;; Command: TEXTUP
(defun c:TEXTUP ( / ss i en ed )
  (setq ss (ssget '((0 . "TEXT,MTEXT"))))
  (if ss
    (progn
      (setq i 0)
      (repeat (sslength ss)
        (setq en (ssname ss i) ed (entget en))
        (setq ed (subst (cons 1 (strcase (cdr (assoc 1 ed))))
                        (assoc 1 ed) ed))
        (entmod ed)
        (setq i (1+ i))
      )
      (princ (strcat "\n" (itoa (sslength ss)) " texts uppercased."))
    )
  )
  (princ)
)
