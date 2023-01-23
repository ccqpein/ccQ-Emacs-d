#!emacs -q --script 

;;; make path var
(defvar cpath "~/.emacs.d/")

(unless (file-exists-p (concat cpath "elpa"))
  (make-directory (concat cpath "elpa")))

;;; load package module
(require 'package)
(setq package-archives '(
 ("melpa" . "http://melpa.org/packages/")
 ("melpa-stable" . "http://stable.melpa.org/packages/")
 ("gnu" . "http://elpa.gnu.org/packages/")
 ))
(package-initialize)

;;; read package list from `packages` file
(defvar *packages-list
  (with-temp-buffer
	(insert-file-contents (concat cpath "init.el"))
	(cl-loop 
	 for exp = (read (current-buffer))
	 if (eql 'custom-set-variables (car exp))
	 return (cl-loop
			 for e in exp
			 when (and (eql 'cons (type-of e))
					   (eql 'package-selected-packages (caadr e)))
			 return (cadr (cadadr e))
			 ))))

;; (print *packages-list)
;; refrash contents anyway in case cannot found package
(package-refresh-contents)

;;; install packages
(dolist (package *packages-list)
  (if (package-installed-p package)
      (princ (format "%s already installed \n" package))
    (progn
      (princ (format "%s is installing \n" package))
      (package-install package)
      (princ (format "%s installed \n\n" package)))))

;;; run the addtional scripts if there is one
;; (if (yes-or-no-p "wanna run addtional package installment? ")
;; 	(let ((default-directory (concat cpath "plugins")))
;; 	  (princ (format "starting to run additional script"))
;; 	  (princ (shell-command-to-string "sbcl --load install-packages.lisp --non-interactive"))))

