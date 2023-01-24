;;;;;;;; exec-path-from-shell ;;;;;;;;;;;;;;;;;
(straight-use-package 'exec-path-from-shell)

(when (memq window-system '(mac ns x))
  (setq exec-path-from-shell-check-startup-files nil)
  (exec-path-from-shell-initialize)
  (exec-path-from-shell-copy-env "GOPATH"))

(provide 'init-shell)

