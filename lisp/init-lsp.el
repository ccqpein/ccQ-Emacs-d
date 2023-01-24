(use-package lsp-mode
  :init
  (setq lsp-keymap-prefix "C-c l")

  :hook
  (;; for yas
   (lsp-mode . yas-minor-mode)

   ;; for toml file, need install taplo
   (conf-toml-mode . lsp-deferred)
   (toml-ts-mode . lsp-deferred)
   (markdown-mode . lsp-deferred)
   )

  :commands (lsp lsp-deferred)

  :bind
  (:map lsp-mode-map
        ("C-c l g d" . lsp-find-definition) ;; I like d => definition rather than g
        )

  :config
  (define-key lsp-mode-map (kbd "C-c l") lsp-command-map)
  
  (setq lsp-idle-delay 0.700
        lsp-log-io nil
        lsp-use-plists t ;;https://emacs-lsp.github.io/lsp-mode/page/performance/
        )
  
  (add-hook 'before-save-hook
            (lambda ()
			  (when (member major-mode '(rust-mode rust-ts-mode
                                         go-mode go-ts-mode
                                         swift-mode
                                         js-mode
                                         json-mode
										 conf-toml-mode toml-ts-mode
                                         ))
                (ignore-errors
                  ;; json-mode "json-ls" will give error
                  (lsp-organize-imports))
                (lsp-format-buffer))))
  (setq 
   lsp-go-env '((GOFLAGS . "-tags=integration"))
   )
  )

;;; https://emacs-lsp.github.io/dap-mode/page/configuration/
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
        ("C-c l M-r" . lsp-ui-peek-find-references)
        ("C-c l M-i" . lsp-ui-peek-find-implementation)
        ("C-c l h i" . lsp-ui-imenu))
  
  :config
  (setq lsp-ui-sideline-enable t
        lsp-ui-sideline-delay 0.7
        lsp-ui-sideline-show-hover t
        lsp-ui-sideline-ignore-duplicate t
        lsp-ui-sideline-show-code-actions t
        lsp-ui-sideline-update-mode 'line

        lsp-ui-doc-enable t
        lsp-ui-doc-delay 0.7
        lsp-ui-doc-show-with-cursor t
        lsp-ui-doc-position 'top ;; this only effect when lsp-ui-doc-show-with-cursor is not-nil
   
        lsp-ui-imenu-enable t
        )
  )

(use-package helm-lsp
  :commands helm-lsp-workspace-symbol) ;;:= MAYBE: give a key bind. Shows workspace symbols

(use-package lsp-treemacs
  :init
  (lsp-treemacs-sync-mode 1)
  
  :commands
  (lsp-treemacs-symbols
   lsp-treemacs-errors-list
   lsp-treemacs-references
   lsp-treemacs-implementations
   )

  :bind
  (("C-c l t s" . lsp-treemacs-symbols)
   ("C-c l t r" . lsp-treemacs-references)
   ("C-c l t i" . lsp-treemacs-implementations)
   ("C-c l t c" . lsp-treemacs-call-hierarchy)
   ("C-c l t t" . lsp-treemacs-type-hierarchy)
   ("C-c l t e" . lsp-treemacs-errors-list))
  )

(provide 'init-lsp)
