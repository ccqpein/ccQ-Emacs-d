;; -*- lexical-binding: t; -*-

(use-package eglot
  :straight nil
  :demand t

  :hook
  (;;(rust-mode . eglot-ensure)
   ;;(rust-ts-mode . eglot-ensure)
   (eglot-managed-mode . (lambda ()
                           (when (fboundp 'eglot-inlay-hints-mode)
                             (eglot-inlay-hints-mode 1)))))

  :bind
  (("C-c l g d" . xref-find-definitions)
   ("C-c l g r" . xref-find-references)
   ("C-c l g i" . eglot-find-implementation)
   ("C-c l g t" . eglot-find-typeDefinition)
   ("C-c l M-d" . xref-find-definitions)
   ("C-c l M-r" . xref-find-references)
   ("C-c l M-i" . eglot-find-implementation)
   ("C-c l h i" . imenu)
   ("C-c l h h" . eldoc-box-eglot-help-at-point)
   ("C-c l a a" . eglot-code-actions)
   ("C-c l a"   . eglot-code-actions)
   ("C-c l r r" . eglot-rename)
   ("C-c l r"   . eglot-rename)
   ("C-c l = =" . eglot-format-buffer)
   ("C-c l = b" . eglot-format-buffer)
   ("C-c l w r" . eglot-reconnect)
   ("C-c l w q" . eglot-shutdown)
   ("C-c l T h" . eglot-inlay-hints-mode))

  :custom
  (eglot-send-changes-idle-time 0.5)
  (eglot-autoshutdown t)

  :config
  ;; Eldoc configuration (hover docs like lsp-ui-doc)
  (setq eldoc-idle-delay 0.5
        eldoc-echo-area-use-multiline-p 3)

  ;; Rust-analyzer workspace configuration
  (setq-default eglot-workspace-configuration
                '(:rust-analyzer
                  (:cargo (:allFeatures t
                                        :loadOutDirsFromCheck t)
                          :procMacro (:enable t)
                          :checkOnSave (:command "clippy"))))

  ;; Format and organize imports on save for Rust
  (defun my-eglot-rust-format-on-save ()
    (when (and (fboundp 'eglot-managed-p)
               (eglot-managed-p)
               (derived-mode-p 'rust-mode 'rust-ts-mode))
      (ignore-errors
        (if (fboundp 'eglot-code-action-organize-imports)
            (eglot-code-action-organize-imports)
          (eglot-code-actions nil nil "source.organizeImports" t)))
      (eglot-format-buffer)))

  (add-hook 'before-save-hook #'my-eglot-rust-format-on-save)

  ;; Integration with Corfu / Cape for smooth completion
  (when (fboundp 'cape-wrap-buster)
    (advice-add 'eglot-completion-at-point :around #'cape-wrap-buster)))

;; Floating documentation childframe at cursor (replaces lsp-ui-doc)
(use-package eldoc-box
  :hook (eglot-managed-mode . eldoc-box-hover-at-point-mode)
  :custom
  (eldoc-box-hover-at-point-delay 0.7)
  :config
  (setq eldoc-box-max-pixel-width 700
        eldoc-box-max-pixel-height 450))

;; Inline diagnostic errors at the end of the line (replaces lsp-ui-sideline)
(use-package flycheck-inline
  :hook (flycheck-mode . turn-on-flycheck-inline))

(provide 'init-eglot)
