;;;;;;;;pythono-mode;;;;;;;;;;;;;;;;;;
(elpy-enable)
(setq python-shell-interpreter "ipython"
      python-shell-interpreter-args "--simple-prompt --pprint")

; M-. conflict with helm-gtags, and helm-gtags is better
(define-key elpy-mode-map (kbd "M-.") nil)

;; enable autopep8 formatting on save
(require 'py-autopep8)
(add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)

(provide 'init-python)
