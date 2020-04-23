;;;;;;;; Rust ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package racer
  :config
  (define-key racer-mode-map (kbd "M-.") #'helm-gtags-dwim))

(use-package rust-mode
  :ensure t
     
  :hook
  ;;(rust-mode . racer-mode)
  (rust-mode . eldoc-mode)
  (rust-mode . flycheck-rust-setup)
  (rust-mode . company-mode)
  (rust-mode . cargo-minor-mode)
  (rust-mode . hs-minor-mode)

  :bind
  (:map rust-mode-map
    	("TAB" . company-indent-or-complete-common)
        ("C-c C-d" . rust-dbg-wrap-or-unwrap)
        ("C-c d" . nil))

  :custom
  (company-tooltip-align-annotations t)
  (rust-format-on-save t)
  )


;(require 'rust-mode)
;(add-hook 'rust-mode-hook #'racer-mode)
;(add-hook 'racer-mode-hook #'eldoc-mode)
;(add-hook 'racer-mode-hook #'flycheck-rust-setup)

;; maybe future, add hook lsp-rust-enable to rust-mode make racer-mode..
;; cannot work, it looks I need define lsp-rust-enable by myself
;(lsp-define-stdio-client
 ;; This can be a symbol of your choosing. It will be used as a the
 ;; prefix for a dynamically generated function "-enable"; in this
 ;; case: lsp-prog-major-mode-enable
; lsp-rust
; "rust"
 ;; This will be used to report a project's root directory to the LSP
 ;; server.
 ;(lambda () default-directory)
 ;; This is the command to start the LSP server. It may either be a
 ;; string containing the path of the command, or a list wherein the
 ;; car is a string containing the path of the command, and the cdr
 ;; are arguments to that command.
; '("rustup" "run" "nightly" "rls"))
;(setq lsp-rust-rls-command '("rustup" "run" "nightly" "rls"))
;(add-hook 'rust-mode-hook #'lsp-rust-enable)

;(define-key rust-mode-map (kbd "TAB") #'company-indent-or-complete-common)
;(setq company-tooltip-align-annotations t)
;(setq rust-format-on-save t)

(provide 'init-rust)
