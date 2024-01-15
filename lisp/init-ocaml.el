(use-package tuareg
  :mode
  (("\\.ml\\'" . tuareg-mode))
  :hook
  ((tuareg-mode . utop-minor-mode)

   (tuareg-mode . my-hook)
   ))

(use-package utop
  :bind
  (("C-c C-z" . utop))
  :config
  ;; Use the opam installed utop
  (setq utop-command "opam exec -- utop -emacs")
  ;; use dune utop
  ;;(setq utop-command "opam exec -- dune utop . -- -emacs")
  )

(use-package merlin
  :hook
  ((tuareg-mode . merlin-mode)
   (merlin-mode . company-mode)
   )
  :config
  (setq merlin-command 'opam)
  (setq merlin-error-after-save nil)
  )

(use-package merlin-eldoc
  :hook
  ((merlin-mode . merlin-eldoc-setup)))

(use-package ocamlformat)

(use-package flycheck-ocaml)

(use-package dune)

(defun my-hook ()
  (setq show-trailing-whitespace t)
  (local-set-key (kbd "C-c C-e") 'utop-eval-phrase)
  (add-hook 'before-save-hook 'ocamlformat-before-save)
  (flycheck-ocaml-setup) ;; flycheck-ocaml here
  )

(provide 'init-ocaml)
