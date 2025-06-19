;; -*- lexical-binding: t; -*-
(use-package tide
  :after (typescript-mode flycheck)
  :hook ((typescript-mode . tide-setup)
         (typescript-mode . tide-hl-identifier-mode)
         (before-save . tide-format-before-save)
         (tide-mode . lsp-deferred))
  :config
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (setq tide-format-options
        '(:indentSize
          2
          :tabSize
          2
          :insertSpaceAfterFunctionKeywordForAnonymousFunctions
          t
          :placeOpenBraceOnNewLineForFunctions
          nil))
  (setq tide-tsserver-executable "/usr/local/bin/tsserver")
  )


(provide 'init-typescript)
