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
        ejira-todo-states-alist   '(("To Do"       . 1)
                                    ("In Progress" . 2)
                                    ("Done"        . 3)))

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


