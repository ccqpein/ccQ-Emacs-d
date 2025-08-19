;; -*- lexical-binding: t; -*-

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
  :bind
  (("M-RET" . magit-diff-visit-file-other-window)))

(use-package forge
  :after magit)

(use-package ace-window
  :bind
  ("M-o" . ace-window)
  )

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

(use-package ultra-scroll
  :straight (ultra-scroll :type git :host github :repo "jdtsmith/ultra-scroll")
  :init
  (setq scroll-conservatively 101
        scroll-margin 0)
  :config
  (ultra-scroll-mode 1))

(use-package mb-depth
  :init (setq enable-recursive-minibuffers t)
  :config (minibuffer-depth-indicate-mode)
  )

(use-package saveplace
  :config (save-place-mode)
  )

(use-package vundo
  :bind
  (("C-c M-y" . vundo))

  :hook
  (vundo-mode . vundo-popup-mode)
  
  :custom
  (vundo-glyph-alist vundo-unicode-symbols)
  (vundo-compact-display t)
  (vundo-popup-timeout 2)
  )

(defun tear-off-window ()
  "Delete the selected window, and create a new frame displaying its buffer."
  (interactive)
  (let* ((window (selected-window))
         (buf (window-buffer window))
         (frame (make-frame)))
    (select-frame frame)
    (switch-to-buffer buf)
    (delete-window window))
  )

(global-set-key (kbd "C-x 5 2") 'tear-off-window)

(use-package bm
  :init
  (setq bm-restore-repository-on-load t)

  :config
  (setq bm-cycle-all-buffers t)

  (setq bm-repository-file "~/.emacs.d/bm-repository")

  ;; save bookmarks
  (setq-default bm-buffer-persistence t)

  ;; Loading the repository from file when on start up.
  (add-hook 'after-init-hook 'bm-repository-load)

  ;; Saving bookmarks
  (add-hook 'kill-buffer-hook #'bm-buffer-save)

  ;; Saving the repository to file when on exit.
  ;; kill-buffer-hook is not called when Emacs is killed, so we
  ;; must save all bookmarks first.
  (add-hook 'kill-emacs-hook #'(lambda nil
                                 (bm-buffer-save-all)
                                 (bm-repository-save)))

  ;; The `after-save-hook' is not necessary to use to achieve persistence,
  ;; but it makes the bookmark data in repository more in sync with the file
  ;; state.
  (add-hook 'after-save-hook #'bm-buffer-save)

  ;; Restoring bookmarks
  (add-hook 'find-file-hooks   #'bm-buffer-restore)
  (add-hook 'helm-projectile-find-file #'bm-buffer-restore)
  (add-hook 'after-revert-hook #'bm-buffer-restore)

  ;; The `after-revert-hook' is not necessary to use to achieve persistence,
  ;; but it makes the bookmark data in repository more in sync with the file
  ;; state. This hook might cause trouble when using packages
  ;; that automatically reverts the buffer (like vc after a check-in).
  ;; This can easily be avoided if the package provides a hook that is
  ;; called before the buffer is reverted (like `vc-before-checkin-hook').
  ;; Then new bookmarks can be saved before the buffer is reverted.
  ;; Make sure bookmarks is saved before check-in (and revert-buffer)
  (add-hook 'vc-before-checkin-hook #'bm-buffer-save)
  )

;;; check the height with (face-attribute 'default :height)
;; (defun my-adjust-default-face-for-frame (frame)
;;   "Adjust the default face height based on FRAME's dimensions."
;;   (with-selected-frame frame
;;     (cond ((and (= 1728 (display-pixel-width))
;;                 (= 1117 (display-pixel-height)))
;;            (set-face-attribute 'default frame :height 140))
;;           ((and (= 1920 (display-pixel-width)) ;; this one is the buggy one
;;                 (= 2197 (display-pixel-height)))
;;            (set-face-attribute 'default frame :height 140))
;;           ((=  1440 (display-pixel-height))
;;            (set-face-attribute 'default frame :height 160)))))

;; (if (daemonp)
;;     (add-hook 'after-make-frame-functions #'my-adjust-default-face-for-frame)
;;   (progn
;;     (my-adjust-default-face-for-frame (selected-frame))
;;     (add-hook 'after-make-frame-functions #'my-adjust-default-face-for-frame)))

(provide 'init-general)
