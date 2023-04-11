;;;;;; go-mode ;;;;;
(use-package go-mode
  :custom
  (tab-width 4)
  (compile-command "go build")
  (gofmt-command "goimports") ;; because lsp go-mode fmt screw up
  
  :hook
  ((go-mode . hs-minor-mode)
   (go-mode . yas-minor-mode)
   )
  
  :config
  (setq-default flycheck-disabled-checkers '(go-staticcheck))

  (straight-use-package 'dap-go)
  ;;(dap-go-setup)
  )

(provide 'init-golang)
