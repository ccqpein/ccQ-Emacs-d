(ql:quickload '("yason" "str" "alexandria"))

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
   (get-output-stream-string (run-command "curl" "-sL" url))))

(defun version-hash-equal (new current)
  (str:starts-with? current new))

(defun check-the-architecture ()
  (if (str:starts-with?
	   "arm64"
	   (get-output-stream-string (run-command "uname" "-m")))
	  'arm64
	  'x86
	  ))

(defun parse-current-version ()
  (loop
	with xx = (list
			   (get-output-stream-string (run-command "rust-analyzer" "--version")))
	for w in '(#\Newline #\Space #\( #\))
	do (setf xx (alexandria:flatten (mapcar (lambda (ss) (str:split w ss :omit-nulls t)) xx)))
	finally (return xx)))

(defun main ()
  (let* ((current-version
           (handler-case
               (parse-current-version)
             (error (m)
               (format t "receive error: ~a~%" m)
               (if (yes-or-no-p "wanna reinstall it?") '("" "" " fakehash") (return-from main nil)))))
         
         (version-hash (nth 2 current-version)))

    (format t "Go get newest release data~%")

    (let* ((response-json-body (call-github-api
                                "https://api.github.com/repos/rust-analyzer/rust-analyzer/releases/tags/nightly"))
           (tag-name (gethash "tag_name" response-json-body))
           (tag-detail (call-github-api
                        (format nil
                                "https://api.github.com/repos/rust-analyzer/rust-analyzer/git/refs/tags/~a"
                                tag-name)))
           (newest-hash (gethash "sha"
                                 (gethash "object" tag-detail))))

      (format t "newest: ~a, current: ~a~%" newest-hash version-hash)

      (if (version-hash-equal newest-hash version-hash)
          (format t "newest version ~a equal current version ~a, don't need to update~%"
                  (subseq newest-hash 0 10)
                  (str:join #\Space current-version))

          ;; have newer version
          (let ((download-link
				  (gethash "browser_download_url"
                           (find-if (lambda (x)
									  (string=
									   (case (check-the-architecture)
										 (x86 "rust-analyzer-x86_64-apple-darwin.gz")
										 (arm64 "rust-analyzer-aarch64-apple-darwin.gz"))
                                       (gethash "name" x)))
                                    (gethash "assets" response-json-body)))))

            ;; check
            (when (not download-link)
              (format t "Cannot find download version, please check it out~%")
              (return-from main nil))

            ;; start to download rust-analyzer
            (format t "Start to download newest version from ~a~%" download-link)

            (let* ((filename (format nil
									 "~a/.cargo/bin/rust-analyzer-newer"
									 (sb-ext:posix-getenv "HOME")
									 ))
				   (d-filename (format nil "~a~a" filename ".gz")))
			  
			  (format t "Downloading to ~a~%" d-filename)
			  
			  (run-command "wget" download-link
						   "-O"
						   d-filename
						   (if *in-proxy* "--no-check-certificate" ""))
             
              (run-command "gunzip" "-dk" d-filename) ;; gunzip will create a file has filename
             
              (run-command "mv"
						   filename
                           (format nil "~a/.cargo/bin/rust-analyzer" (sb-ext:posix-getenv "HOME")))
             
              (run-command "chmod" "+x" (format nil "~a/.cargo/bin/rust-analyzer" (sb-ext:posix-getenv "HOME")))
             
              (format t "Download done"))
            ))
      )))

(main)
(sb-ext:exit)
;;(sb-ext:save-lisp-and-die "update-rust-analyzer" :toplevel #'main :executable t)
