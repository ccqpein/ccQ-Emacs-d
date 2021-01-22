;;;;;; go-mode ;;;;;
(use-package go-mode
  :ensure t

  :custom
  (tab-width 4)
  (compile-command "go build")
  (gofmt-command "goimports") ;; because lsp go-mode fmt screw up
  
  :hook
  ((go-mode . hs-minor-mode)
   (go-mode . (lambda () (funcall 'auto-complete-mode -1))) ;; because lsp go-mode fmt screw up
   (before-save . gofmt-before-save) ;; because lsp go-mode fmt screw up
   )
  
  :config
  (setq-default flycheck-disabled-checkers '(go-staticcheck))
  )

(provide 'init-golang)

;; 2020-02-03
;; gocode is not fluency, use gopls & lsp replace it
;; go mode need `gocode (go get -u github.com/stamblerre/gocode)`, need update regularly

;;; 2018-09-13
;;; because I choice to use `use-package` to loading package
;;; code below are obsolete

;(require 'go-mode)
;(require 'go-autocomplete)
;(with-eval-after-load 'go-mode
;  (require 'go-autocomplete))
;
;(defun my-go-mode-hook ()
;  (setq gofmt-command "goimports") ; Use goimports instead of go-fmt
;  (add-hook 'before-save-hook 'gofmt-before-save) ; Call Gofmt before saving
;  (if (not (string-match "go" compile-command))
;      (set (make-local-variable 'compile-command)
;           "go generate && go build -v && go test -v && go vet")) ; Customize gofmt command to run go build
;  (setq tab-width 4)
;  ;(local-set-key (kbd "M-.") 'godef-jump); Godef jump key binding, rewrite by helm-gtags
;  ;(local-set-key (kbd "M-*") 'pop-tag-mark) ;rewrite by helm-gtags
;  (local-set-key (kbd "C-c C-c") 'compile)
;  ;(local-set-key (kbd "C-c C-r") 'go-remove-unused-imports) ; go-fmt do same thing
;  (local-set-key (kbd "C-c i") 'go-goto-imports)
;  ;; update imenu regex expression to match two-lines funtion declare
;  (setq imenu-generic-expression
;        '(("type" "^[ \t]*type *\\([^ \t\n\r\f]*[ \t]*\\(struct\\|interface\\)\\)" 1)
;          ("func" "^func *\\(.*\\)" 1)))
;  ;;(setq helm-gtags--update-tags-command (lambda (how-to) '("global" "-u")))
;  )
;  
;(add-hook 'go-mode-hook 'my-go-mode-hook)
;
;(provide 'init-golang)
