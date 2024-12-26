;;;;;;;; exec-path-from-shell ;;;;;;;;;;;;;;;;;
(straight-use-package 'exec-path-from-shell)

(when (daemonp)
  (setq exec-path-from-shell-check-startup-files nil)
  (exec-path-from-shell-initialize)
  (exec-path-from-shell-copy-env "GOPATH"))

(use-package fish-mode)

(provide 'init-shell)
