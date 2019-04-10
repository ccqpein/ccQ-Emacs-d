;;;;;;; web mode ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package web-mode
  :hook
  (web-mode . (lambda ()
				(define-key web-mode-map (kbd "C-c s") 'toggle-php-flavor-mode)
				(define-key web-mode-map (kbd "C-c C-;") 'web-mode-comment-or-uncomment)))
  (web-mode . (lambda ()
				(when (string-equal "tsx" (file-name-extension buffer-file-name))
				  (setup-tide-mode))
				(when (string-equal "jsx" (file-name-extension buffer-file-name))
				  (setup-tide-mode))))
  
  :custom
  (web-mode-enable-auto-closing t)
  (web-mode-enable-auto-pairing t)
  (web-mode-enable-current-element-highlight t)
  (web-mode-markup-indent-offset 2)
	(indent-tabs-mode nil)
  )

;(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))

(add-to-list 'auto-mode-alist '("\\.tsx\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.jsx\\'" . web-mode))

(add-to-list 'auto-mode-alist '("\\.php\\'" . php-mode))
(add-to-list 'auto-mode-alist '("\\.blade\\.php\\'" . web-mode))

;(setq web-mode-enable-auto-closing t)
;(setq web-mode-enable-auto-pairing t)
;(setq web-mode-enable-current-element-highlight t)

;(add-hook 'web-mode-hook
;          '(lambda ()
;             (define-key web-mode-map (kbd "C-c s") 'toggle-php-flavor-mode)
;             (define-key web-mode-map (kbd "C-c C-;") 'web-mode-comment-or-uncomment)))

;; for typescript mode
;(add-hook 'web-mode-hook
;          (lambda ()
;            (when (string-equal "tsx" (file-name-extension buffer-file-name))
;              (setup-tide-mode))
;            (when (string-equal "jsx" (file-name-extension buffer-file-name))
;              (setup-tide-mode))))


;;;;;;; PHP mode ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package php-mode
  :hook
  (php-mode . (lambda ()
				(define-key php-mode-map (kbd "M-.") 'ac-php-find-symbol-at-point)
				(define-key php-mode-map (kbd "C-c s") 'toggle-php-flavor-mode)
             ))
  
  :config
  (require 'ac-php))

;(require 'php-mode)
;(require 'ac-php)

(defun toggle-php-flavor-mode ()
  (interactive)
  (cond ((string-prefix-p "PHP" mode-name)
         (web-mode))
        ((string-prefix-p "Web" mode-name)
         (php-mode))))
;(global-set-key (kbd "") 'toggle-php-flavor-mode)

;(add-hook 'php-mode-hook
;          '(lambda ()
;             (define-key php-mode-map (kbd "M-.") 'ac-php-find-symbol-at-point)
;             (define-key php-mode-map (kbd "C-c s") 'toggle-php-flavor-mode)
;             ))

(provide 'init-web-n-php)
