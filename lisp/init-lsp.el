(use-package lsp-mode
  :hook
  ((go-mode . lsp-deferred)
   (js-mode . lsp-deferred)
   (tide-mode . lsp-deferred)
   (rust-mode . lsp-deferred)
   (swift-mode . lsp-deferred)
   )
  :commands (lsp lsp-deferred)
  :config
  (setq lsp-idle-delay 0.500)
  (setq lsp-rust-server 'rust-analyzer)
  ;;;:= TODO: bind commands lsp-rust-analyzer-join-lines, lsp-extend-selection and lsp-rust-analyzer-expand-macro
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
  :commands company-lsp
  :config
  (setq company-minimum-prefix-length 1
	company-idle-delay 0.1) ;; default is 0.2
  )


(use-package helm-lsp
  :commands helm-lsp-workspace-symbol)


(use-package lsp-treemacs
  :commands
  (lsp-treemacs-errors-list
   lsp-treemacs-symbols-list
   lsp-treemacs-references
   lsp-treemacs-implementations
   )
  )


(provide 'init-lsp)
