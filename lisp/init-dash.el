;;;;;; Dash integration ;;;;;;
(autoload 'dash-at-point "dash-at-point"
  "Search the word at point with Dash." t nil)

;; Dash intergration does not have some keys' words connection, add code below to make it happen
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
		  (inferior-python-mode . "python")))
  (add-to-list 'dash-at-point-mode-alist-legacy queryS)
  (add-to-list 'dash-at-point-mode-alist queryS)
  )
(global-set-key "\C-cd" 'dash-at-point)
(global-set-key "\C-ce" 'dash-at-point-with-docset)

(provide 'init-dash)
