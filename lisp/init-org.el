;; -*- lexical-binding: t; -*-

;;;;;; Org mode ;;;;;;;;;;
(use-package org
  :ensure org-plus-contrib
  :hook
  (
   (org-mode . org-indent-mode)
   (org-mode . visual-line-mode)
   ;;(org-mode . ejira-mode)
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
  (tab-width 8)

  ;; capture templates
  (org-capture-templates
   '(("t" "Header template version 0" plain (function buffer-file-name)
      (file
       "template/template_header.org" ;; relative path to org-directory
       ))))
  
  ;; define the location of archive
  (org-archive-location (concat org-directory "/archive/%s_archive::* Archived Tasks"))

  :config
  ;; my emphasis function
  (defun toggle-emphasis ()
    (interactive)
    (save-match-data
      (let* ((element (org-element-context))
             (type (org-element-type element))
             (pos (point)))
        ;;(message "%s, %s, %s" element type pos)
        ;;(message "%s" (1- (org-element-property :end element)))
        ;;(message "%s" (1- (org-element-property :begin element)))
        (if (or (eq type 'code)
                (eq type 'underline)
                (eq type 'bold)
                (eq type 'italic)
                (eq type 'verbatim)
                (eq type 'strike-through))
            (progn
              (goto-char (- (org-element-property :end element) 1))
              (delete-char 1)
              (goto-char (org-element-property :begin element))
              (delete-char 1)
              (goto-char (1- pos))
              )
          (call-interactively #'org-emphasize)))))
  
  (global-set-key [remap org-emphasize] #'toggle-emphasis))

(provide 'init-org)
