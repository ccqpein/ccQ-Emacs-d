(require 'leetcode-picker-inner)

(defun get-random-quiz (fmt-str)
  (interactive "sImport your format (empty using default): ")
  (cond ((string= "" fmt-str)
         (leetcode-picker-inner-get-random-with-level level "#README# {title}\n\n{content}"))
        (t (leetcode-picker-inner-get-random fmt-str))))

(defun get-random-quiz-with-level (fmt-str level)
  (interactive "sImport your format (empty using default): \nsLevel of quiz (e/m(default)/h): ")
  (cond ((string= "" fmt-str)
         (leetcode-picker-inner-get-random-with-level level "#README# {title}\n\n{content}"))
        (t (leetcode-picker-inner-get-random-with-level level fmt-str)))
  )

;;:= TODO: not finish yet
;;(provide 'leetcode-picker)

