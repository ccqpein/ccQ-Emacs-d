;;; init file
(require 'package)
(dolist (url '(("melpa" . "https://melpa.org/packages/")
	       ("melpa-stable" . "http://stable.melpa.org/packages/")
	       ))
  (add-to-list 'package-archives url t))

(dolist (path '("~/.emacs.d/elpa"
		"~/.emacs.d/plugins/"
		"~/.emacs.d/languages/"
                ))
  (add-to-list 'load-path path))

(package-initialize)


;;;;;;;;;; set frame default ;;;;;;;;;;;;;;;
(add-to-list 'default-frame-alist '(width . 110))
(add-to-list 'default-frame-alist '(height . 60))
(global-hl-line-mode 1)
(global-linum-mode t) ;; enable line numbers globally
;; close bars
(tool-bar-mode -1)
(scroll-bar-mode -1)
(menu-bar-mode -1)
(show-paren-mode 1)
(blink-cursor-mode 1)
(setq show-paren-style 'mix)

(setq backup-directory-alist '(("" . "~/.emacs.d/backups")))
(defalias 'list-buffers 'ibuffer) ; make ibuffer default


;;;;;;; lsp support ;;;;;;;
(require 'lsp-mode)
(require 'lsp-imenu)
(add-hook 'lsp-after-open-hook 'lsp-enable-imenu)


;;;;;;; autocomplete ;;;;;;
(require 'auto-complete)
(require 'go-autocomplete)
(require 'auto-complete-config)
(ac-config-default)
(let ((ACpath (file-name-as-directory (car ac-dictionary-directories)))
      (user-modes '("swift-mode" "lisp-mode" "rust-mode")))
  (dolist (user-mode-name user-modes)
    (if (not (file-exists-p (concat ACpath user-mode-name)))
          (shell-command (concat "ln -s " "~/.emacs.d/plugins/" user-mode-name " " ACpath user-mode-name)))
    (add-to-list 'ac-modes (make-symbol user-mode-name))))
(global-auto-complete-mode t)


;;;;;;; flycheck ;;;;;;;
(global-flycheck-mode)


;;;;;;; company ;;;;;;;;
(global-company-mode)


;;;;;;; yasnippet ;;;;;;
(require 'yasnippet)
(yas-global-mode 1)

(require 'treemacs )

;;;;;;;; multiple-cursors ;;;;;;;;;;;;;;;;
(require 'multiple-cursors)
(global-set-key (kbd "M-\\") 'mc/edit-lines)
(global-set-key (kbd "M-]") 'mc/mark-next-like-this)
(global-set-key (kbd "M-[") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c M-p") 'mc/mark-all-like-this)
(global-set-key (kbd "C-c M-\\") 'mc/mark-all-in-region)


;;;;;;;; highlight-symbol ;;;;;;;;;;;;;;;;;;
(require 'highlight-symbol)
(global-set-key (kbd "C-M-]") 'highlight-symbol-next)
(global-set-key (kbd "C-M-[") 'highlight-symbol-prev)

;(require 'init-lisp)

;;;;;;;; expand-region ;;;;;;;;;;;;;;;
(require 'expand-region)
(global-set-key (kbd "C-@") 'er/expand-region)
(delete-selection-mode 1)


(require 'shell)

;;;;;; Styling and Themes ;;;;;;;
(load-theme 'monokai t)


;;;;;; Helm ;;;;;;;;;;;;
(require 'helm)
(require 'helm-config)
(helm-mode 1)
(helm-autoresize-mode t)

(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)
(global-set-key (kbd "C-c h") 'helm-command-prefix)
(global-set-key (kbd "C-x b") 'helm-mini)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "C-s") 'helm-occur)
(global-set-key (kbd "C-c h g") 'helm-google-suggest)

(setq helm-split-window-in-side-p           t
      helm-move-to-line-cycle-in-source     t
      helm-ff-search-library-in-sexp        t
      helm-M-x-fuzzy-match                  t
      helm-buffers-fuzzy-matching           t
      helm-locate-fuzzy-match               t
      helm-recentf-fuzzy-match              t
      helm-semantic-fuzzy-match             t
      helm-imenu-fuzzy-match                t
      helm-scroll-amount                    8
      helm-ff-file-name-history-use-recentf t)

(setq
 helm-gtags-ignore-case t
 helm-gtags-auto-update t
 helm-gtags-use-input-at-cursor t
 helm-gtags-pulse-at-cursor t
 helm-gtags-prefix-key "\C-cg"
 helm-gtags-suggested-key-mapping t
 )

(require 'helm-gtags)

(define-key helm-gtags-mode-map (kbd "C-c g a") 'helm-gtags-tags-in-this-function)
(define-key helm-gtags-mode-map (kbd "C-c g j") 'helm-gtags-select)
(define-key helm-gtags-mode-map (kbd "M-.") 'helm-gtags-dwim)
(define-key helm-gtags-mode-map (kbd "M-,") 'helm-gtags-pop-stack)
(define-key helm-gtags-mode-map (kbd "C-c <") 'helm-gtags-previous-history)
(define-key helm-gtags-mode-map (kbd "C-c >") 'helm-gtags-next-history)

;; Enable helm-gtags-mode
(add-hook 'dired-mode-hook 'helm-gtags-mode)
(add-hook 'eshell-mode-hook 'helm-gtags-mode)
(add-hook 'c-mode-hook 'helm-gtags-mode)
(add-hook 'c++-mode-hook 'helm-gtags-mode)
(add-hook 'emacs-lisp-mode-hook 'helm-gtags-mode)
(add-hook 'lisp-mode-hook 'helm-gtags-mode)
(add-hook 'lisp-interaction-mode-hook 'helm-gtags-mode)
(add-hook 'slime-repl-mode-hook 'helm-gtags-mode)
(add-hook 'clojure-mode-hook 'helm-gtags-mode)
(add-hook 'cider-repl-mode-hook 'helm-gtags-mode)
(add-hook 'python-mode-hook 'helm-gtags-mode)
(add-hook 'elpy-mode-hook 'helm-gtags-mode)
(add-hook 'web-mode-hook 'helm-gtags-mode)
(add-hook 'swift-mode-hook 'helm-gtags-mode)
(add-hook 'haskell-mode-hook 'helm-gtags-mode)
(add-hook 'scala-mode-hook 'helm-gtags-mode)
(add-hook 'go-mode-hook 'helm-gtags-mode)


;;;;;; Magit ;;;;;;;
(global-set-key (kbd "C-x M-G") 'magit-dispatch-popup)
(global-set-key (kbd "C-x M-g") 'magit-status)


;;;;;; AUCTeX ;;;;;;
(require 'tex-mik)
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil)
(add-hook 'LaTeX-mode-hook 'visual-line-mode)
(add-hook 'LaTeX-mode-hook 'flyspell-mode)
(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
(setq reftex-plug-into-AUCTeX t)
(setq TeX-PDF-mode t)


;;;;;; Dash integration ;;;;;;
(autoload 'dash-at-point "dash-at-point"
  "Search the word at point with Dash." t nil)
;; Dash intergration does not have some keys' words connection, add code below to make it happen
(dolist (queryS '((swift-mode . "swift")
		  (swift-repl-mode . "swift")
                  (lisp-mode . "lisp")
                  (slime-repl-mode . "lisp")
                  (lisp-interaction-mode . "elisp")
                  (inferior-emacs-lisp-mode . "elisp")
                  (haskell-interactive-mode . "haskell")
                  (cider-repl-mode . "clojure")
                  (jdee-mode . "java")
		  (scala-mode . "scala")
		  (inferior-python-mode . "python")))
  (add-to-list 'dash-at-point-mode-alist-legacy queryS)
  (add-to-list 'dash-at-point-mode-alist queryS)
  )
(global-set-key "\C-cd" 'dash-at-point)
(global-set-key "\C-ce" 'dash-at-point-with-docset)


;;;;;; Google ;;;;;;;;;;;;;;;;
(require 'google-this)
(google-this-mode 1)
(global-set-key (kbd "C-c /") 'google-this-mode-submap)


;;;;;; Org mode ;;;;;;;;;;
(require 'org)
(define-key org-mode-map (kbd "C-c l") 'org-store-link)
(define-key org-mode-map (kbd "C-c a") 'org-agenda)
(setq org-agenda-files (list (getenv "ORG_PATH")))
(setq org-log-done t)
(setq org-hide-leading-stars t)


;;;;;; markdown mode ;;;;;;
(autoload 'markdown-mode "markdown-mode"
  "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))


(require 'init-java)

(require 'init-python)

(require 'init-golang)

(require 'init-swift)

(require 'init-haskell)

(require 'init-typescript)

(require 'init-web-n-php)

(require 'init-js)

(require 'init-scala)

(require 'init-rust)


;;;;;;;;;;; custom setting;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(expand-region-smart-cursor t)
 '(haskell-process-auto-import-loaded-modules t)
 '(haskell-process-log t)
 '(haskell-process-suggest-remove-import-lines t)
 '(haskell-stylish-on-save t)
 '(haskell-tags-on-save t)
 '(jdee-compiler (quote ("javac")))
 '(jdee-jdk-registry (quote (("1.8" . "/Library/Java/Home"))))
 '(magit-diff-arguments (quote ("--no-ext-diff" "--stat")))
 '(markdown-command "~/.emacs.d/plugins/open-markdown-to-web.sh")
 '(markdown-open-command "~/.emacs.d/plugins/open-markdown-marked2.sh")
 '(package-selected-packages
   (quote
    (treemacs flycheck-rust lsp-mode lsp-rust racer rust-mode highlight-symbol monokai-theme ensime tide helm-gtags helm ac-cider cider clojure-mode auctex magit neotree js2-mode web-mode swiper swift-mode slime py-autopep8 pkg-info paredit multiple-cursors markdown-mode jdee hindent haskell-mode google-this go-mode expand-region exec-path-from-shell elpy dash-at-point better-defaults ac-php)))
 '(recentf-max-saved-items 10)
 '(visible-bell nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(region ((t (:inherit highlight :background "SkyBlue4"))))
 '(show-paren-match ((t (:foreground "#A6E22E" :inverse-video t :weight normal)))))
