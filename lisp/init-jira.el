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

;;(use-package ejira)

(provide 'init-jira)
