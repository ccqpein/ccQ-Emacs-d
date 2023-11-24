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
                (setq dash-at-point-docset "typescript,javascript,react"))))

(global-set-key (kbd "C-c d") 'dash-at-point)
(global-set-key (kbd "C-c e") 'dash-at-point-with-docset)


(provide 'init-dash)
