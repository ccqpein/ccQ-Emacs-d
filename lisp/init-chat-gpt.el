(use-package shell-maker
  :straight (:host github :repo "xenodium/shell-maker")
  
  :custom
  (shell-maker-transcript-default-path "~/Desktop/Org/GPT-transcript")
  (shell-maker-forget-file-after-clear t)
  )

(use-package chatgpt-shell
  :straight (:host github :repo "xenodium/chatgpt-shell")
    
  :custom
  (chatgpt-shell-openai-key
   (exec-path-from-shell-copy-env "OPENAI_API_KEY"))
  (chatgpt-shell-anthropic-key
   (exec-path-from-shell-copy-env "ANTHROPIC_API_KEY"))
  (chatgpt-shell-google-key
   (exec-path-from-shell-copy-env "GEMINI_API_KEY"))
  
  ;; use nil as the default
  (chatgpt-shell-system-prompt nil)
  (chatgpt-shell-model-version "gpt-4o")

  :bind
  (:map chatgpt-shell-mode-map
        ("s-<return>" . chatgpt-shell-submit)
        ("<return>" . chatgpt-shell-newline)
        ("C-c M-o" . chatgpt-shell-clear-buffer))

  :config
  (setf chatgpt-shell-system-prompts
        (delete-dups
         (append gpt-system-prompts ;; custom prompts
                 chatgpt-shell-system-prompts))))

(provide 'init-chat-gpt)
