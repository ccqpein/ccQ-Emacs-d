;; ## added by OPAM user-setup for emacs / base ## 56ab50dc8996d2bb95e7856a6eddb17b ## you can edit, but keep this line
;(require 'opam-user-setup "~/.emacs.d/plugins/opam-user-setup.el")
;; ## end of OPAM user-setup addition for emacs / base ## keep this line
;; move from init.el to here by me

(use-package merlin-mode
  :hook
  (tuareg-mode caml-mode)
  :config
  (setq merlin-command 'opam)
  )

;;need autoload first
;;(autoload 'utop-minor-mode "utop" "Minor mode for utop" t)

(use-package tuareg
  :hook
  ((tuareg-mode . utop-minor-mode)
   (tuareg-mode . my-hook)
   )
  )

(defun my-hook ()
  (setq show-trailing-whitespace t)
  (local-set-key (kbd "C-c C-e") 'utop-eval-phrase)
  )


(provide 'init-ocaml)
