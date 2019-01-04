(use-package merlin-mode
  :hook
  (tuareg-mode caml-mode)
  :config
  (setq merlin-command 'opam)
  )

;;need autoload first
;;(autoload 'utop-minor-mode "utop" "Minor mode for utop" t)

(use-package ocamlformat)

(use-package tuareg
  :hook
  ((tuareg-mode . utop-minor-mode)
   (tuareg-mode . my-hook)
   )
  )

(defun my-hook ()
  (setq show-trailing-whitespace t)
  (local-set-key (kbd "C-c C-e") 'utop-eval-phrase)
  (add-hook 'before-save-hook 'ocamlformat-before-save)
  )


(provide 'init-ocaml)
