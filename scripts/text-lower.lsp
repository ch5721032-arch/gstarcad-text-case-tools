;; text-lower.lsp - Change selected text to lowercase
;; Command: TEXTLOW
(defun c:TEXTLOW ( / ss i en ed )
  (setq ss (ssget '((0 . "TEXT,MTEXT"))))
  (if ss
    (progn
      (setq i 0)
      (repeat (sslength ss)
        (setq en (ssname ss i) ed (entget en))
        (setq ed (subst (cons 1 (strcase (cdr (assoc 1 ed)) T))
                        (assoc 1 ed) ed))
        (entmod ed)
        (setq i (1+ i))
      )
      (princ (strcat "\n" (itoa (sslength ss)) " texts lowercased."))
    )
  )
  (princ)
)
