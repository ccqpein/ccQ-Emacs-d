(use-package elm-mode

  :hook
  (
   (elm-mode . elm-format-on-save-mode)
   (elm-mode . company-mode)
   (elm-mode . elm-oracle-setup-completion)
   (elm-mode . lsp-deferred)
   )

  :config
  (add-to-list 'company-backends 'company-elm)

  :custom
  (elm-tags-on-save t)
  )

(provide 'init-elm)
