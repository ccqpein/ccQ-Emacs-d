;; -*- lexical-binding: t; -*-
(use-package yaml-mode
  )

(add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))

(provide 'init-yaml)
