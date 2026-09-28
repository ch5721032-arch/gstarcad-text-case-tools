;; text-title.lsp - Change selected text to Title Case
;; Command: TEXTITLE
;; Usage: first letter of every word capitalised, the rest lowercased
(defun c:TEXTITLE ( / ss i en ed s out up n )
  (setq ss (ssget '((0 . "TEXT,MTEXT"))))
  (if ss
    (progn
      (setq i 0)
      (repeat (sslength ss)
        (setq en (ssname ss i)
              ed (entget en)
              s  (strcase (cdr (assoc 1 ed)) T)
              out "" up T n 1)
        (while (<= n (strlen s))
          (if up
            (setq out (strcat out (strcase (substr s n 1))))
            (setq out (strcat out (substr s n 1)))
          )
          (setq up (= (substr s n 1) " "))
          (setq n (1+ n))
        )
        (setq ed (subst (cons 1 out) (assoc 1 ed) ed))
        (entmod ed)
        (setq i (1+ i))
      )
      (princ (strcat "\n" (itoa (sslength ss)) " texts converted to Title Case."))
    )
  )
  (princ)
)
