(use-package chatgpt-shell
  :straight (chatgpt-shell :type git :host github :repo "xenodium/chatgpt-shell")
  :custom
  ((chatgpt-shell-openai-key
    (lambda ()
      (exec-path-from-shell-copy-env "OPENAI_API_KEY")))))

(provide 'init-chat-gpt)
