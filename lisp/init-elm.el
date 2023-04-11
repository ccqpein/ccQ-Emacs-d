(use-package elm-mode

  :hook
  (
   (elm-mode . elm-format-on-save-mode)
   (elm-mode . elm-oracle-setup-completion)
   (elm-mode . lsp-deferred)
   )

  :custom
  (elm-tags-on-save t)
  )

(provide 'init-elm)
