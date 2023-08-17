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

  ;;(straight-use-package 'dap-go)
  ;;(dap-go-setup)
  )

;; (use-package go-ts-mode
;;   :hook
;;   ((go-ts-mode . hs-minor-mode)
;;    (go-ts-mode . yas-minor-mode)
;;    )
  
;;   :config
;;   (setq-default flycheck-disabled-checkers '(go-staticcheck))
;;   )

(provide 'init-golang)
