;; -*- lexical-binding: t; -*-
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name
        "straight/repos/straight.el/bootstrap.el"
        (or (bound-and-true-p straight-base-dir)
            user-emacs-directory)))
      (bootstrap-version 7))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(defun check-commands-existence (commands)
  "Check if all COMMANDS exist in the PATH."
  (let ((missing-commands
         (remove nil
                 (mapcar (lambda (cmd)
                           (unless (executable-find cmd)
                             cmd))
                         commands))))
    (dolist (cmd missing-commands)
      (message "Warning: %s, maybe need for some configuration, not found in PATH." cmd))))

;; Example usage
(check-commands-existence
 '("codeitlater"
   "rust-analyzer" ;; for rust lsp
   "ruff" ;; for python lsp
   "uv"
   "aspell"
   ))

(provide 'init-bootstrap)
