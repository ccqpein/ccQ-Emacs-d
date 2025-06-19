;; -*- lexical-binding: t; -*-

;;;;;;;;;;;;; julia ;;;;;;;;;;;;;;;;;;;;
(use-package julia-mode
  :hook
  (julia-mode . julia-repl-mode))

(provide 'init-julia)
