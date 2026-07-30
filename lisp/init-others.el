;;  -*- lexical-binding: t; -*-

;;; others el including anything that not enough inside the general
(use-package protobuf-mode
  :mode "\\.proto\\'")

(use-package treesit
  :straight nil
  :when (treesit-available-p)
  
  :config
  (dolist (queryS '((rust-ts-mode . "rust")
                    (go-ts-mode . "go,godoc")
                    (python-ts-mode . "python3,django,twisted,sphinx,flask,tornado,sqlalchemy,numpy,scipy,saltcvp")))
    (add-to-list 'dash-at-point-mode-alist-legacy queryS)
    (add-to-list 'dash-at-point-mode-alist queryS)
    ))

(use-package treesit-auto
  :custom
  (treesit-auto-install 'prompt)
  :config
  (delete 'markdown treesit-auto-langs)
  (delete 'rust treesit-auto-langs) ;; rust-ts-mode not ready to me yet
  (delete 'go treesit-auto-langs) ;; go-ts-mode has the same issue
  (treesit-auto-add-to-auto-mode-alist 'all)
  (global-treesit-auto-mode))

(provide 'init-others)
