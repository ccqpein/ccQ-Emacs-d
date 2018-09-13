;;;;;;;; treemacs ;;;;;;;;;
(use-package treemacs
  :ensure t

  :init (bind-key "C-x M-d" #'treemacs)
  
  :bind
  (:map treemacs-mode-map
   ("M-p" . treemacs-previous-project)
   ("M-n" . treemacs-next-project))
  
  :custom
  (treemacs-follow-after-init          t)
  (treemacs-width                      25)
  (treemacs-indentation                2)
  
  (treemacs-git-integration            t)
  (treemacs-git-mode                   'extended)
  (treemacs-filewatch-mode             t)
  
  (treemacs-collapse-dirs              3)
  (treemacs-silent-refresh             nil)
  (treemacs-change-root-without-asking nil)
  (treemacs-sorting                    'alphabetic-desc)
  (treemacs-show-hidden-files          t)
  (treemacs-never-persist              nil)
  (treemacs-is-never-other-window      nil)
  (treemacs-goto-tag-strategy          'refetch-index)
)

(provide 'init-treemacs)
