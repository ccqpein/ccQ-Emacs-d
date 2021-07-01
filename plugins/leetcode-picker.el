(require 'leetcode-picker-inner)

(defun get-random-lc-quiz (fmt-str)
  (interactive "sImport your format (empty using default): ")
  (get-buffer-create "quiz-description")
  (with-current-buffer "quiz-description"
    (markdown-mode)
    (kill-region (point-min) (point-max))
    (insert
     (cond ((string= "" fmt-str)
            (leetcode-picker-inner-get-random "# README # {title}\n\n[source]({source})\n\n{content}"))
           (t (leetcode-picker-inner-get-random fmt-str))))))

(defun get-random-lc-quiz-with-level (fmt-str level)
  (interactive "sImport your format (empty using default): \nsLevel of quiz (e/m(default)/h): ")
  (get-buffer-create "quiz-description")
  (with-current-buffer "quiz-description"
    (markdown-mode)
    (kill-region (point-min) (point-max))
    (insert
     (cond ((string= "" fmt-str)
            (leetcode-picker-inner-get-random-with-level
             level
             "# README # {title}\n\n[source]({source})\n\n{content}"))
           (t (leetcode-picker-inner-get-random-with-level level fmt-str))))))

(defun get-lc-quiz-snippet (lang)
  "get quiz snippet"
  (interactive "sImport your language (empty using rust): ")
  (get-buffer-create "code-snippet")
  (with-current-buffer "code-snippet"
    (kill-region (point-min) (point-max))
    (insert
     (cond ((string= "" lang)
            (leetcode-picker-inner-get-code-snippet "rust"))
           (t (leetcode-picker-inner-get-code-snippet lang))))))

(provide 'leetcode-picker)
