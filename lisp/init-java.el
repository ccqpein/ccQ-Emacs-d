;;;;;;;;;; JAVA-jdee ;;;;;;;;;;
(let ((ACpath (file-name-as-directory (car ac-dictionary-directories))))
  (if (not (file-exists-p (concat ACpath "jdee-mode")))
      (shell-command (concat "ln -s " ACpath "java-mode " ACpath "jdee-mode"))))
(load "jdee")
(setq jdee-server-dir "~/.emacs.d/plugins/jdee-server/")

(provide 'init-java)
