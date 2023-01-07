(when (and (>= emacs-major-version 29)
		   (treesit-available-p))
  (require 'treesit)
  (setq treesit-extra-load-path '("~/.emacs.d/tree-sitter-libs/"))
  (add-hook 'go-mode-hook 'go-ts-mode)
  (add-hook 'python-mode-hook 'python-ts-mode)
  (add-hook 'rust-mode-hook 'rust-ts-mode))

(provide 'init-custom)
