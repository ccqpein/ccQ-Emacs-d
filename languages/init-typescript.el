;;;;;;; typescript mode ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun setup-tide-mode ()
  (interactive)
  (tide-setup)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1))
;; aligns annotation to the right hand side
(setq company-tooltip-align-annotations t)

;; formats the buffer before saving
(add-hook 'before-save-hook 'tide-format-before-save)
(add-hook 'typescript-mode-hook #'setup-tide-mode)

(setq tide-format-options
      '(:insertSpaceAfterFunctionKeywordForAnonymousFunctions
        t
        :placeOpenBraceOnNewLineForFunctions
        nil))

(setq tide-tsserver-executable "/usr/local/bin/tsserver")

(provide 'init-typescript)