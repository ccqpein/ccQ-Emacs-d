;; -*- lexical-binding: t; -*-

;; copy from https://github.com/ananthakumaran/tide#tsx
(defun setup-tide-mode ()
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  )

;;;;;;; PHP mode ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package php-mode
  :hook
  (php-mode . (lambda ()
                (define-key php-mode-map (kbd "M-.") 'ac-php-find-symbol-at-point)
                (define-key php-mode-map (kbd "C-c s") 'toggle-php-flavor-mode)
                ))
  
  :config
  (straight-use-package 'ac-php))

(defun toggle-php-flavor-mode ()
  (interactive)
  (cond ((string-prefix-p "PHP" mode-name)
         (web-mode))
        ((string-prefix-p "Web" mode-name)
         (php-mode))))

(provide 'init-web-n-php)
