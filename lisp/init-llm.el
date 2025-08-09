;; -*- lexical-binding: t; -*-

(use-package shell-maker
  :straight (:host github :repo "xenodium/shell-maker")
  
  :custom
  (shell-maker-transcript-default-path "~/Desktop/Org/GPT-transcript")
  (shell-maker-forget-file-after-clear t)
  )

(use-package chatgpt-shell
  :custom
  (chatgpt-shell-openai-key
   (exec-path-from-shell-copy-env "OPENAI_API_KEY"))
  (chatgpt-shell-anthropic-key
   (exec-path-from-shell-copy-env "ANTHROPIC_API_KEY"))
  (chatgpt-shell-google-key
   (exec-path-from-shell-copy-env "GEMINI_API_KEY"))
  
  ;; use nil as the default
  (chatgpt-shell-system-prompt nil)
  (chatgpt-shell-model-version "gemini-2.5-flash")

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

(use-package mcp-hub
  :straight (:host github :repo "lizqwerscott/mcp.el")
  :custom (mcp-hub-servers
           (list (cons "hyper-mcp"
                       (list :command
                             "~/.cargo/bin/hyper-mcp"
                             :args
                             (list "-c" (file-truename "~/Code/garage/ai/hyper-mcp-test/config.json")))))))

(use-package copilot
  :straight (:host github :repo "copilot-emacs/copilot.el" :files ("*.el"))
  :ensure t

  ;;; manully start the mode looks better 
  ;;:hook
  ;;(lisp-mode . copilot-mode)
  ;;(emacs-lisp-mode . copilot-mode)
  
  :bind
  (:map copilot-completion-map
        ("TAB" . copilot-accept-completion)))

(use-package claude-code-ide
  :straight (:type git :host github :repo "manzaltu/claude-code-ide.el")
  :bind ("C-c C-'" . claude-code-ide-menu) 
  :config
  (claude-code-ide-emacs-tools-setup))

(provide 'init-llm)
