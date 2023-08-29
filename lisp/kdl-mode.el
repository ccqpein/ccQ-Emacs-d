;;; kdl-mode.el --- Major mode for editing KDL files -*- lexical-binding: t -*-

;;; Code:

;; (defface kdl-keyword-face
;;   '((t (:foreground "yellow")))
;;   "Face for KDL keywords.")

(defvar kdl-font-lock-keywords
  `(
	;;(,(rx-to-string `(: (or ,@kdl-keywords-regexp)) 'word) 0 font-lock-keyword-face)
	("\\([[:word:]]+\\)\s+" 1 font-lock-keyword-face)
	("\\([[:word:]]+\\)=" 1 font-lock-variable-name-face)
	("r#\\(\".*\"\\)#" 0 font-lock-string-face)
	))

;;;###autoload
(define-derived-mode kdl-mode prog-mode "KDL"
  "Major mode for editing KDL files."
  (message "in kdl")
  
  (setq-local comment-start "// ")
  (setq-local comment-start-skip "//+ *")
  (setq-local comment-end "")
  (setq tab-width 4)
  
  (setq-local font-lock-defaults
              '(,kdl-font-lock-keywords ; Keywords highlighting
                nil nil nil nil
                ;;(font-lock-syntactic-face-function . prog-mode-font-lock-syntactic-face-function)
				)))

;;;###autoload
(add-to-list 'auto-mode-alist '("\\.kdl" . kdl-mode))

(provide 'kdl-mode)
