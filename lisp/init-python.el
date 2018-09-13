;;;;;;;;pythono-mode;;;;;;;;;;;;;;;;;;
(use-package elpy
  :ensure t
  :init (elpy-enable)

  :custom
  (python-shell-interpreter "ipython")
  (python-shell-interpreter-args "--simple-prompt --pprint")

  :bind
  (:map elpy-mode-map
	("M-." . nil))

  :config
  (require 'py-autopep8)

  :hook
  (elpy-mode . py-autopep8-enable-on-save)
  )

(provide 'init-python)


;;; 2018-09-13
;;; because I choice to use `use-package` to loading package
;;; code below are obsolete

;(elpy-enable)
;(setq python-shell-interpreter "ipython"
;      python-shell-interpreter-args "--simple-prompt --pprint")
;
;; M-. conflict with helm-gtags, and helm-gtags is better
;(define-key elpy-mode-map (kbd "M-.") nil)
;
;;; enable autopep8 formatting on save
;(require 'py-autopep8)
;(add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)
;(provide 'init-python)

