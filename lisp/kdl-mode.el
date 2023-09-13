;;; kdl-mode.el --- Major mode for editing KDL files -*- lexical-binding: t -*-

;;; Code:

(defvar kdl-mode-syntax-table
  (let ((st (make-syntax-table prog-mode-syntax-table)))
    ;; (modify-syntax-entry ?+  "." st)
    ;; (modify-syntax-entry ?-  "." st)
    ;; (modify-syntax-entry ?%  "." st)
    ;; (modify-syntax-entry ?&  "." st)
    ;; (modify-syntax-entry ?|  "." st)
    ;; (modify-syntax-entry ?^  "." st)
    ;; (modify-syntax-entry ?!  "." st)
    ;; (modify-syntax-entry ?=  "." st)
    ;; (modify-syntax-entry ?<  "." st)
    ;; (modify-syntax-entry ?>  "." st)
    (modify-syntax-entry ?/  ". 124b" st)
    ;; (modify-syntax-entry ?*  ". 23" st)
    (modify-syntax-entry ?\n "> b" st)
    (modify-syntax-entry ?\" "\"" st)
    (modify-syntax-entry ?\' "\"" st)
    ;; (modify-syntax-entry ?`  "\"" st)
    (modify-syntax-entry ?\\ "\\" st)
    ;; (modify-syntax-entry ?_  "w" st)
	st
	))

(defvar kdl-font-lock-keywords
  `(
	;;(,(rx-to-string `(: (or ,@kdl-keywords-regexp)) 'word) 0 font-lock-keyword-face)
	("\\([^\s+;\n{}()]+\\)[\s+|;|\n]" 1 font-lock-keyword-face)
	("\\(.+\\)=" 1 font-lock-variable-name-face)
	("r#\\(\".*\"\\)#" 0 font-lock-string-face)
	))

;;;###autoload
(define-derived-mode kdl-mode prog-mode "KDL"
  "Major mode for editing KDL files."
  :syntax-table kdl-mode-syntax-table

  (setq-local comment-start "// ")
  (setq-local comment-start-skip "//+ *")

  (setq-local indent-tabs-mode t) ;;:= TODO: not right
  
  (setq-local font-lock-defaults
              '(,kdl-font-lock-keywords ; Keywords highlighting
                nil nil nil nil
                ;;(font-lock-syntactic-face-function . prog-mode-font-lock-syntactic-face-function)
				)))

;;;###autoload
(add-to-list 'auto-mode-alist '("\\.kdl" . kdl-mode))

;;(provide 'kdl-mode)
(provide 'init-kdl)

