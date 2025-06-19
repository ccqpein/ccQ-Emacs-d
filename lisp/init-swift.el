;; -*- lexical-binding: t; -*-
(use-package swift-mode
  :custom
  (swift-indent-offset 4)

  :hook
  ((before-save . swift-format-before-save)
   (swift-mode . lsp-deferred))
  )

(use-package lsp-sourcekit
  :after lsp-mode
  :config
  (setq lsp-sourcekit-executable
        (string-trim (shell-command-to-string "xcrun --find sourcekit-lsp")))
  )


(defun swift-format-before-save ()
  (interactive)
  (when (eq major-mode 'swift-mode)
    (let* ((filename buffer-file-name)
           (tempfilename (concat filename ".tmp"))
           (formatted-buffer (get-buffer-create "*formatted-buffer*")))
      (unwind-protect
          (progn (write-region (point-min) (point-max) tempfilename)
                 (with-current-buffer formatted-buffer
                   (erase-buffer)
                   (insert (shell-command-to-string (format "swift-format %s" tempfilename))))
                 (erase-buffer)
                 (insert-buffer formatted-buffer)
                 ;;(message "temp file name: %s" tempfilename)
                 )
        (kill-buffer formatted-buffer)
        (delete-file tempfilename)
        ))))

(provide 'init-swift)
