;;;;;;;; treemacs ;;;;;;;;;
(require 'treemacs-mode)

(with-eval-after-load 'treemacs-mode
 (setq treemacs-follow-after-init          t
       treemacs-width                      25
       treemacs-indentation                2

       treemacs-git-integration            t
       treemacs-git-mode                   'extended
       treemacs-filewatch-mode             t
      
       treemacs-collapse-dirs              3
       treemacs-silent-refresh             nil
       treemacs-change-root-without-asking nil
       treemacs-sorting                    'alphabetic-desc
       treemacs-show-hidden-files          t
       treemacs-never-persist              nil
       treemacs-is-never-other-window      nil
       treemacs-goto-tag-strategy          'refetch-index
       ))

(global-set-key (kbd "C-x M-d") 'treemacs)
(define-key treemacs-mode-map (kbd "M-p") 'treemacs-previous-project)
(define-key treemacs-mode-map (kbd "M-n") 'treemacs-next-project)

(provide 'init-treemacs)
