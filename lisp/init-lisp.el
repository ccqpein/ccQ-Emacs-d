;; -*- lexical-binding: t; -*-

;;;;;;; slime ;;;;;;;;;
(use-package slime-cape
  :straight (slime-cape :type git :host github :repo "ccqpein/slime-cape")
  :hook
  (slime . slime-cape)
  (slime-repl . slime-cape)
  )

(use-package paredit)

(use-package slime
  :init (add-hook 'lisp-mode-hook 'paredit-mode)
  :config
  (slime-setup '(slime-fancy slime-repl slime-scratch slime-trace-dialog slime-cl-indent slime-cape))

  ;; define some helper functions below after slime load
  
  ;;Stop SLIME's REPL from grabbing DEL, which is annoying when backspacing over a '('
  (defun override-slime-repl-bindings-with-paredit ()
    (define-key slime-repl-mode-map
                (read-kbd-macro paredit-backward-delete-key)
                nil))

  (defun slime-compile-buffer ()
    "compile the current buffer of lisp file.
ignore the first line `#!` because sometimes it is script"
    (interactive)
    (save-excursion
      (goto-char (point-min))
      (while (and (not (eobp))
                  (or (looking-at "^#!")
                      (looking-at "^\\s-*$")))
        (forward-line))
      (if (not (eobp))
          (slime-compile-region (point) (point-max)))))
  
  (setq
   inferior-lisp-program (if (string= "arm64\n" (shell-command-to-string "uname -m"))
                             "/opt/homebrew/bin/sbcl --dynamic-space-size 40Gb"
                           "/usr/local/bin/sbcl"))

  (setq slime-completion-at-point-functions
        '(;; slime-c-p-c-completion-at-point ;; this one has issue
          slime-filename-completion
          slime-simple-completion-at-point))
  
  (autoload 'enable-paredit-mode "paredit" "Turn on pseudo-structural editing of Lisp code." t)
  (add-hook 'emacs-lisp-mode-hook 'enable-paredit-mode)

  (add-hook 'lisp-mode-hook 'enable-paredit-mode)
  (add-hook 'lisp-mode-hook 'hs-minor-mode)
    
  (add-hook 'lisp-interaction-mode-hook 'enable-paredit-mode)
  (add-hook 'slime-repl-mode-hook 'enable-paredit-mode)
  (add-hook 'slime-repl-mode-hook 'override-slime-repl-bindings-with-paredit)
  )


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

