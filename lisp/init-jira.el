;;; looks like org-jira doesn't totally match the use-package
;; (use-package org-jira
;;   :custom  
;;   (org-jira-working-dir (concat (getenv "ORG_PATH") "/jira"))
;;   (jiralib-url (getenv "JIRA_URL"))

;;   :config
;;   (push org-jira-working-dir org-agenda-files)
;;   )

;; (eval-after-load 'org-jira
;;        '(progn
;; 		  (setf org-jira-working-dir (concat (getenv "ORG_PATH") "/jira")
;; 				jiralib-url (getenv "JIRA_URL"))
;;           (add-to-list 'org-agenda-files org-jira-working-dir)
;; 		  ))

(cl-defun make-sure-if-install (name recipe)
  (unless (package-installed-p (intern name))
	(funcall #'quelpa recipe)))

(use-package ejira
  :init (make-sure-if-install
		 "ejira"
		 '(ejira :fetcher git :url "https://github.com/nyyManni/ejira.git"))
  )

(provide 'init-jira)
