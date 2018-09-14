;;;;;;;;;; JAVA-jdee ;;;;;;;;;;
(defun add-jdee-ac ()
  (let ((ACpath (file-name-as-directory (car ac-dictionary-directories))))
	(if (not (file-exists-p (concat ACpath "jdee-mode")))
		(shell-command (concat "ln -s " ACpath "java-mode " ACpath "jdee-mode")))))

(use-package jdee
  :init
  (add-jdee-ac)
  
  :custom
  (jdee-server-dir "~/.emacs.d/plugins/jdee-server/"))

;(require 'jdee)
;(setq jdee-server-dir "~/.emacs.d/plugins/jdee-server/")

(provide 'init-java)
