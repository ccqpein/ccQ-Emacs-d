;;;;;;;; Paredit ;;;;;;;;;;
(autoload 'enable-paredit-mode "paredit" "Turn on pseudo-structural editing of Lisp code." t)
(add-hook 'emacs-lisp-mode-hook 'enable-paredit-mode)
(add-hook 'lisp-mode-hook 'enable-paredit-mode)
(add-hook 'lisp-interaction-mode-hook 'enable-paredit-mode)
(add-hook 'slime-repl-mode-hook 'enable-paredit-mode)
(add-hook 'clojure-mode-hook 'enable-paredit-mode)
(add-hook 'cider-repl-mode-hook 'enable-paredit-mode)


;;;;;;; slime ;;;;;;;;;
(setq inferior-lisp-program "/usr/local/bin/sbcl")
(setq slime-contribs '(slime-fancy))

;;Stop SLIME's REPL from grabbing DEL, which is annoying when backspacing over a '('
(defun override-slime-repl-bindings-with-paredit ()
  (define-key slime-repl-mode-map
    (read-kbd-macro paredit-backward-delete-key)
    nil))
(add-hook 'slime-repl-mode-hook 'override-slime-repl-bindings-with-paredit)


;;;;;;;;; Clojure ;;;;;;;;;;;;
(use-package clojure-mode
  :ensure t

  :bind
  (:map clojurec-mode-map
   ("\C-c\C-z" . cider-jack-in))
  
  :hook
  (cider-mode-hook . ac-flyspell-workaround)
  (cider-mode-hook . ac-cider-setup)
  (cider-repl-mode-hook . ac-cider-setup)
  
  :config
  (require 'cider-mode)
  (require 'ac-cider)
  )

;(require 'clojure-mode)
;(require 'cider-mode)
;(require 'ac-cider)
;
;(add-hook 'clojure-mode-hook (lambda ()
;                             (define-key (current-local-map) (kbd "\C-c\C-z") 'cider-jack-in)))
;(add-hook 'cider-mode-hook 'ac-flyspell-workaround)
;(add-hook 'cider-mode-hook 'ac-cider-setup)
;(add-hook 'cider-repl-mode-hook 'ac-cider-setup)

(eval-after-load "auto-complete"
       '(progn
          (add-to-list 'ac-modes 'cider-mode)
          (add-to-list 'ac-modes 'cider-repl-mode)))

(provide 'init-lisp)
