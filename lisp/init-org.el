;;;;;; Org mode ;;;;;;;;;;
(require 'org)
(define-key org-mode-map (kbd "C-c l") 'org-store-link)
(define-key org-mode-map (kbd "C-c a") 'org-agenda)
(setq org-agenda-files (list (getenv "ORG_PATH")))
(setq org-log-done t)
(setq org-hide-leading-stars t)

(provide 'init-org)
