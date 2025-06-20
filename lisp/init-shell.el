;; -*- lexical-binding: t; -*-

;;;;;;;; exec-path-from-shell ;;;;;;;;;;;;;;;;;
(straight-use-package 'exec-path-from-shell)

(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))

(when (daemonp)
  (setq exec-path-from-shell-check-startup-files nil)
  (exec-path-from-shell-initialize)
  (exec-path-from-shell-copy-env "GOPATH"))

(use-package fish-mode)

(use-package vterm)

(provide 'init-shell)
