#! emacs --script 

(defvar cpath "~/.emacs.d/")

(unless (file-exists-p (concat cpath "elpa"))
  (make-directory (concat cpath "elpa")))

(require 'package)
(dolist (url '(("melpa" . "https://melpa.org/packages/")
	       ("melpa-stable" . "http://stable.melpa.org/packages/")
	       ))
  (add-to-list 'package-archives url t))

(package-initialize)

(defvar *packages-list (with-temp-buffer
                         (insert-file-contents (concat cpath "packages"))
                         (split-string (buffer-string) "\n" t)))

(dolist (package *packages-list)
  (if (package-installed-p (intern package))
      (princ (format "%s already installed \n" package))
    (progn
      (princ (format "%s is installing \n" package))
      (package-install package))))
