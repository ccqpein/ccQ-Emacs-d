(use-package lsp-mode
  :init
  (setq lsp-keymap-prefix "C-c l")
  (defun lsp-mode-setup-completion ()
    (setf (alist-get 'styles (alist-get 'lsp-capf completion-category-defaults))
          '(flex)))

  :hook
  (;; for yas
   (lsp-mode . yas-minor-mode)

   ;; for toml file, need install taplo
   ;; use treesit bind conf-toml-mode with toml-ts-mode
   ;;(conf-toml-mode . lsp-deferred)
   
   (toml-ts-mode . lsp-deferred)
   (markdown-mode . lsp-deferred)
   (python-mode . lsp-deferred)
   (python-ts-mode . lsp-deferred)
   (go-mode . lsp-deferred)
   (go-ts-mode . lsp-deferred)
   (rust-mode . lsp-deferred)
   (rust-ts-mode . lsp-deferred)

   (lsp-completion-mode . lsp-mode-setup-completion)
   )

  :commands (lsp lsp-deferred)

  :bind
  (:map lsp-mode-map
        ("C-c l g d" . lsp-find-definition) ;; I like d => definition rather than g
        )

  :custom
  (lsp-completion-provider :none)
  
  :config
  (define-key lsp-mode-map (kbd "C-c l") lsp-command-map)
  
  (setq lsp-idle-delay 0.700
        lsp-log-io nil
        lsp-use-plists t ;;https://emacs-lsp.github.io/lsp-mode/page/performance/
        )
  
  (add-hook 'before-save-hook
            (lambda ()
			  (when (derived-mode-p 'rust-mode
									'rust-ts-mode
									'go-ts-mode 'go-mode
									'swift-mode
									'js-mode
									'json-mode
									'conf-toml-mode 'toml-ts-mode
									'python-ts-mode
									)
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

;;; eglot below
(use-package eglot
  :hook
  (
   ;;(rust-mode . eglot-ensure)
   ;;(rust-ts-mode . eglot-ensure)

   (eglot-managed-mode . eglot-capf)
   )

  :config
  (add-hook 'before-save-hook
            (lambda ()
			  (when (derived-mode-p
					 'rust-mode
					 'rust-ts-mode
					 )
                (ignore-errors
                  (eglot-code-action-organize-imports))
                (eglot-format-buffer))))
  
  (advice-add 'eglot-completion-at-point :around #'cape-wrap-buster)
  )

(defun eglot-capf ()
  (setq-local completion-at-point-functions
              (list (cape-super-capf
                     #'eglot-completion-at-point))))

(provide 'init-lsp)
