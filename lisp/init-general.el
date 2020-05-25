;;;;;;;;;;; global general packages ;;;;;;;;;;;;;
;;;:= TODO: still need to know how to move auto-complete and yasnippet here
(use-package multiple-cursors
  :bind
  (("M-\\" . mc/edit-lines)
   ("M-]" . mc/mark-next-like-this)
   ("M-[" . mc/mark-previous-like-this)
   ("C-c M-p" . mc/mark-all-like-this)
   ("C-c M-\\" . mc/mark-all-in-region))
  )

(use-package expand-region
  :bind ("C-@" . er/expand-region)

  :config
  (delete-selection-mode 1))

(use-package highlight-symbol
  :bind
  (("C-M-]" . highlight-symbol-next)
   ("C-M-[" . highlight-symbol-prev)))

(use-package google-this
  :init
  (google-this-mode 1)
  
  :bind
  ("C-c /" . google-this-mode-submap)
  )

(use-package magit
  :bind
  (("C-x M-G" . magit-dispatch-popup)
   ("C-x M-g" . magit-status)))

(use-package ace-window
  :bind
  ("M-o" . ace-window))

(provide 'init-general)
