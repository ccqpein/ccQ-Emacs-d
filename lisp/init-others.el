;;  -*- lexical-binding: t; -*-

;;; others el including anything that not enough inside the general
(use-package protobuf-mode
  :mode "\\.proto\\'")

(use-package treesit
  :straight nil
  :when (treesit-available-p)
  :init
  (setq treesit-extra-load-path '("~/.emacs.d/tree-sitter-libs/")
        major-mode-remap-alist
        '((python-mode . python-ts-mode)
          ;; (rust-mode . rust-ts-mode)
          ;; (go-mode . go-ts-mode)
          (conf-toml-mode . toml-ts-mode)
          ))
  
  :config
  (dolist (queryS '((rust-ts-mode . "rust")
                    (go-ts-mode . "go,godoc")
                    (python-ts-mode . "python3,django,twisted,sphinx,flask,tornado,sqlalchemy,numpy,scipy,saltcvp")))
    (add-to-list 'dash-at-point-mode-alist-legacy queryS)
    (add-to-list 'dash-at-point-mode-alist queryS)
    ))

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

(provide 'init-others)
