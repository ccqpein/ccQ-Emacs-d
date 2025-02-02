(use-package shell-maker
  :straight (:host github :repo "xenodium/shell-maker")
  
  :custom
  (shell-maker-transcript-default-path "~/Desktop/Org/GPT-transcript")
  (shell-maker-forget-file-after-clear t)
  )

(use-package chatgpt-shell
  :straight (:host github :repo "xenodium/chatgpt-shell")
  ;;:straight (:local-repo "/Users/ccQ/Code/un-time-machine/chatgpt-shell")
  
  :custom
  (chatgpt-shell-openai-key
   (exec-path-from-shell-copy-env "OPENAI_API_KEY"))
  (chatgpt-shell-anthropic-key
   (exec-path-from-shell-copy-env "ANTHROPIC_API_KEY"))
  (chatgpt-shell-google-key
   (exec-path-from-shell-copy-env "GEMINI_API_KEY"))
  
  ;; use nil as the default
  (chatgpt-shell-system-prompt nil)
  (chatgpt-shell-model-version "gemini-2.0-flash-exp")

  :bind
  (:map chatgpt-shell-mode-map
        ("s-<return>" . chatgpt-shell-submit)
        ("<return>" . chatgpt-shell-newline)
        ("C-c M-o" . chatgpt-shell-clear-buffer))

  :config
  (push
   (chatgpt-shell-openai-make-model
    :version "o3-mini"
    :token-width 3
    :context-window 200000
    :validate-command
    ;; TODO: Standardize whether or not a model supports system prompts.
    (lambda (command model settings)
      (or (chatgpt-shell-openai--validate-command command model settings)
          (when (map-elt settings :system-prompt)
            (format "Model \"%s\" does not support system prompts. Please unset via \"M-x chatgpt-shell-swap-system-prompt\" by selecting None."
                    (map-elt model :version))))))
   chatgpt-shell-models)
  
  (setf chatgpt-shell-system-prompts
        (delete-dups
         (append '(("Grammar/Spell checker" . "You are going to correct the grammar and spelling. Try you best to keep the languages style.")
                   ("Writing helper" . "Your task is to correct the grammar and spelling of various articles. These could include programming documents, READMEs, technical documents, papers, reports, and more. Please ensure you maintain the author's personal writing style appropriate to each type of article."))
                 chatgpt-shell-system-prompts))))

(provide 'init-chat-gpt)
