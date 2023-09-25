(require 'cl-lib)
(require 'helm)

(defgroup code-it-later nil
  "code-it-later emacs mode")

;;(defcustom args) ;; the args for codeitlater

(defcustom cache-sources
  '()
  "for test now"
  :group 'code-it-later)

;; (defun run-code-it-later (&rest keys &key)
;;   "run codeitlater and get the json response"
;;   (shell-command-to-string "codeitlater -O json"))

(defun parse-response-json (respose)
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

(defun code-it-later--filter-one-by-one (candidate)
  (cons candidate candidate)
  )

(defclass code-it-later-class (helm-source-async)
  ((candidate-number-limit :initform 99999)
   (filter-one-by-one :initform 'code-it-later--filter-one-by-one)
   )
  "async helm source"
  )

(defun do-code-it-later ()
  ""
  (let ((proc (apply 	
			   #'start-process-shell-command "code-it-later" nil
			   '("codeitlater -O list ~/.emacs.d/lisp/")
			   ;;'("echo -e \"a\\nb\\nc\\nd\\n\"")
			   )))
	(prog1 proc
	  (set-process-sentinel
	   proc
	   (lambda (process event)
		 (when (string= event "finished\n")
		   (with-helm-window
			 (save-excursion
			   (message (buffer-name))
			   ))
		   (message "done codeitlater")))))))

(defvar code-it-later-source nil)

(defun set-code-it-later-source ()
  "set source"
  (setf code-it-later-source
		(helm-make-source "code-it-later"
			'code-it-later-class
		  :candidates-process
		  (lambda ()
			(let ((proc (do-code-it-later)
						))
			  proc))
		  
		  )))

;;;###autoload
(defun code-it-later-dummy ()
  (interactive)
  (helm :sources (helm-build-sync-source "test"
                 :candidates '(a b c d e)
                 :display-to-real (lambda (c) (concat c ":modified by d-t-r")))
		:buffer "*helm test*"))

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
		:filter-one-by-one 'code-it-later--filter-one-by-one
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
;;   (parse-response-json data)
;;   )

(provide 'code-it-later-mode)
