;;; looks like org-jira doesn't totally match the use-package
(use-package ejira
  :init (straight-use-package
		 '(el-patch :type git :host github :repo "nyyManni/ejira"
					))
  )

(provide 'init-jira)
