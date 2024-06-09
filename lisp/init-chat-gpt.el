(use-package shell-maker
  :straight (:host github :repo "xenodium/chatgpt-shell" :files ("shell-maker.el")))

(use-package chatgpt-shell
  :straight (:host github :repo "xenodium/chatgpt-shell" :files ("chatgpt-shell.el"))

  :custom
  (chatgpt-shell-model-version "gpt-4o")
  (chatgpt-shell-openai-key
   (exec-path-from-shell-copy-env "OPENAI_API_KEY"))

  :bind
  (:map chatgpt-shell-mode-map
        ("M-<return>" . chatgpt-shell-submit)
        ("<return>" . chatgpt-shell-newline)))

(provide 'init-chat-gpt)
