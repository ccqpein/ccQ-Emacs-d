;;;;;; Org mode ;;;;;;;;;;
(use-package org
  :bind
  (:map org-mode-map
	("C-c l" . org-store-link)
	("C-c a" . org-agenda)
	)
  :custom
  (org-agenda-files (list (getenv "ORG_PATH")))
  (org-log-done t)
  (org-hide-leading-stars t)
  (org-hide-emphasis-markers t)
  (org-babel-load-languages
   '((emacs-lisp . t)
	 (dot . t)
	 (python . t)))
  )

(provide 'init-org)


;;; 2018-09-13
;;; because I choice to use `use-package` to loading package
;;; code below are obsolete

;(require 'org)
;(define-key org-mode-map (kbd "C-c l") 'org-store-link)
;(define-key org-mode-map (kbd "C-c a") 'org-agenda)
;(setq org-agenda-files (list (getenv "ORG_PATH")))
;(setq org-log-done t)
;(setq org-hide-leading-stars t)
;(provide 'init-org)

