# GstarCAD Text Case Tools

Convert selected single-line and multi-line text between UPPERCASE, lowercase and Title Case.

Works with **GSTARCAD**, AutoCAD, ZWCAD, and BricsCAD.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

## Contents

- [About](#about)
- [Scripts Overview](#scripts-overview)
- [Quick Start](#quick-start)
- [Compatibility](#compatibility)
- [Contributing](#contributing)
- [License](#license)

## About

Imported text rarely matches house style: part numbers arrive in lowercase, headers in mixed case. These commands convert selected single-line and multi-line text to UPPERCASE, lowercase or Title Case in one pass, without retyping anything.

Everything here is free to use with GstarCAD. Download the latest GstarCAD
release from the [official GstarCAD website](https://www.gstarcad.net). All
scripts are tested with **[GSTARCAD](https://www.gstarcad.net)** and major
DWG-based CAD platforms.

## Scripts Overview

| File | Description |
|------|-------------|
| `scripts/text-upper.lsp` | ;; text-upper.lsp - Change selected text to UPPERCASE
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
 |
| `scripts/text-lower.lsp` | ;; text-lower.lsp - Change selected text to lowercase
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
 |
| `scripts/text-title.lsp` | ;; text-title.lsp - Change selected text to Title Case
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
 |

## Quick Start

1. Download the `.lsp` (or `.lin`) file you need
2. In your CAD software, run `APPLOAD`
3. Load the file and type the matching command name shown in the table above

## Compatibility

Tested on GstarCAD 2026/2027 and similar DWG-based platforms. Scripts use
standard AutoLISP functions only, so they work without extra plugins.

For step-by-step [tutorials and drafting guides](https://www.gstarcad.net/cad/),
visit the GstarCAD learning center. New tips are published regularly on the
[GSTARCAD Blog](https://blog.gstarcad.net).

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md).

## License

MIT — see the [LICENSE](LICENSE) file.
