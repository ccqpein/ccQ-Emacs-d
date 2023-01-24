;;;;;; markdown mode ;;;;;;
(use-package markdown-mode
  )

(use-package flyspell
  :hook
  (markdown-mode)
  (org-mode)
  )

;(autoload 'markdown-mode "markdown-mode" "Major mode for editing Markdown files" t)
;;(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
;;(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))
;;(autoload 'flyspell-mode "flyspell" "On-the-fly spelling checker." t)
;;(add-hook 'markdown-mode-hook 'flyspell-mode-hook)

(provide 'init-markdown)
