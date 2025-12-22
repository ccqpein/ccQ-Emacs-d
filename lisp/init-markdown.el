;; -*- lexical-binding: t; -*-

(defun my/markdown-capf-setup ()
  "need let markdown mode buffer know they are all equal. 
because lsp-completion-at-point is exclusive"
  (setq-local completion-at-point-functions
              (list (cape-capf-super
                     #'lsp-completion-at-point
                     #'cape-dabbrev
                     #'cape-dict
                     ))))

(use-package markdown-mode
  :hook
  ((lsp-managed-mode . my/markdown-capf-setup))
  
  :bind (:map markdown-mode-map
              ("C-;" . flyspell-correct-wrapper)
              ("C-'" . flyspell-buffer)
              )
  :config
  (setq ispell-program-name "aspell")
  )

;;; flyspell mode enable will lag my emacs
;;; manually run the flyspell-buffer instead the on-fly check
(use-package flyspell
  ;; :hook (;;(markdown-mode . flyspell-mode)
  ;;        ;;(org-mode . flyspell-mode)
  ;;        ;;(text-mode . flyspell-mode)
  ;;        )
  :config
  (setq ispell-program-name "aspell")
  )

(use-package flyspell-correct
  ;; :bind (:map flyspell-mode-map
  ;;             ("C-;" . flyspell-correct-wrapper))
  )

(use-package flyspell-correct-helm
  :after flyspell-correct)

(provide 'init-markdown)
