(use-package lsp-mode
  :init
  (setq lsp-keymap-prefix "C-c l")

  :hook
  (;; for yas
   (lsp-mode . yas-minor-mode)
   )

  :commands (lsp lsp-deferred)

  :bind
  (:map lsp-mode-map
        ("C-c l g d" . lsp-find-definition) ;; I like d => definition rather than g
        )

  :config
  (define-key lsp-mode-map (kbd "C-c l") lsp-command-map)
  
  (setq lsp-idle-delay 0.500
        lsp-log-io nil)
  (add-hook 'before-save-hook
            (lambda () (when (member major-mode '(rust-mode
                                                  go-mode
                                                  swift-mode
                                                  ))
                         (lsp-organize-imports)
                         (lsp-format-buffer))))
  (setq 
   lsp-rust-analyzer-proc-macro-enable t
   lsp-rust-analyzer-cargo-load-out-dirs-from-check t
   lsp-go-env '((GOFLAGS . "-tags=integration"))
   )
;;;:= TODO: bind commands lsp-rust-analyzer-join-lines lsp-rust-analyzer-expand-macro
  )

;;:= need to find the way to switch depending on which language is using
(use-package dap-mode
  :hook
  (
   (dap-stopped . (lambda (arg) (call-interactively #'dap-hydra)))
   )
  
  :custom
  ;; next line make lsp mode won't start dap-mode directly
  ;;(lsp-enable-dap-auto-configure nil)
  (dap-auto-configure-mode t "Automatically configure dap.")
  (dap-auto-configure-features
   '(sessions locals breakpoints expressions tooltip))

  :config
  (dap-ui-mode 1)
  (dap-tooltip-mode 1)
  (tooltip-mode 1)
  (dap-ui-controls-mode 1)
  )


(use-package lsp-ui
  :custom
  (lsp-ui-peek-always-show t)

  :bind
  (:map lsp-mode-map
        ("C-c l M-d" . lsp-ui-peek-find-definitions)
        ("C-c l M-r" . lsp-ui-peek-find-references))
  
  :config
  (setq lsp-ui-sideline-enable t
        lsp-ui-sideline-delay 0.6
        lsp-ui-sideline-show-hover t
        lsp-ui-sideline-ignore-duplicate t
        lsp-ui-sideline-update-mode 'line

        lsp-ui-doc-enable t
        lsp-ui-doc-delay 0.6
        lsp-ui-doc-position 'top
   
        lsp-ui-imenu-enable t
        )
  )

(use-package helm-lsp
  :commands helm-lsp-workspace-symbol) ;;:= MAYBE: give a key bind. Shows workspace symbols

(use-package lsp-treemacs
  :commands
  (lsp-treemacs-symbols
   lsp-treemacs-sync-mode
   lsp-treemacs-errors-list
   lsp-treemacs-references
   lsp-treemacs-implementations
   )

  :bind
  (("C-c l t s" . lsp-treemacs-symbols))
  )

(provide 'init-lsp)
