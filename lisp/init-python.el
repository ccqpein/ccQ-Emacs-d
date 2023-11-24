;;;;;;;;pythono-mode;;;;;;;;;;;;;;;;;;
(use-package elpy
  :init
  (elpy-enable)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  
  ;; for ts mode, has to add the hook here 2023/11/11
  :hook (python-ts-mode . elpy-mode)
  
  :custom
  (python-shell-completion-native-enable nil)
  (python-shell-interpreter "ipython")
  (python-shell-interpreter-args "--simple-prompt -c exec('__import__(\\'readline\\')') -i --pprint")
  (elpy-rpc-python-command "~/.pyenv/shims/python")
  
  :bind
  (:map elpy-mode-map
        ("M-." . nil))
  
  :config
  (straight-use-package 'py-autopep8)
  (setq lsp-pylsp-plugins-yapf-enabled     t
        lsp-pylsp-plugins-autopep8-enabled t
        lsp-pylsp-plugins-flake8-enabled   t))

(provide 'init-python)
