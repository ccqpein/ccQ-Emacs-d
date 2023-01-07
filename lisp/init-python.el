;;;;;;;;pythono-mode;;;;;;;;;;;;;;;;;;
(use-package elpy
  :ensure t
  :init (elpy-enable)

  :custom
  (python-shell-completion-native-enable nil)
  (python-shell-interpreter "ipython")
  (python-shell-interpreter-args "--simple-prompt -c exec('__import__(\\'readline\\')') -i --pprint")
  (elpy-rpc-python-command "~/.pyenv/shims/python")

  :bind
  (:map elpy-mode-map
		("M-." . nil))

  :config
  (require 'py-autopep8)
  )

(use-package py-autopep8
  :hook ((python-mode) . py-autopep8-mode))

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

