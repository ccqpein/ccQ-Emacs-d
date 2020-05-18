(ql:quickload '("dexador" "lquery" "quri" "str"))


(defun run-command (comm &rest argvs)
  (let ((out (make-string-output-stream)))
    (sb-ext:run-program comm
                        argvs
                        :search t
                        :output out)
    out)) ;; wanna see the output, call get-output-stream-string outside


(block nil
  (let* ((current-version (handler-case (read-line (sb-ext:process-output
                                                    (sb-ext:run-program "rust-analyzer"
                                                                        '("--version")
                                                                        :search t
                                                                        :output :stream)))
                            (error (m)
                              (format t "receive error: ~a~%" m)
                              (if (yes-or-no-p "wanna reinstall it?") " fakehash" (return nil)))))
         
         (version-hash (subseq current-version (1+ (position #\Space current-version))))
       
         whole-page uri
         
         release-page newest-hash

         (in-proxy nil)
         )

    (format t "Go get newest release data~%")

    (let ((response (multiple-value-list
                     (handler-case
                         (dex:get "https://github.com/rust-analyzer/rust-analyzer/releases/latest")
                       (CL+SSL::SSL-ERROR-SYSCALL (e)
                         (declare (ignore e))
                         (format t "Use proxy here~%")
                         (setf in-proxy t)
                         (dex:get "https://github.com/rust-analyzer/rust-analyzer/releases/latest"
                                  :proxy "http://localhost:8099/" ;; local proxy
                                  :insecure t))))))
      (setf whole-page (nth 0 response)
            uri (nth 3 response)))
  
    (setf release-page (lquery:$ (lquery:initialize whole-page))
          newest-hash (elt (lquery:$ release-page "code" (text)) 0))
  
    (format t "newest: ~a, current: ~a~%" newest-hash version-hash)
    (if (string= newest-hash version-hash)
        (format t "newest version ~a equal current version ~a, don't need to update~%"
                newest-hash current-version)
        (let ((data-tag (car (last (str:split-omit-nulls #\/ (quri:uri-path uri)))))
              download-link)

          ;; make download url
          (setf download-link
                (format nil
                        "https://github.com/rust-analyzer/rust-analyzer/releases/download/~a/rust-analyzer-mac"
                        data-tag))
          ;; (format t
          ;;         "update rust-analyzer-mac by \"wget ~a -O ~~/.cargo/bin/rust-analyzer && chmod +x ~~/.cargo/bin/rust-analyzer\"~%"
          ;;         download-link)

          (format t "Start to download newest version~%")
          
          ;; start to download rust-analyzer
          (run-command "wget" download-link
                       "-O"
                       (format nil "~a/.cargo/bin/rust-analyzer" (sb-ext:posix-getenv "HOME"))
                       (if in-proxy "--no-check-certificate" ""))
          (run-command "chmod" "+x" (format nil "~a/.cargo/bin/rust-analyzer" (sb-ext:posix-getenv "HOME")))
          (format t "Download done")
          ))))

(sb-ext:exit)
