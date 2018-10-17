;;
;;  Copyright (C) 2018, Devon Sparks
;;  URL: https://github.com/devonsparks/wat-mode
;;
;;  This program is free software: you can redistribute it and/or modify
;;  it under the terms of the GNU General Public License as published by
;;  the Free Software Foundation, either version 3 of the License, or
;;  (at your option) any later version.

;;  This program is distributed in the hope that it will be useful,
;;  but WITHOUT ANY WARRANTY; without even the implied warranty of
;;  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;;  GNU General Public License for more details.

;;  You should have received a copy of the GNU General Public License
;;  along with this program.  If not, see <https://www.gnu.org/licenses/>.
;;

(require 'wat-regex)
(require 'wat-macro)

(setq wat-mode-font-highlights
      (list
       (cons wat-mem-instr-regex      'font-lock-builtin-face)
       (cons wat-num-instr-regex      'font-lock-builtin-face)
       (cons wat-folded-instr-regex   'font-lock-builtin-face)
       (cons wat-control-instr-regex  'font-lock-builtin-face)
       (cons wat-var-instr-regex      'font-lock-builtin-face)
       (cons wat-par-instr-regex      'font-lock-builtin-face)
       (cons wat-ident-regex          'font-lock-variable-name-face)
       (cons wat-func-type-regex      'font-lock-type-face)
       (cons wat-global-type-regex    'font-lock-type-face)
       (cons wat-keyword-regex        'font-lock-keyword-face)))
              	
	
(defvar wat-mode-map
  (let ((map (make-sparse-keymap)))
    (set-keymap-parent map lisp-mode-shared-map)
    (define-key map (kbd "C-c 1")   'wat-macro-expand)
    map)
  "Keymap for wat-mode, derived from lisp-mode.")


(define-derived-mode wat-mode lisp-mode "wat-mode"
  "Major mode for editing WebAssembly's text encoding."
  (use-local-map wat-mode-map)
  (setq font-lock-defaults '(wat-mode-font-highlights)))

(add-to-list 'auto-mode-alist '("\\.wat\\'" . wat-mode))
(add-to-list 'auto-mode-alist '("\\.wast\\'" . wat-mode))

(provide 'wat-mode)

;; wat-mode.el ends her
