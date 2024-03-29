;;;;;; Org mode ;;;;;;;;;;
(use-package org
  :ensure org-plus-contrib
  :hook
  (
   (org-mode . org-indent-mode)
   (org-mode . visual-line-mode)
   (org-mode . ejira-mode)
   )
  
  :bind
  (:map org-mode-map
        ("C-c l" . org-store-link)
        ("C-c a" . org-agenda)
        ("C-c c" . org-capture)
        )
  
  :custom
  (org-agenda-files (list (getenv "ORG_PATH")))
  (org-directory (getenv "ORG_PATH"))
  (org-log-done t)
  (org-hide-leading-stars t)
  (org-hide-emphasis-markers t)
  (org-log-into-drawer t)
  (org-babel-load-languages
   '((emacs-lisp . t)
     (dot . t)
     (python . t)
     (lisp . t)
     (shell . t)))
  
  ;;; capture templates
  (org-capture-templates
   '(("t" "Header template version 0" plain (function buffer-file-name)
      (file
       "template/template_header.org" ;; relative path to org-directory
       ))))
  
  ;; define the location of archive
  (org-archive-location "archive/%s_archive::* Archived Tasks")
  )

(provide 'init-org)
