;;;;;;; slime ;;;;;;;;;
(use-package slime
  :config
  (setq
   slime-contribs '(slime-fancy slime-repl slime-scratch slime-trace-dialog)
   inferior-lisp-program "/usr/local/bin/sbcl"
   ;;inferior-lisp-program "/usr/local/bin/clisp"
   )
  
  (autoload 'enable-paredit-mode "paredit" "Turn on pseudo-structural editing of Lisp code." t)
  (add-hook 'emacs-lisp-mode-hook 'enable-paredit-mode)
  (add-hook 'lisp-mode-hook 'enable-paredit-mode)
  (add-hook 'lisp-mode-hook 'hs-minor-mode)
  
  (add-hook 'lisp-interaction-mode-hook 'enable-paredit-mode)
  (add-hook 'slime-repl-mode-hook 'enable-paredit-mode)
  (add-hook 'slime-repl-mode-hook 'override-slime-repl-bindings-with-paredit)
  
  (add-hook 'slime-mode-hook 'set-up-slime-ac)
  (add-hook 'slime-repl-mode-hook 'set-up-slime-ac)

  )

;;Stop SLIME's REPL from grabbing DEL, which is annoying when backspacing over a '('
(defun override-slime-repl-bindings-with-paredit ()
  (define-key slime-repl-mode-map
    (read-kbd-macro paredit-backward-delete-key)
    nil))

(eval-after-load "auto-complete"
  '(add-to-list 'ac-modes 'slime-repl-mode))


;;;;;;;;; Clojure ;;;;;;;;;;;;
(use-package clojure-mode
  :ensure t

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
  (require 'cider-mode)
  )

(eval-after-load "auto-complete"
       '(progn
          (add-to-list 'ac-modes 'cider-mode)
          (add-to-list 'ac-modes 'cider-repl-mode)))

(provide 'init-lisp)
