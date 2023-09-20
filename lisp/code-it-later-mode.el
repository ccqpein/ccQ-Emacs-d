(require 'cl-lib)
(require 'helm)

(defgroup code-it-later nil
  "code-it-later emacs mode")

;;(defcustom args) ;; the args for codeitlater

(defcustom cache-sources
  '()
  "for test now"
  :group 'code-it-later)

(defun run-code-it-later (&rest keys &key)
  "run codeitlater and get the json response"
  (shell-command-to-string "codeitlater -O json"))

(defun parse-response (respose)
  ""
  (cl-loop for bread across respose
		   do (message "bread: %s\n" bread)
		   for file-name = (alist-get 'file_path bread)
		   for crumbs = (cl-loop for crumb across (alist-get 'crumbs bread)
								 collect (cons (alist-get 'line_num crumb)
											   (alist-get 'content crumb)))
		   collect (cons file-name crumbs)))

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


;; (require 'code-it-later-mode)
;; (let ((json-object-type 'hash-table)
;; 	  (data (json-read-from-string (shell-command-to-string "codeitlater -O json")))	  
;; 	  )
;;   ;;(message "type %s" (type-of (car (aref data 0))))
;;   ;;(message "%s" json-object-type)
;;   ;;(message "%s" (car (aref data 0)))
;;   ;;(message "%s" (alist-get (car (aref data 0)) "file_path"))
  
;;   ;; (cl-loop for d across data
;;   ;; 		   do (message "\n")
;;   ;; 		   do (message "%s" (alist-get 'file_path d))
;;   ;; 		   ;;do (message "%s" d)
;;   ;; 		   ;; do (cl-loop for dd in d
;;   ;; 		   ;; 			   do (message "%s" dd)
;;   ;; 		   ;; 			   do (message "%s" (alist-get "file_path" dd)))
;;   ;; 		   )

;;   ;;(message "%s\n" data)
;;   (parse-response data)
;;   )

(provide 'code-it-later-mode)
