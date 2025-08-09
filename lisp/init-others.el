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


(provide 'init-others)
