(when (and (>= emacs-major-version 29)
		   (treesit-available-p))
  (require 'treesit)
  (setq treesit-extra-load-path '("~/.emacs.d/tree-sitter-libs/"))

  ;; hooks of loading ts modes
  (add-hook 'go-mode-hook 'go-ts-mode)
  (add-hook 'python-mode-hook 'python-ts-mode)
  ;;(add-hook 'rust-mode-hook 'rust-ts-mode)
  (add-hook 'rust-ts-mode-hook 'rust-mode)
  ;;(add-hook 'go-mode-hook 'go-ts-mode)


  ;; for dash
  (dolist (queryS '((rust-ts-mode . "rust")
					(go-ts-mode . "go,godoc")
					(python-ts-mode . "python3,django,twisted,sphinx,flask,tornado,sqlalchemy,numpy,scipy,saltcvp")))
	(add-to-list 'dash-at-point-mode-alist-legacy queryS)
    (add-to-list 'dash-at-point-mode-alist queryS))
  )

(provide 'init-custom)
