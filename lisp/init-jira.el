(use-package ejira
  :straight (ejira :type git :host github :repo "nyyManni/ejira")
  :init
  (setq jiralib2-url              (getenv "JIRA_URL")
        jiralib2-auth             'token
        jiralib2-user-login-name  (getenv "JIRA_USERNAME")
        jiralib2-token            (getenv "JIRA_TOKEN")
        
        ;; NOTE, this directory needs to be in `org-agenda-files'`
        ejira-org-directory       (format "%s/%s" (getenv "ORG_PATH") "jira")
        ejira-projects            '("EJ" "JL2")
        
        ejira-priorities-alist    '(("Highest" . ?A)
                                    ("High"    . ?B)
                                    ("Medium"  . ?C)
                                    ("Low"     . ?D)
                                    ("Lowest"  . ?E))
        
		;; this var is used as:
		;; (alist-get status ejira-todo-states-alist 1 nil #'equal)
		;; for example, it will return 2 if the status is "In progress".
		;; Then it will pass 2 to (org-todo) for getting the todo keyword from
		;; org-todo-keywords. org-todo-keywords is defined by #+TODO
		;; header in org file
        ejira-todo-states-alist   '(("In progress" . 2)
                                    ("Done"        . 3)
									))
  
  :config
  (add-hook 'jiralib2-post-login-hook #'ejira-guess-epic-sprint-fields)
  
  (require 'ejira-agenda)
  (add-to-list 'org-agenda-files ejira-org-directory)
  
  ;; Add an agenda view to browse the issues that
  (org-add-agenda-custom-command
   '("j" "My JIRA issues"
     ((ejira-jql "resolution = unresolved and assignee = currentUser()"
                 ((org-agenda-overriding-header "Assigned to me"))))))
  )

(provide 'init-jira)
