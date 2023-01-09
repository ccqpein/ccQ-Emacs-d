;;;;;;;; Rust ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package rust-mode
  :ensure t
     
  :hook
  ((rust-mode . eldoc-mode)
   (rust-mode . company-mode)
   (rust-mode . cargo-minor-mode)
   (rust-mode . hs-minor-mode)
   (rust-mode . lsp-deferred))

  :bind
  (:map rust-mode-map
        ("C-c C-d" . rust-dbg-wrap-or-unwrap)
        ("C-c d" . nil))

  :custom
  (company-tooltip-align-annotations t)
  ;;(rust-format-on-save t) ;; move this command to lsp

  :config
  (setq lsp-rust-analyzer-proc-macro-enable t
        lsp-rust-analyzer-cargo-load-out-dirs-from-check t
;;;:= TODO: bind commands lsp-rust-analyzer-join-lines lsp-rust-analyzer-expand-macro
        )
  
  (require 'dap-gdb-lldb)
  (dap-gdb-lldb-setup)
  
  (require 'dap-cpptools)
  (dap-cpptools-setup)
  ;; (dap-register-debug-template
  ;;  "Rust::CppTools Run Configuration"
  ;;  (list :type "cppdbg"
  ;;        :request "launch"
  ;;        :name "Rust::Run"
  ;;        :MIMode "gdb"
  ;;        :miDebuggerPath "rust-gdb"
  ;;        :environment []
  ;;        :program "${workspaceFolder}/target/debug/gdb-debugger-demo"
  ;;        :cwd "${workspaceFolder}"
  ;;        :console "external"
  ;;        :dap-compilation "cargo build"
  ;;        :dap-compilation-dir "${workspaceFolder}"))
  
  (dap-register-debug-template
   "Rust::GDB Run Configuration"
   (list :type "gdb"
         :request "launch"
         :name "GDB::Run"
         :gdbpath "rust-gdb"
         :target nil
         :dap-compilation "cargo build"
         :dap-compilation-dir "${workspaceFolder}"
         :cwd "${workspaceFolder}"))

  ;; (dap-register-debug-template
  ;;  "Rust::GDB Run Configuration"
  ;;  (list :type "gdb"
  ;;        :request "launch"
  ;;        :name "GDB::Run"
  ;;        :miDebuggerPath "rust-gdb"
  ;;        :program "${workspaceFolder}/target/debug/gdb-debugger-demo"
  ;;        :target "${workspaceFolder}/target/debug/gdb-debugger-demo"
  ;;        :cwd "${workspaceFolder}"
  ;;        :dap-compilation "cargo build"
  ;;        :dap-compilation-dir "${workspaceFolder}"))

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
