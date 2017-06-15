(require 'package)
(dolist (url '(("melpa" . "https://melpa.org/packages/")
	       ("melpa-stable" . "http://stable.melpa.org/packages/")
	       ))
  (add-to-list 'package-archives url t))

(dolist (path '("~/.emacs.d/elpa"
		"~/.emacs.d/plugins/"
                ))
  (add-to-list 'load-path path))

(package-initialize)


;;;;;;;;;; set frame default ;;;;;;;;;;;;;;;
(add-to-list 'default-frame-alist '(width . 110))
(add-to-list 'default-frame-alist '(height . 60))
(global-hl-line-mode 1)
(global-linum-mode t) ;; enable line numbers globally
(tool-bar-mode -1)

;;;;;;; autocomplete ;;;;;;
(require 'auto-complete)
(require 'go-autocomplete)
(require 'auto-complete-config)
(ac-config-default)
(let ((ACpath (file-name-as-directory (car ac-dictionary-directories)))
      (user-modes '("swift-mode" "lisp-mode")))
  (dolist (user-mode-name user-modes)
    (if (not (file-exists-p (concat ACpath user-mode-name)))
          (shell-command (concat "ln -s " "~/.emacs.d/plugins/" user-mode-name " " ACpath user-mode-name)))
    (add-to-list 'ac-modes (make-symbol user-mode-name))))
(global-auto-complete-mode t)


;;;;;;;; multiple-cursors ;;;;;;;;;;;;;;;;
(require 'multiple-cursors)
(global-set-key (kbd "M-\\") 'mc/edit-lines)
(global-set-key (kbd "M-]") 'mc/mark-next-like-this)
(global-set-key (kbd "M-[") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c M-p") 'mc/mark-all-like-this)
(global-set-key (kbd "C-c M-\\") 'mc/mark-all-in-region)


;;;;;;;; Neotree ;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'neotree)
(global-set-key (kbd "C-x M-D") 'neotree-toggle)
(setq neo-smart-open t)


;;;;;;;; Paredit ;;;;;;;;;;
(autoload 'enable-paredit-mode "paredit"
  "Turn on pseudo-structural editing of Lisp code."
  t)
(add-hook 'emacs-lisp-mode-hook 'enable-paredit-mode)
(add-hook 'lisp-mode-hook 'enable-paredit-mode)
(add-hook 'lisp-interaction-mode-hook 'enable-paredit-mode)
(add-hook 'slime-repl-mode-hook 'enable-paredit-mode)
(add-hook 'clojure-mode-hook 'enable-paredit-mode)
(add-hook 'cider-repl-mode-hook 'enable-paredit-mode)

;;Stop SLIME's REPL from grabbing DEL, which is annoying when backspacing over a '('
(defun override-slime-repl-bindings-with-paredit ()
  (define-key slime-repl-mode-map
    (read-kbd-macro paredit-backward-delete-key)
    nil))
(add-hook 'slime-repl-mode-hook 'override-slime-repl-bindings-with-paredit)


;;;;;;;; expand-region ;;;;;;;;;;;;;;;
(require 'expand-region)
(global-set-key (kbd "C-@") 'er/expand-region)
(delete-selection-mode 1)


;;;;;;;; exec-path-from-shell ;;;;;;;;;;;;;;;;;
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize)
  (exec-path-from-shell-copy-env "GOPATH"))


;;;;;; Styling and Themes ;;;;;;;
(require 'solarized-dark-theme)


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
(add-hook 'python-mode 'helm-gtags-mode)
(add-hook 'elpy-mode-hook 'helm-gtags-mode)
(add-hook 'web-mode-hook 'helm-gtags-mode)
(add-hook 'haskell-mode 'helm-gtags-mode)


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
                  (lisp-mode . "lisp")
                  (slime-repl-mode . "lisp")
                  (lisp-interaction-mode . "elisp")
                  (inferior-emacs-lisp-mode . "elisp")
                  (haskell-interactive-mode . "haskell")
                  (cider-repl-mode . "clojure")
                  (jdee-mode . "java")))
  (add-to-list 'dash-at-point-mode-alist-legacy queryS)
  (add-to-list 'dash-at-point-mode-alist queryS)
  )
(global-set-key "\C-cd" 'dash-at-point)
(global-set-key "\C-ce" 'dash-at-point-with-docset)


;;;;;; Google ;;;;;;;;;;;;;;;;
(require 'google-this)
(google-this-mode 1)
(global-set-key (kbd "C-c /") 'google-this-mode-submap)


;;;;;; markdown mode ;;;;;;
(autoload 'markdown-mode "markdown-mode"
  "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))


;;;;;;;;;; JAVA-jdee ;;;;;;;;;;
(let ((ACpath (file-name-as-directory (car ac-dictionary-directories))))
  (if (not (file-exists-p (concat ACpath "jdee-mode")))
      (shell-command (concat "ln -s " ACpath "java-mode " ACpath "jdee-mode"))))
(load "jdee")
(setq jdee-server-dir "~/.emacs.d/plugins/jdee-server/")


;;;;;;;;pythono-mode;;;;;;;;;;;;;;;;;;
(elpy-enable)
; ipython 5 make elpy-use-ipython bug
(elpy-use-ipython "ipython3")
(setq python-shell-interpreter "ipython3"
      python-shell-interpreter-args "--simple-prompt --pprint")

;; enable autopep8 formatting on save
(require 'py-autopep8)
(add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)


;;;;;;;;;Golang;;;;;;;;;;;;;;;;;;;;
(require 'go-mode)
;;(require 'go-autocomplete) add this line to autocomplete config

(defun my-go-mode-hook () ; Call Gofmt before saving
  (add-hook 'before-save-hook 'gofmt-before-save) ; Customize gofmt command to run go build
  (if (not (string-match "go" compile-command))
      (set (make-local-variable 'compile-command)
           "go generate && go build -v && go test -v && go vet")) ; Godef jump key binding
  (setq tab-width 4)
  (local-set-key (kbd "M-.") 'godef-jump)
  (define-key (current-local-map) "\C-c\C-c" 'compile)
  (define-key (current-local-map) "\C-c\C-r" 'go-remove-unused-imports)
  (define-key (current-local-map) "\C-c\i" 'go-goto-imports))

(add-hook 'go-mode-hook 'my-go-mode-hook)


;;;;;;;;; swift ;;;;;;;;;;;;;;;;
(require 'swift-mode)
;;Because swift-mode cannot load from ad-modes automatically even add swift-mode to ac-modes aoready. So need addition sentence next make sure swift mode load auto-complete
(add-hook 'swift-mode-hook
          (lambda ()
            (add-to-list 'ac-modes 'swift-mode)
            (define-key (current-local-map) (kbd "\C-c\C-k") 'swift-mode:send-buffer)
            (setq swift-indent-offset 4)))


;;;;;;;;; haskell ;;;;;;;;;;;;;
(require 'haskell-mode)
(require 'hindent)
(add-hook 'haskell-mode-hook 'interactive-haskell-mode)
(add-hook 'haskell-mode-hook 'hindent-mode)


;;;;;;;;; Clojure ;;;;;;;;;;;;
(require 'clojure-mode)
(require 'cider-mode)
(require 'ac-cider)

(add-hook 'clojure-mode-hook (lambda ()
                             (define-key (current-local-map) (kbd "\C-c\C-z") 'cider-jack-in)))
(add-hook 'cider-mode-hook 'ac-flyspell-workaround)
(add-hook 'cider-mode-hook 'ac-cider-setup)
(add-hook 'cider-repl-mode-hook 'ac-cider-setup)
(eval-after-load "auto-complete"
       '(progn
          (add-to-list 'ac-modes 'cider-mode)
          (add-to-list 'ac-modes 'cider-repl-mode)))


;;;;;;; slime ;;;;;;;;;
(setq inferior-lisp-program "/usr/local/bin/sbcl")
(setq slime-contribs '(slime-fancy))


;;;;;;; typescript mode ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun setup-tide-mode ()
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  (company-mode +1))
;; aligns annotation to the right hand side
(setq company-tooltip-align-annotations t)

;; formats the buffer before saving
(add-hook 'before-save-hook 'tide-format-before-save)
(add-hook 'typescript-mode-hook #'setup-tide-mode)

(setq tide-format-options
      '(:insertSpaceAfterFunctionKeywordForAnonymousFunctions
        t
        :placeOpenBraceOnNewLineForFunctions
        nil))

(setq tide-tsserver-executable "/usr/local/bin/tsserver")

;;;;;;; web mode ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'web-mode)
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

(setq web-mode-enable-auto-closing t)
(setq web-mode-enable-auto-pairing t)
(setq web-mode-enable-current-element-highlight t)

(add-hook 'web-mode-hook
          '(lambda ()
             (define-key web-mode-map (kbd "C-c s") 'toggle-php-flavor-mode)
             (define-key web-mode-map (kbd "C-c C-;") 'web-mode-comment-or-uncomment)))

;; for typescript mode
(add-hook 'web-mode-hook
          (lambda ()
            (when (string-equal "tsx" (file-name-extension buffer-file-name))
              (setup-tide-mode))
            (when (string-equal "jsx" (file-name-extension buffer-file-name))
              (setup-tide-mode))))


;;;;;;; PHP mode ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'php-mode)
(require 'ac-php)

(defun toggle-php-flavor-mode ()
  (interactive)
  (cond ((string-prefix-p "PHP" mode-name)
         (web-mode))
        ((string-prefix-p "Web" mode-name)
         (php-mode))))
(global-set-key (kbd "") 'toggle-php-flavor-mode)

(add-hook 'php-mode-hook
          '(lambda ()
             (define-key php-mode-map (kbd "M-.") 'ac-php-find-symbol-at-point)
             (define-key php-mode-map (kbd "C-c s") 'toggle-php-flavor-mode)
             ))


;;;;;;;; Javascript mode ;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(add-to-list 'interpreter-mode-alist '("node" . js2-mode))
(add-hook 'js-mode-hook 'js2-minor-mode)
(add-hook 'js2-mode-hook #'setup-tide-mode) ; for typescript mode


;;;;;;;;;;; custom setting;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(expand-region-smart-cursor t)
 '(haskell-process-auto-import-loaded-modules t)
 '(haskell-process-suggest-remove-import-lines t)
 '(haskell-stylish-on-save t)
 '(haskell-tags-on-save t)
 '(jdee-compiler (quote ("javac")))
 '(jdee-jdk-registry
   (quote
    (("1.8" . "/Library/Java/Home"))))
 '(magit-diff-arguments (quote ("--no-ext-diff" "--stat")))
 '(markdown-command "~/.emacs.d/plugins/open-markdown-to-web.sh")
 '(markdown-open-command "~/.emacs.d/plugins/open-markdown-marked2.sh")
 '(package-selected-packages
   (quote
    (tide helm-gtags helm solarized-theme ac-cider cider clojure-mode auctex magit neotree js2-mode web-mode swiper swift-mode slime py-autopep8 pkg-info paredit multiple-cursors markdown-mode jdee hindent haskell-mode google-this go-mode expand-region exec-path-from-shell elpy dash-at-point better-defaults ac-php)))
 '(recentf-max-saved-items 10)
 '(visible-bell nil))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
