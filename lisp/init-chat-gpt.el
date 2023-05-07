(use-package chatgpt-shell
  :straight (chatgpt-shell :type git :host github :repo "xenodium/chatgpt-shell")
  :custom
  ((chatgpt-shell-model-version "gpt-4")
   (chatgpt-shell-openai-key
    (exec-path-from-shell-copy-env "OPENAI_API_KEY"))))

(provide 'init-chat-gpt)
