(use-package shell-maker
  :straight (:host github :repo "xenodium/chatgpt-shell" :files ("shell-maker.el")))

(use-package chatgpt-shell
  :straight (:host github :repo "xenodium/chatgpt-shell" :files ("chatgpt-shell.el"))

  :custom
  (chatgpt-shell-model-version "gpt-4o")
  (chatgpt-shell-openai-key
   (exec-path-from-shell-copy-env "OPENAI_API_KEY"))
  (chatgpt-shell-system-prompts
   (delete-dups
    (append '(("nil" . "")
              ("Grammar/Spell checker" . "You are going to correct the grammar and spelling. Try you best to keep the languages style.")
              ("Writing helper" . "Your task is to correct the grammar and spelling of various articles. These could include programming documents, READMEs, technical documents, papers, reports, and more. Please ensure you maintain the author's personal writing style appropriate to each type of article."))
            chatgpt-shell-system-prompts)))
  ;; use nil as the default
  (chatgpt-shell-system-prompt 0)

  :bind
  (:map chatgpt-shell-mode-map
        ("M-<return>" . chatgpt-shell-submit)
        ("<return>" . chatgpt-shell-newline)))

(provide 'init-chat-gpt)
