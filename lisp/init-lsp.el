(use-package lsp-mode
  :hook
  ((go-mode . lsp-deferred)
   (js-mode . lsp-deferred)
   (tide-mode . lsp-deferred)
   ;;(rust-mode . lsp-deferred)
   (swift-mode . lsp-deferred)
   )
  :commands (lsp lsp-deferred)
  )

(use-package lsp-ui
  :commands lsp-ui-mode

  :config
  (setq lsp-ui-sideline-enable t
        lsp-ui-doc-enable t
        lsp-ui-flycheck-enable t
        lsp-ui-imenu-enable t
        lsp-ui-sideline-ignore-duplicate t
        lsp-log-io t)
  )


(use-package company-lsp
  :commands company-lsp)


(use-package helm-lsp
  :commands helm-lsp-workspace-symbol)


(use-package lsp-treemacs
  :commands lsp-treemacs-errors-list)


(provide 'init-lsp)
