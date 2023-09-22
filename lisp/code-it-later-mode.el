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
  "collect the reponse from json to alist"
  (cl-loop for bread across respose
		   do (message "bread: %s\n" bread)
		   for file-name = (alist-get 'file_path bread)
		   for crumbs = (cl-loop for crumb across (alist-get 'crumbs bread)
								 collect (list (alist-get 'line_num crumb)
											   (alist-get 'content crumb)
											   (alist-get 'keyword crumb)
											   (alist-get 'ignore crumb)))
		   collect (cons file-name crumbs)))

(defun format-to-emacs-buffer (responses)
  (message "bread after parse: %s\n" responses)
  (cl-loop with results = '()
		   for bread in responses
		   for filename = (car bread)
		   for crumbs = (cdr bread)
		   
		   do (cl-loop for crumb in crumbs
					   do (message "cumbs: %s" crumb)
					   do (add-to-list 'results
									   (format "%s:%s: %s" filename (car crumb) (nth 1 crumb))))
		   finally (return results)))

(defclass code-it-later-class (helm-source-async)
  ()
  "async helm source"
  )

(defvar code-it-later-source nil)

(defun set-code-it-later-source ()
  "set source"
  (setf code-it-later-source
		(helm-make-source "code-it-later"
			'code-it-later-class
		  :candidates-process
		  (lambda ()
			(let ((proc (prog1 (apply )
						  (set-process-sentinel
						   proc
						   (lambda (process event)
							 (princ
							  (format "Process: %s had the event '%s'" process event))
							 (helm-process-deferred-sentinel-hook
							  process event (helm-default-directory))
							 (when (string= event "finished\n")
							   (helm-ag--do-ag-propertize helm-input)))))
						;; (apply
						;; 	;;#'start-file-process "code-it-later" nil
						;; 	;;'("echo" "a" "b")
						;; 	#'start-process-shell-command "code-it-later" nil
						;; 	'("codeitlater -O json ~/.emacs.d/lisp/")
						;; 	)
						))
			  proc))
		  )))

;;;###autoload
(defun code-it-later ()
  (interactive)
  (set-code-it-later-source)
  (helm :sources
		;; (helm-build-sync-source "test"
		;;   :candidates '(a b c d e))
		'code-it-later-source
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
