(use-package cc-mode
  :hook
  (cc-mode . clang-format)

  :config
  (setq clang-format-style "file"
        clang-format-fallback-style "google"
        flycheck-c/c++-gcc-executable "gcc-10"
        flycheck-gcc-include-path '("/usr/include"
                                    "/usr/local/Cellar/gcc/10.2.0/lib/gcc/10/gcc/x86_64-apple-darwin19/10.2.0/include/")
        )
  (add-hook 'before-save-hook
            (lambda ()
              (when (member major-mode '(c-mode c++-mode))
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
