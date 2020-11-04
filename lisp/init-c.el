(use-package cc-mode
  :hook
  (cc-mode . clang-format)

  :config
  (setq clang-format-style "file"
        clang-format-fallback-style "google")
  (add-hook 'before-save-hook
            (lambda ()
              (when (member major-mode '(c-mode))
                (clang-format-buffer))))
  ;; (add-hook 'c-mode-hook
  ;;           (function
  ;;            (lambda ()
  ;;              (add-hook 'before-save-hook
  ;;                        (lambda ()
  ;;                          (when (member major-mode '(c-mode))
  ;;                            'clang-format-buffer))))))
  )

(provide 'init-c)
