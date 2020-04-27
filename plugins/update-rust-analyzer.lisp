(ql:quickload '("dexador" "lquery" "quri" "str"))

(block nil
  (let* ((current-version (handler-case (read-line (sb-ext:process-output
                                                    (sb-ext:run-program "rust-analyzer"
                                                                        '("--version")
                                                                        :search t
                                                                        :output :stream)))
                            (error (m)
                              (format t "receive error: ~a~%" m)
                              (if (yes-or-no-p "wanns reinstall it?") " fakehash" (return nil)))))
         
         (version-hash (subseq current-version (1+ (position #\Space current-version))))
       
         whole-page statue-code head uri stream release-page newest-hash 
         )

    (format t "Go get newest release data~%")
    (multiple-value-setq (whole-page statue-code head uri stream)
      (dex:get "https://github.com/rust-analyzer/rust-analyzer/releases/latest"))
  
    (setf release-page (lquery:$ (lquery:initialize whole-page))
          newest-hash (elt (lquery:$ release-page "code" (text)) 0))
  
    (format t "newest: ~a, current: ~a~%" newest-hash version-hash)
    (if (string= newest-hash version-hash)
        (format t "newest version ~a equal current version ~a, don't need to update~%"
                newest-hash current-version)
        (let ((data-tag (car (last (str:split-omit-nulls #\/ (quri:uri-path uri)))))
              download-link)
          (setf download-link
                (format nil
                        "https://github.com/rust-analyzer/rust-analyzer/releases/download/~a/rust-analyzer-mac"
                        data-tag))
          (format t
                  "update rust-analyzer-mac by \"wget ~a -O ~~/.cargo/bin/rust-analyzer && chmod +x ~~/.cargo/bin/rust-analyzer\"~%"
                  download-link)))))

(sb-ext:exit)
