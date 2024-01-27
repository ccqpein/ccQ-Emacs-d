;;;;;;;;;;; global general packages ;;;;;;;;;;;;;

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

(use-package corfu
  :init
  (global-corfu-mode)
  (corfu-popupinfo-mode)
  
  :straight (corfu :files (:defaults "extensions/*")
                   :includes (corfu-popupinfo))
  
  :custom
  (corfu-cycle t)
  (corfu-auto t)
  (corfu-separator ?\s)
  (corfu-quit-at-boundary nil)
  (corfu-quit-no-match t)
  (corfu-preview-current 'insert)
  (corfu-preselect 'first)
  (corfu-on-exact-match nil)
  (corfu-scroll-margin 5)
  (corfu-auto-delay 0.0)
  
  ;; corfu-popupinfo
  (corfu-popupinfo-delay '(0.5 . 0.2))
  )

(use-package cape
  :init
  (add-to-list 'completion-at-point-functions #'cape-dict)
  ;;(add-to-list 'completion-at-point-functions #'cape-file)
  (add-to-list 'completion-at-point-functions #'cape-history)
  (add-to-list 'completion-at-point-functions #'cape-keyword)
  ;;(add-to-list 'completion-at-point-functions #'cape-symbol) ;; only for emacs
  (add-to-list 'completion-at-point-functions #'cape-dabbrev)
  )

(use-package flycheck
  :init (global-flycheck-mode)
  :config
  (remove-hook 'flymake-diagnostic-functions 'flymake-proc-legacy-flymake)
  )

(use-package code-it-later-mode
  :straight (code-it-later-mode :type git :host github :repo "ccqpein/code-it-later-mode")
  :commands code-it-later
  )

(provide 'init-general)
