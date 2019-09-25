;;;;;;;; Javascript mode ;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(add-to-list 'interpreter-mode-alist '("node" . js2-mode))
(add-hook 'js-mode-hook 'js2-minor-mode)
(add-hook 'js2-mode-hook #'setup-tide-mode) ; for typescript mode

(add-hook 'js-mode-hook 'paredit-mode-hook)
(add-hook 'js-mode-hook 'hs-minor-mode-hook)

(provide 'init-js)
