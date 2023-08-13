;;;;;; markdown mode ;;;;;;
(use-package markdown-mode
  )

(use-package flyspell
  :hook
  (markdown-mode)
  (org-mode)
  )

(provide 'init-markdown)
