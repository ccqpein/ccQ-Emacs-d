;; ## added by OPAM user-setup for emacs / base ## 56ab50dc8996d2bb95e7856a6eddb17b ## you can edit, but keep this line
;(require 'opam-user-setup "~/.emacs.d/plugins/opam-user-setup.el")
;; ## end of OPAM user-setup addition for emacs / base ## keep this line
;; move from init.el to here by me

(use-package merlin-mode
  :hook
  (tuareg-mode-hook caml-mode-hook)
  )

(use-package tuareg
  :hook
  (tuareg-mode-hook . (lambda()
						(setq show-trailing-whitespace t)
						(setq indicate-empty-lines t))
  ))


(provide 'init-ocaml)
