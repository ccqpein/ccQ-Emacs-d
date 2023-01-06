;;(use-package tree-sitter)
;;(use-package tree-sitter-langs :ensure t)
;;(use-package tree-sitter-indent :ensure t)

;;(require 'treesit)
(setq treesit-extra-load-path '("~/.emacs.d/tree-sitter-libs/"))
;;(treesit-available-p)
(global-tree-sitter-mode)

(provide 'init-treesitter)
