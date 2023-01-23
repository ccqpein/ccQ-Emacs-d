;;;;;;;;;;; global general packages ;;;;;;;;;;;;;
;;;:= TODO: still need to know how to move auto-complete and yasnippet here

;;; straight.el
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 6))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

;;;;;;;; multiple-cursors ;;;;;;;;;;;;;;;;
(use-package multiple-cursors
  :bind
  (("M-\\" . mc/edit-lines)
   ("M-]" . mc/mark-next-like-this)
   ("M-[" . mc/mark-previous-like-this)
   ("C-c M-p" . mc/mark-all-like-this)
   ("C-c M-\\" . mc/mark-all-in-region))
  )

;;;;;;;; expand-region ;;;;;;;;;;;;;;;
(use-package expand-region
  :bind ("C-@" . er/expand-region)

  :config
  (delete-selection-mode 1))

;;;;;;;; highlight-symbol ;;;;;;;;;;;;;;;;;;
(use-package highlight-symbol
  :bind
  (("C-M-]" . highlight-symbol-next)
   ("C-M-[" . highlight-symbol-prev)))

;;;;;; Google ;;;;;;;;;;;;;;;;
(use-package google-this
  :init
  (google-this-mode 1)
  
  :bind
  ("C-c /" . google-this-mode-submap)
  )

;;;;;; Magit ;;;;;;;
(use-package magit
  ;;:hook (magit-mode . magit-delta-mode)

  :bind
  (("M-RET" . magit-diff-visit-file-other-window))
  )

(use-package forge
  :after magit)

(use-package ace-window
  :bind
  ("M-o" . ace-window))

(define-key global-map (kbd "TAB") 'company-indent-or-complete-common)

(provide 'init-general)
