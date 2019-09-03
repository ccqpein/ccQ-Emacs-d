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
 ))
(package-initialize)

;;; read package list from `packages` file
(defvar *packages-list (with-temp-buffer
                         (insert-file-contents (concat cpath "packages"))
                         (split-string (buffer-string) "\n" t)))

;(print *packages-list)
;; refrash contents anyway in case cannot found package
(package-refresh-contents)

;;; install packages
(dolist (package *packages-list)
  (if (package-installed-p (intern package))
      (princ (format "%s already installed \n" package))
    (progn
      (princ (format "%s is installing \n" package))
      (package-install (intern package))
      (princ (format "%s installed \n\n" package)))))
