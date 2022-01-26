(ql:quickload '("yason" "str"))

(defparameter *IN-PROXY* nil)

(defun run-command (comm &rest argvs)
  (let ((out (make-string-output-stream)))
    (sb-ext:run-program comm
                        argvs
                        :search t
                        :output out)
    out))

(defun call-github-api (url)
  (yason:parse
   (get-output-stream-string (run-command "curl" "-s" url))))

(defun version-hash-equal (new current)
  (let ((clean-current (car (str:split " " current))))
    (str:starts-with? clean-current new)))

(defun main ()
  (let* ((current-version
           (handler-case
               (get-output-stream-string (run-command "rust-analyzer" "--version"))
             (error (m)
               (format t "receive error: ~a~%" m)
               (if (yes-or-no-p "wanna reinstall it?") " fakehash" (return-from main nil)))))
         
         (version-hash (subseq current-version (1+ (position #\Space current-version)))))

    (format t "Go get newest release data~%")

    (let* ((response-json-body (call-github-api
                                "https://api.github.com/repos/rust-analyzer/rust-analyzer/releases/tags/nightly"))
           (tag-name (gethash "tag_name" response-json-body))
           (tag-detail (call-github-api
                        (format nil
                                "https://api.github.com/repos/rust-analyzer/rust-analyzer/git/refs/tags/~a"
                                tag-name)))
           (newest-hash (subseq (gethash "sha"
                                         (gethash "object" tag-detail))
                                0 (length version-hash))))

      (format t "newest: ~a, current: ~a" newest-hash version-hash)

      (if (version-hash-equal newest-hash version-hash)
          (format t "newest version ~a equal current version ~a, don't need to update~%"
                  newest-hash current-version)

          ;; have newer version
          (let ((download-link (gethash "browser_download_url"
                                        (find-if (lambda (x) (string= "rust-analyzer-x86_64-apple-darwin.gz"
                                                                      (gethash "name" x)))
                                                 (gethash "assets" response-json-body)))))

            ;; check
            (when (not download-link)
              (format t "Cannot find download version, please check it out~%")
              (return-from main nil))

            ;; start to download rust-analyzer
            (format t "Start to download newest version from ~a~%" download-link)

            (run-command "wget" download-link
                         "-O"
                         (format nil "~a/.cargo/bin/rust-analyzer-x86_64-apple-darwin.gz" (sb-ext:posix-getenv "HOME"))
                         (if *in-proxy* "--no-check-certificate" ""))
            
            (run-command "gunzip" "-dk" (format nil "~a/.cargo/bin/rust-analyzer-x86_64-apple-darwin.gz" (sb-ext:posix-getenv "HOME")))
            
            (run-command "mv"
                         (format nil "~a/.cargo/bin/rust-analyzer-x86_64-apple-darwin" (sb-ext:posix-getenv "HOME"))
                         (format nil "~a/.cargo/bin/rust-analyzer" (sb-ext:posix-getenv "HOME")))
            
            (run-command "chmod" "+x" (format nil "~a/.cargo/bin/rust-analyzer" (sb-ext:posix-getenv "HOME")))
            
            (format t "Download done")
            ))
      )))

(main)
(sb-ext:exit)
;;(sb-ext:save-lisp-and-die "update-rust-analyzer" :toplevel #'main :executable t)
