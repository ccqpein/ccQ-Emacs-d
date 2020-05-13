(use-package dash-at-point
  :config
  (dolist (queryS '((swift-mode . "swift")
				    (swift-repl-mode . "swift")
                    (lisp-mode . "lisp")
                    (slime-repl-mode . "lisp")
                    (lisp-interaction-mode . "elisp")
                    (inferior-emacs-lisp-mode . "elisp")
                    (haskell-interactive-mode . "haskell")
                    (cider-repl-mode . "clojure")
                    (jdee-mode . "java")
				    (scala-mode . "scala")
				    (inferior-python-mode . "python")
				    (utop-mode . "ocaml")
                    (julia-mode . "julia")))
    (add-to-list 'dash-at-point-mode-alist-legacy queryS)
    (add-to-list 'dash-at-point-mode-alist queryS)
    )

  :hook
  (web-mode . (lambda ()
                (setq dash-at-point-docset "typescript,javascript,react")))
  )

;;;;;; Dash integration ;;;;;;
;; (autoload 'dash-at-point "dash-at-point"
;;   "Search the word at point with Dash." t nil)

;; Dash intergration does not have some keys' words connection, add code below to make it happen
;; (dolist (queryS '((swift-mode . "swift")
;; 				  (swift-repl-mode . "swift")
;;                   (lisp-mode . "lisp")
;;                   (slime-repl-mode . "lisp")
;;                   (lisp-interaction-mode . "elisp")
;;                   (inferior-emacs-lisp-mode . "elisp")
;;                   (haskell-interactive-mode . "haskell")
;;                   (cider-repl-mode . "clojure")
;;                   (jdee-mode . "java")
;; 				  (scala-mode . "scala")
;; 				  (inferior-python-mode . "python")
;; 				  (utop-mode . "ocaml")
;;                ))
;;   (add-to-list 'dash-at-point-mode-alist-legacy queryS)
;;   (add-to-list 'dash-at-point-mode-alist queryS)
;;   )
(global-set-key (kbd "C-c d") 'dash-at-point)
(global-set-key (kbd "C-c e") 'dash-at-point-with-docset)

;; (defun web-mode-pick-string ()
;;   (cond ((string-equal "tsx" (file-name-extension buffer-file-name))
;;          (setq dash-at-point-docset "typescript,react"))
;;         ((string-equal "jsx" (file-name-extension buffer-file-name))
;;          (setq dash-at-point-docset "javascript"))))

(provide 'init-dash)
