(use-package swift-mode
  :custom
  (swift-indent-offset 4)

  :hook
  ((before-save . swift-format-before-save))
  
  :config
  (add-to-list 'ac-modes 'swift-mode)
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

;(require 'swift-mode)
;;Because swift-mode cannot load from ad-modes automatically even add swift-mode to ac-modes aoready. So need addition sentence next make sure swift mode load auto-complete
;(add-hook 'swift-mode-hook
;          (lambda ()
;            (add-to-list 'ac-modes 'swift-mode)
;            (define-key (current-local-map) (kbd "\C-c\C-k") 'swift-mode:send-buffer)
;            (setq swift-indent-offset 4)))

(provide 'init-swift)
