;;;;;;;; Javascript mode ;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package js-mode
  :hook
  (
   (js-mode . hs-minor-mode)
   (js-mode . paredit-mode)
   (js-mode . js2-minor-mode)
   )
  
  :config
  (add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
  (add-to-list 'interpreter-mode-alist '("node" . js2-mode))
  )


;; (add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
;; (add-to-list 'interpreter-mode-alist '("node" . js2-mode))
;; (add-hook 'js-mode-hook 'js2-minor-mode)
;; (add-hook 'js2-mode-hook #'setup-tide-mode) ; for typescript mode

;; (add-hook 'js-mode-hook 'paredit-mode)
;; (add-hook 'js-mode-hook 'hs-minor-mode)

(provide 'init-js)
