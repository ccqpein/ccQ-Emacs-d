(defun gcc-version ()
  (car (last
        (split-string
         (shell-command-to-string "gcc-10 --version | head -n 1 | tr -d '\n'")
         " "))))

(use-package cc-mode
  :hook
  (cc-mode . clang-format)

  :config
  (setq gcc-version (gcc-version))
  (setq clang-format-style "file"
        clang-format-fallback-style "google"
        flycheck-c/c++-gcc-executable "gcc-10"
        flycheck-gcc-include-path (list (format "/usr/local/Cellar/gcc/%s/include/c++/%s" gcc-version gcc-version)
                                        (format "/usr/local/Cellar/gcc/%s/lib/include/c++/%s/x86_64-apple-darwin19"gcc-version gcc-version )
                                        (format "/usr/local/Cellar/gcc/%s/include/c++/%s/backward"gcc-version gcc-version )
                                        (format "/usr/local/Cellar/gcc/%s/lib/gcc/10/gcc/x86_64-apple-darwin19/%s/include"gcc-version gcc-version )
                                        (format "/usr/local/Cellar/gcc/%s/lib/gcc/10/gcc/x86_64-apple-darwin19/%s/include-fixed"gcc-version gcc-version )
                                        ))
  (setq-default flycheck-disabled-checkers '(c/c++-clang))
  (add-hook 'before-save-hook
            (lambda ()
              (when (derived-mode-p '(c-mode c++-mode))
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
