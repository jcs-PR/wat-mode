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

;; * TODO

;; - wast support
;; - updated names
;; - texinfo documentation
;; - docstrings
;; - add tests
;; - travis CI build
;; - melpa package


(require 'wat-regex)
(require 'wat-macro)


(defvar wat-mode-syntax-table
  (let ((table (make-syntax-table lisp-mode-syntax-table)))
    ;; update identifier character class 
    ;; to support word jumps
    (mapc #'(lambda (c)
	      (modify-syntax-entry c "w" table))
	  '(?! ?# ?$ ?% ?\' ?* ?+ ?- ?. ?\/ ?:
	    ?< ?= ?> ?\\ ?? ?@ ?^ ?_ ?\` ?| ?~))

    ;; enable wat block comments
    (modify-syntax-entry ?\(  "()1nb" table)
    (modify-syntax-entry ?\)  ")(4nb" table)
    (modify-syntax-entry ?\;  "< 123" table)
    (modify-syntax-entry ?\n ">b" table)
    table)
  "Syntax table for `wat-mode'.")


(defconst wat-mode-font-lock-keywords-1
  (list
   (cons wat-keyword-regex        'font-lock-keyword-face))
  "wat-mode highlight level 1 oof 3 -- just type keywords")


(defconst wat-mode-font-lock-keywords-2
  (append
   wat-mode-font-lock-keywords-1
   (list
    (cons wat-folded-instr-regex   'font-lock-builtin-face)
    (cons wat-control-instr-regex  'font-lock-builtin-face)
    (cons wat-var-instr-regex      'font-lock-builtin-face)
    (cons wat-par-instr-regex      'font-lock-builtin-face)
    (cons wat-table-type-regex     'font-lock-type-face)
    (cons wat-func-type-regex      'font-lock-type-face)
    (cons wat-global-type-regex    'font-lock-type-face)
    (cons wat-val-type-regex       'font-lock-type-face)))
   "`wat-mode' highlighting level level 2 of 3 -- missing number and memory instructions")


(defconst wat-mode-font-lock-keywords-3
  (append
   wat-mode-font-lock-keywords-2
   (list
    (cons wat-ident-regex          'font-lock-variable-name-face)
    (cons wat-mem-instr-regex      'font-lock-builtin-face)
    (cons wat-num-instr-regex      'font-lock-builtin-face)))
  "`wat-mode' highlighting level 3 of 3 -- all core keywords")


(defvar wat-mode-font-lock-keywords
  wat-mode-font-lock-keywords-3
  "Default highlight level for `wat-mode'")
       

(defvar wat-mode-map
  (let ((map (make-sparse-keymap)))
    (set-keymap-parent map lisp-mode-shared-map)
    (define-key map (kbd "C-c 1")   'wat-macro-expand)
    (define-key map (kbd "RET") 'newline-and-indent)
    map)
  "Keymap for `wat-mode', derived from lisp-mode.")


(define-derived-mode wat-mode lisp-mode "wat-mode"
  "Major mode for editing WebAssembly's text encoding."
  (use-local-map wat-mode-map)
  (set (make-local-variable 'font-lock-defaults) '(wat-mode-font-lock-keywords))
  (set-syntax-table wat-mode-syntax-table)
  "`wat-mode', an Emacs major mode for editing WebAssembly's text format")


(add-to-list 'auto-mode-alist '("\\.wat\\'" . wat-mode))
(add-to-list 'auto-mode-alist '("\\.wast\\'" . wat-mode))

(provide 'wat-mode)

;; wat-mode.el ends here
