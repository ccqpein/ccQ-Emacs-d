;;;;;;; slime ;;;;;;;;;
(use-package slime-cape
  :straight (slime-cape :type git :host github :repo "ccqpein/slime-cape")
  :hook
  (slime . slime-cape)
  (slime-repl . slime-cape)
  )

(use-package slime
  :init
  (straight-use-package 'paredit)

  :config
  (slime-setup '(slime-fancy slime-repl slime-scratch slime-trace-dialog slime-cl-indent slime-cape))
  (setq
   inferior-lisp-program (if (string= "arm64\n" (shell-command-to-string "uname -m"))
							 "/opt/homebrew/bin/sbcl"
						   "/usr/local/bin/sbcl"))
  
  (autoload 'enable-paredit-mode "paredit" "Turn on pseudo-structural editing of Lisp code." t)
  (add-hook 'emacs-lisp-mode-hook 'enable-paredit-mode)

  (add-hook 'lisp-mode-hook 'enable-paredit-mode)
  (add-hook 'lisp-mode-hook 'hs-minor-mode)
    
  (add-hook 'lisp-interaction-mode-hook 'enable-paredit-mode)
  (add-hook 'slime-repl-mode-hook 'enable-paredit-mode)
  (add-hook 'slime-repl-mode-hook 'override-slime-repl-bindings-with-paredit)
  )

;;Stop SLIME's REPL from grabbing DEL, which is annoying when backspacing over a '('
(defun override-slime-repl-bindings-with-paredit ()
  (define-key slime-repl-mode-map
    (read-kbd-macro paredit-backward-delete-key)
    nil))

;;;;;;;;; Clojure ;;;;;;;;;;;;
(use-package clojure-mode
  :bind
  (:map clojurec-mode-map
		("\C-c\C-z" . cider-jack-in))
  
  :hook
  (cider-mode . ac-flyspell-workaround)
  (cider-mode . ac-cider-setup)
  (cider-repl-mode . ac-cider-setup)
  (cider-repl-mode . enable-paredit-mode)
  (clojure-mode . enable-paredit-mode)
  
  :config
  (straight-use-package 'cider-mode)
  )

(provide 'init-lisp)

