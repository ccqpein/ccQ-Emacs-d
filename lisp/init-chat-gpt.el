(use-package shell-maker
  :straight (:host github :repo "xenodium/shell-maker")
  
  :custom
  (shell-maker-transcript-default-path "~/Desktop/Org/GPT-transcript")
  (shell-maker-forget-file-after-clear t)
  )

(use-package chatgpt-shell
  :straight (:host github :repo "xenodium/chatgpt-shell")
    
  :custom
  (chatgpt-shell-model-version "chatgpt-4o-latest")
  (chatgpt-shell-openai-key
   (exec-path-from-shell-copy-env "OPENAI_API_KEY"))
  
  ;; use nil as the default
  (chatgpt-shell-system-prompt nil)

  :bind
  (:map chatgpt-shell-mode-map
        ("s-<return>" . chatgpt-shell-submit)
        ("<return>" . chatgpt-shell-newline)
        ("C-c M-o" . chatgpt-shell-clear-buffer))

  :config
  (setf chatgpt-shell-system-prompts
        (delete-dups
         (append '(("Grammar/Spell checker" . "You are going to correct the grammar and spelling. Try you best to keep the languages style.")
                   ("Writing helper" . "Your task is to correct the grammar and spelling of various articles. These could include programming documents, READMEs, technical documents, papers, reports, and more. Please ensure you maintain the author's personal writing style appropriate to each type of article."))
                 chatgpt-shell-system-prompts))))

(provide 'init-chat-gpt)
