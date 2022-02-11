;;;;;;;;;;; global general packages ;;;;;;;;;;;;;
;;;:= TODO: still need to know how to move auto-complete and yasnippet here

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
(use-package magit)

(use-package forge
  :after magit)

(use-package ace-window
  :bind
  ("M-o" . ace-window))

(provide 'init-general)
