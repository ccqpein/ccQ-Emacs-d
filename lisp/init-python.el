;; -*- lexical-binding: t; -*-

;;;;;;;;pythono-mode;;;;;;;;;;;;;;;;;;
(use-package elpy
  :init
  (elpy-enable)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  
  ;; for ts mode, has to add the hook here 2023/11/11
  :hook (python-ts-mode . elpy-mode)
  
  :custom
  (python-shell-completion-native-enable nil)
  (python-shell-interpreter "uv")
  (python-shell-interpreter-args "run ipython --simple-prompt -c exec('__import__(\\'readline\\')') -i --pprint")
  (python-shell-prompt-regexp "^In \\[[0-9]+\\]: ")
  (python-shell-prompt-block-regexp "^\\.\\.\\.+: ")
  (python-shell-prompt-output-regexp "^Out\\[[0-9]+\\]: ")
  (python-shell-prompt-input-regexps '("^In \\[[0-9]+\\]: "))
  (python-shell-prompt-output-regexps '("^Out\\[[0-9]+\\]: "))
  
  :bind
  (:map elpy-mode-map
        ("M-." . nil))
  
  :config
  (straight-use-package 'py-autopep8)
  (setenv "PYTHONIOENCODING" "utf-8")
  (add-to-list 'process-coding-system-alist '("python" . (utf-8 . utf-8)))
  (add-to-list 'process-coding-system-alist '("elpy" . (utf-8 . utf-8)))
  (setq lsp-ruff-lsp-show-notifications "onError"))

(provide 'init-python)
