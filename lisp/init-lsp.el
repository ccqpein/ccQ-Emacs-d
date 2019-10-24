(use-package lsp-mode
  :hook
  ((go-mode . lsp-deferred)
   (rust-mode . lsp-deferred))

  :commands (lsp lsp-deferred)

  :config
  (require 'ra-emacs-lsp) ;; for rust https://github.com/rust-analyzer/rust-analyzer
  )

(use-package lsp-ui
  :commands lsp-ui-mode)

(use-package company-lsp
  :commands company-lsp)

(use-package helm-lsp :commands helm-lsp-workspace-symbol)

(use-package lsp-treemacs :commands lsp-treemacs-errors-list)

(provide 'init-lsp)
