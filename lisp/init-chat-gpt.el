(use-package chatgpt-shell
  :straight (:host github :repo "xenodium/chatgpt-shell" :files ("chatgpt-shell.el"))
  
  :custom
  (chatgpt-shell-model-version "gpt-4")
  (chatgpt-shell-openai-key
   (exec-path-from-shell-copy-env "OPENAI_API_KEY")))

(provide 'init-chat-gpt)
