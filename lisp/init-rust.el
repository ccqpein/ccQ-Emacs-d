;;;;;;;; Rust ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package rust-mode
  :init (straight-use-package 'cargo)

  :hook
  ((rust-mode . cargo-minor-mode)
   (rust-mode . hs-minor-mode)
   )

  :bind
  (:map rust-mode-map
        ("C-c C-d" . rust-dbg-wrap-or-unwrap)
        ("C-c d" . nil))

  ;;:custom
  ;;(company-tooltip-align-annotations t)
  ;;(rust-format-on-save t) ;; move this command to lsp

  :config
  (straight-use-package 'dap-mode)
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

(use-package rust-ts-mode
  :init (straight-use-package 'cargo)

  :hook
  ((rust-ts-mode . eldoc-mode)
   (rust-ts-mode . cargo-minor-mode)
   (rust-ts-mode . hs-minor-mode)
   )

  (setq lsp-rust-analyzer-proc-macro-enable t
        lsp-rust-analyzer-cargo-load-out-dirs-from-check t
        )
  )

(provide 'init-rust)
