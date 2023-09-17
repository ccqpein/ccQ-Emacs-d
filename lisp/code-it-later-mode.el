(require 'cl-lib)
(require 'helm)

(defgroup code-it-later nil
  "code-it-later emacs mode")

(defcustom args) ;; the args for codeitlater

(defcustom cache-sources
  '()
  "for test now"
  :group 'code-it-later)

;;;###autoload
(defun code-it-later ()
  (interactive)
  (helm :sources (helm-build-sync-source "test"
				   :candidates '(a b c d e))
        ;;:full-frame t
        ;;:default input
        :candidate-number-limit 500
        :buffer "*code-it-later*")
  )

(provide 'code-it-later-mode)
